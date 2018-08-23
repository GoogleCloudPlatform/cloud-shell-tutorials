# Activar IAP para GCE o GKE

Identity-Aware Proxy (IAP) protege únicamente el tráfico que pasa a través del balanceador de carga. Sigue estos pasos para proteger tu aplicación de los ataques sin autorización.

[Más información](https://cloud.google.com/iap/docs/)

## Estos son los pasos que debes llevar a cabo:

### Revisa la configuración de la red

Si las direcciones IP del balanceador de carga (`130.211.0.0/22` y `35.191.0.0/16`) no pueden llegar a los backends, IAP **no funcionará**.

Si alguna otra IP puede acceder a los backends, el tráfico omitirá la política de acceso de IAP. Esto puede resultar útil en algunos casos; por ejemplo, para permitir que los sistemas de supervisión se conecten a los backends.

### Supervisa la configuración de la red

Si la configuración cambia después de habilitar IAP, puede dejar de ser segura.
Despliega [Forseti Security][forseti-security], una herramienta de código abierto mantenida por Google que permite supervisar en todo momento la configuración de los proyectos y enviar notificaciones.

### Implementa la comprobación de cabeceras firmadas

[Descubre](https://cloud.google.com/iap/docs/signed-headers-howto) cómo puedes proteger tu aplicación ante las omisiones de las políticas de acceso de IAP, como por ejemplo:

  *  Un administrador de proyecto que inhabilite IAP por error
  *  Errores de configuración de la red
  *  Un usuario que haya iniciado sesión en la VM y se esté conectando al servidor web mediante el host local

### Comprueba la configuración

Confirma que has leído la documentación y que has configurado el recurso de GCE o GKE de acuerdo con ella.

[Mostrar procedimiento][spotlight-config-reviewed]

[forseti-security]: https://opensource.google.com/projects/forseti-security
[spotlight-config-reviewed]: walkthrough://spotlight-pointer?spotlightId=iap-network-config-reviewed
