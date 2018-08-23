# Einführung in Cloud Pub/Sub

<walkthrough-tutorial-url url="https://cloud.google.com/pubsub/quickstart-console"></walkthrough-tutorial-url></walkthrough-test-start-page>

<walkthrough-devshell-precreate></walkthrough-devshell-precreate>

## Einführung

Cloud Pub/Sub ist ein vollständig verwalteter Echtzeit-Messaging-Dienst, mit dem Sie Nachrichten zwischen unabhängigen Anwendungen senden und empfangen können. In dieser Anleitung erhalten Sie eine kurze Einführung in die Befehlszeilenschnittstelle von Cloud Pub/Sub mit dem Befehl `gcloud`.

## Projekt einrichten

Auf der Google Cloud Platform werden Ressourcen in Projekten organisiert. Auf diese Weise können Sie alle für eine einzelne Anwendung relevanten Ressourcen an einer Stelle erfassen.

Damit Sie die Nachrichtenfunktion in Cloud Pub/Sub einrichten können, ist ein Projekt erforderlich.

<walkthrough-project-setup></walkthrough-project-setup>

## Erstes Thema erstellen

### Google Cloud Shell öffnen

Cloud Shell ist ein integriertes Befehlszeilentool für die Konsole. Sie verwenden Cloud Shell zum Einrichten von Cloud Pub/Sub.

Öffnen Sie Cloud Shell, indem Sie oben in der Navigationsleiste der Konsole auf das<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon> [Symbol][spotlight-open-devshell] klicken.

### Thema erstellen

Ein Thema ist eine benannte Ressource, an die Sie Nachrichten senden. Erstellen Sie mit dem folgenden Befehl Ihr erstes Thema:

```bash
gcloud pubsub topics create my-topic
```

## Abo hinzufügen

Damit Sie Nachrichten empfangen können, müssen Sie Abos erstellen. Für ein Abo muss ein entsprechendes Thema vorhanden sein. Erstellen Sie mit dem folgenden Befehl Ihr erstes Abo:

```bash
gcloud pubsub subscriptions \
    create my-sub --topic my-topic \
    --ack-deadline=60
```

Mit diesem Befehl erstellen Sie ein Abo namens `my-sub`, das mit dem Thema `my-topic` verknüpft ist. Alle an `my-topic` veröffentlichten Nachrichten werden an dieses Abo gesendet.

Der Befehl enthält die Option `--ack-deadline=60`. `ack-deadline` steht für 
`Acknowledgement deadline` (Bestätigungsfrist). Das neue Abo hat eine Bestätigungsfrist ``von 60 Sekunden. Wir gehen darauf nachher noch ein.

## Themen und Abos auflisten

Prüfen Sie vor dem Senden Ihrer ersten Nachricht, ob das Thema und das Abo erstellt wurden. Listen Sie mit dem folgenden Befehl das Thema und das Abo auf:

```bash
gcloud pubsub topics list
```

```bash
gcloud pubsub subscriptions list
```

## Nachrichten an das Thema veröffentlichen

Verwenden Sie die folgenden Befehle, um zwei Nachrichten zu senden:

```bash
gcloud pubsub topics publish my-topic --message hello
```

```bash
gcloud pubsub topics publish my-topic --message goodbye
```

Mit jedem dieser Befehle wird eine Nachricht gesendet. Die erste Nachricht lautet `hello`, die zweite `goodbye`. Wenn Sie eine Nachricht veröffentlicht haben, sehen Sie die vom Server zurückgegebene Nachrichten-ID. Hierbei handelt es sich um eine eindeutige ID, die jeder Nachricht automatisch vom Server zugewiesen wird.

## Nachrichten des Abos abrufen

### Nachrichten abrufen

Rufen Sie jetzt die Nachrichten mit dem folgenden Befehl ab:

```bash
gcloud pubsub subscriptions \
    pull --auto-ack --limit=2 my-sub
```

Es sollten die soeben von Ihnen veröffentlichten Nachrichten angezeigt werden. Die Nachrichten enthalten die Daten, d. h. `hello` und `goodbye`, sowie die `MESSAGE_ID`. Die `MESSAGE_ID` ist die vom Server zugewiesene eindeutige ID der Nachricht.

