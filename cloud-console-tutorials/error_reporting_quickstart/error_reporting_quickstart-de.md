# Stackdriver Error Reporting

## Einführung

In Stackdriver Error Reporting werden Fehler von Clouddiensten zusammengefasst und angezeigt.

In dieser Anleitung können Sie sich mit der Webbenutzeroberfläche von Error Reporting vertraut machen. Sie erfahren, wie Sie Ihre Anwendungsfehler auflisten, nähere Informationen erhalten und entsprechende Maßnahmen ergreifen können.

## Projekt einrichten

<walkthrough-project-setup></walkthrough-project-setup>

## Fehler generieren

Bevor Sie fortfahren, müssen Sie künstliche Fehler melden. Sie verwenden hierfür einen `gcloud`-Befehl.

In einem echten Szenario würden diese Fehler direkt von Ihrer laufenden Anwendung gemeldet werden. Im Anschluss an diese Anleitung können Sie sich mit dem Einrichten von Error Reporting vertraut machen.

### Google Cloud Shell öffnen

Öffnen Sie Cloud Shell, indem Sie oben in der Navigationsleiste der Konsole auf das<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon> [Symbol][spotlight-open-devshell] klicken.

### Einige Fehler melden

Klicken Sie im folgenden Skript oben rechts auf die Schaltfläche **In Zwischenablage kopieren**. Führen Sie das Skript anschließend in Cloud Shell aus, um Beispielfehler zu generieren.

```bash
COUNTER=0
while [  $COUNTER -lt 11 ]; do
    gcloud beta error-reporting events report --service tutorial --service-version v$((COUNTER/10+1)) \
        --message "java.lang.RuntimeException: Error rendering template $COUNTER
          at com.example.TestClass.test(TestClass.java:51)
          at com.example.AnotherClass(AnotherClass.java:25)
          at javax.servlet.http.HttpServlet.service (HttpServlet.java:617)
          at javax.servlet.http.HttpServlet.service (HttpServlet.java:717)"
    if [ $COUNTER -lt 3 ]; then
      gcloud beta error-reporting events report --service tutorial --service-version v1 \
          --message "java.lang.ArrayIndexOutOfBoundsException: $COUNTER
            at com.example.AppController.createUser(AppController.java:42)
            at com.example.User(User.java:31)
            at javax.servlet.http.HttpServlet.service (HttpServlet.java:617)
            at javax.servlet.http.HttpServlet.service (HttpServlet.java:717)"
    fi
    if [ $COUNTER -eq 10 ]; then
      echo "All artificial errors reported."
    fi
    let COUNTER=COUNTER+1
done
```

### Cloud Shell schließen

Schließen Sie Cloud Shell und klicken Sie dann auf *Weiter*.

## Anwendungsfehler auflisten

Mit Stackdriver Error Reporting können Sie einen Überblick der gemeldeten Fehler anzeigen.

### Error Reporting öffnen

[Öffnen Sie das Menü][spotlight-console-menu] links in der Konsole.

Gehen Sie zur Kategorie **Stackdriver** und wählen Sie **Error Reporting** aus.

<walkthrough-menu-navigation sectionid="CRASH_SECTION"></walkthrough-menu-navigation>

### Nach *Zuerst erfasst* sortieren

In Ihrer Anwendung auftretende Fehler werden in Gruppen zusammengefasst und durch die Analyse der Stacktraces dedupliziert. Jeder Eintrag in der Liste enthält eine Zusammenfassung, anhand derer Sie feststellen können, wann der Fehler zuerst und zuletzt in der Anwendung aufgetreten ist und wie oft er aufgetreten ist.

Standardmäßig wird die Liste nach *Häufigkeit* sortiert. Klicken Sie auf die Spaltenüberschrift *Zuerst erfasst*, um die Fehler zu sehen, die erst seit Kurzem auftreten.

### Benachrichtigungen zu neuen Fehlern aktivieren

Wenn in Ihrem Projekt ein neuer Fehler auftritt, kann eine E-Mail und für Mobilgeräte eine Push-Benachrichtigung gesendet werden. Um diese Benachrichtigungen zu aktivieren, klicken Sie auf *Benachrichtigungen aktivieren*.

Klicken Sie anschließend auf *Fortfahren*.

## Fehlerdetails verstehen

### Fehlerbericht öffnen

Klicken Sie auf einen Fehler in der Liste, um die zugehörigen Details aufzurufen.

### Problem mit diesem Fehler verknüpfen

Auf dieser Seite beschäftigen Sie sich mit den Informationen und dem Verlauf eines bestimmten Fehlers.

Nach der Überprüfung eines neuen Fehlers wird häufig ein Problemfall in der Problemverfolgung Ihres Teams angelegt. Anschließend können Sie den Eintrag in der Problemverfolgung mit dem Fehler in Stackdriver Error Reporting verknüpfen.

Anleitung:

  *  Klicken Sie oben im Bildschirm auf *Mit Problem verknüpfen*. Sie müssen gegebenenfalls das Menü **Weitere Aktionen** öffnen, um diesen Link zu sehen.
  *  Geben Sie in das Dialogfeld `http://example.com/issues/1234` ein.
  *  Klicken Sie auf *Speichern*.

### Stacktraces analysieren

Damit Sie sich auf Ihren Code konzentrieren können, blenden wir die Frames für Stacktraces aus, die nicht aus Ihrem Anwendungscode stammen.

Klicken Sie in einem Fehlerbeispiel auf *Alle anzeigen*, um die Frames für Framework-Stapel anzuzeigen.

## Fazit

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Glückwunsch! Sie haben die Anleitung zu Stackdriver Error Reporting erfolgreich abgeschlossen.

Vorschläge für die nächsten Schritte:

### Error Reporting für Ihr Projekt einrichten

Erfahren Sie in der [Dokumentation zur Einrichtung][errors-setup], wie Sie Error Reporting für Ihre laufenden Dienste einrichten.

### Weitere Stackdriver-Anleitungen durchgehen

Beheben Sie Fehler in einer Produktionsanwendung mit dem [Schnellstart für Stackdriver Debugger][debug-quickstart].

Erfahren Sie im [Schnellstart für Stackdriver Trace][trace-quickstart] mehr über die Latenz Ihrer Anwendung.

[debug-quickstart]: https://cloud.google.com/debugger/docs/quickstart
[errors-setup]: https://cloud.google.com/error-reporting/docs/how-to
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[trace-quickstart]: https://cloud.google.com/trace/docs/quickstart
