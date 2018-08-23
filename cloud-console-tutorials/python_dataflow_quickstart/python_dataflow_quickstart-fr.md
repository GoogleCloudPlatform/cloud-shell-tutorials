# Tutoriel de Dataflow WordCount

<walkthrough-tutorial-url url="https://cloud.google.com/dataflow/docs/quickstarts/quickstart-python"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="dataflow-intro" key="directory"></walkthrough-watcher-constant>
<walkthrough-watcher-constant value="dataflow-intro" key="job-name"></walkthrough-watcher-constant>

## Présentation

Dans ce tutoriel, vous allez apprendre les principes de base de l'exécution d'un pipeline avec Python sur le service Cloud Dataflow grâce à un exemple très simple.

Les pipelines Dataflow peuvent correspondre à un traitement par *lots* (traitement d'une source de données d'entrée limitée, comme un fichier ou une table de base de données). Ils peuvent également correspondre à un traitement par *flux* (traitement d'un flux de données d'entrée non limité, provenant d'une source telle que Cloud Pub/Sub). Dans cet exemple, il s'agit d'un pipeline par lots dont le but est de comptabiliser les mots dans les œuvres de Shakespeare.

Avant de commencer, vous devez vérifier les conditions requises pour votre projet Cloud Platform et effectuer la configuration initiale.

## Configuration du projet

Google Cloud Platform organise les ressources en projets. Vous pouvez ainsi collecter toutes les ressources associées à une application au même endroit.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>
<walkthrough-project-permissions permissions="dataflow.jobs.create"></walkthrough-project-permissions>

## Configurer Cloud Dataflow

Pour utiliser Dataflow, activez les API Cloud Dataflow, puis ouvrez Cloud Shell.

### Activer les API Google Cloud

<walkthrough-enable-apis apis="compute.googleapis.com,dataflow,cloudresourcemanager.googleapis.com,logging,storage_component,storage_api,bigquery,pubsub">
</walkthrough-enable-apis>

### Ouvrir Cloud Shell

Cloud Shell est un outil de ligne de commande intégré pour la console. Vous allez l'utiliser pour déployer votre application.

Pour ouvrir Cloud Shell, cliquez sur l'<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[icône][spotlight-open-devshell] dans la barre de navigation située en haut de la console.

## Installer des exemples de Cloud Dataflow sur Cloud Shell

La version Python de Cloud Dataflow nécessite que Python, le SDK Google Cloud et le SDK Cloud Dataflow soient installés dans votre environnement de développement.
Notez en outre que Cloud Dataflow utilise pip, le gestionnaire de packages de Python, pour gérer les dépendances des SDK.

Ce tutoriel utilise un environnement Cloud Shell dans lequel Python et pip sont déjà installés. Vous pouvez également suivre ce tutoriel [sur votre machine locale][dataflow-python-tutorial].

### Télécharger les exemples et le SDK Cloud Dataflow pour Python à l'aide de la commande pip

Lorsque vous exécutez cette commande, pip télécharge et installe la bonne version du SDK Cloud Dataflow.

```bash
pip install --user google-cloud-dataflow
```

Exécutez la commande pip dans Cloud Shell.

## Configurer un bucket Cloud Storage

Cloud Dataflow utilise des buckets Cloud Storage pour stocker les données de sortie et mettre en cache votre code de pipeline.

### Exécuter gsutil mb

Dans Cloud Shell, utilisez la commande `gsutil mb` pour créer un bucket Cloud Storage.

```bash
gsutil mb gs://{{project-id-no-domain}}
```

Pour en savoir plus sur l'outil `gsutil`, consultez la [documentation][gsutil-docs].

## Créer et lancer un pipeline

Dans Cloud Dataflow, un *pipeline* représente votre tâche de traitement de données. Il lit les données d'entrée, effectue des transformations sur celles-ci, puis produit des données de sortie. Les transformations effectuées par un pipeline peuvent inclure le filtrage, le regroupement, la comparaison ou la fusion de données.

### Lancer un pipeline sur le service Dataflow

Utilisez Python pour lancer votre pipeline sur le service Cloud Dataflow. Le pipeline en cours d'exécution est appelé *tâche*.

```bash
python -m apache_beam.examples.wordcount \
  --project {{project-id}} \
  --runner DataflowRunner \
  --temp_location gs://{{project-id-no-domain}}/temp \
  --output gs://{{project-id-no-domain}}/results/output \
  --job_name {{job-name}}
```

  *  `output` est le bucket utilisé par l'exemple WordCount pour stocker les résultats de la tâche.

### Tâche en cours d'exécution

Félicitations ! Votre binaire est en cours de simulation dans le bucket de stockage que vous avez créé, et les instances Compute Engine sont en cours de création. Cloud Dataflow va diviser votre fichier d'entrée pour que vos données soient traitées en parallèle sur plusieurs machines.

Remarque : Lorsque le message "JOB_STATE_DONE" s'affiche, vous pouvez fermer Cloud Shell.

## Contrôler votre tâche

Vérifiez la progression du pipeline sur la page Cloud Dataflow.

### Accéder à la page de l'interface utilisateur de surveillance de Cloud Dataflow

Si ce n'est pas déjà fait, accédez à la page de l'interface utilisateur de surveillance de Cloud Dataflow.

Ouvrez le [menu][spotlight-console-menu] situé sur le côté gauche de la console.

Sélectionnez ensuite la section **Dataflow**.

<walkthrough-menu-navigation sectionid="DATAFLOW_SECTION"></walkthrough-menu-navigation>

### Sélectionner votre tâche

Cliquez sur votre tâche pour afficher les détails.

### Explorer les détails et les métriques d'un pipeline

Explorez le pipeline sur la gauche de l'écran et les informations de la tâche sur la droite. Pour consulter l'état détaillé d'une tâche, cliquez sur [Journaux][spotlight-job-logs]. Cliquez sur une étape du pipeline pour afficher ses métriques.

Une fois la tâche terminée, son état est modifié et les instances Compute Engine utilisées sont automatiquement arrêtées.

## Consulter les fichiers de sortie

Maintenant que votre tâche s'est exécutée, vous pouvez consulter les fichiers de sortie dans Cloud Storage.

### Accéder à la page Cloud Storage

Ouvrez le [menu][spotlight-console-menu] situé sur le côté gauche de la console.

Sélectionnez ensuite la section **Compute Engine**.

<walkthrough-menu-navigation sectionid="STORAGE_SECTION"></walkthrough-menu-navigation>

### Accéder au bucket de stockage

Dans la liste des buckets, sélectionnez le bucket que vous avez créé
précédemment. Si vous avez utilisé le nom suggéré, il s'appelle
`{{project-id}}`.

Le bucket contient un dossier de préproduction et des dossiers de sortie. Dataflow enregistre les sorties en segments. Plusieurs fichiers de sortie vont donc être créés.

## Effectuer un nettoyage

Afin d'éviter d'être facturé pour l'utilisation de Cloud Storage, supprimez le bucket que vous avez créé.

### Revenir au navigateur de buckets

Cliquez sur le lien [Buckets][spotlight-buckets-link].

### Sélectionner le bucket

Cochez la case à côté du bucket que vous avez créé.

### Supprimer le bucket

Cliquez sur [Supprimer][spotlight-delete-bucket], puis confirmez l'opération.

## Conclusion

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Liste des opérations que vous pouvez effectuer :

  *  [En savoir plus sur l'exemple WordCount][wordcount]
  *  [En savoir plus sur le modèle de programmation de Cloud Dataflow][df-pipelines]
  *  [Découvrir le SDK Apache Beam sur GitHub][beam-sdk]

Configurez votre environnement local :

  *  [Utiliser Java et Eclipse pour exécuter Dataflow][df-eclipse]
  *  [Utiliser Java et Maven pour exécuter Dataflow][df-maven]

[beam-sdk]: https://github.com/apache/beam/tree/master/sdks/python
[dataflow-python-tutorial]: https://cloud.google.com/dataflow/docs/quickstarts/quickstart-python
[df-eclipse]: https://cloud.google.com/dataflow/docs/quickstarts/quickstart-java-eclipse
[df-maven]: https://cloud.google.com/dataflow/docs/quickstarts/quickstart-java-maven
[df-pipelines]: https://cloud.google.com/dataflow/model/programming-model-beam
[gsutil-docs]: https://cloud.google.com/storage/docs/gsutil
[spotlight-buckets-link]: walkthrough://spotlight-pointer?cssSelector=.p6n-cloudstorage-path-link
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-delete-bucket]: walkthrough://spotlight-pointer?cssSelector=#p6n-cloudstorage-delete-buckets
[spotlight-job-logs]: walkthrough://spotlight-pointer?cssSelector=#p6n-dax-job-logs-toggle
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[wordcount]: https://beam.apache.org/get-started/wordcount-example/
