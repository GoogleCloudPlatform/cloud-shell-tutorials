# Verkorte training voor Compute Engine

## Een to-do-app maken met MongoDB

<walkthrough-tutorial-duration duration="15"></walkthrough-tutorial-duration>

In deze snelstartgids maakt u met Compute Engine een app met twee niveaus: een
frontend-VM die de taak-app Node.js uitvoert en een backend-VM die MongoDB
uitvoert.

Met deze training leert u het volgende:

*   Twee VM's maken en configureren
*   Firewallregels instellen
*   SSH gebruiken om pakketten op uw VM's te installeren

## Project instellen

In Google Cloud Platform worden resources ingedeeld in projecten. Zo kunt u alle
gerelateerde resources voor een app op één plek verzamelen.

<walkthrough-project-billing-setup permissions="compute.instances.create"></walkthrough-project-billing-setup>

## Navigeren naar Compute Engine

Open het [menu][spotlight-console-menu] aan de linkerkant van de console.

Selecteer vervolgens het gedeelte **Compute Engine**.

<walkthrough-menu-navigation sectionid="COMPUTE_SECTION"></walkthrough-menu-navigation>

## Instanties maken

U maakt twee instanties die dienen als backend- en frontend-servers voor de app.

### De backend-instantie maken

Maak eerst de backend-instantie waarop MongoDB wordt uitgevoerd. Op deze server
worden de taakitems opgeslagen.

Klik op de knop [Instantie maken][spotlight-create-instance].

*   Selecteer een [naam][spotlight-instance-name] en
    [zone][spotlight-instance-zone] voor deze instantie.

*   Selecteer [f1-micro][spotlight-machine-type]. Dit brengt minder kosten met
    zich mee.

    *   [Meer informatie over de tarieven][pricing]

*   Selecteer [Ubuntu 14.04 LTS][spotlight-boot-disk] als de opstartschijfimage
    voor deze training.

*   Selecteer **HTTP-verkeer toestaan** in de
    [firewall-kiezer][spotlight-firewall]. Hiermee wordt poort 80 (HTTP) geopend
    voor toegang tot de app.

*   Klik op de knop [Maken][spotlight-submit-create] om de instantie te maken.

Opmerking: Wanneer de instantie is gemaakt, worden kosten in rekening gebracht
bij uw factureringsaccount volgens de prijzen voor GCE. U verwijdert de
instantie later om extra kosten te voorkomen.

### De frontend-instantie maken

Terwijl de backend-VM al draait, maakt u de frontend-VM waarop de taak-app
Node.js wordt uitgevoerd. Gebruik dezelfde configuratie als voor de
backend-instantie.

## Instellen

U installeert een MongoDB-database op de backend-instantie om uw gegevens op te
slaan.

De [SSH-knoppen][spotlight-ssh-buttons] in de tabel openen een SSH-sessie voor
uw instantie in een afzonderlijk venster.

Voor deze training maakt u verbinding via Cloud Shell. Cloud Shell is een
ingebouwde opdrachtregeltool voor de console.

### Cloud Shell openen

Open Cloud Shell door in de navigatiebalk bovenaan de console op het
<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[pictogram][spotlight-open-devshell]
te klikken.

### Wacht tot de instantie is gemaakt

De instanties moeten zijn gemaakt voordat u kunt verdergaan met de training. De
activiteit kan worden gevolgd door op het
[meldingenmenu][spotlight-notification-menu] te klikken in de navigatiebalk
bovenaan.

## Verbinding maken met uw backend-instantie

### Verbinding maken met de instantie

Voer de volgende opdracht voor SSH in de VM in. Als dit de eerste keer is dat u
SSH vanaf Cloud Shell gebruikt, moet u een privésleutel maken. Voer de zone en
naam in van de instantie die u heeft gemaakt.

```bash
gcloud compute --project "{{project-id}}" ssh --zone <backend-zone> <backend-name>
```

### De backend-database installeren

Nu u een SSH-verbinding met de backend-instantie heeft, gebruikt u de volgende
opdrachten om de backend-database te installeren:

Update de pakketten en installeer MongoDB. Wanneer u wordt gevraagd of u wilt
doorgaan, typt u `Y`:

```bash
sudo apt-get update
```

```bash
sudo apt-get install mongodb
```

### De database uitvoeren

De MongoDB-service is gestart toen u deze installeerde. U moet de service
stoppen, zodat u de uitvoering ervan kunt wijzigen.

```bash
sudo service mongodb stop
```

Maak een directory voor MongoDB en voer vervolgens de MongoDB-service op de
achtergrond uit via poort 80.

```bash
sudo mkdir $HOME/db
```

```bash
sudo mongod --dbpath $HOME/db --port 80 --fork --logpath /var/tmp/mongodb
```

Sluit na afloop de SSH-sessie af met de opdracht `exit`:

```bash
exit
```

## Verbinding maken met uw frontend-instantie

### De web-app installeren en uitvoeren op uw frontend-VM

De backend-server is actief, dus nu is het tijd om de frontend-web-app te
installeren.

### Verbinding maken met de instantie

Voer de volgende opdracht voor SSH in de VM in. Voer de zone en naam in van de
instantie die u heeft gemaakt.

```bash
gcloud compute --project "{{project-id}}" ssh --zone <frontend-zone> <frontend-name>
```

### De afhankelijkheden installeren

Nu u verbonden bent met uw frontend-instantie, update u de pakketten en
installeert u git, Node.js en npm. Wanneer u wordt gevraagd of u wilt doorgaan,
typt u `Y`:

```bash
sudo apt-get update
```

```bash
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
```

```bash
sudo apt-get install git nodejs
```

### De frontend-web-app installeren en uitvoeren

Kloon de voorbeeld-app en installeer de app-afhankelijkheden.

```bash
git clone https://github.com/GoogleCloudPlatform/todomvc-mongodb.git
```

```bash
cd todomvc-mongodb; npm install
```

```bash
sed -i -e 's/8080/80/g' server.js
```

Start de taak-web-app met de volgende opdracht, waarbij u de
[interne IP-adressen][spotlight-internal-ip] invoert voor de instanties die u
heeft gemaakt.

```bash
sudo nohup nodejs server.js --be_ip <backend-internal-ip> --fe_ip <frontend-internal-ip> &
```

Sluit na afloop de SSH-sessie af met de opdracht `exit`:

```bash
exit
```

### Uw app bekijken

Ga naar uw webserver op het IP-adres in de kolom
[Externe IP][spotlight-external-ip] naast uw frontend-instantie.

## Opschonen

Als u uw instanties wilt verwijderen, vinkt u het
[selectievakje][spotlight-instance-checkbox] naast de naam van uw instantie aan
en klikt u op de knop [Verwijderen][spotlight-delete-button].

## Conclusie

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

U bent klaar.

U kunt nu het volgende doen:

*   Voorbeelden van Google Cloud Platform
    [op GitHub zoeken](http://googlecloudplatform.github.io/).

*   Leren hoe u
    [load balancing](https://cloud.google.com/compute/docs/load-balancing/)
    instelt.

*   Leren hoe u
    [bestanden overzet naar uw virtuele machine](https://cloud.google.com/compute/docs/instances/transfer-files/).

*   Leren hoe u
    [containers kunt uitvoeren](https://cloud.google.com/compute/docs/containers).

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
