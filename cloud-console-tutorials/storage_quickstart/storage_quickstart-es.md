# Tutorial de inicio rápido de Cloud Storage

## Te damos la bienvenida a Google Cloud Storage

<walkthrough-tutorial-url url="https://cloud.google.com/storage/docs/quickstart-console"></walkthrough-tutorial-url>

Google Cloud Storage es una solución de almacenamiento eficaz y rentable para los objetos sin estructurar. Además, es ideal para realizar todo tipo de tareas, como alojar contenido web publicado, almacenar datos para analizarlos, realizar operaciones de archivado o crear copias de seguridad.

En este tutorial, descubrirás lo fácil que es empezar a almacenar objetos en Cloud Storage. Esto es lo que harás:

  *  **Crear un segmento**

     Los segmentos contienen los objetos (cualquier tipo de archivo) que quieres almacenar en Cloud Storage.

  *  **Subir y compartir objetos**

     Para empezar a usar el segmento, tendrás que subir un objeto y compartirlo públicamente.

  *  **Limpieza**

     En el último paso, eliminarás el segmento y el objeto que hayas creado en el tutorial.

Como eliminarás el segmento y el objeto al final del tutorial, no se te facturarán costes por realizarlo.

## Configuración del proyecto

Cloud Storage necesita un proyecto para crear recursos.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## Crear un segmento

En Cloud Storage, los objetos se almacenan en segmentos. Para crear uno, ve al navegador de Cloud Storage.

Abre el [menú][spotlight-menu] que se encuentra en la parte izquierda de la consola.

Luego, elige la sección **Storage**.

<walkthrough-menu-navigation sectionid="STORAGE_SECTION"></walkthrough-menu-navigation>

## Crear un segmento

Antes de empezar a subir objetos, debes crear un "contenedor" donde almacenarlos (es decir, un segmento). Los segmentos te permiten organizar los objetos y controlar el acceso a ellos.

  1. Haz clic en [Crear segmento](walkthrough://spotlight-pointer?cssSelector=#p6ntest-cloudstorage-create-first-bucket-button).

  1. Especifica las propiedades del segmento en la página de creación de segmentos. A continuación, te indicamos algunas cuestiones que debes tener en cuenta:

     *  **Nombre:** elige un nombre único. Si escribes uno que ya usa otro segmento en Cloud Storage, aparecerá un mensaje de error.
     *  **Clase de almacenamiento predeterminada:** esta es la clase de almacenamiento que se asigna a los objetos de tu segmento de forma predeterminada. La elección depende en gran medida de la frecuencia con que crees que se accederá a los objetos y de si publicas los datos en todo el mundo. La clase de almacenamiento repercute en el coste.
     *  **Ubicación:** te recomendamos que almacenes los datos cerca de las aplicaciones y de los usuarios que van a acceder a ellos. Las opciones disponibles dependen de la clase de almacenamiento que selecciones.

Para esta ejecución de prueba, puedes elegir cualquier clase de almacenamiento y ubicación, ya que al final eliminarás el segmento.

  1. Por último, haz clic en [Crear][spotlight-create-button].

## Subir un objeto

Cuando hayas creado el segmento, podrás empezar a subir objetos.

  1. En la parte superior de la página, haz clic en [Subir archivos][spotlight-upload-file].

  1. Selecciona un archivo que quieras subir (puede ser de cualquier tipo).

     Si aún no tienes ningún archivo, [crea uno de muestra][create-sample-file] y haz clic en [Actualizar segmento][spotlight-refresh-bucket] en la parte superior de la página para verlo en el segmento. También puedes subir objetos si los arrastras y sueltas en el espacio que se encuentra debajo del nombre del segmento.

## Eliminar el segmento

Ahora, vamos a eliminar el segmento que acabas de crear. Si lo haces, también se borrará su contenido.

  1. En la parte superior de la tabla, haz clic en [Segmentos][spotlight-buckets-link] para volver a la lista de segmentos.

  1. Marca la casilla situada junto al segmento en cuestión. Si el proyecto tiene más segmentos y necesitas ayuda para encontrar el tuyo, usa la barra de búsqueda para filtrar la lista.

  1. En la parte superior de la página, haz clic en [Eliminar][spotlight-delete-buckets] y confirma que quieres ejecutar la acción.

## Conclusión

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

¡Enhorabuena!

Ahora que sabes cómo empezar a almacenar objetos en Cloud Storage, te recomendamos que [alojes un sitio web estático](https://cloud.google.com/storage/docs/hosting-static-website) para poner en práctica estos conocimientos en un entorno real.

También puedes aprender a usar Cloud Storage con la [herramienta de línea de comandos gsutil](https://cloud.google.com/storage/docs/quickstart-gsutil).

Descubre cómo empezar a usar Cloud Storage y otros servicios de Google Cloud Platform [de forma gratuita](https://cloud.google.com/free).

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
