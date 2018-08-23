# Stackdriver Error Reporting

## Presentazione

Stackdriver Error Reporting aggrega e visualizza gli errori generati dai servizi cloud.

Questo tutorial ti guiderà attraverso l'interfaccia web di Error Reporting. Imparerai a elencare gli errori dell'applicazione, a visualizzare maggiori dettagli al riguardo e a intraprendere le azioni necessarie.

## Configurazione del progetto

<walkthrough-project-setup></walkthrough-project-setup>

## Genera errori

Prima di continuare, devi segnalare gli errori fittizi. A questo scopo, utilizzerai un comando `gcloud`.

In uno scenario reale, questi errori verrebbero segnalati direttamente dall'applicazione in esecuzione. Dopo questo tutorial, potrai avere ulteriori informazioni su come configurare Error Reporting.

### Apri Google Cloud Shell

Apri Cloud Shell facendo clic sull'[icona][spotlight-open-devshell] <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon> nella barra di navigazione nella parte superiore della console.

### Segnala alcuni errori

Fai clic sul pulsante **Copia negli appunti** in alto a destra dello script seguente ed eseguilo in Cloud Shell per generare alcuni errori di esempio.

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

### Chiudi Cloud Shell

Chiudi Cloud Shell e fai clic su *Continua* quando hai finito.

## Elenca gli errori dell'applicazione

Stackdriver Error Reporting verrà utilizzato per visualizzare una panoramica degli errori segnalati.

### Apri Error Reporting

Apri il [menu][spotlight-console-menu] sul lato sinistro della console.

Quindi scorri fino alla categoria **Stackdriver** e seleziona **Error Reporting**.

<walkthrough-menu-navigation sectionid="CRASH_SECTION"></walkthrough-menu-navigation>

### Ordina per *Prima visualizzazione*

Gli errori che si verificano nella tua applicazione sono raggruppati e deduplicati analizzando le analisi dello stack. Ogni voce in questo elenco fornisce un riepilogo mediante il quale puoi determinare quando l'applicazione ha iniziato a generare l'errore, nonché la frequenza e la data/ora in cui si è verificato.

Per impostazione predefinita, l'elenco è ordinato per *Occorrenze*. Fai clic sull'intestazione di colonna *Prima visualizzazione* per vedere gli errori che hanno iniziato a verificarsi di recente.

### Attiva le notifiche in caso di nuovi errori

Quando si verifica un nuovo errore nel progetto, è possibile che vengano inviate un'email e una notifica push per dispositivi mobili. Per attivare queste notifiche, fai clic su *Attiva notifiche*.

Al termine fai clic su *Continua*.

## Leggi i dettagli di un errore

### Apri un rapporto degli errori

Fai clic su un errore in questo elenco per visualizzarne i dettagli.

### Collega un problema all'errore

Utilizza questa pagina per esaminare le informazioni e la cronologia di un errore specifico.

Dopo aver controllato un nuovo errore, l'azione successiva in genere consiste nell'inserimento di un problema nel programma di monitoraggio dei problemi del team. La segnalazione immessa nello strumento di monitoraggio dei problemi può quindi essere collegata all'errore in Stackdriver Error Reporting.

A tal fine, procedi nel seguente modo:

  *  Fai clic su *Collega a problema* in alto (potresti dover aprire il menu **Altre azioni** per visualizzare questo link).
  *  Inserisci `http://example.com/issues/1234` nella finestra di dialogo.
  *  Fai clic su *Salva*.

### Esplora le analisi dello stack

Per evidenziare solo il tuo codice, vengono nascosti i frame delle analisi dello stack che non appartengono al codice della tua applicazione.

Fai clic su *Mostra tutto* in un errore di esempio per visualizzare gli stack frame del framework.

## Conclusione

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Complimenti! Hai completato con successo il tutorial su Stackdriver Error Reporting.

Ecco cosa puoi fare successivamente:

### Configura Error Reporting per il tuo progetto

Scopri come configurare Error Reporting per i tuoi servizi in esecuzione nella [documentazione relativa alla configurazione][errors-setup].

### Scopri altri tutorial Stackdriver

Esegui il debug di un'applicazione di produzione con la Guida di avvio rapido di [Stackdriver Debugger][debug-quickstart].

Scopri di più sulla latenza della tua applicazione con la Guida di avvio rapido di [Stackdriver Trace][trace-quickstart].

[debug-quickstart]: https://cloud.google.com/debugger/docs/quickstart
[errors-setup]: https://cloud.google.com/error-reporting/docs/how-to
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[trace-quickstart]: https://cloud.google.com/trace/docs/quickstart
