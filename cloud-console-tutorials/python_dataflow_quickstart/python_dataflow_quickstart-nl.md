# Training met WordCount-voorbeeld voor Dataflow

<walkthrough-tutorial-url url="https://cloud.google.com/dataflow/docs/quickstarts/quickstart-python"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="dataflow-intro" key="directory"></walkthrough-watcher-constant>
<walkthrough-watcher-constant value="dataflow-intro" key="job-name"></walkthrough-watcher-constant>

## Inleiding

In deze training leert u de basisbeginselen van de Cloud Dataflow-service door een eenvoudig voorbeeld van een pipeline uit te voeren met Python.

De verwerking van Dataflow-pipelines vindt plaats in *batch* (verwerken van begrensde invoer, zoals een bestand of databasetabel) of via *streaming* (verwerken van onbegrensde invoer vanuit een bron als Cloud Pub/Sub). Het voorbeeld in deze training is een batchpipeline die woorden telt in een verzameling werken van Shakespeare.

Voordat u begint, moet u controleren of uw Cloud Platform-project aan de vereisten voldoet en een configuratie instellen.

## Project instellen

In Google Cloud Platform worden resources ingedeeld in projecten. Zo kunt u alle gerelateerde resources voor een app op één plek verzamelen.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>
<walkthrough-project-permissions permissions="dataflow.jobs.create"></walkthrough-project-permissions>

## Cloud Dataflow installeren

Als u Dataflow wilt gebruiken, moet u Cloud Dataflow API's inschakelen en de Cloud Shell openen.

### Google Cloud API's inschakelen

<walkthrough-enable-apis apis="compute.googleapis.com,dataflow,cloudresourcemanager.googleapis.com,logging,storage_component,storage_api,bigquery,pubsub">
</walkthrough-enable-apis>

### Cloud Shell openen

Cloud Shell is een ingebouwde opdrachtregeltool voor de console. U gaat Cloud Shell gebruiken om uw app te implementeren.

Open Cloud Shell door in de navigatiebalk bovenaan de console op het <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[pictogram][spotlight-open-devshell] te klikken.

## Cloud Dataflow-voorbeelden installeren in Cloud Shell

De Python-versie van Cloud Dataflow vereist een ontwikkelomgeving met Python, de Google Cloud-SDK en de Cloud Dataflow-SDK voor Python.
Daarnaast wordt door Cloud Dataflow gebruikgemaakt van pip, het pakketbeheer van Python, om SDK-afhankelijkheden te beheren.

Deze training maakt gebruik van een Cloud Shell waarin Python en pip al zijn geïnstalleerd. Desgewenst kunt u deze training ook [op uw lokale computer][dataflow-python-tutorial] doen.

### Gebruik de pip-opdracht om de voorbeelden en de Cloud Dataflow-SDK voor Python te downloaden

Wanneer u deze opdracht uitvoert, downloadt en installeert pip de juiste versie van de Cloud Dataflow-SDK.

```bash
pip install --user google-cloud-dataflow
```

Voer de pip-opdracht uit in Cloud Shell.

## Een Cloud Storage-bucket instellen

Cloud Dataflow maakt gebruik van Cloud Storage-buckets voor het opslaan van uitvoergegevens en het opslaan van pipelinecode in het cachegeheugen.

### 'gsutil mb' uitvoeren

Gebruik in Cloud Shell de opdracht `gsutil mb` om een Cloud Storage-bucket te maken.

```bash
gsutil mb gs://{{project-id-no-domain}}
```

Raadpleeg de [documentatie][gsutil-docs] voor meer informatie over de `gsutil`-tool.

## Een pipeline maken en starten

In Cloud Dataflow wordt het gegevensverwerkingsproces weergegeven door een *pipeline*. Een pipeline leest invoergegevens, voert transformaties uit op die gegevens en produceert vervolgens uitvoergegevens. De transformaties van een pipeline kunnen het filteren, groeperen, vergelijken of samenvoegen van gegevens omvatten.

### De pipeline starten in de Dataflow-service

