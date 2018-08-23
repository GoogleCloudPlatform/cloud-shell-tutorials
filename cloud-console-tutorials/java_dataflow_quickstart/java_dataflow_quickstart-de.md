# Anleitung zum Wörterzählen mit Dataflow

<walkthrough-tutorial-url url="https://cloud.google.com/dataflow/docs/quickstarts/quickstart-java-maven"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="dataflow-intro" key="directory"></walkthrough-watcher-constant>
<walkthrough-watcher-constant value="dataflow-intro" key="job-name"></walkthrough-watcher-constant>

## Einführung

In dieser Anleitung lernen Sie die Grundlagen des Cloud Dataflow-Dienstes kennen, indem Sie eine einfache Beispielpipeline mit Python ausführen.

Dataflow-Pipelines sind entweder *Batch-Pipelines* für die Verarbeitung begrenzter Eingaben wie aus einer Datei oder Datenbanktabelle oder *Streaming-Pipelines* für die Verarbeitung von unbegrenzten Eingaben von Quellen wie Cloud Pub/Sub. In dieser Anleitung wird als Beispiel eine Batch-Pipeline verwendet, die Wörter in einer Sammlung von Shakespeare-Werken zählt.

Prüfen Sie vor Beginn, ob Ihr Cloud Platform-Projekt die nötigen Voraussetzungen erfüllt und führen Sie eine Ersteinrichtung durch.

## Projekteinrichtung

Auf der Google Cloud Platform werden Ressourcen in Projekten organisiert. Auf diese Weise können Sie alle für eine einzelne Anwendung relevanten Ressourcen an einer Stelle erfassen.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>
<walkthrough-project-permissions permissions="dataflow.jobs.create"></walkthrough-project-permissions>

## Cloud Dataflow einrichten

Um Dataflow verwenden zu können, müssen Sie die Cloud Dataflow APIs aktivieren und die Cloud Shell öffnen.

### Google Cloud APIs aktivieren

<walkthrough-enable-apis apis="compute.googleapis.com,dataflow,cloudresourcemanager.googleapis.com,logging,storage_component,storage_api,bigquery,pubsub">
</walkthrough-enable-apis>

### Cloud Shell öffnen

Cloud Shell ist ein integriertes Befehlszeilentool für die Konsole. Sie verwenden Cloud Shell zur Ausführung Ihrer Anwendung.

Öffnen Sie Cloud Shell, indem Sie oben in der Navigationsleiste der Konsole auf das<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon> [Symbol][spotlight-open-devshell] klicken.

## Cloud Dataflow-Beispiele in Cloud Shell installieren

Wenn Sie das Cloud Dataflow SDK für Java verwenden möchten, benötigen Sie für Ihre Entwicklungsumgebung Java, das Google Cloud SDK, das Cloud Dataflow SDK für Java und Apache Maven für die Verwaltung von SDK-Abhängigkeiten. In dieser Anleitung wird eine Cloud Shell verwendet, in der Java, das Google Cloud SDK und Maven bereits installiert sind.

Sie können diese Anleitung auch [auf Ihrem lokalen Rechner][dataflow-java-tutorial] durchgehen.

### Laden Sie die Beispiele und das Cloud Dataflow SDK für Java mit dem Maven-Befehl herunter

Wenn Sie diesen Befehl ausführen, erstellt Maven eine Projektstruktur und eine Konfigurationsdatei zum Herunterladen der geeigneten Version des Cloud Dataflow SDKs.

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

  *  Für die Definition der Beispielprojektstruktur werden `archetypeArtifactId` und `archetypeGroupId` verwendet.
  *  Bei `groupId` handelt es sich um das Namenspräfix des Java-Pakets Ihres Unternehmens, z. B. `com.mycompany`.
  *  `artifactId` legt den Namen der erstellten JAR-Datei fest. Verwenden Sie für diese Anleitung den Standardwert (`{{directory}}`).

Führen Sie den Maven-Befehl in Cloud Shell aus.

### Verzeichnis wechseln

Wechseln Sie in das Arbeitsverzeichnis `{{directory}}`.

```bash
cd {{directory}}
```

Den Code für dieses Beispiel finden Sie im Unterverzeichnis `src` des Verzeichnisses `{{directory}}`.

## Cloud Storage-Bucket einrichten

Cloud Dataflow verwendet Cloud Storage-Buckets für die Speicherung von Ausgabedaten. Außerdem wird damit der Pipeline-Code im Cache gespeichert.

### "gsutil mb" ausführen

Verwenden Sie in Cloud Shell den Befehl `gsutil mb`, um einen Cloud Storage-Bucket zu erstellen.

```bash
gsutil mb gs://{{project-id-no-domain}}
```

Weitere Informationen zum Tool `gsutil` finden Sie in der [Dokumentation][gsutil-docs].

## Pipeline erstellen und starten

