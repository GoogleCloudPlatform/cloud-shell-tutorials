# Inicio rápido de App Engine

<walkthrough-tutorial-url url="https://cloud.google.com/appengine/docs/python/quickstart"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="https://github.com/GoogleCloudPlatform/python-docs-samples" key="repo-url"></walkthrough-watcher-constant>
<walkthrough-watcher-constant value="python-docs-samples/appengine/standard/hello_world" key="repo-dir"></walkthrough-watcher-constant>

## Introducción

En este tutorial aprenderás a desplegar una aplicación [Python](https://python.org/) de muestra en Google App Engine mediante el comando `gcloud`.

Estos son los pasos que tendrás que seguir:

  *  **Crear un proyecto**

     Los proyectos incluyen el código, máquinas virtuales y otros recursos para facilitar el desarrollo y la monitorización.

  *  **Crear y ejecutar una aplicación "Hello, world!" **

     Aprenderás a ejecutar la aplicación mediante Google Cloud Shell y sin salir del navegador. Al final, la desplegarás en la Web mediante el comando `gcloud`.

  *  **Después del tutorial**

     Tu aplicación será totalmente real y podrás probarla una vez desplegada, o eliminarla para empezar desde cero.

["Python" y los logotipos de Python son marcas o marcas registradas de Python Software Foundation.](walkthrough://footnote)

## Configuración del proyecto

Para desplegar una aplicación, primero tienes que crear un proyecto.

Google Cloud Platform organiza los recursos en proyectos para que puedas tener en un solo lugar todos los recursos de una misma aplicación.

<walkthrough-devshell-precreate></walkthrough-devshell-precreate>

<walkthrough-project-setup></walkthrough-project-setup>

## Usar Google Cloud Shell

Cloud Shell es una herramienta de línea de comandos integrada para la consola. La usaremos para desplegar la aplicación.

### Abrir Google Cloud Shell

Abre Cloud Shell. Para ello, haz clic en el icono <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[][spotlight-open-devshell] que se encuentra en la barra de navegación de la parte superior de la consola.

### Clonar el código de muestra

Utiliza Cloud Shell para clonar y navegar hasta el código "Hello World". El código de muestra se clona del repositorio de tu proyecto a Cloud Shell.

Nota: Si el directorio ya existe, borra los archivos anteriores antes de iniciar la clonación.

En Cloud Shell, introduce lo siguiente:

```bash
git clone {{repo-url}}
```

Luego, ve al directorio del tutorial:

```bash
cd {{repo-dir}}
```

## Configurar el despliegue

Ahora estás en el directorio principal del código de muestra. A continuación, veremos los archivos que sirven para configurar la aplicación.

### Explorar la aplicación

Introduce el siguiente comando para ver el código de tu aplicación:

```bash
cat main.py
```

Se trata de una aplicación Python sencilla que utiliza el framework web [webapp2](https://webapp2.readthedocs.io/). Esta secuencia de comandos Python responde a una petición con un encabezado HTTP y el mensaje `Hello, World!`.

### Explorar tu configuración

Google App Engine utiliza archivos YAML para especificar la configuración de los despliegues.
Los archivos `app.yaml` contienen información sobre la aplicación, como el entorno de tiempo de ejecución, los controladores de URL, etc.

Introduce el siguiente comando para ver el archivo de configuración:

```bash
cat app.yaml
```

Este archivo de configuración ofrece (de arriba abajo) la siguiente información sobre esta aplicación:

  *  Este código se ejecuta en el entorno de tiempo de ejecución de `python`.
  *  Esta aplicación es `threadsafe`, por lo que la misma instancia puede controlar varias peticiones a la vez. Threadsafe es una función avanzada y puede provocar un comportamiento errático si la aplicación no está específicamente diseñada para ella.
  *  Todas las peticiones a una URL cuya ruta coincida con la expresión regular `/.*` (todas las URL) deberían gestionarse mediante el objeto de la aplicación en el módulo `main` de Python.

La sintaxis de este archivo es [YAML](http://www.yaml.org). Para obtener una lista completa de las opciones de configuración, consulta la documentación de [`app.yaml`][app-yaml-reference].

## Probar la aplicación

### Probar tu aplicación en Cloud Shell

Con Cloud Shell, puedes probar tu aplicación antes de desplegarla para comprobar que funciona correctamente, como una depuración en una máquina local.

Para hacerlo, escribe lo siguiente:

```bash
dev_appserver.py $PWD
```

### Obtener una vista previa de la aplicación con Vista previa web

Ahora, tu aplicación se está ejecutando en Cloud Shell. Puedes acceder a ella mediante la [vista previa web][spotlight-web-preview]<walkthrough-web-preview-icon></walkthrough-web-preview-icon> para conectarte al puerto 8080.

### Desactivar la instancia de vista previa

Pulsa `Ctrl + C` en Cloud Shell para desactivar la instancia de la aplicación.

## Desplegar aplicaciones en Google App Engine

### Crear una aplicación

Para poder desplegar la aplicación, primero debes crearla en una región de la siguiente forma:

```bash
gcloud app create
```

Nota: Si ya has creado una, puedes saltarte este paso.

### Desplegar con Cloud Shell

Puedes usar Cloud Shell para desplegar la aplicación. Para ello, introduce este fragmento de código:

```bash
gcloud app deploy app.yaml --project {{project-id}}
```

### Visitar la aplicación

¡Enhorabuena! Has desplegado tu aplicación. Para visitarla, basta con que hagas clic en su URL predeterminada, que en este caso es [{{project-gae-url}}](http://{{project-gae-url}}). 

### Ver el estado de la aplicación

En el panel de App Engine puedes supervisar el estado de la aplicación para tenerla bajo control.

Abre el [menú][spotlight-console-menu] que se encuentra en la parte izquierda de la consola.

Luego, selecciona el apartado **App Engine**.

<walkthrough-menu-navigation sectionid="APPENGINE_SECTION"></walkthrough-menu-navigation>

## Conclusión

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Has desplegado correctamente una aplicación de App Engine.

Ahora, puedes hacer lo siguiente:

**Descargar el SDK de Google Cloud y desarrollar tus aplicaciones de forma local**

Instala el [SDK de Google Cloud][cloud-sdk-installer] en tu máquina local.

**Desarrollar tu próxima aplicación**

Aprende a utilizar App Engine junto con otros productos de Google Cloud Platform:

<walkthrough-tutorial-card label="django" url="python/django/appengine" icon="APPENGINE_SECTION">
  **Ejecuta Django**
  Desarrolla aplicaciones Django que se ejecuten en App Engine.
</walkthrough-tutorial-card>

<walkthrough-tutorial-card label="datastore" url="appengine/docs/python/datastore/" icon="DATASTORE_SECTION">
  **Aprende a utilizar Cloud Datastore**
  Cloud Datastore es una base de datos NoSQL altamente escalable que puedes usar para tus aplicaciones.
</walkthrough-tutorial-card>

[app-yaml-reference]: https://cloud.google.com/appengine/docs/standard/python/config/appref
[cloud-sdk-installer]: https://cloud.google.com/sdk/downloads#interactive
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-web-preview]: walkthrough://spotlight-pointer?spotlightId=devshell-web-preview-button
