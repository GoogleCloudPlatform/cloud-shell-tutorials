# Guida di avvio rapido di App Engine

<walkthrough-tutorial-url url="https://cloud.google.com/appengine/docs/python/quickstart"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="https://github.com/GoogleCloudPlatform/python-docs-samples" key="repo-url"></walkthrough-watcher-constant>
<walkthrough-watcher-constant value="python-docs-samples/appengine/standard/hello_world" key="repo-dir"></walkthrough-watcher-constant>

## Presentazione

Questo tutorial mostra come distribuire un'applicazione [Python](https://python.org/) di esempio su Google App Engine utilizzando il comando `gcloud`.

Di seguito è illustrata la procedura da seguire.

  *  **Crea un progetto**

     I progetti raggruppano codice, macchine virtuali e altre risorse per uno sviluppo e un monitoraggio semplificati.

  *  **Crea ed esegui l'applicazione "Hello, world!"**

     Imparerai a eseguire l'applicazione utilizzando Google Cloud Shell direttamente nel browser. Alla fine distribuirai la tua applicazione sul Web usando il comando `gcloud`.

  *  **Dopo il tutorial…**

     L'applicazione sarà reale e potrai utilizzarla per fare delle prove dopo la distribuzione, oppure rimuoverla e ricominciare da capo.

["Python" e i loghi Python sono marchi o marchi registrati di Python Software Foundation.](walkthrough://footnote)

## Configurazione del progetto

Per distribuire un'applicazione è necessario prima creare un progetto.

Google Cloud Platform organizza le risorse in progetti. Ciò consente di raccogliere tutte le risorse correlate per una singola applicazione in una sola posizione.

<walkthrough-devshell-precreate></walkthrough-devshell-precreate>

<walkthrough-project-setup></walkthrough-project-setup>

## Uso di Google Cloud Shell

Cloud Shell è uno strumento a riga di comando integrato per la console. Useremo Cloud Shell per distribuire la nostra applicazione.

### Aprire Google Cloud Shell

Apri Cloud Shell facendo clic sull'[icona][spotlight-open-devshell] <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon> nella barra di navigazione in alto nella console.

### Clonare il codice di esempio

Utilizza Cloud Shell per passare al codice "Hello World" e clonarlo. Il codice di esempio viene clonato dal repository del progetto in Cloud Shell.

Nota: se la directory esiste già, rimuovi i file creati in precedenza prima di eseguire la clonazione.

Inserisci quanto segue in Cloud Shell:

```bash
git clone {{repo-url}}
```

Quindi, passa alla directory del tutorial:

```bash
cd {{repo-dir}}
```

## Configurazione della distribuzione

Ti trovi ora nella directory principale del codice di esempio. Daremo un'occhiata ai file con cui configurerai l'applicazione.

### Esplorare l'applicazione

Immetti il comando seguente per visualizzare il codice dell'applicazione:

```bash
cat main.py
```

L'applicazione è una semplice applicazione Python che utilizza il framework web [webapp2](https://webapp2.readthedocs.io/). Questo script Python risponde a una richiesta con un'intestazione HTTP e il messaggio `Hello, World!`.

### Esplorare la configurazione

Google App Engine utilizza i file YAML per specificare una configurazione di distribuzione.
I file `app.yaml` contengono informazioni sulla tua applicazione, come l'ambiente di runtime, i gestori di URL e altro ancora.

Immetti il comando seguente per visualizzare il file di configurazione:

```bash
cat app.yaml
```

Ecco le informazioni contenute nel file di configurazione, dall'alto verso il basso, riguardo a questa applicazione:

  *  Questo codice viene eseguito nell'ambiente di runtime `python`.
  *  Questa applicazione è di tipo `threadsafe`, pertanto la stessa istanza può gestire più richieste allo stesso tempo. Threadsafe è una funzione avanzata e potrebbe causare un comportamento irregolare se l'applicazione non è progettata specificatamente come threadsafe.
  *  Ogni richiesta a un URL il cui percorso corrisponde all'espressione regolare `/.*` (tutti gli URL) deve essere gestita dall'oggetto app nel modulo Python `main`.

La sintassi di questo file è [YAML](http://www.yaml.org). Per un elenco completo delle opzioni di configurazione, consulta la documentazione di riferimento di [`app.yaml`][app-yaml-reference].

## Testare l'applicazione

### Testare l'applicazione su Cloud Shell

Cloud Shell ti permette di eseguire il test dell'applicazione per verificare che sia in esecuzione come previsto, proprio come si fa con il debug sulla macchina locale.

Per eseguire il test dell'applicazione immetti quanto segue:

```bash
dev_appserver.py $PWD
```

### Visualizzare l'anteprima dell'applicazione con "Anteprima web"

La tua applicazione è ora in esecuzione su Cloud Shell. Puoi accedere all'applicazione utilizzando [Anteprima web][spotlight-web-preview] <walkthrough-web-preview-icon></walkthrough-web-preview-icon> per connetterti alla porta 8080.

### Chiudere l'istanza di anteprima

Interrompi l'istanza dell'applicazione premendo `CTRL+C` in Cloud Shell.

## Distribuzione in Google App Engine

### Creare un'applicazione

Per distribuire la tua applicazione, dovrai creare un'applicazione in un'area geografica:

```bash
gcloud app create
```

Nota: se hai già creato un'applicazione, puoi ignorare questo passaggio.

### Distribuire l'applicazione con Cloud Shell

Puoi utilizzare Cloud Shell per distribuire la tua applicazione. Immetti quanto segue:

```bash
gcloud app deploy app.yaml --project {{project-id}}
```

### Visitare l'applicazione

Complimenti. La tua applicazione è stata distribuita. L'URL predefinito della tua applicazione è [{{project-gae-url}}](http://{{project-gae-url}}). Fai clic sull'URL per visitarlo.

### Visualizzare lo stato dell'applicazione

Puoi controllare la tua applicazione monitorandone lo stato sulla dashboard di App Engine.

Apri il [menu][spotlight-console-menu] sul lato sinistro della console.

Quindi, seleziona la sezione **App Engine**.

<walkthrough-menu-navigation sectionid="APPENGINE_SECTION"></walkthrough-menu-navigation>

## Conclusione

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Hai distribuito con successo un'applicazione di App Engine.

Ecco alcuni dei successivi passaggi da seguire:

**Scarica il Google Cloud SDK e sviluppa localmente**

Installa il [Google Cloud SDK][cloud-sdk-installer] sulla tua macchina locale.

**Crea la tua prossima applicazione**

Scopri come utilizzare App Engine con altri prodotti Google Cloud Platform:

<walkthrough-tutorial-card label="django" url="python/django/appengine" icon="APPENGINE_SECTION">
  **Esegui Django**
  Sviluppa applicazioni Django in esecuzione su App Engine.
</walkthrough-tutorial-card>

<walkthrough-tutorial-card label="datastore" url="appengine/docs/python/datastore/" icon="DATASTORE_SECTION">
  **Scopri come utilizzare Cloud Datastore**
  Cloud Datastore è un database NoSQL a scalabilità elevata per le tue applicazioni.
</walkthrough-tutorial-card>

[app-yaml-reference]: https://cloud.google.com/appengine/docs/standard/python/config/appref
[cloud-sdk-installer]: https://cloud.google.com/sdk/downloads#interactive
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-web-preview]: walkthrough://spotlight-pointer?spotlightId=devshell-web-preview-button
