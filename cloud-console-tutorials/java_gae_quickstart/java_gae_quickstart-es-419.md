# Quickstart de App Engine

<walkthrough-test-start-page url="/getting-started?tutorial=java_gae_quickstart_2"/>

<walkthrough-tutorial-url url="https://cloud.google.com/appengine/docs/java/quickstart"/>

<walkthrough-watcher-constant key="repo-url" value="https://github.com/GoogleCloudPlatform/appengine-try-java" />

<walkthrough-watcher-constant key="repo-name" value="appengine-try-java"/>

## Introducción

En este instructivo, aprenderás cómo implementar una aplicación de [Java][java]
de muestra en Google App Engine mediante el complemento Maven App Engine Plugin.

Estos son los pasos que debes seguir.

*   **Compila y ejecuta tu próxima app de "Hello, world!"**

    Aprenderás cómo ejecutar tu app con Google Cloud Shell directamente desde el
    navegador. Al final, podrás implementar tu app en la Web con el complemento
    Maven App Engine Plugin.

*   **Después de la app...**

    Tendrás una app real para hacer pruebas después de implementarla. También
    puedes quitarla y comenzar de cero.

[Java is a registered trademark of Oracle and/or its affiliates.](walkthrough://footnote)

<walkthrough-devshell-precreate/>

## Configuración del proyecto

Para implementar una aplicación, primero debes crear un proyecto. Google Cloud
Platform organiza los recursos en proyectos. Esto te permite recopilar todos los
recursos relacionados con una aplicación en un solo lugar.

<walkthrough-project-setup/>

## Cómo usar Google Cloud Shell

Cloud Shell es una herramienta de línea de comandos integrada para la consola.
Usaremos Cloud Shell para implementar nuestra app.

## Cómo abrir Google Cloud Shell

Para abrir Cloud Shell, haz clic en <walkthrough-cloud-shell-icon/>
[icon](walkthrough://spotlight-pointer?spotlightId=devshell-activate-button) en
la barra de navegación que se encuentra en la parte superior de la consola.

## Cómo clonar el código de muestra

Usa Cloud Shell para clonar el código de "Hello World" y navegar a su ubicación.
El código de muestra se clona del repositorio de tu proyecto a Cloud Shell.

Nota: Si el directorio ya existe, quita los archivos anteriores antes de
realizar la clonación:

```bash
rm -rf {{repo-name}}
```

En Cloud Shell, escribe lo siguiente:

```bash
git clone {{repo-url}}
```

Luego, cambia al directorio del instructivo:

```bash
cd {{repo-name}}
```

## Cómo configurar tu implementación

Ahora te encuentras en el directorio principal del código de muestra. Revisemos
los archivos de configuración de tu aplicación.

### Cómo navegar por la aplicación

Para ver el código de tu aplicación, ingresa el siguiente mensaje:

```bash
cat src/main/java/myapp/DemoServlet.java
```

Este servlet responde ante cualquier solicitud mediante una respuesta con el
mensaje `Hello, world!`.

### Cómo navegar por la configuración

En Java, Google App Engine usa archivos XML para especificar la configuración de
una implementación.

Para ver tu archivo de configuración, ingresa el siguiente comando:

```bash
cat pom.xml
```

La app de `helloworld` usa Maven, lo que significa que debes especificar un
modelo de objeto de proyecto (POM) que contiene información sobre el proyecto y
los detalles de configuración que usa Maven para crear el proyecto.

## Cómo probar tu app

### Prueba tu app en Cloud Shell

Cloud Shell te permite probar la app antes de implementarla para asegurarte de
que se ejecuta correctamente, es como realizar una depuración en tu máquina
local.

Para probar tu app, ingresa lo siguiente:

```bash
mvn appengine:run
```

<walkthrough-test-code-output
  text="module .* running at|Dev App Server is now running" />

### Cómo obtener una vista previa de tu app con "Vista previa web"

Tu app ya se ejecuta en Cloud Shell. Puedes acceder a ella mediante la "Vista
previa web" <walkthrough-web-preview-icon/> para conectarte al puerto 8080. [Ver
una
demostración](walkthrough://spotlight-pointer?spotlightId=devshell-web-preview-button)

### Cómo salir de la instancia de vista previa

Para salir de la vista previa de la aplicación, presiona "Ctrl+C" en Cloud
Shell.

## Cómo implementarla en Google App Engine

### Crea una aplicación

Para implementar nuestra app, debemos crear una en una región:

```bash
gcloud app create
```

Nota: Si ya creaste una app, puedes omitir este paso.

### Como hacer la implementación con Cloud Shell

Ahora puedes usar Cloud Shell para implementar tu app.

Primero, selecciona el proyecto que usarás:

```bash
gcloud config set project {{project-id}}
```

Luego, ingresa el siguiente comando para implementar tu app:

```bash
mvn appengine:deploy
```

<walkthrough-test-code-output text="Deployed (module|service)" />

### Visita tu app

Tu app se implementó. La URL predeterminada es
[{{project-gae-url}}](http://{{project-gae-url}}). Haz clic en la URL para
visitar tu app.

### Cómo ver el estado de tu app

Para revisar tu app, puedes supervisar su estado en el panel de control de App
Engine.

Abre el [menú](walkthrough://spotlight-pointer?spotlightId=console-nav-menu) que
se encuentra en el lado izquierdo de la consola.

Luego, selecciona la sección **App Engine**.

<walkthrough-menu-navigation sectionId="APPENGINE_SECTION"/>

## Conclusión

<walkthrough-conclusion-trophy/>

ˇFelicitaciones! Implementaste correctamente una aplicación de App Engine. Estos
son algunos pasos adicionales que puedes seguir:

**Descarga el SDK de Google Cloud para desarrollar apps de forma local**

[Google Cloud SDK][cloud-sdk-installer]

**Crea tu próxima aplicación**

Aprende a usar App Engine con otros productos de Google Cloud Platform:

<walkthrough-tutorial-card
  url="appengine/docs/java/datastore/"
  icon="DATASTORE_SECTION"
  label="datastore">
**Aprende a usar Cloud Datastore**
Cloud Datastore es una base de datos NoSQL altamente escalable para tus aplicaciones.
</walkthrough-tutorial-card>

<walkthrough-tutorial-card
  url="appengine/docs/java/googlecloudstorageclient/setting-up-cloud-storage/"
  icon="STORAGE_SECTION"
  label="cloudStorage">
**Aprende a usar Cloud Storage**
Cloud Storage es un servicio potente y simple de almacenamiento de objetos.
</walkthrough-tutorial-card>

[java]: https://java.com/
[cloud-sdk-installer]: https://cloud.google.com/sdk/downloads#interactive
