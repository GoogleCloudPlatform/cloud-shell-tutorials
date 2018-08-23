# Schnellstart mit einer TPU

<walkthrough-tutorial-url url="https://cloud.google.com/tpu/docs/quickstart"></walkthrough-tutorial-url>

## Einführung

Sie können eine [Tensor Processing Unit][tpu-docs] (TPU) nutzen, um bestimmte [TensorFlow-Arbeitslasten][tensor-flow] für maschinelles Lernen zu beschleunigen. In dieser Anleitung wird erläutert, wie Sie eine Cloud TPU erstellen und zum Ausführen eines einfachen TensorFlow-Modells verwenden.

## Projekteinrichtung

Auf der Google Cloud Platform werden Ressourcen in Projekten organisiert. Auf diese Weise können Sie alle für eine einzelne Anwendung relevanten Ressourcen an einer Stelle erfassen.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## Cloud SDK konfigurieren

### Cloud Shell öffnen

Cloud Shell ist ein integriertes Befehlszeilentool für die Konsole. Sie können damit eine Verbindung zu Ihrer TPU herstellen.

Öffnen Sie Cloud Shell, indem Sie oben in der Navigationsleiste der Konsole auf das<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon> [Symbol][spotlight-open-devshell] klicken.

### Zone angeben

Geben Sie mit dem folgenden Befehl die Zone an, in der Sie Ihre TPU-Ressource erstellen möchten:

```bash
gcloud config set compute/zone us-central1-c
```

Verwenden Sie in diesem Beispiel die Zone `us-central1-c`.

Verfügbare Zonen finden Sie auf der Dokumentationswebsite für Cloud TPU:

[Cloud TPU Regionen und Zonen][tpu-regions]

## Ressourcen erstellen

Für diesen Schnellstart ist eine VM-Instanz von Compute Engine erforderlich. Das Image enthält das Befehlszeilentool `gcloud beta` sowie einen TensorFlow-Releasekandidaten. Dieser ist für die Ausführung von TensorFlow auf Cloud-TPU-Ressourcen erforderlich.

### Compute Engine-VM erstellen

Erstellen Sie mithilfe des `gcloud`-Befehlszeilentools eine VM-Instanz.

```bash
gcloud compute instances create tpu-demo-vm \
  --machine-type=n1-standard-4 \
  --boot-disk-size=500GB \
  --image-project=ml-images \
  --image-family=tf-1-8 \
  --scopes=cloud-platform
```

### Die TPU API aktivieren

Aktivieren Sie die TPU API, falls noch nicht geschehen.

<walkthrough-enable-apis apis="tpu.googleapis.com"></walkthrough-enable-apis>

### Eine TPU-Ressource erstellen

Erstellen Sie mit dem Befehl `gcloud beta compute tpus create` eine neue Cloud TPU-Ressource. Setzen Sie das Flag `--range` für dieses Beispiel auf `10.240.1.0/29`.

```bash
gcloud beta compute tpus create demo-tpu \
  --range=10.240.1.0/29 --version=1.8
```

## Ein TensorFlow-Beispiel ausführen

Stellen Sie eine Verbindung zu Ihrer Instanz her und erstellen Sie ein TensorFlow-Programm mit einem Remoteprozeduraufruf (Remote Procedure Call, RPC), der auf den Netzwerkendpunkt Ihrer TPU verweist.

### Mit Instanz verbinden

Geben Sie den folgenden Befehl ein, um eine SSH-Verbindung zur VM herzustellen. Wenn Sie SSH von Cloud Shell aus zum ersten Mal verwenden, müssen Sie einen privaten Schlüssel erstellen:

```bash
gcloud compute ssh tpu-demo-vm
```

### TPU benennen

Legen Sie auf der Instanz eine Umgebungsvariable mit einem beliebigen Namen für Ihre TPU fest. Verwenden Sie für dieses Beispiel "demo-tpu".

```bash
export TPU_NAME="demo-tpu"
```

### Anwendung erstellen

Erstellen Sie eine Python-Anwendung, die auf Ihren Cloud TPU-Endpunkt verweist und eine einfache Berechnung ausführt.

```bash
nano cloud-tpu.py
```

Kopieren Sie die folgenden Dateiinhalte:

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

### Anwendung ausführen

Führen Sie das TensorFlow-Programm aus.

```bash
python cloud-tpu.py
```

Erstellen Sie nach Belieben weitere TensorFlow-Programme, die das TPU-Gerät verwenden, und führen Sie sie aus.

Wenn Sie mit dem Experimentieren fertig sind, verlassen Sie die Instanz.

```bash
exit
```

## Ressourcen löschen

So vermeiden Sie, dass Ihr Google Cloud Platform-Konto für die in diesem Schnellstart verwendeten Ressourcen belastet wird:

### Die TPU-Ressource und die VM-Instanz löschen

Verwenden Sie das Befehlszeilentool gcloud zum Löschen Ihrer Cloud-TPU-Ressource.

```bash
gcloud beta compute tpus delete demo-tpu
```

Löschen Sie Ihre Compute Engine-Instanz mithilfe des `gcloud`-Befehlszeilentools.

```bash
gcloud compute instances delete tpu-demo-vm
```

### VPC-Netzwerk löschen

Rufen Sie in der Google Cloud Platform Console den Bereich "VPC-Netzwerk" auf.

<walkthrough-menu-navigation sectionid="VIRTUAL_NETWORK_SECTION"></walkthrough-menu-navigation>

Gehen Sie zum Bereich [VPC-Netzwerk-Peering][spotlight-network-peering] und wählen Sie das VPC-Netzwerk aus, das im Rahmen der Cloud TPU-Einrichtung automatisch von Google erstellt wurde. Die ID des Peering-Eintrags beginnt mit `cp-to-tp-peering`.

Klicken Sie oben auf der Seite auf **Löschen**.

### Die VPC-Route löschen

Gehen Sie zum Bereich [Routen][spotlight-routes-list] und wählen Sie die Route aus, die im Rahmen der Cloud TPU-Einrichtung automatisch von Google erstellt wurde. Die ID des Peering-Eintrags beginnt mit `peering-route`.

Klicken Sie oben auf der Seite auf **Löschen**.

## Fazit

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Glückwunsch!

Sie haben eine Anwendung erstellt, die Cloud TPU verwendet.

Weitere Informationen finden Sie auf der Dokumentationswebsite für Cloud TPU:

[https://cloud.google.com/tpu/][tpu-docs]

[request-tpu-quota]: https://services.google.com/fb/forms/cloud-tpu-beta-request/
[spotlight-network-peering]: walkthrough://spotlight-pointer?cssSelector=#cfctest-section-nav-item-peering_list
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-routes-list]: walkthrough://spotlight-pointer?cssSelector=#cfctest-section-nav-item-routes_list
[tensor-flow]: https://www.tensorflow.org/
[tpu-docs]: https://cloud.google.com/tpu/docs/
[tpu-regions]: https://cloud.google.com/tpu/docs/regions
