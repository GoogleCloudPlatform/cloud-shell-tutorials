# Quickstart de Cloud Storage

## Te damos la bienvenida a Google Cloud Storage

<walkthrough-tutorial-url url="https://cloud.google.com/storage/docs/quickstart-console"></walkthrough-tutorial-url>

Google Cloud Storage es una solución de almacenamiento potente y económica para objetos no estructurados. Es ideal para todo tipo de usos, desde el hosting de contenido web en uso hasta el almacenamiento de datos para analítica, archivado y copias de seguridad.

En este instructivo, verás lo fácil que es comenzar a almacenar objetos en Cloud Storage. Realizarás las siguientes tareas:

  *  **Crear un depósito**

     Los depósitos albergan los objetos (cualquier tipo de archivo) que quieras almacenar en Cloud Storage.

  *  **Subir y compartir objetos**

     Para comenzar a usar tu depósito, sube un objeto y haz que esté disponible públicamente.

  *  **Limpiar**

     En el último paso, borra el depósito y objeto que creaste para este instructivo.

Dado que borrarás el depósito y objeto al final, no tienes que preocuparte por la posibilidad de que se apliquen cargos por seguir este instructivo.

## Configuración del proyecto

Debes tener un proyecto en Cloud Storage para crear recursos.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## Crea un depósito

En Cloud Storage, almacenas tus objetos en depósitos. Para crear uno, ve al navegador de Cloud Storage.

Abre el [menú][spotlight-menu] ubicado en el lado izquierdo de la consola.

Luego, haz clic en la sección **Storage**.

<walkthrough-menu-navigation sectionid="STORAGE_SECTION"></walkthrough-menu-navigation>

## Crea un depósito

Antes de comenzar a subir objetos, deberás crear un "depósito" donde ponerlos. Los depósitos facilitan la organización de los objetos y el control del acceso.

  1. Haz clic en [Crear depósito](walkthrough://spotlight-pointer?cssSelector=#p6ntest-cloudstorage-create-first-bucket-button,).

  1. En la página de creación de depósitos, especifica las propiedades. Cuando lo hagas, ten en cuenta lo siguiente:

     *  **Nombre:** Piensa en un nombre único. Verás un error si ingresas un nombre idéntico al de otro depósito en Cloud Storage.
     *  **Clase de almacenamiento predeterminada:** Se refiere a la clase de almacenamiento que se asigna de forma predeterminada a los objetos de tu depósito. La decisión depende principalmente de la frecuencia con la que esperas que se acceda a los objetos y si los datos se entregarán en todo el mundo. La clase de almacenamiento influye en el costo.
     *  **Ubicación**: Te recomendamos conservar los datos cerca de los usuarios y las aplicaciones que acceden a ellos. Las opciones disponibles dependerán de la clase de almacenamiento que elijas.

Puedes usar cualquier clase de almacenamiento y ubicación en esta versión de prueba, ya que borrarás el depósito cuando termines.

  1. Haz clic en [Crear][spotlight-create-button].

## Sube un objeto

Ahora que tienes un depósito, puedes comenzar a subir objetos.

  1. Haz clic en [Subir archivos][spotlight-upload-file] en la parte superior de la página.

  1. Selecciona un archivo para subir. Puede ser de cualquier tipo de archivo.

     ¿No tienes un archivo? [Crea uno de muestra][create-sample-file] y haz clic en [Actualizar depósito][spotlight-refresh-bucket], en la parte superior de la página, para verlo. Sugerencia: También puedes subir objetos si los arrastras y los sueltas en el espacio que está debajo del nombre del depósito.

  1. Para que un objeto esté disponible públicamente (la configuración predeterminada es privado), marca la casilla en la columna [Compartir públicamente][spotlight-share-public].

  1. Haz clic en [Vínculo público][spotlight-public-link] para probar el vínculo público del objeto, que debería abrirse en una nueva pestaña del navegador.
    Conserva esta pestaña para realizar el siguiente paso.

## Borra el depósito

Ahora, borremos el depósito que creaste. Cuando se borra un depósito, también se borra el contenido.

  1. En la parte superior de la tabla, haz clic en [Depósitos][spotlight-buckets-link] para regresar a la lista.

  1. Marca la casilla que aparece junto a tu depósito. Si el proyecto contiene otros depósitos, y necesitas ayuda para encontrar el tuyo, puedes usar la barra de búsqueda para filtrar la lista.

  1. En la parte superior de la página, haz clic en [Borrar][spotlight-delete-buckets] y confirma la eliminación.

## Conclusión

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Felicitaciones.

Ahora que sabes cómo empezar a almacenar objetos en Cloud Storage, te recomendamos [alojar un sitio web estático](https://cloud.google.com/storage/docs/hosting-static-website) para practicar lo que aprendiste.

O bien, aprende a usar Cloud Storage con la [herramienta de línea de comandos gsutil](https://cloud.google.com/storage/docs/quickstart-gsutil).

Descubre cómo empezar a usar Cloud Storage y otros servicios de GCP [sin costo](https://cloud.google.com/free).

[create-sample-file]: walkthrough://create-sample-storage-file
[spotlight-buckets-link]: walkthrough://spotlight-pointer?cssSelector=.p6n-cloudstorage-path-link
[spotlight-create-bucket]: walkthrough://spotlight-pointer?cssSelector=#p6ntest-cloudstorage-create-first-bucket-button,#p6n-cloudstorage-create-bucket
[spotlight-create-button]: walkthrough://spotlight-pointer?cssSelector=#p6ntest-gcs-create-bucket-button
[spotlight-delete-buckets]: walkthrough://spotlight-pointer?spotlightId=gcs-action-bar-delete-bucket
[spotlight-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-public-link]: walkthrough://spotlight-pointer?cssSelector=.p6n-cloudstorage-browser-public-label
[spotlight-refresh-bucket]: walkthrough://spotlight-pointer?spotlightId=gcs-action-bar-refresh-objects
[spotlight-share-public]: walkthrough://spotlight-pointer?cssSelector=.p6n-cloudstorage-browser-public-checkbox
[spotlight-upload-file]: walkthrough://spotlight-pointer?spotlightId=gcs-action-bar-upload-file
