# Training met WordCount-voorbeeld voor Dataflow

<walkthrough-tutorial-url url="https://cloud.google.com/dataflow/docs/quickstarts/quickstart-java-maven"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="dataflow-intro" key="directory"></walkthrough-watcher-constant>
<walkthrough-watcher-constant value="dataflow-intro" key="job-name"></walkthrough-watcher-constant>

## Inleiding

In deze training leert u de basisbeginselen van de Cloud Dataflow-service door een eenvoudig voorbeeld van een pipeline uit te voeren met Java.

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

Voor de Cloud Dataflow-SDK voor Java is een ontwikkelomgeving nodig met Java, de Google Cloud-SDK en de Cloud Dataflow-SDK voor Java. Cloud Dataflow gebruikt bovendien Apache Maven voor het beheren van SDK-afhankelijkheden. Deze training maakt gebruik van een Cloud Shell waarin Java, de Google Cloud-SDK en Maven al zijn geïnstalleerd.

U kunt deze training ook [op uw lokale computer][dataflow-java-tutorial] doen.

### De voorbeelden en de Cloud Dataflow-SDK voor Java downloaden met de Maven-opdracht

Als u deze opdracht uitvoert, maakt Maven een projectstructuur en een configuratiebestand voor het downloaden van de juiste versie van de Cloud Dataflow-SDK.

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

  *  `archetypeArtifactId` en `archetypeGroupId` worden gebruikt om de voorbeeldprojectstructuur te definiëren.
  *  `groupId` is het voorvoegsel voor de naam van het Java-pakket van uw organisatie, bijvoorbeeld `com.mijnbedrijf`
  *  `artifactId` stelt de naam in van het gemaakte jar-bestand. Gebruik de standaardwaarde (`{{directory}}`) voor het doel van deze training.

Voer de Maven-opdracht uit in Cloud Shell.

### Map wijzigen

Wijzig de werkmap in `{{directory}}`.

```bash
cd {{directory}}
```

Als u de code voor dit voorbeeld wilt bekijken, kunt u deze vinden in de submap `src` in de map `{{directory}}`.

## Een Cloud Storage-bucket instellen

Cloud Dataflow maakt gebruik van Cloud Storage-buckets voor het opslaan van uitvoergegevens en het opslaan van pipelinecode in het cachegeheugen.

### 'gsutil mb' uitvoeren

Gebruik in Cloud Shell de opdracht `gsutil mb` om een Cloud Storage-bucket te maken.

```bash
gsutil mb gs://{{project-id-no-domain}}
```

Raadpleeg de `documentatie` voor meer informatie over de [gsutil][gsutil-docs]-tool.

## Een pipeline maken en starten

In Cloud Dataflow wordt het gegevensverwerkingsproces weergegeven door een *pipeline*. Een pipeline leest invoergegevens, voert transformaties uit op die gegevens en produceert vervolgens uitvoergegevens. De transformaties van een pipeline kunnen het filteren, groeperen, vergelijken of samenvoegen van gegevens omvatten.

Als u de code voor dit voorbeeld wilt bekijken, kunt u deze vinden in de submap `src` in de map `{{directory}}`.

### De pipeline starten in de Dataflow-service

Gebruik de Apache Maven-opdracht `mvn exec` om uw pipeline in de service te starten.
Naar de pipeline die wordt uitgevoerd, wordt verwezen met de term *taak (job)*.

```bash
mvn compile exec:java \ -Dexec.mainClass=com.example.WordCount \
  -Dexec.args="--project={{project-id}} \
  --stagingLocation=gs://{{project-id-no-domain}}/staging/ \
  --output=gs://{{project-id-no-domain}}/output \
  --runner=DataflowRunner \
  --jobName={{job-name}}"
```

  *  `stagingLocation` is de opslagbucket die Cloud Dataflow gebruikt voor de binaire bestanden en andere gegevens die worden gebruikt voor het uitvoeren van uw pipeline. Deze locatie kan worden gedeeld door meerdere taken.
  *  `output` is de bucket die door het WordCount-voorbeeld wordt gebruikt om de taakresultaten in op te slaan.

### Uw taak wordt uitgevoerd

Gefeliciteerd Uw binaire bestand is nu opgeslagen in de opslagbucket die u eerder heeft gemaakt en er worden Compute Engine-instanties gemaakt. Cloud Dataflow verdeelt uw invoerbestand zodanig dat uw gegevens gelijktijdig door meerdere machines kunnen worden verwerkt.

Opmerking: Wanneer het bericht 'Taak voltooid' wordt weergegeven, kunt u Cloud Shell sluiten.

Als u het door u gegenereerde Maven-project wilt wissen, voert u `cd .. && rm -R {{directory}}` uit in de Cloud Shell om de map te verwijderen.

## Uw taak controleren

Controleer de voortgang van uw pipeline op de pagina 'Controle-interface van Cloud Dataflow'.

### Naar de Cloud Dataflow-pagina gaan

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

Selecteer vervolgens het gedeelte **Opslag**.

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
  *  [Meer lezen over het programmeermodel van Cloud Dataflow][df-model]
  *  [De Cloud Dataflow-SDK bekijken op GitHub][df-sdk]

Uw lokale omgeving instellen:

  *  [Eclipse gebruiken om Dataflow uit te voeren][df-eclipse]
  *  [Python gebruiken om Dataflow uit te voeren][df-python]

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
