# QuickStart de App Engine

<walkthrough-tutorial-url url="https://cloud.google.com/appengine/docs/python/quickstart"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="https://github.com/GoogleCloudPlatform/python-docs-samples" key="repo-url"></walkthrough-watcher-constant>
<walkthrough-watcher-constant value="python-docs-samples/appengine/standard/hello_world" key="repo-dir"></walkthrough-watcher-constant>

## Introducción

En este instructivo, se muestra cómo puedes implementar una aplicación de [Python](https://python.org/) de muestra en Google App Engine con el comando de `gcloud`.

Estos son los pasos que seguirás.

  *  **Crear un proyecto**

     Los proyectos son un paquete que incluye código, VM y otros recursos para facilitar el desarrollo y la supervisión.

  *  **Compila y ejecuta tu app "Hello, world!"**

     Aprenderás cómo ejecutar tu app en el navegador con Google Cloud Shell. Al final usarás el comando de `gcloud` para implementar tu app en la Web.

  *  **Después del instructivo…**

     Tu app será real y podrás experimentar con ella después de implementarla, o puedes quitarla y comenzar de nuevo.

[“Python” y sus logotipos son marcas comerciales de Python Software Foundation.](walkthrough://footnote)

## Configuración del proyecto

Para implementar una aplicación, primero debes crear un proyecto.

Google Cloud Platform organiza los recursos en proyectos. Esto te permite recopilar todos los recursos relacionados con una aplicación específica en un solo lugar.

<walkthrough-devshell-precreate></walkthrough-devshell-precreate>

<walkthrough-project-setup></walkthrough-project-setup>

## Usa Google Cloud Shell

Cloud Shell es una herramienta de línea de comandos integrada para Console. Usaremos Cloud Shell para implementar nuestra app.

### Abre Google Cloud Shell

Para abrir Cloud Shell, haz <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>clic en el [ícono][spotlight-open-devshell] de la barra de navegación ubicada en la parte superior de Console.

### Clona el código de muestra

Usa Cloud Shell para clonar el código de “Hello World” y navegar por él. El código de muestra se clonó desde tu repositorio de proyecto a Cloud Shell.

Nota: Si el directorio ya existe, quita los archivos antiguos antes de realizar la clonación.

En Cloud Shell, ingresa lo siguiente:

```bash
git clone {{repo-url}}
```

Luego, cambia al directorio del instructivo:

```bash
cd {{repo-dir}}
```

## Configura tu implementación

Estás en el directorio principal del código de muestra. En él, veremos los archivos que configuran tu aplicación.

### Explora la aplicación

Ingresa el siguiente comando para ver el código de tu aplicación:

```bash
cat main.py
```

Se trata de una aplicación de Python sencilla que usa el marco de trabajo web [webapp2](https://webapp2.readthedocs.io/). Esta secuencia de comandos de Python responde a una solicitud con un encabezado HTTP y al mensaje `Hello, World!`

### Explora tu configuración

Google App Engine usa archivos YAML para especificar cómo se configura una implementación.
Los archivos `app.yaml` contienen información de tu aplicación, como el entorno de tiempo de ejecución y los controladores de URL.

Ingresa el siguiente comando para ver el archivo de configuración:

```bash
cat app.yaml
```

Desde la parte superior a la inferior, este archivo de configuración muestra lo siguiente sobre la aplicación:

  *  Este código se ejecuta en el entorno de tiempo de ejecución de `python`.
  *  Esta aplicación es `threadsafe`, por lo que la misma instancia puede controlar varias solicitudes simultáneas. Threadsafe es una función avanzada que puede generar un comportamiento errático si la aplicación no se diseñó específicamente para ella.
  *  El objeto de la app del módulo `main` de Python debe administrar cada solicitud a una URL cuya ruta de acceso coincida con la expresión regular `/.*` (todas las URL).

La sintaxis de este archivo es [YAML](http://www.yaml.org). Para ver una lista completa de las opciones de configuración, consulta la referencia [`app.yaml`][app-yaml-reference].

## Prueba tu app

### Prueba tu app en Cloud Shell

Cloud Shell te permite probar la app antes de implementarla para asegurarte de que se ejecuta de manera correcta, al igual que una depuración en tu máquina local.

Para probar tu app, ingresa lo siguiente:

```bash
dev_appserver.py $PWD
```

### Obtén una vista previa de la app con "Vista previa en la Web"

Tu app ya se ejecuta en Cloud Shell. <walkthrough-web-preview-icon></walkthrough-web-preview-icon>Usa [Vista previa en la Web][spotlight-web-preview] para conectarte al puerto 8080 y acceder a la app.

### Finaliza la instancia de vista previa

Presiona `Ctrl+C` en Cloud Shell para finalizar la instancia de la aplicación.

## Implementa en Google App Engine

### Crea una aplicación

Para implementar la app, debes crearla en una región:

```bash
gcloud app create
```

Nota: Si ya creaste una, puedes omitir este paso.

### Implementa con Cloud Shell

Usa Cloud Shell para implementar tu app. Para hacerlo, ingresa lo siguiente:

```bash
gcloud app deploy app.yaml --project {{project-id}}
```

### Visita tu app

Felicitaciones. Implementaste tu app. La URL predeterminada para la app es [{{project-gae-url}}](http://{{project-gae-url}}). Para visitarla, haz clic en la URL.

### Ve el estado de tu app

Para supervisar el estado de tu app, usa el panel de App Engine.

Abre el [menú][spotlight-console-menu] ubicado en el lado izquierdo de la consola.

Luego, haz clic en la sección **App Engine**.

<walkthrough-menu-navigation sectionid="APPENGINE_SECTION"></walkthrough-menu-navigation>

## Conclusión

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Implementaste la aplicación de App Engine correctamente.

Como siguiente paso, puedes probar lo siguiente:

**Descarga el SDK de Google Cloud y desarrolla localmente**

Instala el [SDK de Google Cloud][cloud-sdk-installer] en tu máquina local.

**Compila tu próxima aplicación**

Descubre cómo usar App Engine con otros productos de Google Cloud Platform, como los siguientes:

<walkthrough-tutorial-card label="django" url="python/django/appengine" icon="APPENGINE_SECTION">
  **Ejecuta Django**
Desarrolla apps de Django que se ejecuten en App Engine.
</walkthrough-tutorial-card>

<walkthrough-tutorial-card label="datastore" url="appengine/docs/python/datastore/" icon="DATASTORE_SECTION">
  **Aprende a usar Cloud Datastore**
Cloud Datastore es una base de datos NoSQL altamente escalable para tus aplicaciones.
</walkthrough-tutorial-card>

[app-yaml-reference]: https://cloud.google.com/appengine/docs/standard/python/config/appref
[cloud-sdk-installer]: https://cloud.google.com/sdk/downloads#interactive
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-web-preview]: walkthrough://spotlight-pointer?spotlightId=devshell-web-preview-button
