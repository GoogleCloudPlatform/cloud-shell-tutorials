# Cloud Storage-Schnellstart

## Willkommen bei Google Cloud Storage!

<walkthrough-tutorial-url url="https://cloud.google.com/storage/docs/quickstart-console"></walkthrough-tutorial-url>

Google Cloud Storage ist eine leistungsfähige, kostengünstige Speicherlösung für unstrukturierte Objekte. Sie eignet sich optimal für jegliche Aufgaben, angefangen vom Hosting von Live-Webinhalten über das Speichern von Daten zur Analyse bis hin zur Archivierung und Sicherung von Daten.

In dieser Anleitung erfahren Sie, wie Sie ganz einfach Ihre ersten Objekte in Cloud Storage speichern können. Dabei gehen Sie so vor:

  *  **Bucket erstellen**

     Buckets enthalten die Objekte eines beliebigen Dateityps, die Sie in Cloud Storage speichern möchten.

  *  **Objekte hochladen und freigeben**

     Beginnen Sie mit der Nutzung des Buckets, indem Sie ein Objekt hochladen und öffentlich verfügbar machen.

  *  **Bereinigen**

     Zum Schluss löschen Sie den für diese Anleitung erstellten Bucket und das Objekt.

Da Sie den Bucket und das Objekt am Ende löschen, entstehen Ihnen beim Befolgen dieser Anleitung auch keine Kosten.

## Projekt einrichten

Cloud Storage benötigt ein Projekt, um Ressourcen erstellen zu können.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## Bucket erstellen

In Cloud Storage speichern Sie Ihre Objekte in Buckets. Für die Bucket-Erstellung wechseln Sie zum Cloud Storage-Browser.

[Öffnen Sie das Menü][spotlight-menu] links in der Konsole.

Wählen Sie anschließend den Abschnitt **Storage** aus.

<walkthrough-menu-navigation sectionid="STORAGE_SECTION"></walkthrough-menu-navigation>

## Bucket erstellen

Bevor Sie mit dem Hochladen von Objekten beginnen können, müssen Sie einen "Bucket" zum Speichern der Objekte erstellen. Buckets ermöglichen es Ihnen, Ihre Objekte zu organisieren und den Zugriff darauf zu steuern.

  1. Klicken Sie auf [Bucket erstellen](walkthrough://spotlight-pointer?cssSelector=#p6ntest-cloudstorage-create-first-bucket-button,).

  1. Geben Sie auf der Seite zur Bucket-Erstellung die Eigenschaften des Buckets an. Beachten Sie dabei Folgendes:

     *  **Name**: Verwenden Sie einen eindeutigen Namen. Wenn Sie einen Namen eines bereits in Cloud Storage vorhandenen Buckets eingeben, erhalten Sie eine Fehlermeldung.
     *  **Standard-Storage-Klasse**: Dies ist die Storage-Klasse, die den Objekten Ihres Buckets standardmäßig zugewiesen ist. Ihre Auswahl hängt hauptsächlich davon ab, wie oft voraussichtlich auf die Objekte zugegriffen wird und ob Sie die Daten weltweit bereitstellen. Die Storage-Klasse beeinflusst Ihre Kosten.
     *  **Speicherort**: Ihre Daten sollten in der Nähe der Anwendungen und der Nutzer gespeichert werden, die darauf zugreifen. Die verfügbaren Optionen hängen von der ausgewählten Storage-Klasse ab.

Für diesen Test können Sie eine beliebige Storage-Klasse und einen beliebigen Speicherort auswählen, weil Sie den Bucket am Ende ohnehin wieder löschen.

  1. Klicken Sie auf [Erstellen][spotlight-create-button].

## Objekt hochladen

Mit dem neuen Bucket können Sie nun mit dem Hochladen von Objekten beginnen.

  1. Klicken Sie oben auf der Seite auf [Dateien hochladen][spotlight-upload-file].

  1. Wählen Sie eine Datei zum Hochladen aus. Sie können einen beliebigen Dateityp hochladen.

     Sie haben keine Datei? [Erstellen Sie eine Beispieldatei.][create-sample-file] Klicken Sie anschließend oben auf der Seite auf [Bucket aktualisieren][spotlight-refresh-bucket], um die Datei in Ihrem Bucket anzuzeigen. Tipp: Sie können Objekte auch hochladen, indem Sie sie in den Bereich unter dem Bucket-Namen ziehen.


## Bucket löschen

Löschen Sie jetzt den soeben erstellten Bucket. Beim Löschen eines Buckets wird auch der Inhalt gelöscht.

  1. Klicken Sie oben in der Tabelle auf [Buckets][spotlight-buckets-link], um zur Liste der Buckets zurückzukehren.

  1. Klicken Sie das Kästchen neben Ihrem Bucket an. Wenn in diesem Projekt weitere Buckets vorhanden sind und Sie Hilfe beim Auffinden Ihres eigenen Buckets benötigen, filtern Sie die Bucket-Liste über die Suchleiste.

  1. Klicken Sie oben auf der Seite auf [Löschen][spotlight-delete-buckets], um den Löschvorgang zu bestätigen.

## Fazit

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Glückwunsch!

Nachdem Sie nun wissen, wie Sie Objekte in Cloud Storage speichern, möchten Sie vielleicht mehr darüber erfahren, wie Sie dies durch das [Hosting einer statischen Website](https://cloud.google.com/storage/docs/hosting-static-website) in der Praxis anwenden können.

Oder informieren Sie sich, wie Sie Cloud Storage zusammen mit dem [Befehlszeilentool gsutil](https://cloud.google.com/storage/docs/quickstart-gsutil) verwenden können.

Erfahren Sie, wie Sie Cloud Storage und andere GCP-Dienste zu Beginn [kostenlos nutzen können](https://cloud.google.com/free).

[create-sample-file]: walkthrough://create-sample-storage-file
[spotlight-buckets-link]: walkthrough://spotlight-pointer?cssSelector=.p6n-cloudstorage-path-link
[spotlight-create-bucket]: walkthrough://spotlight-pointer?cssSelector=#p6ntest-cloudstorage-create-first-bucket-button,#p6n-cloudstorage-create-bucket
[spotlight-create-button]: walkthrough://spotlight-pointer?cssSelector=#p6ntest-gcs-create-bucket-button
[spotlight-delete-buckets]: walkthrough://spotlight-pointer?spotlightId=gcs-action-bar-delete-bucket
[spotlight-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-public-link]: walkthrough://spotlight-pointer?cssSelector=.p6n-cloudstorage-browser-public-label
[spotlight-refresh-bucket]: walkthrough://spotlight-pointer?spotlightId=gcs-action-bar-refresh-objects
[spotlight-share-public]: walkthrough://spotlight-pointer?cssSelector=.p6n-cloudstorage-browser-public-checkbox
[spotlight-upload-file]: walkthrough://spotlight-pointer?spotlightId=gcs-action-bar-upload-file
