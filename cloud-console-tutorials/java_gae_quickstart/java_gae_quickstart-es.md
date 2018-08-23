# Inicio rápido de App Engine

<walkthrough-test-start-page url="/getting-started?tutorial=java_gae_quickstart_2"/>

<walkthrough-tutorial-url url="https://cloud.google.com/appengine/docs/java/quickstart"/>

<walkthrough-watcher-constant key="repo-url" value="https://github.com/GoogleCloudPlatform/appengine-try-java" />

<walkthrough-watcher-constant key="repo-name" value="appengine-try-java"/>

## Introducción

En este tutorial, aprenderás a desplegar una aplicación [Java][java] de ejemplo
en Google App Engine mediante el complemento de Maven para App Engine.

En esta guía, te detallamos losEstos son los pasos que tendrás que seguir.

*   **Crea y ejecuta una aplicación "Hello, World!"** Te enseñaremos a ejecutar
    la aplicación mediante Google Cloud Shell, sin salir del navegador, y,
    luego, la desplegarás en Internet mediante el complemento de Maven para App
    Engine.

*   **Pasos trasTras desplegar la aplicación...**

    Cuando termines de desplegar la aplicación, podrás hacer pruebas con ella o
    borrarla para empezar de cero.

[Java es una marca registrada de Oracle o sus empresas
afiliadas.](walkthrough://footnote)

<walkthrough-devshell-precreate/>

## Configuración del proyecto

Antes de desplegar una aplicación, primero debes crear un proyecto.

En Google Cloud Platform, los recursos se organizan en proyectos para que puedas
reunir en un solo lugar todos los elementos de una misma aplicación.

<walkthrough-project-setup/>

## Usar Google Cloud Shell

Cloud Shell es una herramienta de línea de comandos integrada en la consola. En
este ejemplo, vamos a usarla para desplegar la aplicación.

### Abrir Google Cloud Shell

Para abrir Cloud Shell, haz clic en <walkthrough-cloud-shell-icon/>
[icon](walkthrough://spotlight-pointer?spotlightId=devshell-activate-button) en
la barra de navegación que se encuentra en la parte superior de la consola.

### Clonar el código de ejemplo

Utiliza Cloud Shell para clonar y localizar el código de "Hello, World!". Dicho
código se clona desde el repositorio del proyecto a Cloud Shell.

Nota: Si ya existiera dicho directorio, debes borrar los archivos que hubiera en
él antes de iniciar la operación de clonación:

```bash
rm -rf {{repo-name}}
```

En Cloud Shell, escribe lo siguiente:

```bash
git clone {{repo-url}}
```

A continuación, ve al directorio del tutorial:

```bash
cd {{repo-name}}
```

## Configurar el despliegue

Ahora mismo, te encuentras en el directorio principal del código de ejemplo.
Vamos a ver en detalle los archivos que componen tu aplicación.

### Explorar la aplicación

Para ver el código de la aplicación, escribe el siguiente comando:

```bash
cat src/main/java/myapp/DemoServlet.java
```

El servlet responderá a todas las peticiones con el mensaje "Hello, World!".

### Explorar la configuración

En Java, Google App Engine utiliza archivos XML para especificar la
configuración de los despliegues.

Para ver el archivo con dichos ajustes, escribe el siguiente comando:

```bash
cat pom.xml
```

La aplicación `helloworld` utiliza Maven, por lo que debes especificar un modelo
de objeto de proyecto (POM) que contenga información sobre el proyecto y los
datos de configuración que utiliza Maven para crearlo.

## Probar la aplicación

### Probar la aplicación en Cloud Shell

En Cloud Shell, puedes probar tu aplicación antes de desplegarla para comprobar
que funciona correctamente, igual que harías la depuración en una máquina local.

Para ello, escribe lo siguiente:

```bash
mvn appengine:run
```

<walkthrough-test-code-output
  text="module .* running at|Dev App Server is now running" />

### Previsualiza la aplicación mediante la opción Vista previa web

Tu aplicación ya se está ejecutando en Cloud Shell. Puedes acceder a ella
mediante el puerto 8080. Para conectarte a él, utiliza la opción Vista previa
web <walkthrough-web-preview-icon/>. [Demostración
práctica](walkthrough://spotlight-pointer?spotlightId=devshell-web-preview-button)

### Desactivar la instancia de vista previa

Para desactivar la instancia de la aplicación, pulsa `Ctrl + C` en Cloud Shell.

## Desplegar la aplicación en Google App Engine

### Crear una aplicación

Para desplegar la aplicación, primero debes crearla en una región:

```bash
gcloud app create
```

Nota: Puedes saltarte este paso si la aplicación ya está creada.

### Desplegar la aplicación mediante Cloud Shell

A continuación, puedes utilizar Cloud Shell para desplegar la aplicación.

Primero, determina qué proyecto quieres usar:

```bash
gcloud config set project {{project-id}}
```

Luego, despliega la aplicación:

```bash
mvn appengine:deploy
```

<walkthrough-test-code-output text="Deployed (module|service)" />

### Ir a la aplicación

Tras seguir todos los pasos anteriores, la aplicación se habrá desplegado. Para
abrirla, ve a su URL predeterminada
({{project-gae-url}}](http://{{project-gae-url}}).

### Consultar el estado de la aplicación

En el panel de App Engine puedes monitorizar el estado de la aplicación. Para
ello, abre el
[menú](walkthrough://spotlight-pointer?spotlightId=console-nav-menu) que se
encuentra a la izquierda de la consola.

A continuación, selecciona **App Engine**.

<walkthrough-menu-navigation sectionId="APPENGINE_SECTION"/>

## Conclusión

<walkthrough-conclusion-trophy/>

¡Enhorabuena! Has desplegado una aplicación de App Engine sin problemas. Ahora
puedes hacer lo siguiente:

**Descargar el SDK de Google Cloud para desarrollar aplicaciones localmente**

[Google Cloud SDK][cloud-sdk-installer]

**Crear otra aplicación**

Aprende a utilizar App Engine con otros productos de Google Cloud Platform:

<walkthrough-tutorial-card
  url="appengine/docs/java/datastore/"
  icon="DATASTORE_SECTION"
  label="datastore">
**Aprende a usar Cloud Datastore**
Cloud Datastore es una base de datos NoSQL altamente escalable que puedes usar en tus aplicaciones.
</walkthrough-tutorial-card>

<walkthrough-tutorial-card
  url="appengine/docs/java/googlecloudstorageclient/setting-up-cloud-storage/"
  icon="STORAGE_SECTION"
  label="cloudStorage">
**Aprende a usar Cloud Storage**
Cloud Storage es un servicio de almacenamiento de objetos sencillo y eficaz.
</walkthrough-tutorial-card>

[java]: https://java.com/
[cloud-sdk-installer]: https://cloud.google.com/sdk/downloads#interactive
