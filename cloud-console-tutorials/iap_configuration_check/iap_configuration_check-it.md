# Attiva IAP per GCE/GKE

Identity-Aware Proxy (IAP) protegge solo il traffico che passa attraverso il bilanciatore del carico. Per proteggere la tua app da attacchi o accessi non autorizzati, procedi nel seguente modo.

[Ulteriori informazioni](https://cloud.google.com/iap/docs/)

## Di seguito è illustrata la procedura da seguire:

### Rivedi la configurazione della rete

Se gli indirizzi IP del bilanciatore del carico, `130.211.0.0/22` e `35.191.0.0/16`, non riescono a raggiungere i backend, IAP **non funzionerà**.

Se un altro indirizzo IP riesce ad accedere ai backend, tale traffico ignorerà i criteri di accesso IAP. In alcuni casi questa situazione può risultare utile, ad esempio per consentire ai sistemi di monitoraggio di collegarsi ai backend.

### Monitora la configurazione della rete

Se la configurazione viene modificata dopo l'attivazione dell'IAP, potrebbero verificarsi problemi di sicurezza.
Distribuisci [Forseti Security][forseti-security], uno strumento open source gestito da Google, per monitorare continuamente la configurazione del progetto e inviare notifiche.

### Implementa il controllo delle intestazioni con firma

[Scopri come](https://cloud.google.com/iap/docs/signed-headers-howto) proteggere la tua app nei casi in cui i criteri di accesso IAP vengano ignorati, ad esempio se:

  *  Un amministratore di progetto disattiva inavvertitamente IAP
  *  Errori di configurazione di rete
  *  Un utente che accede alla VM e si collega al server web tramite localhost

### Conferma la configurazione

Conferma di aver letto e configurato la risorsa GCE/GKE secondo la documentazione.

[Mostrami come fare][spotlight-config-reviewed]

[forseti-security]: https://opensource.google.com/projects/forseti-security
[spotlight-config-reviewed]: walkthrough://spotlight-pointer?spotlightId=iap-network-config-reviewed
