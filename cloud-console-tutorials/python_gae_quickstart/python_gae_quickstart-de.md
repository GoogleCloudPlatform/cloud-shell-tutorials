# App Engine-Schnellstart

<walkthrough-tutorial-url url="https://cloud.google.com/appengine/docs/python/quickstart"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="https://github.com/GoogleCloudPlatform/python-docs-samples" key="repo-url"></walkthrough-watcher-constant>
<walkthrough-watcher-constant value="python-docs-samples/appengine/standard/hello_world" key="repo-dir"></walkthrough-watcher-constant>

## Einführung

In dieser Anleitung erfahren Sie, wie Sie eine [Python-Beispielanwendung](https://python.org/) mit dem Befehl `gcloud` in Google App Engine bereitstellen.

Die folgenden Schritte sind dazu erforderlich:

  *  **Projekt erstellen**

     In Projekten werden Code, VMs und andere Ressourcen zusammengefasst, um die Entwicklung und das Monitoring zu vereinfachen.

  *  **Anwendung "Hello, world!" erstellen und ausführen**

     Sie erfahren, wie Sie die Anwendung mit Google Cloud Shell direkt in Ihrem Browser ausführen. Abschließend stellen Sie die Anwendung mit dem Befehl `gcloud` im Web bereit.

  *  **Nach der Anleitung...**

     Ihre Anwendung existiert tatsächlich. Sie können sie nach der Bereitstellung beliebig anpassen oder entfernen und von vorn beginnen.

["Python" und die Python-Logos sind Marken oder eingetragene Marken der Python Software Foundation.](walkthrough://footnote)

## Projekteinrichtung

Damit Sie eine Anwendung bereitstellen können, müssen Sie zuerst ein Projekt erstellen.

Auf der Google Cloud Platform werden Ressourcen in Projekten organisiert. Auf diese Weise können Sie alle für eine einzelne Anwendung relevanten Ressourcen an einer Stelle erfassen.

<walkthrough-devshell-precreate></walkthrough-devshell-precreate>

<walkthrough-project-setup></walkthrough-project-setup>

## Google Cloud Shell verwenden

Cloud Shell ist ein integriertes Befehlszeilentool für die Konsole. Wir verwenden Cloud Shell, um die Anwendung bereitzustellen.

### Google Cloud Shell öffnen

Öffnen Sie Cloud Shell, indem Sie oben in der Navigationsleiste der Konsole auf das<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon> [Symbol][spotlight-open-devshell] klicken.

### Beispielcode klonen

Verwenden Sie Cloud Shell, um den Code "Hello World" zu klonen und aufzurufen. Der Beispielcode wird aus Ihrem Projekt-Repository geklont und in Cloud Shell kopiert.

Hinweis: Wenn das Verzeichnis bereits vorhanden ist, entfernen Sie die früheren Dateien vor dem Klonen.

Geben Sie in Cloud Shell Folgendes ein:

```bash
git clone {{repo-url}}
```

In das Anleitungsverzeichnis wechseln:

```bash
cd {{repo-dir}}
```

## Bereitstellung konfigurieren

Sie befinden sich nun im Hauptverzeichnis, das den Beispielcode enthält. Sie sehen die Dateien, mit denen Ihre Anwendung konfiguriert wird.

### Die Anwendung kennenlernen

Geben Sie den folgenden Befehl ein, um den Anwendungscode anzuzeigen:

```bash
cat main.py
```

Die Anwendung ist eine einfache Python-Anwendung, die das Webframework [webapp2](https://webapp2.readthedocs.io/) verwendet. Dieses Python-Skript antwortet auf eine Anfrage mit einem HTTP-Header und der Nachricht `Hello, World!`.

### Mit der Konfiguration vertraut machen

Google App Engine legt mithilfe von YAML-Dateien die Konfiguration der Bereitstellung fest.
In `app.yaml`-Dateien sind Informationen zu Ihrer Anwendung enthalten, z. B. die Laufzeitumgebung und URL-Handler.

Geben Sie den folgenden Befehl ein, um die Konfigurationsdatei anzuzeigen:

```bash
cat app.yaml
```

Diese Konfigurationsdatei enthält die folgenden Informationen über die Anwendung (in der Reihenfolge der Nennung):

  *  Dieser Code wird in der `python`-Laufzeitumgebung ausgeführt.
  *  Diese Anwendung ist threadsicher (`threadsafe`) konfiguriert, damit dieselbe Instanz mehrere gleichzeitige Anfragen verarbeiten kann. Threadsicherheit ist eine erweiterte Funktion und kann zu Fehlern führen, wenn Ihre Anwendung nicht speziell dafür entworfen wurde.
  *  Jede Anfrage an eine URL, deren Pfad mit dem regulären Ausdruck `/.*` (alle URLs) übereinstimmt, sollte vom App-Objekt im Python-Modul `main` verarbeitet werden.

Die Syntax dieser Datei ist [YAML](http://www.yaml.org). Eine vollständige Liste der Konfigurationsoptionen finden Sie in der [`Referenz zu app.yaml`][app-yaml-reference].

## Anwendung testen

### Anwendung in Cloud Shell testen

Mit Cloud Shell können Sie Ihre Anwendung vor der Bereitstellung genau wie bei der Fehlerbehebung auf Ihrem lokalen Rechner testen, um sicherzustellen, dass sie einwandfrei funktioniert.

Geben Sie Folgendes ein, um Ihre Anwendung zu testen:

```bash
dev_appserver.py $PWD
```

### Anwendung mit "Webvorschau" anzeigen

Ihre Anwendung wird jetzt in Cloud Shell ausgeführt. Sie können über die [Webvorschau][spotlight-web-preview]<walkthrough-web-preview-icon></walkthrough-web-preview-icon> auf die Anwendung zugreifen, um eine Verbindung zu Port 8080 herzustellen.

### Vorschauinstanz beenden

Beenden Sie die Anwendungsinstanz, indem Sie in der Cloud Shell `Strg+C` drücken.

## In Google App Engine bereitstellen

### Anwendung erstellen

Damit Sie Ihre Anwendung bereitstellen können, müssen Sie die Anwendung in einer Region erstellen:

```bash
gcloud app create
```

Hinweis: Wenn Sie bereits eine Anwendung erstellt haben, können Sie diesen Schritt überspringen.

### Mit Cloud Shell bereitstellen

Sie können Ihre Anwendung mithilfe von Cloud Shell bereitstellen. Geben Sie zum Bereitstellen der Anwendung Folgendes ein:

```bash
gcloud app deploy app.yaml --project {{project-id}}
```

### Anwendung aufrufen

Glückwunsch! Ihre Anwendung wurde bereitgestellt. Die Standard-URL der Anwendung lautet [{{project-gae-url}}](http://{{project-gae-url}}). Klicken Sie auf die URL, um die Anwendung aufzurufen.

### Status der Anwendung aufrufen

Sie können Ihre Anwendung im App Engine-Dashboard anhand ihres Status überwachen.

[Öffnen Sie das Menü][spotlight-console-menu] links in der Konsole.

Wählen Sie anschließend den Abschnitt **App Engine** aus.

<walkthrough-menu-navigation sectionid="APPENGINE_SECTION"></walkthrough-menu-navigation>

## Fazit

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Sie haben eine App Engine-Anwendung erstellt.

Mögliche weitere Schritte:

**Google Cloud SDK herunterladen und lokal entwickeln**

Installieren Sie das [Google Cloud SDK][cloud-sdk-installer] auf Ihrem lokalen Rechner.

**Nächste Anwendung erstellen**

Erfahren Sie, wie Sie App Engine mit anderen Google Cloud Platform-Produkten verwenden können:

<walkthrough-tutorial-card label="django" url="python/django/appengine" icon="APPENGINE_SECTION">
  **Django ausführen**
  Entwickeln Sie Django-Anwendungen, die in App Engine ausgeführt werden.
</walkthrough-tutorial-card>

<walkthrough-tutorial-card label="datastore" url="appengine/docs/python/datastore/" icon="DATASTORE_SECTION">
  **Cloud Datastore verwenden**
  Cloud Datastore ist eine hoch skalierbare NoSQL-Datenbank für Ihre Anwendungen.
</walkthrough-tutorial-card>

[app-yaml-reference]: https://cloud.google.com/appengine/docs/standard/python/config/appref
[cloud-sdk-installer]: https://cloud.google.com/sdk/downloads#interactive
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-web-preview]: walkthrough://spotlight-pointer?spotlightId=devshell-web-preview-button
