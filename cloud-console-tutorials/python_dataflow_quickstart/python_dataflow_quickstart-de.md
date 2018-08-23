# Anleitung zum Wörterzählen mit Dataflow

<walkthrough-tutorial-url url="https://cloud.google.com/dataflow/docs/quickstarts/quickstart-python"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="dataflow-intro" key="directory"></walkthrough-watcher-constant>
<walkthrough-watcher-constant value="dataflow-intro" key="job-name"></walkthrough-watcher-constant>

## Einführung

In dieser Anleitung lernen Sie die Grundlagen des Cloud Dataflow-Dienstes kennen, indem Sie eine einfache Beispielpipeline mit Python ausführen.

Dataflow-Pipelines sind entweder *Batch-Pipelines* für die Verarbeitung begrenzter Eingaben wie aus einer Datei oder Datenbanktabelle oder *Streaming-Pipelines* für die Verarbeitung von unbegrenzten Eingaben von Quellen wie Cloud Pub/Sub. In dieser Anleitung wird als Beispiel eine Batch-Pipeline verwendet, die Wörter in einer Sammlung von Shakespeare-Werken zählt.

Prüfen Sie vor Beginn, ob Ihr Cloud Platform-Projekt die nötigen Voraussetzungen erfüllt, und führen Sie eine Ersteinrichtung durch.

## Projekteinrichtung

Auf der Google Cloud Platform werden Ressourcen in Projekten organisiert. Auf diese Weise können Sie alle für eine einzelne Anwendung relevanten Ressourcen an einer Stelle erfassen.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>
<walkthrough-project-permissions permissions="dataflow.jobs.create"></walkthrough-project-permissions>

## Cloud Dataflow einrichten

Um Dataflow verwenden zu können, müssen Sie die Cloud Dataflow APIs aktivieren und Cloud Shell öffnen.

### Google Cloud APIs aktivieren

<walkthrough-enable-apis apis="compute.googleapis.com,dataflow,cloudresourcemanager.googleapis.com,logging,storage_component,storage_api,bigquery,pubsub">
</walkthrough-enable-apis>

### Cloud Shell öffnen

Cloud Shell ist ein integriertes Befehlszeilentool für die Konsole. Sie verwenden Cloud Shell zur Ausführung Ihrer Anwendung.

Öffnen Sie Cloud Shell, indem Sie oben in der Navigationsleiste der Konsole auf das [Symbol][spotlight-open-devshell] <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon> klicken.

## Cloud Dataflow-Beispiele in Cloud Shell installieren

Für die Python-Version von Cloud Dataflow brauchen Sie eine Entwicklungsumgebung mit Python, dem Google Cloud SDK und dem Cloud Dataflow SDK für Python.
Außerdem ist der Python-Paketmanager "pip" für Cloud Dataflow erforderlich, um SDK-Abhängigkeiten zu verwalten.

In dieser Anleitung wird eine Cloud Shell verwendet, in der Python und "pip" bereits installiert sind. Sie können diese Anleitung auch [auf Ihrem lokalen Rechner][dataflow-python-tutorial] durchgehen.

### Beispiele und Cloud Dataflow SDK für Python mit dem "pip"-Befehl herunterladen

Wenn Sie diesen Befehl ausführen, lädt und installiert "pip" die entsprechende Cloud Dataflow SDK-Version.

```bash
pip install --user google-cloud-dataflow
```

Führen Sie den "pip"-Befehl in Cloud Shell aus.

## Cloud Storage-Bucket einrichten

Cloud Dataflow verwendet Cloud Storage-Buckets für die Speicherung von Ausgabedaten. Außerdem wird damit der Pipelinecode im Cache gespeichert.

### "gsutil mb" ausführen

Verwenden Sie in Cloud Shell den Befehl `gsutil mb`, um einen Cloud Storage-Bucket zu erstellen.

```bash
gsutil mb gs://{{project-id-no-domain}}
```

Weitere Informationen zum `gsutil`-Tool finden Sie in der [Dokumentation][gsutil-docs].

