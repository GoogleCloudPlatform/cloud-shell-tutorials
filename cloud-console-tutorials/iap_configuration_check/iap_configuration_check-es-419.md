# Activa IAP para GCE/GKE

Identity-Aware Proxy (IAP) solo protege el tráfico que pasa por el balanceador de cargas. Realiza los siguientes pasos a fin de proteger tu aplicación de ataques no autorizados.

[Más información](https://cloud.google.com/iap/docs/)

## Estos son los pasos que deberás completar:

### Revisa la configuración de red

Si las IP del balanceador de cargas, `130.211.0.0/22` y `35.191.0.0/16`, no pueden alcanzar tus backends, IAP **no funcionará**.

Si hay otras IP con acceso a tus backends, ese tráfico no se verá sometido a tu política de acceso de IAP. En algunos casos, esto puede ser útil para permitir que los sistemas de supervisión se conecten a los backends.

### Supervisa tu configuración de red

Si tu configuración cambia después de habilitar IAP, podría volverse insegura.
Implementa [Forseti Security][forseti-security], una herramienta de código abierto mantenida por Google que permite supervisar continuamente la configuración de proyectos y enviar notificaciones.

### Implementa la verificación de encabezados firmados

[Obtén información sobre cómo](https://cloud.google.com/iap/docs/signed-headers-howto) impedir situaciones en las que se pueda evadir la política de acceso de IAP de tu app. Por ejemplo:

  *  Un administrador de proyectos que inhabilita IAP por accidente
  *  Errores de configuración de red
  *  Un usuario que accede a la VM y se conecta al servidor web mediante localhost

### Confirmar configuración

Confirma que leíste y configuraste el recurso de GCE/GKE, conforme a lo indicado en la documentación.

[Mostrarme cómo][spotlight-config-reviewed]

[forseti-security]: https://opensource.google.com/projects/forseti-security
[spotlight-config-reviewed]: walkthrough://spotlight-pointer?spotlightId=iap-network-config-reviewed
