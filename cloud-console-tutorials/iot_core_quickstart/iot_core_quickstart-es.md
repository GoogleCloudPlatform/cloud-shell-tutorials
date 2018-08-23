# Introducción a Cloud IoT Core

<walkthrough-tutorial-url url="https://cloud.google.com/iot/docs/quickstart"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="https://github.com/GoogleCloudPlatform/nodejs-docs-samples.git" key="repo-url"></walkthrough-watcher-constant>

## Introducción

Google Cloud Internet of Things (IoT) Core es un servicio completamente administrado para conectar y gestionar dispositivos del Internet de las Cosas de forma segura, desde unos pocos de ellos hasta millones de unidades. En este tutorial se muestra cómo usar la herramienta de línea de comandos `gcloud` para crear un registro de dispositivos de Cloud IoT Core y añadir un dispositivo. También se incluye información sobre cómo ejecutar un ejemplo de MQTT para conectar un dispositivo y publicar eventos de telemetría de los dispositivos.

En este tutorial se tratan los temas siguientes:

  *  Crear un tema Cloud Pub/Sub
  *  Crear un registro de dispositivos
  *  Añadir un dispositivo al registro
  *  Configurar credenciales en el dispositivo
  *  Crear una suscripción al tema Pub/Sub para enviar y recibir mensajes
  *  Conectar un dispositivo virtual y ver los datos de telemetría

## Configuración del proyecto

Google Cloud Platform organiza los recursos en proyectos para que puedas tener en un solo lugar todos los recursos de una aplicación.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## Usar Google Cloud Shell

En este tutorial, trabajarás únicamente en Cloud Shell.

### Abrir Google Cloud Shell

Para abrir esta herramienta, haz clic en el <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[icono][spotlight-open-devshell] que se encuentra en la barra de navegación de la parte superior de la consola.

### Activar las API de Google Cloud

Si lo haces, se habilitará la API de Cloud IoT Core.

<walkthrough-enable-apis apis="cloudiot.googleapis.com"></walkthrough-enable-apis>

## Crear tu primer tema

Un tema es un recurso con nombre al que los dispositivos envían mensajes. Usa el siguiente comando para crear tu primer tema:

```bash
gcloud pubsub topics create my-topic
```

Más adelante, enviarás varios mensajes a este tema.

## Clonar los archivos de ejemplo Node.js de Cloud IoT Core desde GitHub

Usarás el ejemplo de MQTT para enviar mensajes a Cloud IoT Core.

Nota: Si el directorio ya existe, borra los archivos anteriores antes de iniciar la clonación:

```bash
rm -rf nodejs-docs-samples
```

Clona el programa de ejemplo con el siguiente comando:

```bash
git clone {{repo-url}}
```

## Conceder permiso a la cuenta de servicio de Cloud IoT Core

Con la secuencia de comandos de ayuda de la carpeta `/iot/scripts` y la función de editor, añade la cuenta de servicio `cloud-iot@system.gserviceaccount.com` al tema Cloud Pub/Sub.

### Ve al directorio iot:

```bash
cd nodejs-docs-samples/iot
```

### Instala las dependencias:

```bash
npm --prefix ./scripts install
```

### Ejecuta la secuencia de comandos de ayuda:

```bash
node scripts/iam.js my-topic
```

La secuencia de comandos se encarga de conceder permiso a la cuenta de servicio de Cloud IoT Core en el tema `my-topic`.

## Crear un registro de dispositivos

En los registros de dispositivos se definen las propiedades que comparten dichos dispositivos. Crea el tuyo con el siguiente comando:

```bash
gcloud iot registries create my-registry \
    --project={{project-id}} \
    --region=us-central1 \
    --event-notification-config=topic=projects/{{project-id}}/topics/my-topic
```

## Generar tus claves de firma

Para autenticar un dispositivo en Cloud IoT Core, se necesita una clave privada y otra pública. Puedes ejecutar el siguiente comando para generar las tuyas:

```bash
./scripts/generate_keys.sh
```

Aunque esta secuencia de comandos crea las claves RS256 y ES256 en formato PEM, en este tutorial solo son necesarias las claves RS256. La clave privada, que se utiliza para firmar el JWT ([token web de JSON][web-token-docs]) de autenticación, debe almacenarse de forma segura en el dispositivo. La clave pública se guarda en el registro de dispositivos.