## Pipeline erstellen und starten

Die Datenverarbeitung erfolgt in Cloud Dataflow in einer *Pipeline*. Eine Pipeline liest Eingabedaten, transformiert diese und erstellt daraus Ausgabedaten. Während der Transformationen können die Daten in einer Pipeline gefiltert, gruppiert, verglichen oder zusammengeführt werden.

### Pipeline im Dataflow-Dienst starten

Starten Sie die Pipeline mithilfe von Python im Cloud Dataflow-Dienst. Die ausgeführte Pipeline wird als *Job* bezeichnet.

```bash
python -m apache_beam.examples.wordcount \
  --project {{project-id}} \
  --runner DataflowRunner \
  --temp_location gs://{{project-id-no-domain}}/temp \
  --output gs://{{project-id-no-domain}}/results/output \
  --job_name {{job-name}}
```

  *  Im WordCount-Beispiel werden die Ergebnisse des Jobs im Bucket `output` gespeichert

### Ihr Job wird ausgeführt

Glückwunsch! Ihre Binärdatei ist nun mit dem von Ihnen erstellten Storage-Bucket verbunden und es werden Compute Engine-Instanzen erstellt. Die Eingabe wird in Cloud Dataflow so aufgeteilt, dass die Daten auf mehreren Maschinen parallel verarbeitet werden können.

Hinweis: Wenn die Nachricht "JOB_STATE_DONE" angezeigt wird, können Sie Cloud Shell schließen.

## Job überwachen

Prüfen Sie den Fortschritt der Pipeline auf der Seite "Cloud Dataflow".

### Monitoring-UI-Seite von Cloud Dataflow öffnen

Öffnen Sie, sofern noch nicht geschehen, die Monitoring-UI-Seite von Cloud Dataflow.

Öffnen Sie [das Menü][spotlight-console-menu] links in der Konsole.

Wählen Sie anschließend den Tab **Dataflow** aus.

<walkthrough-menu-navigation sectionid="DATAFLOW_SECTION"></walkthrough-menu-navigation>

### Job auswählen

Klicken Sie auf Ihren Job, um Details aufzurufen.

### Details und Messwerte der Pipeline ansehen

Sehen Sie sich die Pipeline auf der linken Seite und die Jobinformationen auf der rechten Seite an. Klicken Sie auf [Protokolle][spotlight-job-logs], um den genauen Jobstatus zu prüfen. Sie können auf einen Schritt in der Pipeline klicken, um die zugehörigen Messwerte aufzurufen.

Bei Abschluss des Jobs ändert sich der Jobstatus und die für den Job verwendeten Compute Engine-Instanzen werden automatisch beendet.

## Ausgabe ansehen

Nachdem Ihr Job nun ausgeführt wurde, können Sie sich in Cloud Storage die Ausgabedateien näher ansehen.

### Cloud Storage-Seite aufrufen

Öffnen Sie [das Menü][spotlight-console-menu] links in der Konsole.

Wählen Sie anschließend den Abschnitt **Compute Engine** aus.

<walkthrough-menu-navigation sectionid="STORAGE_SECTION"></walkthrough-menu-navigation>

### Storage-Bucket aufrufen

Wählen Sie in der Bucket-Liste den zuvor erstellten Bucket aus. Wenn Sie den vorgeschlagenen Namen verwendet haben, hat er den Namen `{{project-id}}`.

Der Bucket enthält einen Staging-Ordner sowie verschiedene Ausgabeordner. Da die Ausgabe von Dataflow in Shards gespeichert wird, enthält der Bucket mehrere Ausgabedateien.

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

  *  [Mehr zum Beispiel für das Zählen von Wörtern erfahren][wordcount]
  *  [Mehr zum Cloud Dataflow-Programmiermodell erfahren][df-pipelines]
  *  [Apache Beam SDK auf GitHub ansehen][beam-sdk]

Lokale Umgebung einrichten:

  *  [Dataflow mit Java und Eclipse ausführen][df-eclipse]
  *  [Dataflow mit Java und Maven ausführen][df-maven]

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
