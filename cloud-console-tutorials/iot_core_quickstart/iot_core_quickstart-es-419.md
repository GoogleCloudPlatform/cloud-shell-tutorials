# Introducción a Cloud IoT Core

<walkthrough-tutorial-url url="https://cloud.google.com/iot/docs/quickstart"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="https://github.com/GoogleCloudPlatform/nodejs-docs-samples.git" key="repo-url"></walkthrough-watcher-constant>

## Introducción

Google Cloud Internet of Things (IoT) Core es un servicio completamente administrado que permite conectar y administrar dispositivos de IoT de manera segura, sin importar si se trata de un pequeño conjunto o de millones de dispositivos. En este instructivo, se muestra cómo usar la herramienta de línea de comandos de `gcloud` para crear un registro de dispositivos de Cloud IoT Core y agregar un dispositivo. También se muestra cómo ejecutar una muestra de MQTT para conectar un dispositivo y publicar eventos de telemetría del dispositivo.

En este instructivo se tratan los temas siguientes:

  *  Cómo crear un tema de Cloud Pub/Sub
  *  Cómo crear un registro de dispositivo
  *  Cómo agregar un dispositivo al registro
  *  Cómo configurar credenciales en el dispositivo
  *  Cómo crear una suscripción al tema de Pub/Sub para enviar y recibir mensajes
  *  Cómo conectar un dispositivo virtual y ver los datos de telemetría

## Configuración del proyecto

Google Cloud Platform organiza los recursos en proyectos. Esto te permite recopilar todos los recursos relacionados con una aplicación específica en un solo lugar.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## Usa Google Cloud Shell

En este instructivo, solo trabajarás en Cloud Shell.

### Abre Google Cloud Shell

Para abrir Cloud Shell, haz <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>clic en el [ícono][spotlight-open-devshell] de la barra de navegación ubicada en la parte superior de Console.

### Activa las API de Google Cloud

Esto habilitará la API de Cloud IoT Core.

<walkthrough-enable-apis apis="cloudiot.googleapis.com"></walkthrough-enable-apis>

## Crea tu primer tema

Un tema es un recurso con nombre al que los dispositivos envían mensajes. Usa el siguiente comando para crear tu primer tema:

```bash
gcloud pubsub topics create my-topic
```

Enviarás varios mensajes a este tema más adelante.

## Clona los archivos de muestra Node.js de Cloud IoT Core desde GitHub

Usarás la muestra de MQTT para enviar mensajes a Cloud IoT Core.

Nota: Si el directorio ya existe, quita los archivos antiguos antes de realizar la clonación:

```bash
rm -rf nodejs-docs-samples
```

Usa este comando para clonar el programa de muestra:

```bash
git clone {{repo-url}}
```

## Otorga permiso a la cuenta de servicio de Cloud IoT Core

Agrega la cuenta de servicio `cloud-iot@system.gserviceaccount.com` al tema de Cloud Pub/Sub con la función de publicador. Para ello, usa la secuencia de comandos auxiliar ubicada en la carpeta `/iot/scripts`.

### Navega al directorio iot:

```bash
cd nodejs-docs-samples/iot
```

### Instala las dependencias:

```bash
npm --prefix ./scripts install
```

### Ejecuta la secuencia de comandos auxiliar:

```bash
node scripts/iam.js my-topic
```

La secuencia de comandos otorga permiso a la cuenta de servicio de Cloud IoT Core en el tema `my-topic`.

## Crea un registro de dispositivo

Un registro de dispositivos contiene una lista de dispositivos y define las propiedades que estos comparten. Para crear tu registro de dispositivo, usa el siguiente comando:

```bash
gcloud iot registries create my-registry \
    --project={{project-id}} \
    --region=us-central1 \
    --event-notification-config=topic=projects/{{project-id}}/topics/my-topic
```

## Genera tus claves de firma

Para la autenticación con Cloud IoT Core, un dispositivo necesita una clave privada y una pública. Ejecuta el siguiente comando para generar tus claves de firma:

```bash
./scripts/generate_keys.sh
```

