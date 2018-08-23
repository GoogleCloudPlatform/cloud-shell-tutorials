# Tutorial Conteggio parole Dataflow

<walkthrough-tutorial-url url="https://cloud.google.com/dataflow/docs/quickstarts/quickstart-python"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="dataflow-intro" key="directory"></walkthrough-watcher-constant>
<walkthrough-watcher-constant value="dataflow-intro" key="job-name"></walkthrough-watcher-constant>

## Presentazione

In questo tutorial apprenderai le nozioni di base del servizio Cloud Dataflow mediante l'esecuzione di una semplice pipeline di esempio utilizzando Python.

Le pipeline Dataflow possono essere di tipo *batch* (elaborazione di input limitato come un file o una tabella di database) o *flusso* (elaborazione di input illimitato da un'origine come Cloud Pub/Sub). In questo tutorial viene utilizzata come esempio una pipeline batch per contare le parole di una raccolta di opere di Shakespeare.

Prima di iniziare, dovrai controllare i prerequisiti del tuo progetto Cloud Platform ed eseguire alcune operazioni iniziali di configurazione.

## Configurare il progetto

Google Cloud Platform organizza le risorse in progetti. Ciò consente di raccogliere tutte le risorse correlate per una singola applicazione in una sola posizione.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>
<walkthrough-project-permissions permissions="dataflow.jobs.create"></walkthrough-project-permissions>

## Configura Cloud Dataflow

Per utilizzare Dataflow, attiva le API Cloud Dataflow e apri Cloud Shell.

### Abilita le API di Google Cloud

<walkthrough-enable-apis apis="compute.googleapis.com,dataflow,cloudresourcemanager.googleapis.com,logging,storage_component,storage_api,bigquery,pubsub">
</walkthrough-enable-apis>

### Apri Cloud Shell

Cloud Shell è uno strumento a riga di comando integrato per la console. Utilizzerai Cloud Shell per distribuire la tua applicazione.

Apri Cloud Shell facendo clic sull'[icona][spotlight-open-devshell] <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>nella barra di navigazione nella parte superiore della console.

## Installa esempi di Cloud Dataflow su Cloud Shell

Per la versione Python di Cloud Dataflow è necessario che l'ambiente di sviluppo locale includa Python, Google Cloud SDK e l'SDK di Cloud Dataflow per Python.
Inoltre, Cloud Dataflow utilizza pip, il gestore dei pacchetti di Python, per gestire le dipendenze dagli SDK.

Questo tutorial utilizza Cloud Shell in cui sono già installati Python e pip. Se preferisci, puoi eseguire questo tutorial [sulla tua macchina locale.][dataflow-python-tutorial]

### Scarica gli esempi e l'SDK di Cloud Dataflow per Python utilizzando il comando pip

Quando esegui questo comando, pip scaricherà e installerà la versione appropriata dell'SDK di Cloud Dataflow.

```bash
pip install --user google-cloud-dataflow
```

Esegui il comando pip in Cloud Shell.

## Configura un bucket Cloud Storage

Cloud Dataflow utilizza i bucket Cloud Storage per archiviare i dati di output e memorizzare nella cache il codice della pipeline.

### Esegui gsutil mb

In Cloud Shell utilizza il comando `gsutil mb` per creare un bucket Cloud Storage.

```bash
gsutil mb gs://{{project-id-no-domain}}
```

Per ulteriori informazioni sullo strumento `gsutil`, consulta la [documentazione][gsutil-docs].

## Crea e avvia una pipeline

In Cloud Dataflow, il lavoro di elaborazione dei dati è rappresentato da una *pipeline*. Una pipeline legge i dati immessi, li trasforma e produce dati di output. Le trasformazioni della pipeline possono includere operazioni di filtro, raggruppamento, confronto o unione dei dati.

### Avvia la tua pipeline nel servizio Dataflow

Utilizza Python per avviare la pipeline nel servizio Cloud Dataflow. La pipeline in esecuzione è detta *job.*

```bash
python -m apache_beam.examples.wordcount \
  --project {{project-id}} \
  --runner DataflowRunner \
  --temp_location gs://{{project-id-no-domain}}/temp \
  --output gs://{{project-id-no-domain}}/results/output \
  --job_name {{job-name}}
```

  *  `output` è il bucket utilizzato dall'esempio Conteggio parole per archiviare i risultati del job.

### Il tuo job è in esecuzione

Complimenti! Il file binario è in fase di inserimento nell'area temporanea del bucket di archiviazione creato in precedenza ed è in corso la creazione delle istanze di Compute Engine. Cloud Dataflow suddividerà il file di input in modo che possa essere elaborato in parallelo su più macchine.

Nota: quando compare il messaggio "JOB_STATE_DONE", puoi chiudere Cloud Shell.

## Monitora il tuo job

Verifica lo stato di avanzamento della tua pipeline sulla pagina di Cloud Dataflow.

### Accedi alla pagina dell'interfaccia utente di monitoraggio di Cloud Dataflow

Se non lo hai già fatto, accedi alla pagina dell'interfaccia utente di monitoraggio di Cloud Dataflow.

Apri il [menu][spotlight-console-menu] sul lato sinistro della console.

Seleziona quindi la sezione **Dataflow**.

<walkthrough-menu-navigation sectionid="DATAFLOW_SECTION"></walkthrough-menu-navigation>

### Seleziona il tuo job

Fai clic sul job per visualizzarne i dettagli.

### Esplora dettagli e metriche della pipeline

Esplora la pipeline sulla sinistra e le informazioni del job sulla destra. Per visualizzare lo stato dettagliato del job, fai clic su [Log][spotlight-job-logs]. Prova a fare clic su un passo nella pipeline per visualizzarne le metriche.

Quando il job termina, il suo stato cambia e le istanze di Compute Engine utilizzate dal job vengono arrestate automaticamente.

## Visualizza l'output

Ora che il job è stato eseguito, puoi esplorare i file di output in Cloud Storage.

### Vai alla pagina di Cloud Storage

Apri il [menu][spotlight-console-menu] sul lato sinistro della console.

Quindi, seleziona la sezione **Compute Engine**.

<walkthrough-menu-navigation sectionid="STORAGE_SECTION"></walkthrough-menu-navigation>

### Vai al bucket di archiviazione

Nell'elenco di bucket, seleziona il bucket creato in precedenza. Se hai utilizzato il nome suggerito, sarà denominato `{{project-id}}`.

Il bucket contiene una cartella di gestione temporanea e le cartelle di output. Dataflow salva l'output in shard, pertanto il bucket conterrà vari file di output.

## Esegui la pulizia

Per evitare che ti siano addebitati costi per l'utilizzo di Cloud Storage, elimina il bucket che hai creato.

### Torna al browser dei bucket

Fai clic sul link [Bucket][spotlight-buckets-link].

### Seleziona il bucket

Seleziona la casella accanto al bucket che hai creato.

### Elimina il bucket

Fai clic su [Elimina][spotlight-delete-bucket] e conferma l'eliminazione.

## Conclusione

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Ecco cosa puoi fare successivamente:

  *  [Ulteriori informazioni sull'esempio Conteggio parole][wordcount]
  *  [Informazioni sul modello di programmazione Cloud Dataflow][df-pipelines]
  *  [Esplora l'SDK di Apache Beam su GitHub][beam-sdk]

Configura il tuo ambiente locale:

  *  [Utilizza Java ed Eclipse per eseguire Dataflow][df-eclipse]
  *  [Utilizza Java e Maven per eseguire Dataflow][df-maven]

[beam-sdk]: https://github.com/apache/beam/tree/master/sdks/python
[dataflow-python-tutorial]: https://cloud.google.com/dataflow/docs/quickstarts/quickstart-python
[df-eclipse]: https://cloud.google.com/dataflow/docs/quickstarts/quickstart-java-eclipse
[df-maven]: https://cloud.google.com/dataflow/docs/quickstarts/quickstart-java-maven
[df-pipelines]: https://cloud.google.com/dataflow/model/programming-model-beam
[gsutil-docs]: https://cloud.google.com/storage/docs/gsutil
[spotlight-buckets-link]: walkthrough://spotlight-pointer?cssSelector=.p6n-cloudstorage-path-link
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-delete-bucket]: walkthrough://spotlight-pointer?cssSelector=#p6n-cloudstorage-delete-buckets
[spotlight-job-logs]: walkthrough://spotlight-pointer?cssSelector=#p6n-dax-job-logs-toggle
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[wordcount]: https://beam.apache.org/get-started/wordcount-example/
