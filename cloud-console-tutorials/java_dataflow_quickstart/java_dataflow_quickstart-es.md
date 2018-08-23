# Tutorial de recuento de palabras de Dataflow

<walkthrough-tutorial-url url="https://cloud.google.com/dataflow/docs/quickstarts/quickstart-java-maven"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="dataflow-intro" key="directory"></walkthrough-watcher-constant>
<walkthrough-watcher-constant value="dataflow-intro" key="job-name"></walkthrough-watcher-constant>

## Introducción

En este tutorial, ejecutarás un ejemplo muy sencillo de flujo de procesamiento con Java para descubrir los aspectos básicos del servicio Cloud Dataflow.

Los flujos de procesamiento de Dataflow pueden ser por lotes** (que procesan entradas vinculadas, como un archivo o una tabla de base de datos) o en streaming** (que procesan entradas sin vincular de un origen como Cloud Pub/Sub). En el ejemplo de este tutorial se muestra un flujo de procesamiento por lotes que cuenta las palabras de las obras de Shakespeare.

Antes de empezar, debes comprobar los requisitos previos de tu proyecto de Cloud Platform y llevar a cabo la configuración inicial.

## Configuración del proyecto

Google Cloud Platform organiza los recursos en proyectos para que puedas tener en un solo lugar todos los recursos de una misma aplicación.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>
<walkthrough-project-permissions permissions="dataflow.jobs.create"></walkthrough-project-permissions>

## Configurar Cloud Dataflow

Para usar Dataflow, tienes que activar las API de Cloud Dataflow y abrir Cloud Shell.

### Activar las API de Google Cloud

<walkthrough-enable-apis apis="compute.googleapis.com,dataflow,cloudresourcemanager.googleapis.com,logging,storage_component,storage_api,bigquery,pubsub">
</walkthrough-enable-apis>

### Abrir Cloud Shell

Cloud Shell es una herramienta de línea de comandos integrada para la consola. En este tutorial la emplearás para desplegar la aplicación.

Para abrir esta herramienta, haz clic en el <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[icono][spotlight-open-devshell] que se encuentra en la barra de navegación de la parte superior de la consola.

## Instalar ejemplos de Cloud Dataflow en Cloud Shell

Para usar el SDK de Cloud Dataflow para Java, tu entorno de desarrollo necesitará Java, el SDK de Google Cloud, el SDK de Cloud Dataflow para Java y Apache Maven para administrar las dependencias de los SDK. En este tutorial se utilizan un entorno de Cloud Shell con Java, el SDK de Google Cloud y Maven (previamente instalados).

Si lo prefieres, puedes seguir este tutorial [en tu máquina local][dataflow-java-tutorial].

### Descargar los ejemplos y el SDK de Cloud Dataflow para Java mediante el comando de Maven

Cuando ejecutes este comando, Maven creará una estructura de proyecto y un archivo de configuración para descargar la versión pertinente del SDK de Cloud Dataflow.

```bash
mvn archetype:generate \
    -DarchetypeArtifactId=google-cloud-dataflow-java-archetypes-examples \
    -DarchetypeGroupId=com.google.cloud.dataflow \
    -DarchetypeVersion=2.1.0 \
    -DgroupId=com.example \
    -DartifactId={{directorio}} \
    -Dversion="0.1" \
    -DinteractiveMode=false \
    -Dpackage=com.example
```

  *  `archetypeArtifactId` y `archetypeGroupId` se utilizan para definir la estructura del proyecto de ejemplo.
  *  `groupId` es el prefijo del nombre del paquete de Java de tu organización; por ejemplo, `com.miempresa`.
  *  `artifactId` define el nombre del archivo jar creado. En este tutorial utiliza el valor predeterminado (`{{directorio}}`).

Ejecuta el comando Maven en Cloud Shell.

### Cambiar el directorio

Cambia el directorio de trabajo por `{{directorio}}`.

```bash
cd {{directorio}}
```

Si quieres ver el código de este ejemplo, se encuentra en el subdirectorio `src`, dentro del directorio `{{directorio}}`.

## Configurar un segmento de Cloud Storage

Cloud Dataflow utiliza segmentos de Cloud Storage para almacenar los datos de salida y almacenar en caché tu código de flujo de procesamiento.

### Ejecutar gsutil mb

En Cloud Shell utiliza el comando `gsutil mb` para crear un segmento de Cloud Storage.

```bash
gsutil mb gs://{{id-proyecto-sin-dominio}}
```

Para obtener más información sobre la herramienta `gsutil`, consulta la [documentación][gsutil-docs].

## Crear y lanzar un flujo de procesamiento

En Cloud Dataflow, las tareas de tratamiento de datos se representan mediante flujos de procesamiento** que leen los datos de entrada, los transforman y, luego, producen datos de salida. Entre las modificaciones que se realizan en un flujo de procesamiento se pueden incluir el filtrado, la agrupación, la comparación y la unificación de datos.

Si quieres ver el código de este ejemplo, se encuentra en el subdirectorio `src`, dentro del directorio `{{directorio}}`.

### Lanzar tu flujo de procesamiento en el servicio Dataflow

