# Tutorial Conteggio parole Dataflow

<walkthrough-tutorial-url url="https://cloud.google.com/dataflow/docs/quickstarts/quickstart-java-maven"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="dataflow-intro" key="directory"></walkthrough-watcher-constant>
<walkthrough-watcher-constant value="dataflow-intro" key="job-name"></walkthrough-watcher-constant>

## Presentazione

In questo tutorial apprenderai le nozioni di base del servizio Cloud Dataflow mediante l'esecuzione di una semplice pipeline di esempio utilizzando Java.

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

Apri Cloud Shell facendo clic sull'<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[icona][spotlight-open-devshell] nella barra di navigazione nella parte superiore della console.

## Installa esempi di Cloud Dataflow su Cloud Shell

Per utilizzare l'SDK di Cloud Dataflow per Java, l'ambiente di sviluppo deve avere Java, Google Cloud SDK, l'SDK di Cloud Dataflow per Java e Apache Maven per gestire le dipendenze dagli SDK. Questo tutorial utilizza Cloud Shell in cui sono già installati Java, Google Cloud SDK e Maven.

In alternativa, puoi eseguire questo tutorial [sulla tua macchina locale.][dataflow-java-tutorial]

### Scarica gli esempi e l'SDK di Cloud Dataflow per Java utilizzando il comando Maven

Se esegui questo comando, Maven creerà una struttura di progetto e un file di configurazione per scaricare la versione appropriata dell'SDK di Cloud Dataflow.

```bash
mvn archetype:generate \
    -DarchetypeArtifactId=google-cloud-dataflow-java-archetypes-examples \
    -DarchetypeGroupId=com.google.cloud.dataflow \
    -DarchetypeVersion=2.1.0 \
    -DgroupId=com.example \
    -DartifactId={{directory}} \
    -Dversion="0.1" \
    -DinteractiveMode=false \
    -Dpackage=com.example
```

  *  `archetypeArtifactId` e `archetypeGroupId` sono utilizzati per definire la struttura
    del progetto di esempio.
  *  `groupId` è il prefisso del nome del pacchetto Java della tua organizzazione; ad es.
    `com.mycompany`
  *  `artifactId` imposta il nome del file jar creato. Utilizza il valore predefinito
    (`{{directory}}`) ai fini di questo tutorial.

Esegui il comando Maven in Cloud Shell.

### Cambia la directory

Cambia la directory di lavoro in `{{directory}}`.

```bash
cd {{directory}}
```

Se vuoi visualizzare il codice per questo esempio, puoi trovarlo nella sottodirectory `src` della directory `{{directory}}`.

## Configura un bucket Cloud Storage

Cloud Dataflow utilizza i bucket Cloud Storage per archiviare i dati di output e
memorizzare nella cache il codice della pipeline.

### Esegui gsutil mb

In Cloud Shell utilizza il comando `gsutil mb` per creare un bucket Cloud Storage.

```bash
gsutil mb gs://{{project-id-no-domain}}
```

Per ulteriori informazioni sullo strumento `gsutil`, consulta la [documentazione][gsutil-docs].

## Crea e avvia una pipeline

In Cloud Dataflow, il lavoro di elaborazione dei dati è rappresentato da una *pipeline*. Una pipeline legge i dati immessi, li trasforma e produce dati di output. Le trasformazioni della pipeline possono includere operazioni di filtro, raggruppamento, confronto o unione dei dati.

Se vuoi visualizzare il codice per questo esempio, puoi trovarlo nella sottodirectory `src` della directory `{{directory}}`.

### Avvia la tua pipeline nel servizio Dataflow

Utilizza il comando `mvn exec` di Apache Maven per avviare la pipeline nel servizio.
La pipeline in esecuzione è detta *job.*

```bash
mvn compile exec:java \
  -Dexec.mainClass=com.example.WordCount \
  -Dexec.args="--project={{project-id}} \
  --stagingLocation=gs://{{project-id-no-domain}}/staging/ \
  --output=gs://{{project-id-no-domain}}/output \
  --runner=DataflowRunner \
  --jobName={{job-name}}"
```

  *  `stagingLocation` è il bucket di archiviazione utilizzato da Cloud Dataflow per i file binari e di altro tipo richiesti per eseguire la pipeline. Questa posizione può essere condivisa in più job.
  *  `output` è il bucket utilizzato dall'esempio Conteggio parole per archiviare i risultati del job.

### Il tuo job è in esecuzione

Complimenti! Il file binario è in fase di inserimento nell'area temporanea del bucket di archiviazione creato in precedenza ed è in corso la creazione delle istanze di Compute Engine. Cloud Dataflow suddividerà il file di input in modo che possa essere elaborato in parallelo su più macchine.

Nota: quando vedi il messaggio "Job completato", puoi chiudere Cloud Shell.

Se vuoi pulire i dati del progetto Maven generato, esegui `cd .. && rm -R
{{directory}}` in Cloud Shell per eliminare la directory.

## Monitora il tuo job

Verifica lo stato di avanzamento della tua pipeline nella pagina dell'interfaccia utente di monitoraggio di Cloud Dataflow.

### Vai alla pagina Cloud Dataflow

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

Seleziona quindi la sezione **Archiviazione**.

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
  *  [Informazioni sul modello di programmazione Cloud Dataflow][df-model]
  *  [Esplora l'SDK di Cloud Dataflow su GitHub][df-sdk]

Configura il tuo ambiente locale:

  *  [Utilizza Eclipse per eseguire Dataflow][df-eclipse]
  *  [Utilizza Python per eseguire Dataflow][df-python]

[dataflow-java-tutorial]: https://cloud.google.com/dataflow/docs/quickstarts/quickstart-java-maven
[df-eclipse]: https://cloud.google.com/dataflow/docs/quickstarts/quickstart-java-eclipse
[df-model]: https://cloud.google.com/dataflow/model/programming-model-beam
[df-python]: https://cloud.google.com/dataflow/docs/quickstarts/quickstart-python
[df-sdk]: https://github.com/apache/beam/tree/master/sdks/java
[gsutil-docs]: https://cloud.google.com/storage/docs/gsutil
[spotlight-buckets-link]: walkthrough://spotlight-pointer?cssSelector=.p6n-cloudstorage-path-link
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-delete-bucket]: walkthrough://spotlight-pointer?cssSelector=#p6n-cloudstorage-delete-buckets
[spotlight-job-logs]: walkthrough://spotlight-pointer?cssSelector=#p6n-dax-job-logs-toggle
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[wordcount]: https://beam.apache.org/get-started/wordcount-example/
