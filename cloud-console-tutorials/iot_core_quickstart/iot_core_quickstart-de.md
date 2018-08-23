# Einführung in Cloud IoT Core

<walkthrough-tutorial-url url="https://cloud.google.com/iot/docs/quickstart"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="https://github.com/GoogleCloudPlatform/nodejs-docs-samples.git" key="repo-url"></walkthrough-watcher-constant>

## Einführung

Google Cloud Internet of Things (IoT) Core ist ein vollständig verwalteter Dienst zur sicheren Vernetzung und Steuerung von wenigen bis zu einigen Millionen IdD-Geräten. In dieser Anleitung erfahren Sie, wie Sie das `gcloud`-Befehlszeilentool verwenden, um eine Cloud IoT Core-Geräte-Registry zu erstellen und ein Gerät hinzuzufügen. Außerdem wird erläutert, wie Sie ein MQTT-Beispiel ausführen, um ein Gerät zu verbinden und Telemetrieereignisse von Geräten zu veröffentlichen.

In dieser Anleitung erfahren Sie, wie Sie Folgendes tun können:

  *  Cloud Pub/Sub-Thema erstellen
  *  Geräte-Registry erstellen
  *  Gerät der Registry hinzufügen
  *  Anmeldedaten auf dem Gerät einrichten
  *  Abo für das Pub/Sub-Thema erstellen, um Nachrichten zu senden und zu empfangen
  *  Virtuelles Gerät verbinden und Telemetriedaten aufrufen

## Projekteinrichtung

Auf der Google Cloud Platform werden Ressourcen in Projekten organisiert. Auf diese Weise können Sie alle für eine einzelne Anwendung relevanten Ressourcen an einer Stelle erfassen.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## Google Cloud Shell verwenden

Bei dieser Anleitung arbeiten Sie ausschließlich mit Cloud Shell.

### Google Cloud Shell öffnen

Öffnen Sie Cloud Shell, indem Sie oben in der Navigationsleiste der Konsole auf das [Symbol][spotlight-open-devshell] <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon> klicken.

### Google Cloud APIs aktivieren

Dadurch wird die Cloud IoT Core API aktiviert.

<walkthrough-enable-apis apis="cloudiot.googleapis.com"></walkthrough-enable-apis>

## Erstes Thema erstellen

Ein Thema ist eine benannte Ressource, an die Geräte Nachrichten senden. Erstellen Sie mit dem folgenden Befehl Ihr erstes Thema:

```bash
gcloud pubsub topics create my-topic
```

Sie senden später mehrere Nachrichten an dieses Thema.

## Cloud IoT Core-Node.js-Beispieldateien von GitHub klonen

Verwenden Sie das MQTT-Beispiel, um Nachrichten an Cloud IoT Core zu senden.

Hinweis: Wenn das Verzeichnis bereits vorhanden ist, entfernen Sie die früheren Dateien vor dem Klonen:

```bash
rm -rf nodejs-docs-samples
```

Klonen Sie das Beispielprogramm mit dem folgenden Befehl:

```bash
git clone {{repo-url}}
```

## Berechtigung für das IoT Core-Dienstkonto erteilen

Fügen Sie das Dienstkonto `cloud-iot@system.gserviceaccount.com` dem Cloud Pub/Sub-Thema mit der Publisher-Rolle hinzu, indem Sie das Hilfsskript im Ordner `/iot/scripts` verwenden.

### Wechseln Sie zum Verzeichnis "iot":

```bash
cd nodejs-docs-samples/iot
```

### Installieren Sie die Abhängigkeiten:

```bash
npm --prefix ./scripts install
```

### Führen Sie das Hilfsskript aus:

```bash
node scripts/iam.js my-topic
```

Das Skript erteilt dem Cloud IoT Core-Dienstkonto die Zugriffsberechtigung für das Thema `my-topic`.

## Geräte-Registry erstellen

Eine Geräte-Registry beinhaltet Geräte und definiert deren gemeinsame Eigenschaften. Mit dem folgenden Befehl erstellen Sie eine Geräte-Registry:

```bash
gcloud iot registries create my-registry \
    --project={{project-id}} \
    --region=us-central1 \
    --event-notification-config=topic=projects/{{project-id}}/topics/my-topic
```

## Signaturschlüssel generieren

Ein Gerät benötigt einen privaten und einen öffentlichen Schlüssel, um sich bei Cloud IoT Core zu authentifizieren. Mit dem folgenden Befehl generieren Sie die Signaturschlüssel:

```bash
./scripts/generate_keys.sh
```

Durch das Skript werden RS256- und ES256-Schlüssel im PEM-Format erstellt. Für diese Anleitung benötigen Sie aber nur die RS256-Schlüssel. Der private Schlüssel muss sicher auf dem Gerät gespeichert werden. Er wird für die JWT-Authentifizierung ([JSON Web Token][web-token-docs]) verwendet. Der öffentliche Schlüssel wird in der Geräte-Registry gespeichert.