Utiliza el comando `mvn exec` de Apache Maven para lanzar tu flujo de procesamiento en el servicio.
El flujo de procesamiento que se está ejecutando se considera una tarea**.

```bash
mvn compile exec:java \
  -Dexec.mainClass=com.example.WordCount \
  -Dexec.args="--project={{id-proyecto}} \
  --stagingLocation=gs://{{id-proyecto-sin-dominio}}/staging/ \
  --output=gs://{{id-proyecto-sin-dominio}}/output \
  --runner=DataflowRunner \
  --jobName={{nombre-tarea}}"
```

  *  `stagingLocation` es el segmento de almacenamiento que utilizará Cloud Dataflow para los archivos binarios y los demás datos con los que se ejecuta tu flujo de procesamiento. Esta ubicación se puede compartir en varias tareas.
  *  `output` es el segmento que usa el ejemplo del recuento de palabras para almacenar los resultados de la tarea.

### Tu tarea se está ejecutando

¡Enhorabuena! Tus datos binarios ya se han almacenado en área de stage en el segmento de almacenamiento que creaste antes y las instancias de Compute Engine se están generando. Además, Cloud Dataflow dividirá el archivo de entrada para que varias máquinas puedan procesar tus datos en paralelo.

Nota: Cuando veas el mensaje Job finished (Tarea finalizada), podrás cerrar Cloud Shell.

Si quieres limpiar el proyecto de Maven que has generado, ejecuta `cd .. && rm -R {{directorio}}` en Cloud Shell para eliminar el directorio.

## Supervisar tu tarea

Puedes comprobar el progreso de tu flujo de procesamiento en la página de la interfaz de supervisión de Cloud Dataflow.

### Acceder a la página de Cloud Dataflow

Abre el [menú][spotlight-console-menu] que se encuentra en la parte izquierda de la consola.

Luego, elige la sección **Dataflow**.

<walkthrough-menu-navigation sectionid="DATAFLOW_SECTION"></walkthrough-menu-navigation>

### Seleccionar tu tarea

Haz clic en tu tarea para ver los detalles.

### Explorar los detalles y las métricas del flujo de procesamiento

Puedes explorar el flujo de procesamiento en la parte de la izquierda y, a la derecha, la información de la tarea. Para ver el estado detallado de la tarea, haz clic en [Registros][spotlight-job-logs]. Haz clic en un paso del flujo de procesamiento para ver sus métricas.

Cuando la tarea termine, cambiará su estado y se detendrán automáticamente las instancias de Compute Engine que se hayan utilizado en dicha tarea.

## Ver los archivos de salida

Ahora que la tarea se ha ejecutado, puedes explorar los archivos de salida en Cloud Storage.

### Ir a la página de Cloud Storage

Abre el [menú][spotlight-console-menu] que se encuentra en la parte izquierda de la consola.

Luego, elige la sección **Storage**.

<walkthrough-menu-navigation sectionid="STORAGE_SECTION"></walkthrough-menu-navigation>

### Ir al segmento de almacenamiento

En la lista de segmentos, selecciona el que has creado antes. Si has usado el nombre sugerido, se llamará `{{id-proyecto}}`.

El segmento contiene una carpeta en área de stage y varias carpetas de salida. Dataflow guarda el resultado en fragmentos, por lo que el segmento contendrá varios archivos de salida.

## Eliminar los recursos

Para evitar que te cobremos por el uso de Cloud Storage, elimina el segmento que has creado.

### Volver al navegador de segmentos

Haz clic en el enlace [Segmentos][spotlight-buckets-link].

### Seleccionar el segmento

Marca la casilla que aparece junto al segmento que has creado.

### Eliminar el segmento

Haz clic en [Eliminar][spotlight-delete-bucket] y confirma que quieres ejecutar dicha acción.

## Conclusión

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Esto es lo que puedes hacer a continuación:

  *  [Obtener más información sobre el ejemplo del recuento de palabras][wordcount]
  *  [Obtener más información sobre el modelo de programación de Cloud Dataflow][df-model]
  *  [Explorar el SDK de Cloud Dataflow en GitHub][df-sdk]

También puedes configurar tu entorno local:

  *  [Usar Eclipse para ejecutar Dataflow][df-eclipse]
  *  [Usar Python para ejecutar Dataflow][df-python]

[dataflow-java-tutorial]: https://cloud.google.com/dataflow/docs/quickstarts/quickstart-java-maven
[df-eclipse]: https://cloud.google.com/dataflow/docs/quickstarts/quickstart-java-eclipse
[df-model]: https://cloud.google.com/dataflow/model/programming-model-beam
[df-python]: https://cloud.google.com/dataflow/docs/quickstarts/quickstart-python
[df-sdk]: https://github.com/apache/beam/tree/master/sdks/java
[gsutil-docs]: https://cloud.google.com/storage/docs/gsutil
[spotlight-buckets-link]: walkthrough://spotlight-pointer?cssSelector=.p6n-cloudstorage-path-link
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-delete-bucket]: walkthrough://spotlight-pointer?cssSelector=#p6n-cloudstorage-delete-buckets
[spotlight-job-logs]: walkthrough://spotlight-pointer?cssSelector=#p6n-dax-job-logs-toggle
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[wordcount]: https://beam.apache.org/get-started/wordcount-example/