## Crear un dispositivo y añadirlo al registro

Para crear un dispositivo y añadirlo al registro, ejecuta el siguiente comando:

```bash
gcloud iot devices create my-node-device \
    --project={{project-id}} \
    --region=us-central1 \
    --registry=my-registry \
    --public-key path=rsa_cert.pem,type=rs256
```

## Conectar tu dispositivo y ver los datos de telemetría

En este paso, enviarás mensajes desde un dispositivo virtual a Pub/Sub. Después, podrás extraer los mensajes y verlos.

### Ve al directorio de ejemplo de MQTT:

```bash
cd mqtt_example
```

### Instala las dependencias Node.js:

```bash
npm install
```

### Ejecuta el siguiente comando para conectar un dispositivo virtual a Cloud IoT Core con el puente de MQTT:

```bash
node cloudiot_mqtt_example_nodejs.js \
    --projectId={{project-id}} \
    --registryId=my-registry \
    --deviceId=my-node-device \
    --privateKeyFile=../rsa_private.pem \
    --numMessages=25 \
    --algorithm=RS256 \
    --mqttBridgePort=443
```

El resultado muestra que el dispositivo virtual está publicando mensajes en el tema de telemetría. Actualmente, hay 25 mensajes publicados.

## Crear una suscripción al tema del dispositivo

Ejecuta el siguiente comando para crear una suscripción que te permita ver los mensajes que ha publicado tu dispositivo:

```bash
gcloud pubsub subscriptions create \
    projects/{{project-id}}/subscriptions/my-subscription \
    --topic=my-topic
```

## Extraer los mensajes publicados

Extrae los mensajes que ha publicado el dispositivo con el siguiente comando:

```bash
gcloud pubsub subscriptions pull --auto-ack \
    projects/{{project-id}}/subscriptions/my-subscription
```

Al ejecutarlo, se devuelven los mensajes que ha publicado el dispositivo. Dichos mensajes incluyen los siguientes datos: `my-registry/my-node-device-payload-&lt;INTEGER&gt;`, un `MESSAGE_ID` y una lista de `ATTRIBUTES` con información sobre el dispositivo. El `MESSAGE_ID` es un ID único que asigna el servidor.

Nota: Es posible que Cloud Pub/Sub no muestre los mensajes en orden. También es posible que solo veas un mensaje en Cloud Shell. En ese caso, prueba a ejecutar el mismo comando varias veces hasta que aparezcan el resto de los mensajes.

## Ver recursos en la consola de Google Cloud Platform

Con esto concluye el tutorial de la línea de comandos `gcloud`. También puedes usar la consola de Google Cloud Platform para ver los recursos que acabas de crear.

Abre el [menú][spotlight-console-menu] que se encuentra en el lado izquierdo de la consola.

A continuación, selecciona **IoT Core**.

<walkthrough-menu-navigation sectionid="IOT_SECTION"></walkthrough-menu-navigation>

En la IU también puedes crear y administrar dispositivos y registros de dispositivos.

## Conclusión

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Acabas de explorar los conceptos básicos de Cloud IoT Core mediante la herramienta de línea de comandos `gcloud`. Además, has usado la consola de Google Cloud Platform para ver los recursos de Cloud IoT Core. El siguiente paso consiste en crear aplicaciones estupendas. Para obtener más información, consulta la [documentación de IoT Core](https://cloud.google.com/iot/docs/).

### Esto es lo que puedes hacer a continuación

Consultar más ejemplos de Cloud IoT Core en GitHub:

  *  [C](https://github.com/GoogleCloudPlatform/cpp-docs-samples/tree/master/iot/mqtt-ciotc)
  *  [Java](https://github.com/GoogleCloudPlatform/java-docs-samples/tree/master/iot/api-client)
  *  [Node.js](https://github.com/GoogleCloudPlatform/nodejs-docs-samples/tree/master/iot)
  *  [Python](https://github.com/GoogleCloudPlatform/python-docs-samples/tree/master/iot/api-client)

[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[web-token-docs]: https://cloud.google.com/iot/docs/how-tos/credentials/jwts
