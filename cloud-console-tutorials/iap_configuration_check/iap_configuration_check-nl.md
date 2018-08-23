# IAP voor GCE/GKE inschakelen

Met Identity-Aware Proxy (IAP) beveiligt u alleen verkeer dat door de load balancer gaat. Voer de volgende stappen uit om uw app te beveiligen tegen ongeoorloofde aanvallen.

[Meer informatie](https://cloud.google.com/iap/docs/)

## Dit zijn de stappen die u uitvoert:

### Netwerkconfiguratie beoordelen

Als de IP-adressen van de load balancer, `130.211.0.0/22` en `35.191.0.0/16`, uw backends niet kunnen bereiken, **werkt IAP niet**.

Als andere IP's toegang hebben tot uw backends, zal dat verkeer uw IAP-toegangsbeleid omzeilen. In sommige gevallen is dit nuttig, bijvoorbeeld om controlesystemen de mogelijkheid te bieden verbinding te maken met backends.

### Uw netwerkconfiguratie controleren

Als uw configuratie is gewijzigd na het inschakelen van IAP, kan deze onveilig worden.
Implementeer [Forseti Security][forseti-security], een open source tool die door Google wordt onderhouden, om continu de projectconfiguratie te controleren en meldingen te verzenden.

### Controle van ondertekende headers implementeren

[Meer informatie](https://cloud.google.com/iap/docs/signed-headers-howto) over de beveiliging van uw app tegen manieren om het IAP-toegangsbeleid te omzeilen, zoals:

  *  Een projectbeheerder die per ongeluk IAP uitschakelt
  *  Fouten in de netwerkconfiguratie
  *  Een gebruiker die inlogt bij de VM en via een lokale host verbinding maakt met de webserver

### Configuratie bevestigen

Bevestig dat u de GCE/GKE-resource heeft gelezen en geconfigureerd volgens de documentatie.

[Laat me zien hoe][spotlight-config-reviewed]

[forseti-security]: https://opensource.google.com/projects/forseti-security
[spotlight-config-reviewed]: walkthrough://spotlight-pointer?spotlightId=iap-network-config-reviewed
