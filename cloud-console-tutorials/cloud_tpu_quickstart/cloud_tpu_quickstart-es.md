# Tutorial de inicio rápido con una unidad de procesamiento de tensor

<walkthrough-tutorial-url url="https://cloud.google.com/tpu/docs/quickstart"></walkthrough-tutorial-url>

## Introducción

Las [unidades de procesamiento de tensor][tpu-docs] (TPU) sirven para acelerar cargas de trabajo de aprendizaje automático concretas de [TensorFlow][tensor-flow]. En este tutorial, aprenderás a crear una TPU de Cloud para ejecutar un modelo de TensorFlow básico.

## Configuración del proyecto

Google Cloud Platform organiza los recursos en proyectos para que puedas tener en un solo lugar todos los recursos de una misma aplicación.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## Configurar el SDK de Google Cloud

### Abrir Cloud Shell

Cloud Shell es una herramienta de línea de comandos integrada para la consola que puedes usar para conectarte a tu TPU.

Para abrir esta herramienta, haz clic en el <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[icono][spotlight-open-devshell] que se encuentra en la barra de navegación de la parte superior de la consola.

### Especificar una zona

Usa el siguiente comando para especificar la zona donde tienes previsto crear tu recurso de TPU:

```bash
gcloud config set compute/zone us-central1-c
```

En este ejemplo, utiliza la zona `us-central1-c`.

Para ver las zonas disponibles, visita el sitio web de la documentación de la TPU de Cloud:

[Regiones y zonas de la TPU de Cloud][tpu-regions]

## Crear recursos

Para hacer este tutorial de inicio rápido, necesitarás una instancia de una máquina virtual de Compute Engine. La imagen incluye la herramienta de línea de comandos `gcloud beta` y la versión candidata para el lanzamiento de TensorFlow que sea necesaria para ejecutar TensorFlow en los recursos de TPU de Cloud.

### Crear una máquina virtual de Compute Engine

Utiliza la herramienta de línea de comandos `gcloud` para crear una instancia de máquina virtual:

```bash
gcloud compute instances create tpu-demo-vm \
  --machine-type=n1-standard-4 \
  --boot-disk-size=500GB \
  --image-project=ml-images \
  --image-family=tf-1-8 \
  --scopes=cloud-platform
```

### Habilitar la API de TPU

Si todavía no lo has hecho, activa la API de TPU.

<walkthrough-enable-apis apis="tpu.googleapis.com"></walkthrough-enable-apis>

### Crear un recurso de TPU

Utiliza el comando `gcloud beta compute tpus create` para crear un recurso de TPU de Cloud. En este ejemplo, el valor de la marca `--range` debe ser `10.240.1.0/29`.

```bash
gcloud beta compute tpus create demo-tpu \
  --range=10.240.1.0/29 --version=1.8
```

## Ejecutar un ejemplo de TensorFlow

Conéctate a tu instancia y crea un programa de TensorFlow con una llamada a procedimiento remoto (RPC) que apunte al punto de conexión de la red de tu TPU.

### Conectarse a la instancia

Introduce el siguiente comando para acceder a la máquina virtual a través de SSH. Si es la primera vez que utilizas SSH en Cloud Shell, tendrás que crear una clave privada:

```bash
gcloud compute ssh tpu-demo-vm
```

### Asignar un nombre a tu TPU

En la instancia, configura una variable de entorno con el nombre que elijas para tu TPU. En este ejemplo, usa "demo-tpu":

```bash
export TPU_NAME="demo-tpu"
```

### Crear la aplicación

Crea una aplicación Python que apunte al punto de conexión de tu TPU de Cloud y ejecute una operación informática sencilla:

```bash
nano cloud-tpu.py
```

Copia y pega el contenido de este archivo:

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
    tpu=[os.environ['NOMBRE_TPU']]).get_master()

with tf.Session(tpu_grpc_url) as sess:
  sess.run(tpu.initialize_system())
  sess.run(tf.global_variables_initializer())
  output = sess.run(tpu_computation)
  print(output)
  sess.run(tpu.shutdown_system())

print('¡Listo!')
```

### Ejecutar la aplicación

Ejecuta el programa de TensorFlow.

```bash
python cloud-tpu.py
```

Si quieres, puedes crear y ejecutar otros programas de TensorFlow que usen el dispositivo de TPU.

Cuando hayas terminado de hacer pruebas, sal de la instancia.

```bash
exit
```

## Eliminar recursos

Para evitar incurrir en cargos en tu cuenta de Google Cloud Platform por usar los recursos de este tutorial de inicio rápido, haz lo siguiente:

### Elimina el recurso de TPU y la instancia de VM

Usa la herramienta de línea de comandos gcloud para eliminar tu recurso de TPU de Cloud.

```bash
gcloud beta compute tpus delete demo-tpu
```

Usa la herramienta de línea de comandos `gcloud` para eliminar tu instancia de Compute Engine.

```bash
gcloud compute instances delete tpu-demo-vm
```

### Elimina la red de VPC

Ve a la sección Red de VPC de la consola de Google Cloud Platform.

<walkthrough-menu-navigation sectionid="VIRTUAL_NETWORK_SECTION"></walkthrough-menu-navigation>

Ve a la sección [Emparejamiento entre redes de VPC][spotlight-network-peering] y selecciona la red de VPC que creó Google automáticamente durante la configuración de la TPU de Cloud. El ID de la entrada de emparejamiento empieza por `cp-to-tp-peering`.

En la parte superior de la página, haz clic en **Eliminar**.

### Elimina la ruta de VPC

Ve a la sección [Rutas][spotlight-routes-list] y selecciona la que creó Google automáticamente como parte del proceso de configuración de la TPU de Cloud. El ID de la entrada de emparejamiento empieza por `peering-route`.

En la parte superior de la página, haz clic en **Eliminar**.

## Conclusión

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

¡Enhorabuena!

Has creado una aplicación que usa la TPU de Cloud.

Para obtener más información, visita el sitio web de la documentación de la TPU de Cloud:

[https://cloud.google.com/tpu/][tpu-docs]

[request-tpu-quota]: https://services.google.com/fb/forms/cloud-tpu-beta-request/
[spotlight-network-peering]: walkthrough://spotlight-pointer?cssSelector=#cfctest-section-nav-item-peering_list
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-routes-list]: walkthrough://spotlight-pointer?cssSelector=#cfctest-section-nav-item-routes_list
[tensor-flow]: https://www.tensorflow.org/
[tpu-docs]: https://cloud.google.com/tpu/docs/
[tpu-regions]: https://cloud.google.com/tpu/docs/regions