Die Datenverarbeitung erfolgt in Cloud Dataflow in einer *Pipeline*. Eine Pipeline liest Eingabedaten, transformiert diese und erstellt davon Ausgabedaten. Während der Transformationen können die Daten in einer Pipeline gefiltert, gruppiert, verglichen oder zusammengeführt werden.

Den Code für dieses Beispiel finden Sie im Unterverzeichnis `src` des Verzeichnisses `{{directory}}`.

### Pipeline im Dataflow-Dienst starten

Mit dem Apache Maven-Befehl `mvn exec` starten Sie die Pipeline für den Dienst.
Die ausgeführte Pipeline wird als *Job* bezeichnet.

```bash
mvn compile exec:java \
  -Dexec.mainClass=com.example.WordCount \
  -Dexec.args="--project={{project-id}} \
  --stagingLocation=gs://{{project-id-no-domain}}/staging/ \
  --output=gs://{{project-id-no-domain}}/output \
  --runner=DataflowRunner \
  --jobName={{job-name}}"
```

  *  Cloud Dataflow verwendet den Storage-Bucket `stagingLocation`, um die Binärdateien und andere Daten zu speichern, mit denen Sie die Pipeline ausführen. Dieser Speicherort kann für mehrere Jobs verwendet werden.
  *  Im WordCount-Beispiel werden die Ergebnisse des Jobs im Bucket `output` gespeichert.

### Ihr Job wird ausgeführt

Glückwunsch! Ihre Binärdatei ist nun mit dem von Ihnen erstellten Storage-Bucket verbunden und es werden Compute Engine-Instanzen erstellt. Die Eingabe wird in Cloud Dataflow so aufgeteilt, dass die Daten auf mehreren Maschinen parallel verarbeitet werden können.

Hinweis: Wenn die Nachricht "Job abgeschlossen" erscheint, können Sie Cloud Shell schließen.

Wenn Sie das von Ihnen erstellte Maven-Projekt bereinigen möchten, führen Sie `cd .. && rm -R {{directory}}` in Cloud Shell aus und löschen Sie das Verzeichnis.

## Job überwachen

Auf der Monitoring-Seite für Cloud Dataflow können Sie den Fortschritt der Pipeline verfolgen.

### Zur Seite "Cloud Dataflow" gehen

Öffnen Sie das [Menü][spotlight-console-menu] auf der linken Seite der Konsole.

Wählen Sie anschließend den Abschnitt **Dataflow** aus.

<walkthrough-menu-navigation sectionid="DATAFLOW_SECTION"></walkthrough-menu-navigation>

### Job auswählen

Klicken Sie auf Ihren Job, um Details aufzurufen.

### Details und Messwerte der Pipeline ansehen

Sehen Sie sich die Pipeline auf der linken Seite und die Jobinformationen auf der rechten Seite an. Klicken Sie auf [Logs][spotlight-job-logs], um den genauen Jobstatus zu prüfen. Sie können auf einen Schritt in der Pipeline klicken, um die zugehörigen Messwerte aufzurufen.

Bei Abschluss des Jobs ändert sich der Jobstatus und die für den Job verwendeten Compute Engine-Instanzen werden automatisch angehalten.

## Ausgabe ansehen

Nachdem Ihr Job nun ausgeführt wurde, können Sie sich in Cloud Storage die Ausgabedateien näher ansehen.

### Cloud Storage-Seite aufrufen

Öffnen Sie das [Menü][spotlight-console-menu] auf der linken Seite der Konsole.

Wählen Sie anschließend den Abschnitt **Storage** aus.

<walkthrough-menu-navigation sectionid="STORAGE_SECTION"></walkthrough-menu-navigation>

### Storage-Bucket aufrufen

Suchen Sie in der Bucket-Liste den zuvor erstellten Bucket aus. Wenn Sie den vorgeschlagenen Namen verwendet haben, heißt er `{{project-id}}`.

Der Bucket enthält einen Staging-Ordner sowie Ausgabeordner. Da die Ausgabe von Dataflow in Shards gespeichert wird, enthält der Bucket mehrere Ausgabedateien.

## Bereinigen

Damit keine Kosten für die Nutzung von Cloud Storage anfallen, löschen Sie den erstellten Bucket.

### Zum Buckets-Browser zurückkehren

Klicken Sie auf den Link [Buckets][spotlight-buckets-link].

### Bucket auswählen

Klicken Sie das Kästchen neben dem Bucket an, den Sie erstellt haben.

### Bucket löschen

Klicken Sie auf [Löschen][spotlight-delete-bucket] und bestätigen Sie den Löschvorgang.

## Fazit

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Vorschläge für die nächsten Schritte:

  *  [Weitere Informationen zum Beispiel für das Zählen von Wörtern][wordcount]
  *  [Weitere Informationen zum Cloud Dataflow-Programmiermodell][df-model]
  *  [Das Cloud Dataflow SDK auf GitHub erkunden][df-sdk]

Lokale Umgebung einrichten:

  *  [Dataflow mit Eclipse ausführen][df-eclipse]
  *  [Dataflow mit Python ausführen][df-python]

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
