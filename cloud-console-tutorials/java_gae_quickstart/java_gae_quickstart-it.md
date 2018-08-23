# Guida di avvio rapido di App Engine

<walkthrough-test-start-page url="/getting-started?tutorial=java_gae_quickstart_2"/>

<walkthrough-tutorial-url url="https://cloud.google.com/appengine/docs/java/quickstart"/>

<walkthrough-watcher-constant key="repo-url" value="https://github.com/GoogleCloudPlatform/appengine-try-java" />

<walkthrough-watcher-constant key="repo-name" value="appengine-try-java"/>

## Introduzione

Questo tutorial descrive come distribuire un'a semplice applicazione
[Java][java] di esempio in Google App Engine utilizzando il plug-in App Engine
Maven.

Ecco i passaggi da completare.

*   **Crea ed esegui la tua applicazione "Hello, world!"**

    Scoprirai come eseguire la tua applicazione utilizzando Google Cloud Shell,
    direttamente nel browser. Alla fine distribuirai l'applicazione nel Web
    utilizzando il plug-in App Engine Maven.

*   **Una volta creata l'applicazione...**

    L'applicazione sarà perfettamente funzionante e potrai effettuare
    esperimenti su di essa dopo la distribuzione o potrai rimuoverla e
    ricominciare da capo.

[Java is a registered trademark of Oracle and/or its affiliates.](walkthrough://footnote)

<walkthrough-devshell-precreate/>

## Configurazione del progetto

Per distribuire un'applicazione, devi prima creare un progetto.

Google Cloud Platform organizza le risorse in progetti. Ciò consente di
raccogliere tutte le risorse relative a una singola applicazione in un unico
posto.

<walkthrough-project-setup/>

## Utilizzo di Google Cloud Shell

Cloud Shell è uno strumento a riga di comando integrato per la console.
Utilizzeremo Cloud Shell per distribuire l'applicazione.

### Apri Google Cloud Shell

Apri Cloud Shell facendo clic su <walkthrough-cloud-shell-icon/>
[icon](walkthrough://spotlight-pointer?spotlightId=devshell-activate-button)
nella barra di navigazione nella parte superiore della console.

### Clona il codice di esempio

Utilizza Cloud Shell per clonare e utilizzare il codice "Hello World". Il codice
di esempio viene clonato dal repository del progetto in Cloud Shell.

Nota: se già esiste la directory, rimuovi i file precedenti prima di iniziare la
clonazione:

```bash
rm -rf {{repo-name}}
```

Inserisci quanto segue In Cloud Shell inserisci quanto segue:

```bash
git clone {{repo-url}}
```

Poi, passa alla directory del tutorial:

```bash
cd {{repo-name}}
```

## Configurazione della distribuzione

Ti trovi nella directory principale del codice di esempio. Esaminiamo i file che
configurano l'applicazione.

### Esplorazione dell'applicazione

Immetti il comando seguente per visualizzare il codice dell'applicazione:

```bash
cat src/main/java/myapp/DemoServlet.java
```

Il servlet risponde a qualsiasi richiesta inviando una risposta contenente il
messaggio `Hello, world!`.

### Esplorazione della configurazione

Per Java, Google App Engine utilizza i file XML per specificare la
configurazione di una distribuzione.

Immetti il comando seguente per visualizzare il file di configurazione:

```bash
cat pom.xml
```

L'applicazione `helloworld` utilizza Maven, pertanto devi specificare un modello
a oggetti del progetto o POM (Project Object Model) contenente informazioni sul
progetto, nonché i dettagli di configurazione utilizzati da Maven per creare il
progetto.

## Test dell'applicazione

### Esegui il test della tua applicazione su Cloud Shell

Cloud Shell ti permette di eseguire un test dell'applicazione prima della
distribuzione per verificare che sia in esecuzione come previsto, proprio come
per il debug sulla macchina locale.

Per eseguire il test dell'applicazione immetti quanto segue:

```bash
mvn appengine:run
```

<walkthrough-test-code-output
  text="module .* running at|Dev App Server is now running" />

### Visualizza l'anteprima della tua applicazione con "Anteprima web"

La tua ape applicazione viene ora eseguita su Cloud Shell. Puoi accedere
all'applicazione utilizzando "Anteprima web" <walkthrough-web-preview-icon/> per
connetterti alla porta 8080. [Mostra
procedura](walkthrough://spotlight-pointer?spotlightId=devshell-web-preview-button)

### Chiusura Interrompi l'istanza di anteprima

InterrompiInterrompi l'istanza dell'applicazione premendo `Ctrl+C` in Cloud
Shell.

## Distribuzione in Google App Engine

### Crea un'applicazione

Per distribuire l'applicazione, dobbiamo creare un'applicazione in un'area
geografica:

```bash
gcloud app create
```

Nota: se hai già creato un'applicazione, puoi saltare questo passaggio.

### Distribuzione con Cloud Shell

Ora puoi utilizzare Cloud Shell per distribuire la tua applicazione.

In primo luogo, specifica il progetto da utilizzare:

```bash
gcloud config set project {{project-id}}
```

Poi distribuisci l'applicazione:

```bash
mvn appengine:deploy
```

<walkthrough-test-code-output text="Deployed (module|service)" />

### Visita la pagina della tua applicazione

L'applicazione è stata distribuita! L'URL predefinito dell'applicazione è
[{{project-gae-url}}](http://{{project-gae-url}}). Fai clic sull'URL per
visitarlo.

### Visualizza lo stato dell'applicazione

Puoi controllare la tua applicazione monitorandone lo stato sulla dashboard di
App Engine.

Apri [menu](walkthrough://spotlight-pointer?spotlightId=console-nav-menu) a sul
lato sinistra sinistro della console.

Seleziona la sezione **App Engine**.

<walkthrough-menu-navigation sectionId="APPENGINE_SECTION"/>

## Conclusione

<walkthrough-conclusion-trophy/>

Complimenti, hai appena distribuito un'applicazione App Engine! Ecco i passaggi
successivi:

**Scarica l'SDK Google Cloud e sviluppa localmente**

[Google Cloud SDK][cloud-sdk-installer]

**Crea la tua prossima applicazione**

Scopri come utilizzare App Engine con altri prodotti Google Cloud Platform:

<walkthrough-tutorial-card
  url="appengine/docs/java/datastore/"
  icon="DATASTORE_SECTION"
  label="datastore">
**Scopri come utilizzare Cloud Datastore**
Cloud Datastore è un database NoSQL a scalabilità elevata per le applicazioni.
</walkthrough-tutorial-card>

<walkthrough-tutorial-card
  url="appengine/docs/java/googlecloudstorageclient/setting-up-cloud-storage/"
  icon="STORAGE_SECTION"
  label="cloudStorage">
**Scopri come utilizzare Cloud Storage**
Cloud Storage è un servizio di archiviazione di oggetti semplice ed efficiente.
</walkthrough-tutorial-card>

[java]: https://java.com/
[cloud-sdk-installer]: https://cloud.google.com/sdk/downloads#interactive
