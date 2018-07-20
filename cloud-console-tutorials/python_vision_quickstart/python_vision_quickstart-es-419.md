# API de Cloud Vision

<walkthrough-test-start-page url="/start?tutorial=python_vision_quickstart_v2"></walkthrough-test-start-page>

<walkthrough-tutorial-url url="https://cloud.google.com/vision/docs/label-tutorial"></walkthrough-tutorial-url>

<walkthrough-watcher-constant value="https://github.com/GoogleCloudPlatform/python-docs-samples.git" key="repo-url"></walkthrough-watcher-constant>

<walkthrough-watcher-constant value="python-docs-samples" key="repo-name"></walkthrough-watcher-constant>

<walkthrough-devshell-precreate></walkthrough-devshell-precreate>

## Introducción

En este instructivo, se explica el funcionamiento de una aplicación básica de la
API de Vision mediante una solicitud `LABEL_DETECTION`. La solicitud
`LABEL_DETECTION` agrega una imagen a una etiqueta, que se selecciona según el
contenido de la imagen. Por ejemplo, una foto de un establo puede generar la
etiqueta “establo”, “granja” o anotaciones similares.

Estos son los pasos que realizarás:

*   **Ejecución de tu app de detección de etiquetas**: Aprenderás a ejecutarla
    con Google Cloud Shell en el navegador.
*   **Después de la app…** Tu app será real y podrás experimentar con ella o
    quitarla y volver a comenzar.

[“Python” y sus logotipos son marcas comerciales de
Python Software Foundation.](walkthrough://footnote)

# Configuración del proyecto

Deberás habilitar la API de Cloud Vision mediante un proyecto.

Google Cloud Platform organiza los recursos en proyectos. Esto te permite
recopilar todos los recursos relacionados con una aplicación específica en un
solo lugar.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## Cómo habilitar la API de Vision

Para aceptar solicitudes, debes habilitar la API de Vision en tu proyecto.

### Navega al administrador de la API

El administrador define las API que se habilitan en tu proyecto.

Abre el [menú](walkthrough://spotlight-pointer?spotlightId=console-nav-menu) que
se encuentra en el lado izquierdo de la consola.

Luego, ve a la sección **API y servicios**.

<walkthrough-menu-navigation sectionid="API_SECTION"></walkthrough-menu-navigation>

### Ve las API disponibles

Para habilitar las API, haz clic en el botón [Habilitar
API](walkthrough://spotlight-pointer?cssSelector=.p6n-action-bar-button).

### Selecciona la API de Vision

Haz clic en el vínculo de la
[API de Vision](walkthrough://spotlight-pointer?cssSelector=.p6n-action-bar-button)

### Habilita la API de Vision

Para habilitar la API de Vision, haz clic en el botón
[Habilitar](walkthrough://spotlight-pointer?spotlightId=api-vision.googleapis.com).
Más adelante, te explicaremos cómo crear credenciales para tu proyecto.

## Cómo usar Google Cloud Shell

Cloud Shell incluye una herramienta de línea de comandos integrada para la
consola. Usarás Cloud Shell para ejecutar tu app.

### Abre Google Cloud Shell

Haz clic en el
<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>
[ícono](walkthrough://spotlight-pointer?spotlightId=devshell-activate-button)
en la barra de navegación de la parte superior de la consola para abrir
Cloud Shell.

### Clona el código de muestra

Usa Cloud Shell para clonar el código de “Hello World” y navegar por él. El
código de muestra se clonó desde tu repositorio de proyecto a Cloud Shell.

Nota: Si el directorio ya existe, quita los archivos antiguos antes de realizar
la clonación:

```bash
rm -rf {{repo-name}}
```

Clona el un repositorio de muestra con el siguiente comando:

```bash
git clone {{repo-url}}
```

Luego, cambia al directorio del instructivo:

```bash
cd {{repo-name}}/vision/cloud-client/quickstart
```

## Cómo configurar tu implementación

Estás en el directorio principal del código de muestra. En él, podrás ver los
archivos que configuran tu aplicación.

### Explora la aplicación

Ingresa el siguiente comando para ver el código de tu aplicación:

```bash
cat quickstart.py
```

El archivo `quickstart.py` le da formato a la información de tu solicitud, como
el tipo de solicitud y contenido. Expande cada una de las siguientes secciones
para saber más.

Las solicitudes a la API de Vision se proporcionan como objetos JSON. Consulta
la [Referencia de la API de Vision][vision-request-doc] para ver la información
completa sobre la estructura específica de las solicitudes. Tu solicitud JSON
solo se envía cuando llamas a `execute`. Este patrón te permite pasar las
solicitudes y llamar a `execute` según sea necesario.

## Cómo probar la aplicación

Para usar la API, debes configurar credenciales. A fin de usar una API de Cloud,
deberás configurar las [credenciales][auth-doc] adecuadas para tu aplicación.
Esto permitirá autenticar su identidad ante el servicio y obtener la
autorización para ejecutar tareas. Luego, probarás la API con imágenes de
muestra.

### Crea una cuenta de servicio

Debes crear una cuenta de servicio para autenticar tus solicitudes de API. Si ya
creaste una cuenta de servicio, se volverá a usar.

```bash
gcloud iam service-accounts create vision-quickstart
```

### Crea credenciales

Luego, crea una clave de cuenta de servicio y configúrala como tus credenciales
predeterminadas.

```bash
gcloud iam service-accounts keys create key.json --iam-account    vision-quickstart@{{project-id}}.iam.gserviceaccount.com
```

```bash
export GOOGLE_APPLICATION_CREDENTIALS=key.json
```

<walkthrough-test-code-output text="created key"></walkthrough-test-code-output>

### Prueba tu app

Para probar tu app con una imagen de muestra, ingresa lo siguiente:

```bash
python quickstart.py
```

En la fuente, se especifica el recurso de imagen (`resources/wakeupcat.jpg`).
[Ver imagen][cat-picture]

## Conclusión

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

¡Felicitaciones! Estás listo para usar la API de Cloud Vision

A continuación puedes hacer lo siguiente:

*   Seguir el instructivo de [detección de rostros][face-tutorial]
*   Probar el instructivo de [texto en documentos][document-text-tutorial]
*   Ver las [apps de muestra][vision-samples]
*   Descargar el [SDK de Google Cloud][get-cloud-sdk] para ejecutarlo en tu
    máquina local

[auth-doc]: https://cloud.google.com/vision/docs/auth
[cat-picture]: https://raw.githubusercontent.com/GoogleCloudPlatform/python-docs-samples/master/vision/cloud-client/quickstart/resources/wakeupcat.jpg
[document-text-tutorial]: https://cloud.google.com/vision/docs/fulltext-annotations
[face-tutorial]: https://cloud.google.com/vision/docs/face-tutorial
[get-cloud-sdk]: https://cloud.google.com/sdk/
[vision-request-doc]: https://cloud.google.com/vision/reference/rest
[vision-samples]: https://cloud.google.com/vision/docs/samples
