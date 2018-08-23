# Verkorte training: Een TPU gebruiken

<walkthrough-tutorial-url url="https://cloud.google.com/tpu/docs/quickstart"></walkthrough-tutorial-url>

## Inleiding

U kunt een [Tensor Processing Unit][tpu-docs] (TPU) gebruiken om specifieke productietaken op basis van machine learning van [TensorFlow][tensor-flow] te versnellen. In deze training wordt uitgelegd hoe u een Cloud TPU maakt en deze gebruikt om een eenvoudig TensorFlow-model uit te voeren.

## Project instellen

In Google Cloud Platform worden resources ingedeeld in projecten. Zo kunt u alle gerelateerde resources voor een app op één plek verzamelen.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## De Cloud-SDK configureren

### Cloud Shell openen

Cloud Shell is een ingebouwde opdrachtregeltool van de console die u kunt gebruiken om verbinding te maken met uw TPU.

Open Cloud Shell door in de navigatiebalk bovenaan de console op het <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[pictogram][spotlight-open-devshell] te klikken.

### Een zone opgeven

Gebruik de volgende opdracht om de zone op te geven waarin u uw TPU-resource wilt maken:

```bash
gcloud config set compute/zone us-central1-c
```

Gebruik voor dit voorbeeld de zone `us-central1-c`.

Als u de beschikbare zones wilt bekijken, gaat u naar de Cloud TPU-documentatiesite:

[Cloud TPU-regio's en -zones][tpu-regions]

## Resources maken

Voor deze verkorte training is een VM-instantie (virtuele machine) van Compute Engine vereist. De image bevat de opdrachtregeltool `gcloud beta` en een TensorFlow-releasekandidaat die nodig is om TensorFlow op Cloud TPU-resources uit te voeren.

### Een Compute Engine-VM maken

Gebruik de opdrachtregeltool `gcloud` om een VM-instantie te maken.

```bash
gcloud compute instances create tpu-demo-vm \
  --machine-type=n1-standard-4 \
  --boot-disk-size=500GB \
  --image-project=ml-images \
  --image-family=tf-1-8 \
  --scopes=cloud-platform
```

### De TPU API inschakelen

Activeer de TPU API als u dit nog niet heeft gedaan.

<walkthrough-enable-apis apis="tpu.googleapis.com"></walkthrough-enable-apis>

### Een TPU-resource maken

Gebruik de opdracht `gcloud beta compute tpus create` om een nieuwe Cloud TPU-resource te maken. Voor dit voorbeeld stelt u de vlag `--range` in op `10.240.1.0/29`.

```bash
gcloud beta compute tpus create demo-tpu \
  --range=10.240.1.0/29 --version=1.8
```

## Een TensorFlow-voorbeeld uitvoeren

Maak verbinding met uw instantie en maak een TensorFlow-programma met een externe procedureaanroep (remote procedure call of RPC) die naar het netwerkeindpunt van uw TPU verwijst.

### Verbinding maken met uw instantie

Voer de volgende opdracht voor SSH in de VM in. Als dit de eerste keer is dat u SSH in Cloud Shell gebruikt, moet u een privésleutel maken:

```bash
gcloud compute ssh tpu-demo-vm
```

### Uw TPU een naam geven

Stel op de instantie een omgevingsvariabele in met een naam die u kiest voor uw TPU. Gebruik voor dit voorbeeld 'demo-tpu'.

```bash
export TPU_NAME="demo-tpu"
```

### De app maken

Maak een Python-app die naar uw Cloud TPU-eindpunt verwijst en een eenvoudige berekening uitvoert.

```bash
nano cloud-tpu.py
```

Kopieer en plak de volgende bestandsinhoud:

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

### De app uitvoeren

Voer het TensorFlow-programma uit.

```bash
python cloud-tpu.py
```

U kunt aanvullende TensorFlow-programma's maken en uitvoeren die gebruikmaken van het TPU-apparaat.

Wanneer u klaar bent met experimenteren, verlaat u de instantie.

```bash
exit
```

## Resources verwijderen

Als u wilt voorkomen dat er voor uw Google Cloud Platform-account kosten in rekening worden gebracht voor de resources die in deze verkorte training worden gebruikt, doet u het volgende:

### De TPU-resource en VM-instantie verwijderen

Gebruik de opdrachtregeltool gcloud om uw Cloud TPU-resource te verwijderen.

```bash
gcloud beta compute tpus delete demo-tpu
```

Gebruik de opdrachtregeltool `gcloud` om uw Compute Engine-instantie te verwijderen.

```bash
gcloud compute instances delete tpu-demo-vm
```

### VPC-netwerk verwijderen

Ga naar de sectie voor het VPC-netwerk in de Google Cloud Platform-console.

<walkthrough-menu-navigation sectionid="VIRTUAL_NETWORK_SECTION"></walkthrough-menu-navigation>

Navigeer naar het gedeelte [VPC-netwerkpeering][spotlight-network-peering] en selecteer het VPC-netwerk dat Google automatisch heeft gemaakt als onderdeel van de Cloud TPU-installatie. De peeringvermelding begint met `cp-to-tp-peering` in de ID.

Klik bovenaan de pagina op **Verwijderen**.

### VPC-route verwijderen

Navigeer naar het gedeelte [Routes][spotlight-routes-list] en selecteer de route die Google automatisch heeft gemaakt als onderdeel van de Cloud TPU-installatie. De peeringvermelding begint met `peering-route` in de ID.

Klik bovenaan de pagina op **Verwijderen**.

## Conclusie

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Gefeliciteerd

U heeft een app gemaakt die Cloud TPU gebruikt.

Ga voor meer informatie naar de Cloud TPU-documentatiesite:

[https://cloud.google.com/tpu/][tpu-docs]

[request-tpu-quota]: https://services.google.com/fb/forms/cloud-tpu-beta-request/
[spotlight-network-peering]: walkthrough://spotlight-pointer?cssSelector=#cfctest-section-nav-item-peering_list
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-routes-list]: walkthrough://spotlight-pointer?cssSelector=#cfctest-section-nav-item-routes_list
[tensor-flow]: https://www.tensorflow.org/
[tpu-docs]: https://cloud.google.com/tpu/docs/
[tpu-regions]: https://cloud.google.com/tpu/docs/regions
