# Guida di avvio rapido mediante TPU

<walkthrough-tutorial-url url="https://cloud.google.com/tpu/docs/quickstart"></walkthrough-tutorial-url>

## Presentazione

Puoi utilizzare un'unità TPU ([Tensor Processing Unit][tpu-docs]) per velocizzare specifici carichi di lavoro di machine learning [TensorFlow][tensor-flow]. Questo tutorial spiega come creare una Cloud TPU e utilizzarla per eseguire un modello base di TensorFlow.

## Configurazione del progetto

Google Cloud Platform organizza le risorse in progetti. Ciò consente di raccogliere tutte le risorse correlate per una singola applicazione in una sola posizione.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## Configurazione di Cloud SDK

### Apri Cloud Shell

Cloud Shell è uno strumento a riga di comando incorporato per la console che consente di connetterti
alla tua unità TPU.

Apri Cloud Shell facendo clic sull'<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[icona][spotlight-open-devshell] nella barra di navigazione nella parte superiore della console.

### Specifica una zona

Utilizza il seguente comando per specificare la zona in cui intendi creare la risorsa TPU:

```bash
gcloud config set compute/zone us-central1-c
```

Per questo esempio utilizza la zona `us-central1-c`.

Per conoscere le zone disponibili, visita il sito della documentazione per Cloud TPU:

[Aree geografiche e zone di Cloud TPU][tpu-regions]

## Creare risorse

Questa guida di avvio rapido richiede un'istanza di macchina virtuale Compute Engine. L'immagine include lo strumento a riga di comando `gcloud beta` nonché un candidato di release TensorFlow richiesto per eseguire TensorFlow su risorse Cloud TPU.

### Creare una VM Compute Engine

Utilizza lo strumento a riga di comando `gcloud` per creare un'istanza VM.

```bash
gcloud compute instances create tpu-demo-vm \
  --machine-type=n1-standard-4 \
  --boot-disk-size=500GB \
  --image-project=ml-images \
  --image-family=tf-1-8 \
  --scopes=cloud-platform
```

### Attiva l'API TPU

Se non l'hai già fatto, attiva l'API TPU.

<walkthrough-enable-apis apis="tpu.googleapis.com"></walkthrough-enable-apis>

### Crea una risorsa TPU

Utilizza il comando `gcloud beta compute tpus create` per creare una nuova risorsa
Cloud TPU. Per questo esempio, imposta il flag `--range` a `10.240.1.0/29`.

```bash
gcloud beta compute tpus create demo-tpu \
  --range=10.240.1.0/29 --version=1.8
```

## Eseguire un esempio di TensorFlow

Connettiti all'istanza e crea un programma TensorFlow con una chiamata di procedura remota
(RPC) che punta all'endpoint di rete dell'unità TPU.

### Connettiti all'istanza

Inserisci nella VM il comando per SSH. Se è la prima volta che utilizzi SSH da Cloud Shell,
devi creare una chiave privata:

```bash
gcloud compute ssh tpu-demo-vm
```

### Assegna un nome all'unità TPU

Imposta nell'istanza una variabile di ambiente con il nome che scegli per l'unità TPU.
Per questo esempio utilizza "demo-tpu".

```bash
export TPU_NAME="demo-tpu"
```

### Crea l'applicazione

Crea un'applicazione Python che punti all'endpoint TPU Cloud e che esegua un calcolo semplice.

```bash
nano cloud-tpu.py
```

Copia e incolla questi contenuti del file:

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

### Esegui l'applicazione

Esegui il programma TensorFlow.

```bash
python cloud-tpu.py
```

Puoi creare ed eseguire altri programmi TensorFlow che utilizzano il dispositivo TPU.

Quando hai terminato i tuoi esperimenti, chiudi l'istanza.

```bash
exit
```

## Eliminare le risorse

Per evitare che al tuo account Google Cloud Platform vengano addebitate le risorse utilizzate in questa
guida di avvio rapido:

### Elimina la risorsa TPU e l'istanza VM

Utilizza lo strumento a riga di comando gcloud per eliminare la risorsa Cloud TPU.

```bash
gcloud beta compute tpus delete demo-tpu
```

Utilizza lo strumento a riga di comando `gcloud` per eliminare l'istanza di Compute Engine.

```bash
gcloud compute instances delete tpu-demo-vm
```

### Elimina la rete VPC

Accedi alla sezione rete VPC nella console di Google Cloud Platform.

<walkthrough-menu-navigation sectionid="VIRTUAL_NETWORK_SECTION"></walkthrough-menu-navigation>

Accedi alla sezione [Peering di rete VPC][spotlight-network-peering] e seleziona la rete VPC creata automaticamente da Google durante la configurazione della risorsa TPU Cloud. La voce di peering inizia con `cp-to-tp-peering` nell'ID.

Nella parte superiore della pagina, fai clic su **Elimina**.

### Elimina la route VPC

Accedi alla sezione [Route][spotlight-routes-list] e seleziona la route creata automaticamente da Google durante la configurazione di Cloud TPU. La voce di peering inizia con `peering-route` nell'ID.

Nella parte superiore della pagina, fai clic su **Elimina**.

## Conclusione

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Complimenti!

Hai creato un'applicazione che utilizza Cloud TPU.

Per ulteriori informazioni, visita il sito della documentazione per Cloud TPU:

[https://cloud.google.com/tpu/][tpu-docs]

[request-tpu-quota]: https://services.google.com/fb/forms/cloud-tpu-beta-request/
[spotlight-network-peering]: walkthrough://spotlight-pointer?cssSelector=#cfctest-section-nav-item-peering_list
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-routes-list]: walkthrough://spotlight-pointer?cssSelector=#cfctest-section-nav-item-routes_list
[tensor-flow]: https://www.tensorflow.org/
[tpu-docs]: https://cloud.google.com/tpu/docs/
[tpu-regions]: https://cloud.google.com/tpu/docs/regions
