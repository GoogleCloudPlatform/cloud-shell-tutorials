# Stackdriver Error Reporting

## Introducción

Stackdriver Error Reporting agrupa y muestra los errores que causan los servicios en la nube.

Este tutorial te guiará a través de la interfaz web de Error Reporting, además de enseñarte cómo mostrar los errores de tu aplicación, ver más información sobre ellos y tomar medidas al respecto.

## Configuración del proyecto

<walkthrough-project-setup></walkthrough-project-setup>

## Generar errores

Antes de continuar, debes informar de los errores artificiales. Para ello, utilizarás un comando `gcloud`.

En una situación real, estos errores se notificarían directamente desde la aplicación que se esté ejecutando. Cuando termines este tutorial, podrás obtener más información sobre cómo configurar Error Reporting.

### Abrir Google Cloud Shell

Para abrir esta herramienta, haz clic en el icono <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[][spotlight-open-devshell] que se encuentra en la barra de navegación de la parte superior de la consola.

### Informar de algunos errores

Haz clic en el botón **Copiar en el portapapeles** situado en la parte superior derecha de la secuencia de comandos que aparece más adelante. Luego, ejecútala en Cloud Shell para generar errores de ejemplo.

```bash
COUNTER=0
while [  $COUNTER -lt 11 ]; do
    gcloud beta error-reporting events report --service tutorial --service-version v$((COUNTER/10+1)) \
        --message "java.lang.RuntimeException: Error rendering template $COUNTER
          at com.example.TestClass.test(TestClass.java:51)
          at com.example.AnotherClass(AnotherClass.java:25)
          at javax.servlet.http.HttpServlet.service (HttpServlet.java:617)
          at javax.servlet.http.HttpServlet.service (HttpServlet.java:717)"
    if [ $COUNTER -lt 3 ]; then
      gcloud beta error-reporting events report --service tutorial --service-version v1 \
          --message "java.lang.ArrayIndexOutOfBoundsException: $COUNTER
            at com.example.AppController.createUser(AppController.java:42)
            at com.example.User(User.java:31)
            at javax.servlet.http.HttpServlet.service (HttpServlet.java:617)
            at javax.servlet.http.HttpServlet.service (HttpServlet.java:717)"
    fi
    if [ $COUNTER -eq 10 ]; then
      echo "All artificial errors reported."
    fi
    let COUNTER=COUNTER+1
done
```

### Cerrar Cloud Shell

Cierra esta herramienta y haz clic en *Continuar* cuando hayas terminado.

## Mostrar los errores de la aplicación

A continuación, utilizarás Stackdriver Error Reporting para ver los errores notificados de un solo vistazo.

### Abrir Error Reporting

Abre el [menú][spotlight-console-menu] que se encuentra en el lado izquierdo de la consola.

A continuación, desplázate hasta la categoría **Stackdriver** y, luego, selecciona **Error Reporting**.

<walkthrough-menu-navigation sectionid="CRASH_SECTION"></walkthrough-menu-navigation>

### Ordenar por *Visto por primera vez*

Los errores que se producen en tu aplicación se agrupan y se anulan los duplicados mediante el análisis de sus trazas de pila. Cada una de las entradas de esta lista proporciona un resumen que te ayuda a determinar cuándo apareció el error por primera vez en la aplicación, con qué frecuencia sucedió y cuándo fue la última vez que se produjo.

El orden predeterminado es *Repeticiones*. Haz clic en el encabezado de la columna *Visto por primera vez* para ver los errores que han empezado a producirse recientemente.

### Habilitar las notificaciones sobre nuevos errores

Puedes recibir un correo electrónico y una notificación push móvil cada vez que se produzca un error nuevo en el proyecto. Para habilitar estas notificaciones, haz clic en *Activar notificaciones*.

Haz clic en *Continuar* cuando tengas todo listo.

## Entender los detalles de un error

### Abrir un informe de error

Haz clic en un error de esta lista para ver los detalles correspondientes.

### Enlazar un problema a este error

Utiliza esta página para examinar la información y el historial de un error específico.

Lo que se suele hacer después de detectar un error nuevo es registrar el problema en la herramienta de seguimiento de incidencias del equipo. En Stackdriver Error Reporting, puedes vincular la entrada correspondiente de esta herramienta con el error en cuestión.

Para hacerlo, sigue estos pasos:

  *  En la parte superior, haz clic en *Enlazar con el problema* (puede que tengas que abrir el menú **Más acciones** para ver este enlace).
  *  Introduce `http://example.com/issues/1234` en el cuadro de diálogo.
  *  Haz clic en *Guardar*.

### Examinar las trazas de pila

En esta herramienta, se ocultan los marcos de trazas de pila que no pertenecen al código de tu aplicación para que puedas centrar toda tu atención en dicho código.

Haz clic en *Mostrar todo* en un error de ejemplo para que aparezcan los marcos de pila del framework.

## Conclusión

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

¡Enhorabuena! Has completado correctamente el tutorial de Stackdriver Error Reporting.

Esto es lo que puedes hacer a continuación:

### Configurar Error Reporting en tu proyecto

Aprende a configurar Error Reporting en tus servicios en ejecución con la [documentación de configuración][errors-setup].

### Explorar otros tutoriales de Stackdriver

Depura una aplicación de producción con el tutorial de inicio rápido de [Stackdriver Debugger][debug-quickstart].

Comprende la latencia de tu aplicación con el tutorial de inicio rápido de [Stackdriver Trace][trace-quickstart].

[debug-quickstart]: https://cloud.google.com/debugger/docs/quickstart
[errors-setup]: https://cloud.google.com/error-reporting/docs/how-to
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[trace-quickstart]: https://cloud.google.com/trace/docs/quickstart