Hinweis: Die zeitlich korrekte Reihenfolge der Nachrichten wird in Cloud Pub/Sub nicht gewährleistet. Möglicherweise wird auch nur eine Nachricht angezeigt. Führen Sie in diesem Fall denselben Befehl mehrmals aus, bis Sie auch die andere Nachricht sehen.

### Bestätigung und Bestätigungsfrist

Nachdem Sie eine Nachricht abgerufen und ordnungsgemäß verarbeitet haben, müssen Sie Cloud Pub/Sub darüber informieren, dass Sie die Nachricht erhalten haben. Diese Aktion wird als **Bestätigung** bezeichnet.

Zusammen mit dem Befehl `pull` wurde das Flag `--auto-ack` übergeben.
Das Flag `--auto-ack` dient dazu, die Nachricht automatisch abzurufen und zu bestätigen.

## Manuelle Bestätigung

### Neue Nachricht senden

Verwenden Sie den folgenden Befehl, um eine neue Nachricht zu senden:

```bash
gcloud pubsub \
    topics publish my-topic --message thanks
```

### Nachrichten erneut abrufen

Rufen Sie die Nachrichten auf folgende Weise ab:

```bash
gcloud pubsub subscriptions \
    pull my-sub
```

Damit sollten die Nachricht `thanks`, die `MESSAGE_ID` und die `ACK_ID` angezeigt werden.
Die `ACK_ID` ist eine weitere ID, die Sie zum Bestätigen der Nachricht verwenden können.

### Nachricht bestätigen

Nachdem Sie eine Nachricht abgerufen haben, müssen Sie den Erhalt innerhalb der **Bestätigungsfrist** bestätigen. Wenn für ein Abo beispielsweise wie in dieser Anleitung eine **Bestätigungsfrist** von 60 Sekunden festgelegt ist, müssen Sie die Nachricht 60 Sekunden nach dem Abruf bestätigen. Andernfalls wird die Nachricht von Cloud Pub/Sub noch einmal gesendet.

Acknowledge the message with the following command (replace the `ACK_ID` with
the real one by copy/paste):

```bash
gcloud pubsub subscriptions ack \
    my-sub --ack-ids ACK_ID
```

## Thema und Abo in der Pub/Sub-Benutzeroberfläche aufrufen

Bevor wir zum Ende der Anleitung für das Befehlszeilentool `gcloud` kommen, sehen wir uns noch die Benutzeroberfläche in der Google Cloud Console an.

Sie finden die Themen und Abos auch im Abschnitt "Pub/Sub".

### Abschnitt "Pub/Sub" aufrufen

[Öffnen Sie das Menü][spotlight-console-menu] links in der Konsole.

Wählen Sie anschließend den Abschnitt **Pub/Sub** aus.

<walkthrough-menu-navigation sectionid="CLOUDPUBSUB_SECTION"></walkthrough-menu-navigation>

Über die Benutzeroberfläche können Sie außerdem Themen und Abos erstellen und verwalten.

### Thema löschen

Klicken Sie das Kästchen neben dem erstellten Thema an und klicken Sie anschließend auf [Löschen][spotlight-delete-button], um das Thema dauerhaft zu löschen.

## Fazit

Glückwunsch!

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Sie sind gerade die grundlegenden Konzepte von Cloud Pub/Sub mit dem Befehlszeilentool `gcloud` durchgegangen und haben einen Überblick über die Benutzeroberfläche von Cloud Pub/Sub erhalten. Im nächsten Schritt erstellen Sie Ihre Anwendungen. Weitere Informationen erhalten Sie in der [Pub/Sub-Dokumentation][pubsub-docs].

Vorschläge für die nächsten Schritte:

[Codebeispiele anzeigen](https://cloud.google.com/pubsub/docs/quickstart-client-libraries)

[pubsub-docs]: https://cloud.google.com/pubsub/docs/
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-delete-button]: walkthrough://spotlight-pointer?cssSelector=.p6n-icon-delete
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