Esta secuencia de comandos permite crear claves RS256 y ES256 en formato PEM, pero solo necesitarás las claves RS256 para este instructivo. La clave privada se usa para firmar el JWT ([JSON Web Token][web-token-docs]) de autenticación y debe guardarse de manera segura en el dispositivo. La clave pública se guarda en el registro de dispositivos.

## Crea un dispositivo y agrégalo al registro

Ejecuta el siguiente comando para crear un dispositivo y agregarlo al registro:

```bash
gcloud iot devices create my-node-device \
    --project={{project-id}} \
    --region=us-central1 \
    --registry=my-registry \
    --public-key path=rsa_cert.pem,type=rs256
```

## Conecta tu dispositivo y observa los datos de telemetría

En este paso, enviarás mensajes de un dispositivo virtual a Pub/Sub. Luego, extraerás los mensajes y los revisarás.

### Navega al directorio de muestra de MQTT:

```bash
cd mqtt_example
```

### Instala las dependencias de Node.js:

```bash
npm install
```

### Usa el puente MQTT para ejecutar el siguiente comando y conectar un dispositivo virtual a Cloud IoT Core:

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

El resultado muestra que el dispositivo virtual está publicando mensajes en el tema de telemetría. Se publicaron veinticinco mensajes.

## Crea una suscripción al tema del dispositivo

Ejecuta el siguiente comando para crear una suscripción. Esto te permite revisar los mensajes que tu dispositivo publica:

```bash
gcloud pubsub subscriptions create \
    projects/{{project-id}}/subscriptions/my-subscription \
    --topic=my-topic
```

## Extrae los mensajes publicados

Usa el siguiente comando para extraer los mensajes que publica el dispositivo:

```bash
gcloud pubsub subscriptions pull --auto-ack \
    projects/{{project-id}}/subscriptions/my-subscription
```

Cuando ejecutes este comando, recibirás los mensajes que el dispositivo publicó. Los mensajes contienen los siguientes datos: `my-registry/my-node-device-payload-&lt;INTEGER&gt;`, un `MESSAGE_ID` y una lista de `ATTRIBUTES` de información sobre el dispositivo. El `MESSAGE_ID` es un ID único que asigna el servidor.

Nota: El uso de Cloud Pub/Sub no garantiza el orden de los mensajes. También es posible que veas solo un mensaje en Cloud Shell. En ese caso, intenta ejecutar el mismo comando varias veces hasta que veas los otros mensajes.

## Consulta los recursos en Google Cloud Platform Console

Con esto concluye el instructivo sobre la línea de comandos de `gcloud`, pero también puedes usar GCP Console para ver los recursos que acabas de crear.

Abre el [menú][spotlight-console-menu] ubicado en el lado izquierdo de la consola.

Luego, selecciona **IoT Core**.

<walkthrough-menu-navigation sectionid="IOT_SECTION"></walkthrough-menu-navigation>

La IU también te permite crear y administrar dispositivos y registros de dispositivos.

## Conclusión

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Felicitaciones. Acabas de revisar los conceptos básicos de Cloud IoT Core con la herramienta de línea de comandos de `gcloud`. Además, usaste GCP Console para ver los recursos de Cloud IoT Core. El siguiente paso es crear aplicaciones extraordinarias. Para obtener más información, consulta la [documentación de IoT Core](https://cloud.google.com/iot/docs/).

### A continuación, puedes hacer lo siguiente:

Revisa más ejemplos de Cloud IoT Core en GitHub:

  *  [C](https://github.com/GoogleCloudPlatform/cpp-docs-samples/tree/master/iot/mqtt-ciotc)
  *  [Java](https://github.com/GoogleCloudPlatform/java-docs-samples/tree/master/iot/api-client)
  *  [Node.js](https://github.com/GoogleCloudPlatform/nodejs-docs-samples/tree/master/iot)
  *  [Python](https://github.com/GoogleCloudPlatform/python-docs-samples/tree/master/iot/api-client)

[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[web-token-docs]: https://cloud.google.com/iot/docs/how-tos/credentials/jwts
