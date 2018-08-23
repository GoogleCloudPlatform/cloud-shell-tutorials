# IAP für GCE/GKE aktivieren

IAP (Identity-Aware Proxy) sichert nur Traffic, der das Lastenausgleichsmodul durchläuft. Befolgen Sie diese Schritte, um Ihre Anwendung vor nicht autorisierten Zugriffen zu schützen.

[Weitere Informationen](https://cloud.google.com/iap/docs/)

## Die folgenden Schritte müssen ausgeführt werden:

### Netzwerkkonfiguration prüfen

Wenn die IP-Adressen `130.211.0.0/22` und `35.191.0.0/16` des Lastenausgleichsmoduls die Back-Ends nicht erreichen können, **funktioniert IAP nicht**.

Wenn andere IP-Adressen auf Ihre Back-Ends zugreifen können, umgeht dieser Traffic Ihre IAP-Zugriffsrichtlinien. Dies kann mitunter nützlich sein, beispielsweise damit Monitoringsysteme eine Verbindung zu Back-Ends herstellen können.

### Netzwerkkonfiguration überwachen

Wenn Ihre Konfiguration nach der Aktivierung von IAP geändert wird, könnte sie ihren Sicherheitsstatus verlieren.
Stellen Sie das Open-Source-Tool [Forseti Security][forseti-security] von Google bereit, um die Projektkonfiguration kontinuierlich zu überwachen und Benachrichtigungen zu senden.

### Prüfung auf signierten Header implementieren

[Hier erhalten Sie weitere Informationen](https://cloud.google.com/iap/docs/signed-headers-howto) zum Schutz Ihrer Anwendung vor Umgehungen der IAP-Zugriffsrichtlinie wie den folgenden:

  *  Ein Projektadministrator deaktiviert IAP versehentlich
  *  Fehler bei Netzwerkkonfiguration
  *  Ein Nutzer meldet sich bei der VM an und stellt eine Verbindung zum Webserver über localhost her

### Konfiguration bestätigen

Bestätigen Sie, dass Sie die GCE/GKE-Ressource gemäß der Dokumentation konfiguriert haben.

[Anleitung][spotlight-config-reviewed]

[forseti-security]: https://opensource.google.com/projects/forseti-security
[spotlight-config-reviewed]: walkthrough://spotlight-pointer?spotlightId=iap-network-config-reviewed
