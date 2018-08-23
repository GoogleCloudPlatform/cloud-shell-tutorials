# Schnellstart für Compute Engine

## To-do-Anwendung mit MongoDB entwickeln

<walkthrough-tutorial-duration duration="15"></walkthrough-tutorial-duration>

Bei diesem Schnellstart verwenden Sie die Compute Engine zur Erstellung einer
zweischichtigen Anwendung. Die Front-End-VM führt eine
Node.js-To-do-Webanwendung aus, und die Back-End-VM MongoDB.

In dieser Anleitung erfahren Sie, wie Sie Folgendes tun können:

*   Zwei VMs erstellen und konfigurieren
*   Firewallregeln einrichten
*   Mit SSH Pakete auf Ihren VMs installieren

## Projekteinrichtung

Auf der Google Cloud Platform werden Ressourcen in Projekten organisiert. Auf
diese Weise können Sie alle für eine einzelne Anwendung relevanten Ressourcen an
einer Stelle erfassen.

<walkthrough-project-billing-setup permissions="compute.instances.create"></walkthrough-project-billing-setup>

## Compute Engine aufrufen

Öffnen Sie das [Menü][spotlight-console-menu] links in der Konsole.

Wählen Sie anschließend den Abschnitt **Compute Engine** aus.

<walkthrough-menu-navigation sectionid="COMPUTE_SECTION"></walkthrough-menu-navigation>

## Instanzen erstellen

Sie erstellen zwei Instanzen als Back-End- und Front-End-Server für die
Anwendung.

### Back-End-Instanz erstellen

Erstellen Sie zuerst die Back-End-Instanz, auf der MongoDB ausgeführt wird. Auf
diesem Server werden die To-do-Listen gespeichert.

Klicken Sie auf [Instanz erstellen][spotlight-create-instance].

*   Wählen Sie einen [Namen][spotlight-instance-name] und eine
    [Zone][spotlight-instance-zone] für diese Instanz aus.

*   Wählen Sie [f1-micro][spotlight-machine-type] aus. Dadurch fallen weniger
    Gebühren an.

    *   [Weitere Informationen zu Preisen][pricing]

*   Wählen Sie für diese Anleitung [Ubuntu 14.04 LTS][spotlight-boot-disk] als
    Bootlaufwerk-Image aus.

*   Wählen Sie in der [Firewallauswahl][spotlight-firewall] die Option
    **HTTP-Traffic zulassen** aus. Dies öffnet Port 80 (HTTP) und erlaubt den
    Zugriff auf die Anwendung.

*   Klicken Sie auf die Schaltfläche ["Erstellen"][spotlight-submit-create], um
    die Instanz zu erstellen.

Hinweis: Nach der Erstellung der Instanz wird Ihr Rechnungskonto gemäß GCE-Tarif
belastet. Sie entfernen die Instanz später, um zusätzliche Kosten zu vermeiden.

### Front-End-Instanz erstellen

Erstellen Sie, während die Back-End-VM hochgefahren wird, die Front-End-Instanz,
auf der die Node.js-To-do-Anwendung ausgeführt wird. Verwenden Sie dieselbe
Konfiguration wie bei der Back-End-Instanz.

## Einrichtung

Sie installieren eine MongoDB-Datenbank auf der Back-End-Instanz, um Ihre Daten
zu speichern.

Mit den [SSH-Schaltflächen][spotlight-ssh-buttons] der Tabelle wird in einem
separaten Fenster eine SSH-Sitzung für Ihre Instanz geöffnet.

Für diese Anleitung verbinden Sie sich mit Google Cloud Shell. Cloud Shell ist
ein integriertes Befehlszeilentool für die Konsole.

### Cloud Shell öffnen

Öffnen Sie Cloud Shell, indem Sie in der Navigationsleiste oben in der Konsole
auf das <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>
[Symbol][spotlight-open-devshell] klicken.

### Warten Sie, bis die Erstellung der Instanz abgeschlossen worden ist

Die Instanzerstellung muss abgeschlossen sein, bevor die Anleitung fortgesetzt
werden kann. Klicken Sie in der Navigationsleiste oben auf das
[Benachrichtigungsmenü][spotlight-notification-menu], um die Aktivität zu
verfolgen.

## Verbindung zu Ihrer Back-End-Instanz herstellen

### Verbindung zur Instanz herstellen

Geben Sie in der VM den folgenden Befehl für SSH ein. Wenn Sie SSH von Cloud
Shell aus zum ersten Mal verwenden, müssen Sie einen privaten Schlüssel
erstellen. Geben Sie die Zone und den Namen der von Ihnen erstellten Instanz
ein.

```bash
gcloud compute --project "{{project-id}}" ssh --zone <backend-zone> <backend-name>
```

### Back-End-Datenbank erstellen

Sie haben eine SSH-Verbindung zur Back-End-Instanz hergestellt. Sie können jetzt
mit den folgenden Befehlen die Back-End-Datenbank installieren:

Pakete werden aktualisiert und MongoDB wird installiert. Geben Sie `Y` ein, wenn
Sie gefragt werden, ob Sie fortfahren möchten.

```bash
sudo apt-get update
```

```bash
sudo apt-get install mongodb
```

### Datenbank ausführen

