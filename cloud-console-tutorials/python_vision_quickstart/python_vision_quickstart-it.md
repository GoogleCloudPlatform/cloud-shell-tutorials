# Cloud Vision API

<walkthrough-test-start-page url="/start?tutorial=python_vision_quickstart_v2"></walkthrough-test-start-page>

<walkthrough-tutorial-url url="https://cloud.google.com/vision/docs/label-tutorial"></walkthrough-tutorial-url>

<walkthrough-watcher-constant value="https://github.com/GoogleCloudPlatform/python-docs-samples.git" key="repo-url"></walkthrough-watcher-constant>

<walkthrough-watcher-constant value="python-docs-samples" key="repo-name"></walkthrough-watcher-constant>

<walkthrough-devshell-precreate></walkthrough-devshell-precreate>

## Introduzione

Questo tutorial illustra un'applicazione di base per la Vision API utilizzando
una richiesta `LABEL_DETECTION`. Una richiesta `LABEL_DETECTION` aggiunge a
un'immagine un'etichetta (o "tag") selezionata in base al contenuto
dell'immagine. Ad esempio, l'immagine di un fienile potrebbe generare
l'etichetta "fienile", "fattoria" o un'altra annotazione simile.

Di seguito è illustrata la procedura da seguire:

*   **Esegui l'applicazione per il rilevamento etichette.** Imparerai a eseguire
    l'applicazione utilizzando Google Cloud Shell, direttamente nel browser.
*   **Successivamente…** L'applicazione sarà reale e potrai utilizzarla per fare
    delle prove o rimuoverla e ricominciare da capo.

["Python" e i loghi Python sono marchi o marchi registrati di Python Software
Foundation.](walkthrough://footnote)

# Configurazione del progetto

Dovrai attivare la Cloud Vision API tramite un progetto.

Google Cloud Platform organizza le risorse in progetti. Ciò consente di
raccogliere tutte le risorse correlate per una singola applicazione in una sola
posizione.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## Abilitare la Vision API

Il progetto deve consentire alla Vision API di accettare le richieste.

### Passare al gestore API

Il gestore API determina quali API sono abilitate per il progetto.

Apri [menu](walkthrough://spotlight-pointer?spotlightId=console-nav-menu) a sul
lato sinistra sinistro della console.

Seleziona quindi la sezione **API e servizi**.

<walkthrough-menu-navigation sectionid="API_SECTION"></walkthrough-menu-navigation>

### Visualizzare le API disponibili

Per abilitare le API, fai clic sul pulsante [Abilita
API](walkthrough://spotlight-pointer?cssSelector=.p6n-action-bar-button).

### Selezionare Vision API

Fai clic sul link [Vision API](walkthrough://spotlight-pointer?spotlightId=api-vision.googleapis.com).

### Abilitare la Vision API

Per abilitare la Vision API, fai clic sul pulsante
[Abilita](walkthrough://spotlight-pointer?spotlightId=api-enable-vision.googleapis.com). Potrai creare le credenziali per il tuo
progetto più avanti in questo tutorial.

## Utilizzare Google Cloud Shell

Cloud Shell è uno strumento a riga di comando integrato per la console.
Utilizzerai Cloud Shell per eseguire la tua applicazione.

### Aprire Google Cloud Shell

Apri Cloud Shell facendo clic sull'[icona](walkthrough://spotlight-pointer?spotlightId=devshell-activate-button)
<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>nella barra di
navigazione nella parte superiore della console.

### Clonare il codice di esempio

Utilizza Cloud Shell per passare al codice "Hello World" e clonarlo. Il codice d
esempio viene clonato dal repository del progetto in Cloud Shell.

Nota: se la directory esiste già, rimuovi i file creati in precedenza prima di
eseguire la clonazione:

```bash
rm -rf {{repo-name}}
```

Clona un repository di esempio:

```bash
git clone {{repo-url}}
```

Quindi, passa alla directory del tutorial:

```bash
cd {{repo-name}}/vision/cloud-client/quickstart
```

## Configurazione dell'implementazione

Ti trovi ora nella directory principale del codice di esempio. A questo punto,
diamo un'occhiata ai file con cui configurerai l'applicazione.

### Esplorare l'applicazione

Immetti il comando seguente per visualizzare il codice dell'applicazione:

```bash
cat quickstart.py
```

Il file `quickstart.py` formatta le informazioni sulla richiesta, come il tipo e
il contenuto della richiesta. Espandi ogni sezione in basso per visualizzare i
dettagli.

Le richieste alla Vision API vengono fornite come oggetti JSON. Consulta la
documentazione di [riferimento per la Vision API][vision-request-doc] per
informazioni sulla struttura specifica di una richiesta di questo tipo. La tua
richiesta JSON viene inviata solo quando chiami `execute`. Questo pattern ti
consente di inoltrare tali richieste e di chiamare `execute` quando è
necessario.

## Eseguire il test dell'applicazione

Per utilizzare l'API, devi impostare le credenziali. Per utilizzare una Cloud
API, devi impostare le [credenziali][auth-doc] corrette per l'applicazione. Ciò
consentirà alla tua applicazione di autenticare la propria identità nel servizio
e di ottenere l'autorizzazione per eseguire le attività. Successivamente,
sottoporrai l'API a test utilizzando le immagini di esempio.

### Creare un account di servizio

Devi creare un account di servizio per autenticare le richieste API. Se hai già
l'account di servizio creato, verrà riutilizzato.

```bash
gcloud iam service-accounts create vision-quickstart
```

### Creare le credenziali

Successivamente, crea una chiave dell'account di servizio e impostala come
credenziale predefinita.

```bash
gcloud iam service-accounts keys create key.json --iam-account    vision-quickstart@{{project-id}}.iam.gserviceaccount.com
```

```bash
export GOOGLE_APPLICATION_CREDENTIALS=key.json
```

<walkthrough-test-code-output text="created key"></walkthrough-test-code-output>

### Testare l'applicazione

Per testare la tua applicazione con un'immagine di esempio, immetti quanto
segue:

```bash
python quickstart.py
```

La risorsa immagine, `resources/wakeupcat.jpg`, è specificata nel codice
sorgente. ([Visualizza immagine][cat-picture])

## Conclusione

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Complimenti! Adesso puoi utilizzare la Cloud Vision API.

Ecco cosa puoi fare successivamente:

*   Completa il tutorial sul [rilevamento facciale][face-tutorial].
*   Prova il tutorial per il rilevamento del [testo del
    documento][document-text-tutorial].
*   Visualizza le [applicazioni di esempio][vision-samples].
*   Scarica ed esegui [Google Cloud SDK][get-cloud-sdk] sulla tua macchina
    locale.

[auth-doc]: https://cloud.google.com/vision/docs/auth
[cat-picture]: https://raw.githubusercontent.com/GoogleCloudPlatform/python-docs-samples/master/vision/cloud-client/quickstart/resources/wakeupcat.jpg
[document-text-tutorial]: https://cloud.google.com/vision/docs/fulltext-annotations
[face-tutorial]: https://cloud.google.com/vision/docs/face-tutorial
[get-cloud-sdk]: https://cloud.google.com/sdk/
[vision-request-doc]: https://cloud.google.com/vision/reference/rest
[vision-samples]: https://cloud.google.com/vision/docs/samples
