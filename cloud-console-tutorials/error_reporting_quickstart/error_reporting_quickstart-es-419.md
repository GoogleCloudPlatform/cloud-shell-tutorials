# Stackdriver Error Reporting

## Introducción

Stackdriver Error Reporting agrega y muestra errores que se producen en los servicios de Cloud.

Este instructivo es una guía para usar la interfaz web de Error Reporting. Aprenderás a crear una lista de los errores de tu aplicación, ver más detalles sobre ellos y llevar a cabo acciones.

## Configuración del proyecto

<walkthrough-project-setup></walkthrough-project-setup>

## Genera errores

Antes de continuar, tendrás que generar informes de errores artificiales. Para ello, usarás un comando de `gcloud`.

En una situación real, estos errores se informarían directamente desde tu aplicación en ejecución. Después de terminar este instructivo, puedes obtener más información sobre la configuración de Error Reporting.

### Abre Google Cloud Shell

Para abrir Cloud Shell, haz <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>clic en el [ícono][spotlight-open-devshell] de la barra de navegación ubicada en la parte superior de Console.

### Informa algunos errores

Para generar errores de muestra, haz clic en el botón **Copiar al portapapeles** en la parte superior derecha de la siguiente secuencia de comandos y ejecútala en Cloud Shell.

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

### Cierra Cloud Shell

Cierra Cloud Shell y haz clic en *Continuar* cuando termines.

## Muestra la lista de errores de tu aplicación

Usarás Stackdriver Error Reporting para ver los errores informados.

### Abre Error Reporting

Abre el [menú][spotlight-console-menu] ubicado en el lado izquierdo de la consola.

A continuación, desplázate hasta la categoría **Stackdriver** y selecciona **Error Reporting**.

<walkthrough-menu-navigation sectionid="CRASH_SECTION"></walkthrough-menu-navigation>

### Ordenar por *Visto por primera vez*

Los errores que se producen en tu aplicación se agrupan y deduplican mediante un análisis de los seguimientos de pila. Las entradas de esta lista proporcionan un resumen que te ayuda a determinar en qué momento comenzó producirse el error en la aplicación, con qué frecuencia y cuándo sucedió por última vez.

El orden predeterminado por cantidad de *Repeticiones*. Haz clic en el encabezado de la columna *Visto por primera vez* para ver los errores que comenzaron a generarse recientemente.

### Acepta las notificaciones de errores nuevos

El sistema puede enviar un correo electrónico y una notificación push a un dispositivo móvil cuando se genera un error nuevo en el proyecto. Para aceptar estas notificaciones, haz clic en *Activar notificaciones*.

Haz clic en *Continuar* cuando hayas terminado.

## Comprende los detalles de un error

### Abre un informe de error

Haz clic en un error de la lista para ver sus detalles.

### Vincula un problema con este error

Usa esta página para examinar la información y el historial de un error específico.

Cuando se observa un error nuevo, una de las primeras medidas que se toma normalmente es registrarlo en el sistema de seguimiento de problemas de tu equipo. Puedes vincular la entrada del sistema de seguimiento de problemas con el error en Stackdriver Error Reporting.

Para ello, deberás hacer lo siguiente:

  *  Haz clic en *Vínculo al problema* en la parte superior de la página (es posible que debas abrir el menú **más acciones** para ver este vínculo).
  *  Ingresa `http://example.com/issues/1234` en el cuadro de diálogo.
  *  Haz clic en *Guardar*.

### Explora seguimientos de pila

Para que puedas concentrarte en el código, ocultamos los marcos de seguimiento de pila que no provienen del código de tu aplicación.

Haz clic en *Mostrar todo* en una muestra de error para ver los marcos de pila del marco de trabajo.

## Conclusión

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Felicitaciones. Terminaste el instructivo de Stackdriver Error Reporting correctamente.

A continuación, puedes hacer lo siguiente:

### Configura Error Reporting para tu proyecto

Consulta la [documentación de configuración][errors-setup] para aprender a configurar Error Reporting en tus servicios en ejecución.

### Explora otros instructivos de Stackdriver

Consulta la guía de inicio rápido de [Stackdriver Debugger][debug-quickstart] para depurar una aplicación de producción.

Consulta la guía de inicio rápido de [Stackdriver Trace][trace-quickstart] para comprender la latencia de tu aplicación.

[debug-quickstart]: https://cloud.google.com/debugger/docs/quickstart
[errors-setup]: https://cloud.google.com/error-reporting/docs/how-to
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[trace-quickstart]: https://cloud.google.com/trace/docs/quickstart
