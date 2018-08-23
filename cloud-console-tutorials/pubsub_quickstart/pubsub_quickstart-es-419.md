# Introducción a Cloud Pub/Sub

<walkthrough-tutorial-url url="https://cloud.google.com/pubsub/quickstart-console"></walkthrough-tutorial-url></walkthrough-test-start-page>

<walkthrough-devshell-precreate></walkthrough-devshell-precreate>

## Introducción

Cloud Pub/Sub es un servicio de mensajería en tiempo real completamente administrado que te permite enviar y recibir mensajes entre aplicaciones independientes. Este instructivo es una breve introducción a la interfaz de línea de comandos de Cloud Pub/Sub mediante el comando de `gcloud`.

## Configuración del proyecto

Google Cloud Platform organiza los recursos en proyectos. Esto te permite recopilar todos los recursos relacionados con una aplicación específica en un solo lugar.

Cloud Pub/Sub necesita un proyecto para configurar los mensajes.

<walkthrough-project-setup></walkthrough-project-setup>

## Crea tu primer tema

### Abre Google Cloud Shell

Cloud Shell es una herramienta de línea de comandos integrada para Console. Para configurarla, usarás Cloud Pub/Sub.

Para abrir Cloud Shell, haz <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>clic en el [ícono][spotlight-open-devshell] de la barra de navegación ubicada en la parte superior de Console.

### Crea un tema

Un tema es un recurso con nombre al que enviarás mensajes. Usa el siguiente comando para crear tu primer tema:

```bash
gcloud pubsub topics create my-topic
```

## Agrega una suscripción

Para recibir mensajes, debes crear suscripciones, que deben tener un tema correspondiente. Usa el siguiente comando para crear tu primera suscripción:

```bash
gcloud pubsub subscriptions \
    create my-sub --topic my-topic \
    --ack-deadline=60
```

Este comando crea una suscripción llamada `my-sub` que se adjunta al tema 
`my-topic`. Esta suscripción recibirá todos los mensajes publicados en `my-topic`.

Quizá notaste la opción `--ack-deadline=60`. El valor de `ack-deadline` indica el plazo de confirmación (`Acknowledgement deadline`). Esta nueva suscripción tiene un plazo de confirmación `ack-deadline` de 60 segundos. Hablaremos de esto más adelante.

## Muestra una lista de temas y suscripciones

Antes de enviar el primer mensaje, asegúrate de que el tema y la suscripción se hayan creado correctamente. Usa el siguiente comando para ver tu tema y suscripción:

```bash
gcloud pubsub topics list
```

```bash
gcloud pubsub subscriptions list
```

## Publica mensajes en el tema

Envía dos mensajes con los siguientes comandos:

```bash
gcloud pubsub topics publish my-topic --message hello
```

```bash
gcloud pubsub topics publish my-topic --message goodbye
```

Cada uno de estos comandos envía un mensaje. El primer mensaje es `hello` y el segundo `goodbye`. Cuando publicas un mensaje correctamente, deberías ver el valor messageId que muestra el servidor. Este es un ID único que el servidor asigna automáticamente a cada mensaje.

## Extrae mensajes de la suscripción

### Extrae mensajes

Extrae los mensajes con el siguiente comando:

```bash
gcloud pubsub subscriptions \
    pull --auto-ack --limit=2 my-sub
```

Es probable que veas los dos mensajes que acabas de publicar. Los mensajes tienen los datos `hello` y `goodbye`, como también un `MESSAGE_ID`. `MESSAGE_ID` es el ID único del mensaje que el servidor le asignó.

Nota: El uso de Cloud Pub/Sub no garantiza el orden de los mensajes. También es posible que hayas visto uno solo. En ese caso, intenta ejecutar el mismo comando varias veces hasta que veas el otro mensaje.

### Confirmación y plazo de confirmación

Después de extraer un mensaje y procesarlo de forma adecuada, debes notificar a Cloud Pub/Sub que lo recibiste correctamente. Esta acción se llama **confirmación**.

Quizá notaste la marca `--auto-ack` que se envió junto con el comando `pull`.
La marca `--auto-ack` extrae el mensaje automáticamente y lo confirma.

## Confirmación manual

### Envía un mensaje nuevo

Envía un mensaje nuevo con el siguiente comando:

```bash
gcloud pubsub \
    topics publish my-topic --message thanks
```

### Vuele a extraer mensajes

Usa el siguiente comando para extraer los mensajes:

```bash
gcloud pubsub subscriptions \
    pull my-sub
```

Debería aparecer el mensaje `thanks`, además de `MESSAGE_ID` y `ACK_ID`. `ACK_ID` es otro ID que puedes usar para confirmar el mensaje.

### Confirma el mensaje

Después de extraer un mensaje, debes confirmarlo antes de que el **plazo de confirmación** finalice. Por ejemplo, si el **plazo de confirmación** de la suscripción se configura en 60 segundos, como en este instructivo, debes confirmar el mensaje en el plazo de 60 segundos después de extraerlo. De lo contrario, Cloud Pub/Sub volverá a enviar el mensaje.

Usa el siguiente comando para confirmar el mensaje (reemplaza `ACK_ID` por el valor real que debes copiar y pegar):

```bash
gcloud pubsub subscriptions ack \
    my-sub --ack-ids ACK_ID
```

## Mira el tema y la suscripción en la IU de Pub/Sub

Con esto concluye el instructivo sobre la línea de comandos de `gcloud`, pero repasemos la IU de Google Cloud Console antes de terminar el instructivo.

También puedes ver los temas y las suscripciones en la sección Pub/Sub.

### Navega a la sección Pub/Sub

Abre el [menú][spotlight-console-menu] ubicado en el lado izquierdo de la consola.

Luego, haz clic en la sección **Pub/Sub**.

<walkthrough-menu-navigation sectionid="CLOUDPUBSUB_SECTION"></walkthrough-menu-navigation>

La IU también te permite crear y administrar temas y suscripciones.

### Borra el tema

Para borrar el tema de forma permanente, marca la casilla de verificación junto al tema que creaste y haz clic en el [botón Borrar][spotlight-delete-button].

## Conclusión

Felicitaciones.

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Acabas de revisar los conceptos básicos de Cloud Pub/Sub con la herramienta de línea de comandos de `gcloud` y pudiste ver la IU de Cloud Pub/Sub. El siguiente paso es crear aplicaciones increíbles. Para obtener más información, consulta [la documentación de Pub/Sub][pubsub-docs].

A continuación, puedes hacer lo siguiente:

[Ver muestras de código](https://cloud.google.com/pubsub/docs/quickstart-client-libraries)

[pubsub-docs]: https://cloud.google.com/pubsub/docs/
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-delete-button]: walkthrough://spotlight-pointer?cssSelector=.p6n-icon-delete
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
