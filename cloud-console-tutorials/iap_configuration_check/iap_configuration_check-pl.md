# Włączanie IAP na potrzeby GCE/GKE

IAP zabezpiecza tylko ruch, który przechodzi przez system równoważenia obciążenia. Aby zabezpieczyć aplikację przed nieautoryzowanym dostępem, wykonaj opisane tu czynności.

[Więcej informacji](https://cloud.google.com/iap/docs/)

## Wykonasz następujące działania:

### Sprawdzenie konfiguracji sieci

Jeśli adresy IP `130.211.0.0/22` oraz `35.191.0.0/16` systemu równoważenia obciążenia nie będą mogły skontaktować się z backendami, IAP **nie będzie działać**.

Jeśli dowolne inne adresy IP mają dostęp do backendów, ruch z nich pominie zasady dostępu IAP. W niektórych przypadkach może to być przydatne, na przykład do łączenia systemów monitorowania z backendami.

### Monitorowanie konfiguracji sieciowej

Jeśli po włączeniu IAP konfiguracja ulegnie zmianie, może utracić zabezpieczenia.
Skorzystaj z udostępnianego przez Google narzędzia open-source [Forseti Security][forseti-security], które stale monitoruje konfigurację projektu i wysyła powiadomienia.

### Implementacja kontroli podpisu nagłówka

[Dowiedz się](https://cloud.google.com/iap/docs/signed-headers-howto), w jaki sposób chronić aplikację przed możliwymi sposobami ominięcia zasad dostępu IAP, takimi jak:

  *  przypadkowe wyłączenie IAP przez administratora projektu,
  *  błędy w konfiguracji sieci,
  *  logowanie się użytkownika na maszynie wirtualnej i łączenie z serwerem internetowym za pomocą lokalnego hosta.

### Potwierdzenie konfiguracji

Potwierdź, że znasz treść dokumentacji i udało Ci się skonfigurować zasób GCE/GKE zgodnie z nią.

[Pokaż mi, jak to zrobić][spotlight-config-reviewed]

[forseti-security]: https://opensource.google.com/projects/forseti-security
[spotlight-config-reviewed]: walkthrough://spotlight-pointer?spotlightId=iap-network-config-reviewed
