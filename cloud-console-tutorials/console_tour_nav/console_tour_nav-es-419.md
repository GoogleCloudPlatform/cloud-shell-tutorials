# Recorrido por Cloud Console

<walkthrough-tutorial-duration duration="5"></walkthrough-tutorial-duration>

## Introducción

En este instructivo, se explican las funciones principales de Cloud Console para que puedas compilar y administrar tus aplicaciones en Google Cloud Platform.

Aprenderás los siguientes conceptos:

  *  Proyectos y recursos de GCP
  *  Registros de actividad y descripción general de recursos de alto nivel
  *  Navegación y búsqueda en Console
  *  Administración de usuarios y permisos
  *  Asistencia técnica
  *  Línea de comandos de GCP basada en el navegador

¡Comencemos!

## Usa recursos de GCP

Los recursos de GCP son los componentes fundamentales que conforman todos los servicios de Google Cloud. Se organizan de manera jerárquica y te ayudan a organizar el trabajo en GCP.

Los proyectos son el primer nivel de la jerarquía de recursos y contienen otros recursos de nivel inferior, como los depósitos de Cloud Storage y las instancias de Compute Engine.

[Obtén más información sobre los recursos de GCP][gcp-resources]

### Navegación de proyectos

Usa el [selector de alcance][spotlight-project-select] en Cloud Console para navegar con facilidad por los proyectos de GCP. Cuando cambies de proyecto, la vista se ajustará al proyecto nuevo y todos sus recursos secundarios.

<walkthrough-project-setup></walkthrough-project-setup>

## Navega por los servicios de Google Cloud

### Navegación por los servicios

Puedes acceder a los servicios de Google Cloud en el [menú de navegación del lado izquierdo][spotlight-console-menu] que se divide en áreas de producto, como macrodatos, Compute, Networking y más.

### Fija secciones

Si hay servicios que visites con regularidad, puedes fijar la sección correspondiente a la parte superior del menú de navegación. Para ello, desplázate sobre el elemento de la sección y haz clic en el ícono de fijar.

Para continuar, abre el menú de navegación y selecciona **Inicio**.

<walkthrough-menu-navigation sectionid="HOME_SECTION"></walkthrough-menu-navigation>

## Mira una descripción general de alto nivel de cualquier proyecto

### Panel principal

El Panel principal muestra una descripción general de alto nivel del proyecto de GCP seleccionado, que destaca las métricas clave, la facturación y otros datos útiles.

### Personalización

Haz clic en [Personalizar][spotlight-customize-dashboard] para ajustar tu panel.
Puedes ocultar, mostrar o reordenar las tarjetas que aparecen en la página. Además, cada tarjeta tiene opciones personalizadas a las que puedes acceder desde el menú ampliado cuando te desplazas sobre una tarjeta.

## Mira la actividad de distintos recursos de GCP

El [flujo de actividades][spotlight-activity-stream] te permitirá ver todas las actividades de tus recursos de GCP en un solo lugar.

Observa qué partes del proyecto actualizan tus compañeros de equipo para hacer un seguimiento de los problemas y auditar el acceso. Filtra el feed fácilmente para encontrar exactamente lo que necesitas.

## Busca en todo Cloud Console

La [barra de búsqueda][spotlight-search-bar] de Cloud Console te permite acceder con rapidez a los productos de Google Cloud y a cualquiera de tus recursos de GCP.

Prueba buscar **App Engine** o el nombre de alguno de tus proyectos.

## Obtén asistencia en cualquier momento

Si tienes dificultades o necesitas ayuda para navegar por el mundo de GCP, nuestro equipo de asistencia está disponible para ayudarte.

[Obtén más información sobre la Asistencia](http://cloud.google.com/support)

Accede a la asistencia desde el menú de navegación.

<walkthrough-menu-navigation sectionid="SUPPORT_SECTION"></walkthrough-menu-navigation>

## Administra usuarios y permisos

Google Cloud Identity and Access Management (Cloud IAM) te permite administrar y crear permisos para tus recursos de GCP.

[Obtén más información sobre IAM](https://cloud.google.com/iam/docs/)

A medida que incorpores más personas a tu equipo, puedes otorgarles acceso con Cloud IAM en la sección “IAM y administración”.

Agrega usuarios, grupos o cuentas de servicio y asígnales la cantidad de funciones que desees para otorgarles los permisos que necesitan.

<walkthrough-menu-navigation sectionid="IAM_ADMIN_SECTION"></walkthrough-menu-navigation>

## Accede a la línea de comandos desde el navegador

Google Cloud Shell te brinda acceso de línea de comandos a tus recursos en la nube directamente desde el navegador. Puedes administrar fácilmente los proyectos y recursos sin tener que instalar el SDK de Google Cloud ni ninguna otra herramienta en tu sistema.

<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>Con Cloud Shell, el comando de [gcloud][spotlight-open-devshell] del SDK de Cloud y otras herramientas de línea de comandos útiles siempre están disponibles, actualizados y completamente autenticados cuando los necesites.

[Obtén más información sobre Cloud Shell](https://cloud.google.com/shell/)

## Continúa tu recorrido por GCP

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Ahora deberías sentirte preparado para navegar por Cloud Console con una base sólida que te permita explorar nuevos servicios y productos.

Nuestra [documentación detallada](https://cloud.google.com/docs/) también proporciona mucha información, desde descripciones generales de productos hasta guías de inicio rápido y referencias de la API.

Vuelve a la página Comenzar para ver más instructivos.
<walkthrough-menu-navigation sectionid="ONBOARDING_SECTION"></walkthrough-menu-navigation>

[gcp-resources]: https://cloud.google.com/resource-manager/docs/cloud-platform-resource-hierarchy
[spotlight-activity-stream]: walkthrough://spotlight-pointer?cssSelector=.mat-tab-link:nth-of-type(2)
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-customize-dashboard]: walkthrough://spotlight-pointer?cssSelector=.cfc-customize-button
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-project-select]: walkthrough://spotlight-pointer?spotlightId=purview-switcher
[spotlight-search-bar]: walkthrough://spotlight-pointer?cssSelector=.p6n-search-bar,.pcc-platform-bar-search-bar
