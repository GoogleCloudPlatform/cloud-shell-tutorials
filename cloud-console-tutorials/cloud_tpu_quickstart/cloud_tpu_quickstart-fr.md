# Démarrage rapide avec un TPU

<walkthrough-tutorial-url url="https://cloud.google.com/tpu/docs/quickstart"></walkthrough-tutorial-url>

## Présentation

Vous pouvez accélérer des charges de travail de machine learning [TensorFlow][tensor-flow] spécifiques grâce à un [TPU (Tensor Processing Unit)][tpu-docs]. Ce tutoriel vous explique comment créer une instance Cloud TPU et comment l'utiliser pour exécuter un modèle TensorFlow de base.

## Configuration du projet

Google Cloud Platform organise les ressources en projets. Vous pouvez ainsi collecter toutes les ressources associées à une application au même endroit.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## Configurer le SDK Cloud

### Ouvrir Cloud Shell

Cloud Shell est un outil de ligne de commande intégré pour la console. Vous pouvez l'utiliser pour vous connecter à votre TPU.

Pour ouvrir Cloud Shell, cliquez sur l'<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[icône][spotlight-open-devshell] dans la barre de navigation située en haut de la console.

### Spécifier une zone

Exécutez la commande suivante pour spécifier la zone dans laquelle vous prévoyez de créer votre ressource TPU :

```bash
gcloud config set compute/zone us-central1-c
```

Pour cet exemple, utilisez la zone `us-central1-c`.

Pour en savoir plus sur les zones disponibles, consultez le site de documentation de Cloud TPU :

[Régions et zones de Cloud TPU][tpu-regions]

## Créer des ressources

Une instance de machine virtuelle Compute Engine est nécessaire pour ce démarrage rapide. L'image comprend l'outil de ligne de commande `gcloud beta`, ainsi qu'une version Release Candidate de TensorFlow. Ces deux éléments sont requis pour exécuter TensorFlow sur des ressources Cloud TPU.

### Créer une VM Compute Engine

Créez une instance de VM à l'aide de l'outil de ligne de commande `gcloud`.

```bash
gcloud compute instances create tpu-demo-vm \
  --machine-type=n1-standard-4 \
  --boot-disk-size=500GB \
  --image-project=ml-images \
  --image-family=tf-1-8 \
  --scopes=cloud-platform
```

### Activer l'API TPU

Activez l'API TPU, si ce n'est pas déjà fait.

<walkthrough-enable-apis apis="tpu.googleapis.com"></walkthrough-enable-apis>

### Créer une ressource TPU

Créez une ressource Cloud TPU à l'aide de la commande `gcloud beta compute tpus create`. Pour cet exemple, définissez la valeur `10.240.1.0/29` pour le paramètre `--range`.

```bash
gcloud beta compute tpus create demo-tpu \
  --range=10.240.1.0/29 --version=1.8
```

## Exécuter un exemple TensorFlow

Connectez-vous à votre instance, puis créez un programme TensorFlow avec un appel de procédure à distance (RPC) qui renvoie vers le point de terminaison du réseau de votre TPU.

### Se connecter à l'instance

Saisissez la commande suivante pour vous connecter en SSH à la VM. S'il s'agit de votre première utilisation de SSH depuis Cloud Shell, vous devez créer une clé privée :

```bash
gcloud compute ssh tpu-demo-vm
```

### Attribuer un nom au TPU

Sur l'instance, définissez une variable d'environnement en indiquant le nom que vous souhaitez attribuer à votre TPU. Pour cet exemple, utilisez "demo-tpu".

```bash
export TPU_NAME="demo-tpu"
```

### Créer l'application

Créez une application Python qui renvoie vers votre point de terminaison Cloud TPU et exécute un calcul simple.

```bash
nano cloud-tpu.py
```

Copiez et collez le contenu de ce fichier :

```python
import os
import tensorflow as tf
from tensorflow.contrib import tpu
from tensorflow.contrib.cluster_resolver import TPUClusterResolver

def axy_computation(a, x, y):
  return a * x + y

inputs = [
    3.0,
    tf.ones([3, 3], tf.float32),
    tf.ones([3, 3], tf.float32),
]

tpu_computation = tpu.rewrite(axy_computation, inputs)

tpu_grpc_url = TPUClusterResolver(
    tpu=[os.environ['TPU_NAME']]).get_master()

with tf.Session(tpu_grpc_url) as sess:
  sess.run(tpu.initialize_system())
  sess.run(tf.global_variables_initializer())
  output = sess.run(tpu_computation)
  print(output)
  sess.run(tpu.shutdown_system())

print('Done!')
```

### Exécuter l'application

Exécutez le programme TensorFlow.

```bash
python cloud-tpu.py
```

N'hésitez pas à créer et exécuter d'autres programmes TensorFlow utilisant l'appareil TPU.

Lorsque vous avez terminé vos tests, quittez l'instance.

```bash
exit
```

## Supprimer des ressources

Afin d'éviter que des frais ne soient facturés sur votre compte Google Cloud Platform pour les ressources utilisées dans ce démarrage rapide, procédez comme suit :

### Supprimer la ressource TPU et l'instance de VM

Supprimez votre ressource Cloud TPU à l'aide de l'outil de ligne de commande gcloud.

```bash
gcloud beta compute tpus delete demo-tpu
```

Supprimez votre instance Compute Engine à l'aide de l'outil de ligne de commande `gcloud`.

```bash
gcloud compute instances delete tpu-demo-vm
```

### Supprimer le réseau VPC

Accédez à la section "Réseau VPC" de la console Google Cloud Platform.

<walkthrough-menu-navigation sectionid="VIRTUAL_NETWORK_SECTION"></walkthrough-menu-navigation>

Accédez à la section [Appairage de réseaux VPC][spotlight-network-peering], puis sélectionnez le réseau VPC que Google a créé automatiquement dans le cadre de la configuration de Cloud TPU. L'ID de l'entrée d'appairage commence par `cp-to-tp-peering`.

En haut de la page, cliquez sur **Supprimer**.

### Supprimer le routage VPC

Accédez à la section [Routes][spotlight-routes-list], puis sélectionnez la route que Google a créée automatiquement dans le cadre de la configuration de Cloud TPU. L'ID de l'entrée d'appairage commence par `peering-route`.

En haut de la page, cliquez sur **Supprimer**.

## Conclusion

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Félicitations !

Vous avez créé une application qui utilise Cloud TPU.

Pour en savoir plus, consultez le site de documentation de Cloud TPU :

[https://cloud.google.com/tpu/][tpu-docs]

[request-tpu-quota]: https://services.google.com/fb/forms/cloud-tpu-beta-request/
[spotlight-network-peering]: walkthrough://spotlight-pointer?cssSelector=#cfctest-section-nav-item-peering_list
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-routes-list]: walkthrough://spotlight-pointer?cssSelector=#cfctest-section-nav-item-routes_list
[tensor-flow]: https://www.tensorflow.org/
[tpu-docs]: https://cloud.google.com/tpu/docs/
[tpu-regions]: https://cloud.google.com/tpu/docs/regions
