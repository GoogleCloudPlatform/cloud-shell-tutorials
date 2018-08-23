# Schnellstart für App Engine

<walkthrough-test-start-page url="/getting-started?tutorial=java_gae_quickstart_2"/>

<walkthrough-tutorial-url url="https://cloud.google.com/appengine/docs/java/quickstart"/>

<walkthrough-watcher-constant key="repo-url" value="https://github.com/GoogleCloudPlatform/appengine-try-java" />

<walkthrough-watcher-constant key="repo-name" value="appengine-try-java"/>

## Einleitung

In dieser Anleitung erfahren Sie, wie Sie mit dem Maven-Plug-in für App Engine
eine [Java][java]-Beispielanwendung für Google App Engine bereitstellen.

Sie werden folgende Schritte ausführen.

*   **"Hello, world!"-App erstellen und ausführen**

    Sie werden erfahren, wie Sie Ihre App mit Google Cloud Shell direkt in Ihrem
    Browser ausführen können. Zum Schluss werden Sie Ihre App mit dem
    Maven-Plug-in für App Engine im Web bereitstellen.

*   **Nach der App...**

    Ihre App existiert tatsächlich und Sie können nach der Bereitstellung mit
    ihr experimentieren. Sie können sie aber auch entfernen und von vorn
    beginnen.

