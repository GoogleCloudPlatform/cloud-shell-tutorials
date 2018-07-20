# Cloud Vision API

<walkthrough-test-start-page url="/start?tutorial=python_vision_quickstart_v2"></walkthrough-test-start-page>

<walkthrough-tutorial-url url="https://cloud.google.com/vision/docs/label-tutorial"></walkthrough-tutorial-url>

<walkthrough-watcher-constant value="https://github.com/GoogleCloudPlatform/python-docs-samples.git" key="repo-url"></walkthrough-watcher-constant>

<walkthrough-watcher-constant value="python-docs-samples" key="repo-name"></walkthrough-watcher-constant>

<walkthrough-devshell-precreate></walkthrough-devshell-precreate>

## Einführung

In dieser Anleitung werden Sie schrittweise durch eine einfache Vision
API-Anwendung mit einer `LABEL_DETECTION`-Anfrage geführt. Mit der Anfrage
`LABEL_DETECTION` fügen Sie einem Bild ein Label (oder "Tag") hinzu, das auf
Grundlage des Bildinhalts ausgewählt wird. So könnte beispielsweise für das Bild
einer Scheune das Label "Scheune", "Bauernhof" oder eine ähnliche Anmerkung
generiert werden.

Sie führen die folgenden Schritte aus:

*   **Anwendung für Labelerkennung ausführen**: Sie lernen, wie Sie die
    Anwendung mit Google Cloud Shell direkt in Ihrem Browser ausführen können.
*   **Schritte nach Ausführung der Anwendung: ** Da es sich um eine echte
    Anwendung handelt, können Sie sie nach Belieben ausprobieren und testen. Sie
    können die Anwendung aber auch entfernen und von vorn beginnen.

