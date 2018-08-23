# Introduzione a Cloud Pub/Sub

<walkthrough-tutorial-url url="https://cloud.google.com/pubsub/quickstart-console"></walkthrough-tutorial-url></walkthrough-test-start-page>

<walkthrough-devshell-precreate></walkthrough-devshell-precreate>

## Presentazione

Cloud Pub/Sub è un servizio di messaggistica in tempo reale completamente gestito che consente di inviare e ricevere messaggi tra applicazioni indipendenti. Questo tutorial fornisce una breve introduzione all'interfaccia a riga di comando di Cloud Pub/Sub utilizzando il comando `gcloud`.

## Configurazione del progetto

Google Cloud Platform organizza le risorse in progetti. Ciò consente di raccogliere tutte le risorse correlate per una singola applicazione in una sola posizione.

Per configurare i messaggi è necessario avere un progetto in Cloud Pub/Sub.

<walkthrough-project-setup></walkthrough-project-setup>

## Crea il tuo primo argomento

### Apri Google Cloud Shell

Cloud Shell è uno strumento a riga di comando integrato per la console. Utilizzerai Cloud Shell per configurare Cloud Pub/Sub.

Apri Cloud Shell facendo clic sull'[icona][spotlight-open-devshell] <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon> nella barra di navigazione nella parte superiore della console.

### Crea un argomento

Un argomento è una risorsa denominata a cui inviare messaggi. Crea il tuo primo argomento con il seguente comando:

```bash
gcloud pubsub topics create my-topic
```

## Aggiungi una sottoscrizione

Per ricevere messaggi, è necessario creare sottoscrizioni. Una sottoscrizione deve avere un argomento corrispondente. Crea la tua prima sottoscrizione con il seguente comando:

```bash
gcloud pubsub subscriptions \
    create my-sub --topic my-topic \
    --ack-deadline=60
```

Questo comando crea una sottoscrizione denominata `my-sub` associata all'argomento `my-topic`. Tutti i messaggi pubblicati su `my-topic` saranno consegnati a questa sottoscrizione.

Potresti aver notato l'opzione `--ack-deadline=60`. `ack-deadline` sta per `scadenza dell'acknowledgement`. Questa nuova sottoscrizione ha una `scadenza di acknowledgement` di 60 secondi. Approfondiremo questo aspetto più avanti.

## Elenca argomenti e sottoscrizioni

Prima di inviare il primo messaggio, controlla se la creazione dell'argomento e della sottoscrizione è riuscita. Elenca argomento e sottoscrizione utilizzando il seguente comando:

```bash
gcloud pubsub topics list
```

```bash
gcloud pubsub subscriptions list
```

## Pubblica messaggi sull'argomento

Invia due messaggi con i seguenti comandi:

```bash
gcloud pubsub topics publish my-topic --message hello
```

```bash
gcloud pubsub topics publish my-topic --message goodbye
```

Ognuno di questi comandi invia un messaggio. Il primo messaggio è `hello` e il secondo è `goodbye`. Quando pubblichi correttamente un messaggio, dovresti vedere l'ID messaggio restituito dal server. Si tratta di un ID univoco assegnato automaticamente dal server a ciascun messaggio.

## Esegui il pull dei messaggi dalla sottoscrizione

### Esegui il pull dei messaggi

Adesso esegui il pull dei messaggi con il seguente comando:

```bash
gcloud pubsub subscriptions \
    pull --auto-ack --limit=2 my-sub
```

Probabilmente hai visto i due messaggi che hai appena pubblicato. I messaggi contengono dati, `hello` e `goodbye`, e `MESSAGE_ID`. `MESSAGE_ID` è un ID univoco del messaggio assegnato dal server.

Nota: Cloud Pub/Sub non garantisce l'ordine dei messaggi. È anche possibile che tu abbia visto solo un messaggio. In tal caso, prova a eseguire lo stesso comando più volte fino a visualizzare l'altro messaggio.

### Acknowledgement e scadenza dell'acknowledgement

Dopo aver eseguito il pull di un messaggio e averlo elaborato, devi avvisare Cloud Pub/Sub di aver ricevuto il messaggio. Questa azione è chiamata **acknowledgement**.

Potresti aver notato il flag `--auto-ack` passato insieme al comando `pull`.
Il flag `--auto-ack` esegue automaticamente il pull del messaggio e invia l'acknowledgement del messaggio.

## Acknowledgement manuale

### Invia un nuovo messaggio

Invia un nuovo messaggio con il seguente comando:

```bash
gcloud pubsub \
    topics publish my-topic --message thanks
```

### Esegui di nuovo il pull dei messaggi

Esegui il pull dei messaggi con:

```bash
gcloud pubsub subscriptions \
    pull my-sub
```

Questo dovrebbe visualizzare il messaggio `thanks` oltre a `MESSAGE_ID` e `ACK_ID`.
`ACK_ID` è un altro ID che puoi utilizzare per l'acknowledgement del messaggio.

### Invia l'acknowledgement del messaggio

Dopo avere eseguito il pull di un messaggio, devi inviare l'acknowledgement del messaggio prima che sia trascorsa la **scadenza dell'acknowledgement**. Ad esempio, se una sottoscrizione è configurata con una **scadenza di acknowledgement** di 60 secondi, come in questo tutorial, devi inviare l'acknowledgement del messaggio entro 60 secondi dopo aver eseguito il pull del messaggio. In caso contrario, Cloud Pub/Sub invierà nuovamente il messaggio.

Invia l'acknowledgement del messaggio con il seguente comando (sostituisci `ACK_ID` con l'ID reale copiandolo e incollandolo):

```bash
gcloud pubsub subscriptions ack \
    my-sub --ack-ids ACK_ID
```

## Visualizza argomento e sottoscrizione nella UI di Pub/Sub

Prima di concludere il tutorial sulla riga di comando `gcloud`, diamo un'occhiata alla UI di Google Cloud Console.

Puoi anche vedere gli argomenti e le sottoscrizioni nella sezione Pub/Sub.

### Accedi alla sezione Pub/Sub

Apri il [menu][spotlight-console-menu] sul lato sinistro della console.

Quindi seleziona la sezione **Pub/Sub**.

<walkthrough-menu-navigation sectionid="CLOUDPUBSUB_SECTION"></walkthrough-menu-navigation>

La UI permette anche di creare e gestire argomenti e sottoscrizioni.

### Elimina l'argomento

Seleziona la casella di controllo accanto all'argomento che hai creato e fai clic sul [pulsante Elimina][spotlight-delete-button] per eliminare definitivamente l'argomento.

## Conclusione

Complimenti!

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Hai appreso i concetti di base di Cloud Pub/Sub utilizzando lo strumento a riga di comando `gcloud` e hai iniziato a conoscere la UI di Cloud Pub/Sub. Il passo successivo prevede la creazione di fantastiche applicazioni. Per ulteriori informazioni, consulta la [documentazione di Pub/Sub][pubsub-docs].

Ecco cosa puoi fare successivamente:

[Vedere esempi di
codice](https://cloud.google.com/pubsub/docs/quickstart-client-libraries)

[pubsub-docs]: https://cloud.google.com/pubsub/docs/
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-delete-button]: walkthrough://spotlight-pointer?cssSelector=.p6n-icon-delete
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