[Java is a registered trademark of Oracle and/or its affiliates.](walkthrough://footnote)

<walkthrough-devshell-precreate/>

## Projekteinrichtung

Zum Bereitstellen einer Anwendung müssen Sie zuerst ein Projekt erstellen.

Die Google Cloud Platform organisiert Ressourcen in Projekten. So können Sie
alle für eine einzelne Anwendung relevanten Ressourcen an einem einzigen Ort
erfassen.

<walkthrough-project-setup/>

## Google Cloud Shell verwenden

Cloud Shell ist ein integriertes Befehlszeilentool für die Konsole. Wir
verwenden Cloud Shell, um Ihre App bereitzustellen.

### Google Cloud Shell öffnen

Öffnen Sie Cloud Shell, indem Sie in der oberen Navigationsleiste der Konsole
auf die Schaltfläche <walkthrough-cloud-shell-icon/>
[icon](walkthrough://spotlight-pointer?spotlightId=devshell-activate-button)
klicken.

### Beispielcode klonen

Mit Cloud Shell können Sie den "Hello World"-Code klonen und aufrufen. Der
Beispielcode wird aus Ihrem Projekt-Repository geklont und in Cloud Shell
kopiert.

Hinweis: Wenn das Verzeichnis bereits existiert, entfernen Sie vor dem Klonen
die vorherigen Dateien:

```bash
rm -rf {{repo-name}}
```

Geben Sie in Cloud Shell Folgendes ein:

```bash
git clone {{repo-url}}
```

Wechseln Sie dann zum Anleitungsverzeichnis:

```bash
cd {{repo-name}}
```

## Bereitstellung konfigurieren

Sie befinden sich nun im Hauptverzeichnis für den Beispielcode. Wir werden uns
mit den Dateien für die Konfiguration Ihrer Anwendung befassen.

### Mit der Anwendung vertraut machen

Geben Sie den folgenden Befehl ein, um Ihren Anwendungscode anzuzeigen:

```bash
cat src/main/java/myapp/DemoServlet.java
```

Dieses Servlet reagiert auf alle Anfragen mit dem Senden einer Antwort mit der
Nachricht "Hello, world!".

### Mit der Konfiguration vertraut machen

Für Java verwendet Google App Engine XML-Dateien zum Angeben der Konfiguration
einer Bereitstellung.

Geben Sie den folgenden Befehl ein, um Ihre Konfigurationsdatei anzuzeigen:

```bash
cat pom.xml
```

Die "Helloworld"-App verwendet Maven. Sie müssen also ein POM (Project Object
Model, Projektobjektmodell) angeben, das Informationen zum Projekt sowie
Konfigurationsdetails enthält, die von Maven für die Erstellung des Projekts
verwendet werden.

## App testen

### App in Cloud Shell testen

Cloud Shell bietet Ihnen die Möglichkeit, Ihre App vor der Bereitstellung zu
testen und so sicherzustellen, dass sie wie beabsichtigt funktioniert – wie bei
der Fehlerbehebung auf Ihrem lokalen Gerät.

Geben Sie Folgendes ein, um Ihre App zu testen:

```bash
mvn appengine:run
```

<walkthrough-test-code-output
  text="module .* running at|Dev App Server is now running" />

### Mit der Webvorschau eine Vorschau der App anzeigen

Ihre App wird jetzt in Cloud Shell ausgeführt. Sie können auf die App zugreifen,
indem Sie mit der Webvorschau <walkthrough-web-preview-icon/> eine Verbindung zu
Port 8080 herstellen.
[Anleitung](walkthrough://spotlight-pointer?spotlightId=devshell-web-preview-button)

### Vorschauinstanz beenden

Beenden Sie die Instanz der Anwendung, indem Sie in Cloud Shell "Strg+C"
drücken.

## Google App Engine bereitstellen

### Anwendung erstellen

Zum Bereitstellen Ihrer App muss eine App in einer Region erstellt werden:

```bash
gcloud app create
```

Hinweis: Wenn Sie bereits eine App erstellt haben, können Sie diesen Schritt
überspringen.

### Mit Cloud Shell bereitstellen

Sie können jetzt Cloud Shell zum Bereitstellen Ihrer App verwenden.

Legen Sie zuerst fest, welches Projekt verwendet werden soll: `bash gcloud
config set project {{project-id}}`

Stellen Sie dann Ihre App bereit: `bash mvn appengine:deploy`

<walkthrough-test-code-output text="Deployed (module|service)" />

### App aufrufen

Ihre App wurde bereitgestellt. Die Standard-URL Ihrer App ist
[{{project-gae-url}}](http://{{project-gae-url}}). Klicken Sie auf die URL, um
die App aufzurufen.

### Den Status der App überprüfen

Sie können Ihre App im App Engine-Dashboard anhand ihres Status überwachen.

Öffnen Sie das Menü
[menu](walkthrough://spotlight-pointer?spotlightId=console-nav-menu) links in
der Konsole.

Wählen Sie dann den Abschnitt **App Engine** aus.

<walkthrough-menu-navigation sectionId="APPENGINE_SECTION"/>

## Fazit

<walkthrough-conclusion-trophy/>

Glückwunsch! Sie haben erfolgreich eine App Engine-Anwendung bereitgestellt.
Dies sind einige weitere Schritte:

**Google Cloud SDK herunterladen und lokal entwickeln**

[Google Cloud SDK][cloud-sdk-installer]

**Ihre nächste Anwendung erstellen**

Entdecken Sie, wie Sie App Engine mit anderen Google Cloud Platform-Produkten
verwenden können:

<walkthrough-tutorial-card
  url="appengine/docs/java/datastore/"
  icon="DATASTORE_SECTION"
  label="datastore">
**Verwendung von Cloud Datastore erlernen**
Cloud Datastore ist eine hoch skalierbare NoSQL-Datenbank für Ihre Anwendungen.
</walkthrough-tutorial-card>

<walkthrough-tutorial-card
  url="appengine/docs/java/googlecloudstorageclient/setting-up-cloud-storage/"
  icon="STORAGE_SECTION"
  label="cloudStorage">
**Verwendung von Cloud Storage erlernen**
Cloud Storage ist ein leistungsstarker, einfacher Objektspeicherdienst.
</walkthrough-tutorial-card>

[java]: https://java.com/
[cloud-sdk-installer]: https://cloud.google.com/sdk/downloads#interactive
