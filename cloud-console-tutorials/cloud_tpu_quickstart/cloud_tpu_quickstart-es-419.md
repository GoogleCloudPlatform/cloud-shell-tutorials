# QuickStart sobre el uso de una TPU

<walkthrough-tutorial-url url="https://cloud.google.com/tpu/docs/quickstart"></walkthrough-tutorial-url>

## Introducción

Puedes usar una [unidad de procesamiento de tensor][tpu-docs] (TPU) para acelerar cargas de trabajo de aprendizaje automático específicas en [TensorFlow][tensor-flow]. En este instructivo, se explica cómo crear un recurso de Cloud TPU y usarlo para ejecutar un modelo básico de TensorFlow.

## Configuración del proyecto

Google Cloud Platform organiza los recursos en proyectos. Esto te permite recopilar todos los recursos relacionados con una aplicación específica en un solo lugar.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## Configura el SDK de Cloud

### Abre Cloud Shell

Cloud Shell incluye una herramienta de línea de comandos integrada para Console que puedes usar a fin de conectarte a tu TPU.

Para abrir Cloud Shell, haz <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>clic en el [ícono][spotlight-open-devshell] de la barra de navegación ubicada en la parte superior de Console.

### Especifica una zona

Usa el siguiente comando para especificar la zona en la que vas a crear tu recurso de TPU:

```bash
gcloud config set compute/zone us-central1-c
```

Para este ejemplo, usa la zona `us-central1-c`.

Para ver las zonas disponibles, visita el sitio web de documentación de Cloud TPU:

[Regiones y zonas de Cloud TPU][tpu-regions]

## Crea recursos

Para esta guía de inicio rápido, se requiere una instancia de máquina virtual de Compute Engine. La imagen incluye la `versión Beta de la herramienta de línea de comandos de gcloud`, así como una versión candidata para lanzamiento de TensorFlow, que es necesaria a fin de ejecutar TensorFlow en recursos de Cloud TPU.

### Crea una VM de Compute Engine

Usa la herramienta de línea de comandos de `gcloud` para crear una instancia de VM.

```bash
gcloud compute instances create tpu-demo-vm \
  --machine-type=n1-standard-4 \
  --boot-disk-size=500GB \
  --image-project=ml-images \
  --image-family=tf-1-8 \
  --scopes=cloud-platform
```

### Habilita la API de TPU

Activa la API de TPU si todavía no lo hiciste.

<walkthrough-enable-apis apis="tpu.googleapis.com"></walkthrough-enable-apis>

### Crea un recurso de TPU

Usa el comando `gcloud beta compute tpus create` para crear un nuevo recurso de Cloud TPU. Para este ejemplo, configura la marca `--range` en `10.240.1.0/29`.

```bash
gcloud beta compute tpus create demo-tpu \
  --range=10.240.1.0/29 --version=1.8
```

## Ejecuta un ejemplo de TensorFlow

Conéctate a tu instancia y crea un programa de TensorFlow con una llamada de procedimiento remoto (RPC) que apunte al extremo de red de tu TPU.

### Conéctate a tu instancia

Ingresa el siguiente comando para establecer una conexión SSH a la VM. Si es la primera vez que usas el protocolo SSH desde Cloud Shell, deberás crear una clave privada:

```bash
gcloud compute ssh tpu-demo-vm
```

### Asígnale un nombre a tu TPU

En la instancia, configura una variable de entorno con un nombre que elijas para la TPU. En este ejemplo, usa "demo-tpu".

```bash
export TPU_NAME="demo-tpu"
```

### Crea la aplicación

Crea una aplicación de Python que apunte a tu extremo de Cloud TPU y ejecute un cálculo simple.

```bash
nano cloud-tpu.py
```

Copia y pega este contenido de archivo:

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

### Ejecuta la aplicación

Ejecuta el programa de TensorFlow.

```bash
python cloud-tpu.py
```

Puedes crear y ejecutar otros programas de TensorFlow que usen el dispositivo de TPU.

Cuando termines de hacer experimentos, sal de la instancia.

```bash
exit
```

## Borra los recursos

Sigue estos pasos para evitar que se apliquen cargos a tu cuenta de Google Cloud Platform por los recursos de este QuickStart:

### Borra el recurso de TPU y la instancia de VM

Usa la herramienta de línea de comandos de gcloud para borrar el recurso de Cloud TPU.

```bash
gcloud beta compute tpus delete demo-tpu
```

Usa la herramienta de línea de comandos de `gcloud` para borrar tu instancia de Compute Engine.

```bash
gcloud compute instances delete tpu-demo-vm
```

### Borra la red de VPC

Ve a la sección Red de VPC en Google Cloud Platform Console.

<walkthrough-menu-navigation sectionid="VIRTUAL_NETWORK_SECTION"></walkthrough-menu-navigation>

Navega a la sección [Intercambio de tráfico entre redes de VPC][spotlight-network-peering] y selecciona la red de VPC que Google creó automáticamente como parte de la configuración de Cloud TPU. El ID de la entrada de intercambio de tráfico comienza con `cp-to-tp-peering`.

Haz clic en **Borrar** en la parte superior de la página.

### Borra la ruta de VPC

Navega a la sección [Rutas][spotlight-routes-list] y selecciona la que Google creó automáticamente como parte de la configuración de Cloud TPU. El ID de la entrada de intercambio de tráfico comienza con `peering-route`.

Haz clic en **Borrar** en la parte superior de la página.

## Conclusión

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Felicitaciones.

Completaste la creación de una aplicación que usa las unidades de Cloud TPU.

Para obtener más información, visita el sitio web de documentación de Cloud TPU:

[https://cloud.google.com/tpu/][tpu-docs]

[request-tpu-quota]: https://services.google.com/fb/forms/cloud-tpu-beta-request/
[spotlight-network-peering]: walkthrough://spotlight-pointer?cssSelector=#cfctest-section-nav-item-peering_list
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-routes-list]: walkthrough://spotlight-pointer?cssSelector=#cfctest-section-nav-item-routes_list
[tensor-flow]: https://www.tensorflow.org/
[tpu-docs]: https://cloud.google.com/tpu/docs/
[tpu-regions]: https://cloud.google.com/tpu/docs/regions