Der MongoDB-Dienst wurde nach der Installation gestartet. Sie müssen ihn
beenden, bevor Sie Änderungen an der Funktionsweise vornehmen können.

```bash
sudo service mongodb stop
```

Erstellen Sie ein Verzeichnis für MongoDB und führen Sie den MongoDB-Dienst im
Hintergrund auf Port 80 aus.

```bash
sudo mkdir $HOME/db
```

```bash
sudo mongod --dbpath $HOME/db --port 80 --fork --logpath /var/tmp/mongodb
```

Beenden Sie anschließend die SSH-Sitzung mit dem Befehl `exit`:

```bash
exit
```

## Verbindung zu Ihrer Front-End-Instanz herstellen

### Webanwendung auf Front-End-VM installieren und ausführen

Der Back-End-Server wird nun ausgeführt. Installieren Sie jetzt die
Front-End-Webanwendung.

### Verbindung zur Instanz herstellen

Geben Sie in der VM den folgenden Befehl für SSH ein. Geben Sie die Zone und den
Namen der von Ihnen erstellten Instanz ein.

```bash
gcloud compute --project "{{project-id}}" ssh --zone <frontend-zone> <frontend-name>
```

### Abhängigkeiten installieren

Da nun eine Verbindung mit der Front-End-Instanz besteht, aktualisieren Sie
Pakete und installieren Sie git, Node.js und npm. Geben Sie `Y` ein, wenn Sie
gefragt werden, ob Sie fortfahren möchten.

```bash
sudo apt-get update
```

```bash
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
```

```bash
sudo apt-get install git nodejs
```

### Front-End-Webanwendung installieren und ausführen

Duplizieren Sie die Beispielanwendung und installieren Sie
Anwendungsabhängigkeiten.

```bash
git clone https://github.com/GoogleCloudPlatform/todomvc-mongodb.git
```

```bash
cd todomvc-mongodb; npm install
```

```bash
sed -i -e 's/8080/80/g' server.js
```

Starten Sie die To-do-Webanwendung mit dem folgenden Befehl und geben Sie die
[internen IP-Adressen][spotlight-internal-ip] für die von Ihnen erstellten
Instanzen ein.

```bash
sudo nohup nodejs server.js --be_ip <backend-internal-ip> --fe_ip <frontend-internal-ip> &
```

Beenden Sie anschließend die SSH-Sitzung mit dem Befehl `exit`:

```bash
exit
```

### Anwendung ansehen

Rufen Sie Ihren Webserver über die IP-Adresse auf, die in der Spalte
[Externe IP-Adresse][spotlight-external-ip] neben Ihrer Front-End-Instanz
aufgeführt ist.

## Bereinigen

Klicken Sie neben den entsprechenden Instanznamen auf das
[Kontrollkästchen][spotlight-instance-checkbox] und dann auf die
[Schaltfläche "Löschen"][spotlight-delete-button], um Ihre Instanzen zu löschen.

## Fazit

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Fertig!

Vorschläge für die nächsten Schritte:

*   Suchen Sie Google Cloud
    Platform-[Beispiele auf GitHub](http://googlecloudplatform.github.io/).

*   Weitere Informationen zum
    [Einrichten des Lastenausgleichs](https://cloud.google.com/compute/docs/load-balancing/)

*   Weitere Informationen zum
    [Übertragen von Dateien auf Ihre virtuelle Maschine](https://cloud.google.com/compute/docs/instances/transfer-files/)

*   Weitere Informationen zum
    [Ausführen von Containern](https://cloud.google.com/compute/docs/containers)

[pricing]: https://cloud.google.com/compute/#compute-engine-pricing
[spotlight-boot-disk]: walkthrough://spotlight-pointer?cssSelector=vm-set-boot-disk
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-control-panel]: walkthrough://spotlight-pointer?cssSelector=#p6n-action-bar-container-main
[spotlight-create-instance]: walkthrough://spotlight-pointer?spotlightId=gce-zero-new-vm,gce-vm-list-new
[spotlight-delete-button]: walkthrough://spotlight-pointer?cssSelector=.p6n-icon-delete
[spotlight-external-ip]: walkthrough://spotlight-pointer?cssSelector=.p6n-external-link
[spotlight-firewall]: walkthrough://spotlight-pointer?spotlightId=gce-vm-add-firewall
[spotlight-instance-checkbox]: walkthrough://spotlight-pointer?cssSelector=.p6n-checkbox-form-label
[spotlight-instance-name]: walkthrough://spotlight-pointer?spotlightId=gce-vm-add-name
[spotlight-instance-zone]: walkthrough://spotlight-pointer?spotlightId=gce-vm-add-zone-select
[spotlight-internal-ip]: walkthrough://spotlight-pointer?cssSelector=gce-internal-ip
[spotlight-machine-type]: walkthrough://spotlight-pointer?spotlightId=gce-add-machine-type-select
[spotlight-notification-menu]: walkthrough://spotlight-pointer?cssSelector=.p6n-notification-dropdown,.cfc-icon-notifications
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-ssh-buttons]: walkthrough://spotlight-pointer?cssSelector=gce-connect-to-instance
[spotlight-submit-create]: walkthrough://spotlight-pointer?spotlightId=gce-submit
[spotlight-vm-list]: walkthrough://spotlight-pointer?cssSelector=vm2-instance-list%20.p6n-checkboxed-table
