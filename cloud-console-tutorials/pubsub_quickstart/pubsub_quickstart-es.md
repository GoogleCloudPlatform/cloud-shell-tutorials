# Introducción a Cloud Pub/Sub

<walkthrough-tutorial-url url="https://cloud.google.com/pubsub/quickstart-console"></walkthrough-tutorial-url></walkthrough-test-start-page>

<walkthrough-devshell-precreate></walkthrough-devshell-precreate>

## Introducción

Cloud Pub/Sub es un servicio de mensajería en tiempo real totalmente administrado que te permite enviar y recibir mensajes entre aplicaciones independientes. Este tutorial sirve de breve introducción a la interfaz de línea de comandos de Cloud Pub/Sub mediante el comando `gcloud`.

## Configuración del proyecto

Google Cloud Platform organiza los recursos en proyectos para que puedas tener en un solo lugar todos los recursos de una misma aplicación.

Cloud Pub/Sub necesita un proyecto para configurar mensajes.

<walkthrough-project-setup></walkthrough-project-setup>

## Crear tu primer tema

### Abrir Google Cloud Shell

Cloud Shell es una herramienta de línea de comandos integrada para la consola. En este tutorial la emplearás para configurar Cloud Pub/Sub.

Para abrir esta herramienta, haz clic en el <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[icono][spotlight-open-devshell] que se encuentra en la barra de navegación de la parte superior de la consola.

### Crear un tema

Un tema es un recurso con nombre al que envías mensajes. Usa el siguiente comando para crear tu primer tema:

```bash
gcloud pubsub topics create my-topic
```

## Añadir una suscripción

Para poder recibir mensajes, primero tienes que crear suscripciones con sus correspondientes temas. Usa el siguiente comando para crear tu primera suscripción:

```bash
gcloud pubsub subscriptions \
    create my-sub --topic my-topic \
    --ack-deadline=60
```

Este comando crea una suscripción llamada `my-sub` que se encuentra adjunta al tema `my-topic`. Todos los mensajes que se publiquen en `my-topic` se enviarán a esta suscripción.

Observa la opción `--ack-deadline=60`. `ack-deadline` representa el límite de confirmación (del inglés "`acknowledgement deadline`"). Esta nueva suscripción tiene un `límite de confirmación` de 60 segundos. Más adelante indagaremos más sobre esto.

## Mostrar temas y suscripciones

Antes de enviar tu primer mensaje, comprueba si has creado el tema y la suscripción correctamente. Para mostrar tus temas y suscripciones, utiliza el siguiente comando:

```bash
gcloud pubsub topics list
```

```bash
gcloud pubsub subscriptions list
```

## Publicar mensajes en el tema

Envía dos mensajes con los siguientes comandos:

```bash
gcloud pubsub topics publish my-topic --message hello
```

```bash
gcloud pubsub topics publish my-topic --message goodbye
```

Cada uno de estos comandos sirve para enviar un mensaje concreto: el primero es `hello` (hola) y el segundo es `goodbye` (adiós). Si los publicas correctamente, se te devolverá el valor messageId (ID de mensaje) desde el servidor. Se trata de un ID único que el servidor asigna de forma automática a cada mensaje.

## Extraer mensajes de la suscripción

### Extraer mensajes

Para extraer los mensajes, utiliza el siguiente comando:

```bash
gcloud pubsub subscriptions \
    pull --auto-ack --limit=2 my-sub
```

Seguramente hayas visto los dos mensajes que acabas de publicar. Estos contienen los datos `hello` y `goodbye`, así como el `MESSAGE_ID`, que`` es un ID único que el servidor asigna a los mensajes.

Nota: Es posible que Cloud Pub/Sub no muestre los mensajes en orden o que solo veas uno de ellos. En ese caso, prueba a ejecutar el mismo comando varias veces hasta que aparezca el que falta.

### Confirmación y límite de confirmación

Después de extraer un mensaje y procesarlo, debes notificar a Cloud Pub/Sub que lo has recibido correctamente. Esta acción se denomina **confirmación**.

Observa la marca `--auto-ack` que se ha enviado junto con el comando `pull`.
Esta marca ``se encarga de extraer el mensaje y confirmarlo de forma automática.

## Confirmación manual

### Enviar un mensaje nuevo

Envía un nuevo mensaje con el siguiente comando:

```bash
gcloud pubsub \
    topics publish my-topic --message thanks
```

### Extraer de nuevo los mensajes

Utiliza este comando para volver a extraer los mensajes:

```bash
gcloud pubsub subscriptions \
    pull my-sub
```

Una vez hecho esto, debería mostrarse el mensaje `thanks` (gracias), así como su `MESSAGE_ID` y su `ACK_ID`. Este último`` es otro ID que puedes utilizar para confirmar el mensaje.

### Confirmar el mensaje

Después de extraer un mensaje, tienes que confirmarlo antes de que se pase el **límite de confirmación**. Por ejemplo, si una suscripción está configurada para que su **límite de confirmación** sea de 60 segundos (como hemos hecho en este tutorial), tendrás que confirmar el mensaje antes de que pasen 60 segundos desde el momento en el que lo hayas extraído. De lo contrario, Cloud Pub/Sub reenviará el mensaje.

Utiliza el siguiente comando para confirmar el mensaje. Debes sustituir el `ACK_ID` por el ID que corresponda (basta con que lo copies y lo pegues):

```bash
gcloud pubsub subscriptions ack \
    my-sub --ack-ids ACK_ID
```

## Visualizar el tema y la suscripción en la IU de Pub/Sub

Con esto concluye el tutorial de la línea de comandos `gcloud`, pero nos gustaría enseñarte la interfaz de usuario (IU) de Google Cloud Console antes de terminar.

También puedes ver los temas y suscripciones en la sección Pub/Sub.

### Ir a la sección Pub/Sub

Abre el [menú][spotlight-console-menu] que se encuentra en la parte izquierda de la consola.

Luego, elige la sección **Pub/Sub**.

<walkthrough-menu-navigation sectionid="CLOUDPUBSUB_SECTION"></walkthrough-menu-navigation>

En la interfaz de usuario también puedes crear y administrar temas y suscripciones.

### Eliminar el tema

Haz clic en la casilla situada junto al tema que hayas creado y haz clic en el botón [Eliminar][spotlight-delete-button] para borrarlo de forma permanente.

## Conclusión

¡Enhorabuena!

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Acabas de explorar los conceptos básicos de Cloud Pub/Sub mediante la herramienta de línea de comandos `gcloud` y has echado un vistazo a la IU de Cloud Pub/Sub. El siguiente paso es empezar a crear aplicaciones increíbles. Para obtener más información, consulta la [documentación de Pub/Sub][pubsub-docs].

Esto es lo que puedes hacer a continuación:

[Consulta muestras de código](https://cloud.google.com/pubsub/docs/quickstart-client-libraries)

[pubsub-docs]: https://cloud.google.com/pubsub/docs/
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-delete-button]: walkthrough://spotlight-pointer?cssSelector=.p6n-icon-delete
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