Gebruik Python om uw pipeline in de Cloud Dataflow-service te starten. Naar de pipeline die wordt uitgevoerd, wordt verwezen met de term *taak (job)*.

```bash
python -m apache_beam.examples.wordcount \
  --project {{project-id}} \
  --runner DataflowRunner \
  --temp_location gs://{{project-id-no-domain}}/temp \
  --output gs://{{project-id-no-domain}}/results/output \
  --job_name {{job-name}}
```

  *  `output` is de bucket die door het WordCount-voorbeeld wordt gebruikt om de taakresultaten in op te slaan.

### Uw taak wordt uitgevoerd

Gefeliciteerd Uw binaire bestand is nu opgeslagen in de opslagbucket die u eerder heeft gemaakt en er worden Compute Engine-instanties gemaakt. Cloud Dataflow verdeelt uw invoerbestand zodanig dat de gegevens gelijktijdig door meerdere machines kunnen worden verwerkt.

Opmerking: Wanneer het bericht 'JOB_STATE_DONE' wordt weergegeven, kunt u Cloud Shell sluiten.

## Uw taak controleren

Controleer de voortgang van uw pipeline op de Cloud Dataflow-pagina.

### Ga naar de pagina 'Controle-interface van Cloud Dataflow'

Navigeer naar de pagina 'Controle-interface van Cloud Dataflow', als u dit nog niet heeft gedaan.

Open het [menu][spotlight-console-menu] aan de linkerkant van de console.

Selecteer vervolgens het gedeelte **Dataflow**.

<walkthrough-menu-navigation sectionid="DATAFLOW_SECTION"></walkthrough-menu-navigation>

### Uw taak selecteren

Klik op uw taak om de bijbehorende details te bekijken.

### Pipelinedetails en -waarden bekijken

Verken de pipeline aan de linkerkant en de taakinformatie aan de rechterkant. Klik op [Logboeken][spotlight-job-logs] om de gedetailleerde taakstatus te bekijken. Klik op een stap in de pipeline om de bijbehorende statistieken te bekijken.

Wanneer uw taak is voltooid, ziet u dat de taakstatus is gewijzigd en worden de Compute Engine-instanties die door de taak worden gebruikt automatisch beëindigd.

## De uitvoer bekijken

Nu de taak is uitgevoerd, kunt u de uitvoerbestanden in Cloud Storage bekijken.

### Naar de Cloud Storage-pagina gaan

Open het [menu][spotlight-console-menu] aan de linkerkant van de console.

Selecteer vervolgens het gedeelte **Compute Engine**.

<walkthrough-menu-navigation sectionid="STORAGE_SECTION"></walkthrough-menu-navigation>

### Naar de opslagbucket gaan

Selecteer in de lijst met buckets de bucket die u eerder heeft gemaakt. Als u de voorgestelde naam heeft gebruikt, heet deze `{{project-id}}`.

De bucket bevat een testmap en uitvoermappen. Dataflow slaat de uitvoer op in shards, dus uw bucket zal meerdere uitvoerbestanden bevatten.

## Opschonen

Verwijder de bucket die u heeft gemaakt om te voorkomen dat er kosten in rekening worden gebracht voor het gebruik van Cloud Storage.

### Ga terug naar de bucketbrowser

Klik op de link [Buckets][spotlight-buckets-link].

### De bucket selecteren

Vink het vakje aan naast de bucket die u heeft gemaakt.

### De bucket verwijderen

Klik op [Verwijderen][spotlight-delete-bucket] en bevestig de verwijdering.

## Conclusie

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

U kunt nu het volgende doen:

  *  [Meer lezen over het WordCount-voorbeeld][wordcount]
  *  [Meer lezen over het programmeermodel van Cloud Dataflow][df-pipelines]
  *  [De Apache Beam SDK bekijken op GitHub][beam-sdk]

Uw lokale omgeving instellen:

  *  [Java en Eclipse gebruiken om Dataflow uit te voeren][df-eclipse]
  *  [Java en Maven gebruiken om Dataflow uit te voeren][df-maven]

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