## Gerät erstellen und der Registry hinzufügen

Mit dem folgenden Befehl erstellen Sie ein Gerät und fügen es der Registry hinzu:

```bash
gcloud iot devices create my-node-device \
    --project={{project-id}} \
    --region=us-central1 \
    --registry=my-registry \
    --public-key path=rsa_cert.pem,type=rs256
```

## Gerät verbinden und Telemetriedaten abrufen

In diesem Schritt senden Sie Nachrichten von einem virtuellen Gerät an Pub/Sub. Dann rufen Sie die Nachrichten ab und sehen sie sich an.

### Wechseln Sie zum MQTT-Beispielverzeichnis:

```bash
cd mqtt_example
```

### Installieren Sie die Node.js-Abhängigkeiten:

```bash
npm install
```

### Führen Sie den folgenden Befehl aus, um ein virtuelles Gerät über die MQTT-Bridge mit Cloud IoT Core zu verbinden:

```bash
node cloudiot_mqtt_example_nodejs.js \
    --projectId={{project-id}} \
    --registryId=my-registry \
    --deviceId=my-node-device \
    --privateKeyFile=../rsa_private.pem \
    --numMessages=25 \
    --algorithm=RS256 \
    --mqttBridgePort=443
```

Die Ausgabe zeigt, dass das virtuelle Gerät Nachrichten zum Telemetriethema veröffentlicht. In diesem Fall sind es 25 Nachrichten.

## Abo für das Thema des Geräts erstellen

Mit dem folgenden Befehl erstellen Sie ein Abo, mit dem Sie die von Ihrem Gerät veröffentlichten Nachrichten anzeigen lassen können:

```bash
gcloud pubsub subscriptions create \
    projects/{{project-id}}/subscriptions/my-subscription \
    --topic=my-topic
```

## Veröffentlichte Nachrichten abrufen

Mit dem folgenden Befehl rufen Sie die vom Gerät veröffentlichten Nachrichten ab:

```bash
gcloud pubsub subscriptions pull --auto-ack \
    projects/{{project-id}}/subscriptions/my-subscription
```

Durch Ausführen dieses Befehls werden die vom Gerät veröffentlichten Nachrichten abgerufen. Die Nachrichten enthalten `my-registry/my-node-device-payload-&lt;INTEGER&gt;`, eine `MESSAGE_ID` und eine `ATTRIBUTES`-Liste mit Informationen zum Gerät. Die `MESSAGE_ID` ist eine eindeutige ID, die vom Server zugewiesen wird.

Hinweis: Cloud Pub/Sub bietet keine Garantie für die korrekte Reihenfolge der Nachrichten. Möglicherweise sehen Sie auch nur eine einzige Nachricht in Cloud Shell. Führen Sie in diesem Fall denselben Befehl mehrmals aus, bis Sie auch die anderen Nachrichten sehen.

## Ressourcen in der Google Cloud Platform Console ansehen

Damit sind wir am Ende der Anleitung zum `gcloud`-Befehlszeilentool. Sie können sich die soeben erstellten Ressourcen aber auch in der GCP Console ansehen.

Öffnen Sie [das Menü][spotlight-console-menu] links in der Konsole.

Wählen Sie anschließend **IoT Core** aus.

<walkthrough-menu-navigation sectionid="IOT_SECTION"></walkthrough-menu-navigation>

Über die UI können Sie auch Geräte-Registrys und Geräte erstellen sowie verwalten.

## Fazit

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Glückwunsch! Sie kennen jetzt die grundlegenden Konzepte von Cloud IoT Core unter Verwendung des `gcloud`-Befehlszeilentools und haben sich Cloud IoT Core-Ressourcen in der GCP Console angesehen. Jetzt können Sie anfangen, Ihre eigenen Anwendungen zu erstellen. Weitere Informationen finden Sie in der [IoT Core-Dokumentation](https://cloud.google.com/iot/docs/).

### Vorschläge für die nächsten Schritte

Weitere Beispiele zu Cloud IoT Core auf GitHub ansehen:

  *  [C](https://github.com/GoogleCloudPlatform/cpp-docs-samples/tree/master/iot/mqtt-ciotc)
  *  [Java](https://github.com/GoogleCloudPlatform/java-docs-samples/tree/master/iot/api-client)
  *  [Node.js](https://github.com/GoogleCloudPlatform/nodejs-docs-samples/tree/master/iot)
  *  [Python](https://github.com/GoogleCloudPlatform/python-docs-samples/tree/master/iot/api-client)

[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[web-token-docs]: https://cloud.google.com/iot/docs/how-tos/credentials/jwts