["Python" und die Python-Logos sind Marken oder eingetragene Marken der Python
Software Foundation.](walkthrough://footnote)

# Projekt einrichten

Die Cloud Vision API muss in einem Projekt aktiviert werden.

Auf der Google Cloud Platform werden Ressourcen in Projekten organisiert. Auf
diese Weise können Sie alle für eine einzelne Anwendung relevanten Ressourcen an
einer Stelle erfassen.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## Vision API aktivieren

In Ihrem Projekt muss die Vision API aktiviert sein, damit Anfragen angenommen
werden können.

### API Manager aufrufen

Im API Manager können Sie die APIs für Ihr Projekt aktivieren.

Öffnen Sie das Menü
[menu](walkthrough://spotlight-pointer?spotlightId=console-nav-menu) links in
der Konsole.

Wählen Sie dann den Abschnitt **APIs und Dienste** aus.

<walkthrough-menu-navigation sectionid="API_SECTION"></walkthrough-menu-navigation>

### Verfügbare APIs ansehen

Die APIs werden über die Schaltfläche
[API aktivieren](walkthrough://spotlight-pointer?cssSelector=.p6n-action-bar-button)
ausgewählt.

### Vision API auswählen

Klicken Sie auf den Link
[Vision API](walkthrough://spotlight-pointer?spotlightId=api-vision.googleapis.com).

### Vision API aktivieren

Klicken Sie auf die Schaltfläche
[Aktivieren](walkthrough://spotlight-pointer?spotlightId=api-enable-vision.googleapis.com), um die
Vision API auszuwählen. Weiter unten in dieser Anleitung erstellen Sie die
Anmeldedaten für Ihr Projekt.

## Google Cloud Shell verwenden

Cloud Shell ist ein integriertes Befehlszeilentool für die Konsole. Sie
verwenden Cloud Shell zur Ausführung Ihrer Anwendung.

### Google Cloud Shell öffnen

Öffnen Sie Cloud Shell. Klicken Sie dafür in der Navigationsleiste am oberen
Rand der Konsole auf das
<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>
[Symbol](walkthrough://spotlight-pointer?spotlightId=devshell-activate-button).

### Beispielcode klonen

Verwenden Sie Cloud Shell, um den Code "Hello World" zu klonen und aufzurufen.
Der Beispielcode wird aus Ihrem Projekt-Repository geklont und in Cloud Shell
kopiert.

Hinweis: Wenn das Verzeichnis bereits vorhanden ist, entfernen Sie die früheren
Dateien vor dem Klonen:

```bash
rm -rf {{repo-name}}
```

Beispiel-Repository klonen:

```bash
git clone {{repo-url}}
```

In das Anleitungsverzeichnis wechseln:

```bash
cd {{repo-name}}/vision/cloud-client/quickstart
```

## Bereitstellung konfigurieren

Sie befinden sich nun im Hauptverzeichnis, das den Beispielcode enthält. Im
Folgenden werden die Dateien zur Konfiguration Ihrer Anwendung vorgestellt.

### Die Anwendung kennenlernen

Geben Sie den folgenden Befehl ein, um den Anwendungscode anzuzeigen:

```bash
cat quickstart.py
```

Mit der Datei `quickstart.py` werden Ihre Anfrageinformationen formatiert, z. B.
Typ und Inhalt der Anfrage. Maximieren Sie jeweils die folgenden Abschnitte, um
weitere Informationen zu erhalten.

Die Anfragen an die Vision API werden als JSON-Objekte übergeben. Vollständige
Informationen zur spezifischen Struktur solcher Anfragen finden Sie in der
[Vision API-Referenz][vision-request-doc]. Ihre JSON-Anfrage wird erst gesendet,
wenn Sie `execute` aufrufen. Dadurch haben Sie die Möglichkeit, die Anfragen
weiterzugeben und `execute` bei Bedarf aufzurufen.

## Anwendung testen

Zur Verwendung der API benötigen Sie Anmeldedaten. Für alle Cloud-APIs müssen
Sie jeweils die korrekten [Anmeldedaten][auth-doc] für Ihre Anwendung
einrichten. Mit den Anmeldedaten kann die Anwendung ihre Identität gegenüber dem
Dienst authentifizieren und die Berechtigung zur Ausführung von Aufgaben
einholen. Anschließend testen Sie die API anhand von Beispielbildern.

### Dienstkonto erstellen

Zur Authentifizierung Ihrer API-Anfragen müssen Sie ein Dienstkonto erstellen.
Ist das Dienstkonto bereits vorhanden, wird es wiederverwendet.

```bash
gcloud iam service-accounts create vision-quickstart
```

### Anmeldedaten erstellen

Im nächsten Schritt erstellen Sie einen Dienstkontoschlüssel und richten ihn
ein. Er soll standardmäßig zur Authentifizierung verwendet werden.

```bash
gcloud iam service-accounts keys create key.json --iam-account \
  vision-quickstart@{{project-id}}.iam.gserviceaccount.com
```

```bash
export GOOGLE_APPLICATION_CREDENTIALS=key.json
```

<walkthrough-test-code-output text="created key"></walkthrough-test-code-output>

### Anwendung testen

Geben Sie den folgenden Befehl ein, um Ihre Anwendung mit einem Beispielbild zu
testen:

```bash
python quickstart.py
```

Die Bildressource `resources/wakeupcat.jpg` wird in der Quelle angegeben. ([Bild
ansehen][cat-picture])

## Ergebnis

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Glückwunsch! Sie können die Cloud Vision API jetzt verwenden.

Vorschläge für die nächsten Schritte:

*   Anleitung zur [Gesichtserkennung][face-tutorial] durcharbeiten
*   Anleitung zum [Dokumenttext][document-text-tutorial] ausprobieren
*   [Beispielanwendungen][vision-samples] ansehen
*   [Google Cloud SDK][get-cloud-sdk] herunterladen und auf Ihrem lokalen
    Computer ausführen

[auth-doc]: https://cloud.google.com/vision/docs/auth
[cat-picture]: https://raw.githubusercontent.com/GoogleCloudPlatform/python-docs-samples/master/vision/cloud-client/quickstart/resources/wakeupcat.jpg
[document-text-tutorial]: https://cloud.google.com/vision/docs/fulltext-annotations
[face-tutorial]: https://cloud.google.com/vision/docs/face-tutorial
[get-cloud-sdk]: https://cloud.google.com/sdk/
[vision-request-doc]: https://cloud.google.com/vision/reference/rest
[vision-samples]: https://cloud.google.com/vision/docs/samples
