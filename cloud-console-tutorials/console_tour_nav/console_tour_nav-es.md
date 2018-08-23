# Visita guiada por Cloud Console

<walkthrough-tutorial-duration duration="5"></walkthrough-tutorial-duration>

## Introducción

En este tutorial se abordan las funciones principales de Cloud Console para que puedas empezar a crear y administrar aplicaciones en Google Cloud Platform (GCP).

Encontrarás información sobre los siguientes conceptos:

  *  Proyectos y recursos de GCP
  *  Registros de actividad y resumen general de los recursos
  *  Búsqueda y navegación en la consola
  *  Administración de permisos y usuarios
  *  Servicio de asistencia técnica
  *  Línea de comandos basada en navegador de GCP

¡Pongámonos manos a la obra!

## Usar los recursos de Google Cloud Platform

Los recursos de GCP son los componentes fundamentales que constituyen todos los servicios de Google Cloud. Se organizan jerárquicamente y te ayudan a estructurar tu trabajo en la plataforma.

Los proyectos conforman el primer nivel de la jerarquía de recursos y contienen, a su vez, otros recursos, como los segmentos de Cloud Storage y las instancias de Compute Engine.

[Más información sobre los recursos de GCP][gcp-resources]

### Desplazarse por los proyectos

Usa el [selector de proyectos][spotlight-project-select] de Cloud Console para desplazarte fácilmente por tus proyectos de GCP. Cuando cambias de proyecto, la vista se adapta al que selecciones y a sus respectivos recursos secundarios.

<walkthrough-project-setup></walkthrough-project-setup>

## Desplazarse por los servicios de Google Cloud

### Desplazarse por los servicios

Puedes acceder a los servicios de Google Cloud desde el [menú de navegación de la izquierda][spotlight-console-menu], que está organizado por área de productos (como Big Data, Recursos informáticos o Redes).

### Fijar secciones

Puedes fijar la sección de cualquier servicio que visites con regularidad en la parte superior del menú de navegación. Para ello, desplaza el cursor sobre el elemento de la sección y haz clic en el icono para fijarla.

Abre el menú de navegación y selecciona **Inicio** para continuar.

<walkthrough-menu-navigation sectionid="HOME_SECTION"></walkthrough-menu-navigation>

## Ver la información general de cualquier proyecto

### Panel de control de Inicio

En el panel de control de Inicio encontrarás información general sobre el proyecto de GCP seleccionado, donde se destacarán las métricas clave, la facturación y otros datos de utilidad.

### Personalización

Para personalizar el panel, haz clic en [Personalizar][spotlight-customize-dashboard].
También puedes ocultar, mostrar y reordenar cualquier tarjeta de la página. Si desplazas el cursor sobre una tarjeta, podrás acceder a un menú adicional con opciones personalizadas.

## Ver la actividad de los recursos de Google Cloud Platform

El [flujo de actividad][spotlight-activity-stream] te permite ver todas las actividades que ocurren en tus recursos de GCP desde un mismo lugar.

De ese modo, sabrás qué están actualizando tus compañeros de equipo en cualquier proyecto para detectar posibles problemas y auditar los accesos. Puedes filtrar fácilmente el feed para encontrar exactamente la información que necesitas.

## Realizar búsquedas en Cloud Console

Con la [barra de búsqueda][spotlight-search-bar] de Cloud Console, puedes acceder rápidamente a los productos de Google Cloud y a cualquiera de tus recursos de GCP.

Prueba a buscar **App Engine** o el nombre de uno de tus proyectos.

## Obtener asistencia en cualquier momento

Si se te plantea alguna dificultad o necesitas ayuda a la hora de explorar GCP, puedes contar con nuestro equipo de asistencia.

[Más información sobre la asistencia](http://cloud.google.com/support)

Accede al servicio de asistencia desde el menú de navegación.

<walkthrough-menu-navigation sectionid="SUPPORT_SECTION"></walkthrough-menu-navigation>

## Administrar usuarios y permisos

Con Cloud Identity and Access Management (Cloud IAM), puedes crear y administrar los permisos de tus recursos de Google Cloud Platform.

[Más información sobre Cloud IAM](https://cloud.google.com/iam/docs/)

A medida que tu equipo sigue creciendo, puedes otorgar permisos a tus compañeros con Cloud IAM, situado en la sección "IAM y administración".

Añade usuarios, grupos o cuentas de servicio y asígnales las funciones que quieras para concederles los permisos que necesiten.

<walkthrough-menu-navigation sectionid="IAM_ADMIN_SECTION"></walkthrough-menu-navigation>

## Acceder a la línea de comandos desde el navegador

Google Cloud Shell te ofrece acceso a tus recursos en la nube mediante la línea de comandos directamente desde el navegador. Puedes administrar fácilmente tus proyectos y recursos sin tener que instalar en tu sistema el SDK de Google Cloud ni otras herramientas.

Con <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[Cloud Shell][spotlight-open-devshell], la herramienta de línea de comandos gcloud del SDK de Google Cloud y otras utilidades esenciales están siempre disponibles, actualizadas y completamente autenticadas para cuando las necesites.

[Más información sobre Cloud Shell](https://cloud.google.com/shell/)

## Sigue descubriendo Google Cloud Platform

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Después de esta visita guiada habrás adquirido suficientes conocimientos de navegación por Cloud Console como para permitirte explorar nuevos productos y servicios.

En nuestra [documentación detallada](https://cloud.google.com/docs/) también encontrarás una amplia variedad de información, desde descripciones generales de productos hasta guías de inicio rápido y referencias de las API.

Vuelve a la página Primeros pasos para ver más tutoriales.
<walkthrough-menu-navigation sectionid="ONBOARDING_SECTION"></walkthrough-menu-navigation>

[gcp-resources]: https://cloud.google.com/resource-manager/docs/cloud-platform-resource-hierarchy
[spotlight-activity-stream]: walkthrough://spotlight-pointer?cssSelector=.mat-tab-link:nth-of-type(2)
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-customize-dashboard]: walkthrough://spotlight-pointer?cssSelector=.cfc-customize-button
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-project-select]: walkthrough://spotlight-pointer?spotlightId=purview-switcher
[spotlight-search-bar]: walkthrough://spotlight-pointer?cssSelector=.p6n-search-bar,.pcc-platform-bar-search-bar
