# API Cloud Vision

<walkthrough-test-start-page url="/start?tutorial=python_vision_quickstart_v2"></walkthrough-test-start-page>

<walkthrough-tutorial-url url="https://cloud.google.com/vision/docs/label-tutorial"></walkthrough-tutorial-url>

<walkthrough-watcher-constant value="https://github.com/GoogleCloudPlatform/python-docs-samples.git" key="repo-url"></walkthrough-watcher-constant>

<walkthrough-watcher-constant value="python-docs-samples" key="repo-name"></walkthrough-watcher-constant>

<walkthrough-devshell-precreate></walkthrough-devshell-precreate>

## Introducción

En este tutorial aprenderás a crear una aplicación básica de la API Vision
mediante una petición `LABEL_DETECTION`, que ``añade un rótulo (o "etiqueta") a
la imagen seleccionada en función de su contenido. Por ejemplo, una foto de un
granero puede generar la etiqueta "granero" o "granja", o una anotación similar.

Estos son los pasos que seguirás:

*   **Ejecutar la aplicación de detección de etiquetas** mediante Google Cloud
    Shell y sin salir del navegador.
*   **Después de completar el tutorial,** tu aplicación será totalmente real y
    podrás probarla o eliminarla para empezar de nuevo.

["Python" y los logotipos de Python son marcas o marcas registradas de Python
Software Foundation.](walkthrough://footnote)

# Configuración del proyecto

Es necesario habilitar la API Cloud Vision a través de un proyecto.

Google Cloud Platform organiza los recursos en proyectos para que puedas tener
en un solo lugar todos los recursos de una aplicación.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## Habilitar la API Vision

Tu proyecto debe habilitar la API Vision para aceptar peticiones.

### Ir al administrador de APIs

El administrador de APIs establece qué APIs están habilitadas en tu proyecto.

Abre el [menú](walkthrough://spotlight-pointer?spotlightId=console-nav-menu) que
se encuentra en el lado izquierdo de la consola.

Luego, ve a la sección **APIs y servicios**.

<walkthrough-menu-navigation sectionid="API_SECTION"></walkthrough-menu-navigation>

### Ver las API disponibles

Para habilitar las API, haz clic en el botón [Habilitar
API](walkthrough://spotlight-pointer?cssSelector=.p6n-action-bar-button).

### Seleccionar la API Vision

Haz clic en el enlace de la [API Vision](walkthrough://spotlight-pointer?spotlightId=api-vision.googleapis.com).

### Habilitar la API Vision

Para habilitar la API Vision, haz clic en el botón
[Habilitar](walkthrough://spotlight-pointer?spotlightId=api-enable-vision.googleapis.com). Crearás las credenciales de tu proyecto más
adelante en este tutorial.

## Usar Google Cloud Shell

Cloud Shell es una herramienta de línea de comandos integrada para la consola.
Aquí la emplearás para ejecutar la aplicación.

### Abrir Google Cloud Shell

Abre Cloud Shell. Para ello, haz clic en el
<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>
[icono](walkthrough://spotlight-pointer?spotlightId=devshell-activate-button)
que se encuentra en la parte superior de la consola, en la barra de navegación.

### Clonar el código de muestra

Utiliza Cloud Shell para clonar y navegar hasta el código "Hello World". El
código de muestra se clona del repositorio de tu proyecto a Cloud Shell.

Nota: Si el directorio ya existe, borra los archivos anteriores antes de iniciar
la clonación:

```bash
rm -rf {{repo-name}}
```

Clona un repositorio de muestra:

```bash
git clone {{repo-url}}
```

Luego, ve al directorio del tutorial:

```bash
cd {{repo-name}}/vision/cloud-client/quickstart
```

## Configurar el despliegue

Ahora estás en el directorio principal del código de muestra. Veamos los
archivos que configuran la aplicación.

### Explorar la aplicación

Introduce el siguiente comando para ver el código de tu aplicación:

```bash
cat quickstart.py
```

El archivo `quickstart.py` aplica formato a la información de la petición, como
el tipo de petición y el contenido. Despliega cada sección para conocer los
detalles.

Las peticiones a la API Vision se transfieren como objetos JSON. Consulta la
[referencia de dicha API][vision-request-doc] para obtener información detallada
sobre la estructura concreta de dichas peticiones. La petición JSON se envía
únicamente tras invocar el comando `execute`. Este patrón permite transferir las
peticiones e invocar el comando `execute` según sea necesario.

## Probar la aplicación

Para usar una API, es necesario configurar las credenciales correspondientes. En
el caso de las API de Cloud, debes configurar [credenciales][auth-doc] para tu
aplicación. De esta forma, la aplicación podrá autenticar su identidad ante el
servicio y obtendrá la autorización pertinente para realizar tareas. Luego,
probarás la API con imágenes de muestra.

### Crear una cuenta de servicio

Para autenticar las peticiones de la API, es necesario crear una cuenta de
servicio. Si ya tienes una, se reutilizará.

```bash
gcloud iam service-accounts create vision-quickstart
```

### Crear credenciales

A continuación, crea una clave de cuenta de servicio, que se convertirá en tus
credenciales predeterminadas.

```bash
gcloud iam service-accounts keys create key.json --iam-account    vision-quickstart@{{id-proyecto}}.iam.gserviceaccount.com
```

```bash
export GOOGLE_APPLICATION_CREDENTIALS=key.json
```

<walkthrough-test-code-output text="created key"></walkthrough-test-code-output>

### Probar la aplicación

Para probar tu aplicación con una imagen de muestra, escribe lo siguiente:

```bash
python quickstart.py
```

El recurso de imagen `resources/wakeupcat.jpg` se especifica en el origen. ([Ver
imagen][cat-picture])

## Conclusión

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

¡Enhorabuena! Ya puedes usar la API Cloud Vision.

Esto es lo que puedes hacer a continuación:

*   Realizar el tutorial de [detección de caras][face-tutorial].
*   Probar el tutorial de [texto en documentos][document-text-tutorial].
*   Ver las [aplicaciones de muestra][vision-samples].
*   Descargar el [SDK de Google Cloud][get-cloud-sdk] para ejecutarlo en tu
    máquina local.

[auth-doc]: https://cloud.google.com/vision/docs/auth
[cat-picture]: https://raw.githubusercontent.com/GoogleCloudPlatform/python-docs-samples/master/vision/cloud-client/quickstart/resources/wakeupcat.jpg
[document-text-tutorial]: https://cloud.google.com/vision/docs/fulltext-annotations
[face-tutorial]: https://cloud.google.com/vision/docs/face-tutorial
[get-cloud-sdk]: https://cloud.google.com/sdk/
[vision-request-doc]: https://cloud.google.com/vision/reference/rest
[vision-samples]: https://cloud.google.com/vision/docs/samples
