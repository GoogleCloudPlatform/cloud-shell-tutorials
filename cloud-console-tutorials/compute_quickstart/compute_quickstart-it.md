# Guida di avvio rapido di Compute Engine

## Creazione di un'app di promemoria con MongoDB

<walkthrough-tutorial-duration duration="15"></walkthrough-tutorial-duration>

In questa guida di avvio rapido, utilizzerai Compute Engine per creare
un'applicazione a due livelli. La VM di frontend esegue un'app web di promemoria
Node.js, mentre la VM di backend esegue MongoDB.

Questo tutorial ti guiderà attraverso i seguenti processi:

*   Creazione e configurazione di due VM
*   Impostazione delle regole firewall
*   Installazione di pacchetti nelle VM mediante SSH

## Configurazione del progetto

Google Cloud Platform organizza le risorse in progetti. Ciò consente di
raccogliere tutte le risorse correlate per una singola applicazione in una sola
posizione.

<walkthrough-project-billing-setup permissions="compute.instances.create"></walkthrough-project-billing-setup>

## Accesso a Compute Engine

Apri il [menu][spotlight-console-menu] sul lato sinistro della console.

Quindi, seleziona la sezione **Compute Engine**.

<walkthrough-menu-navigation sectionid="COMPUTE_SECTION"></walkthrough-menu-navigation>

## Creazione delle istanze

Crea due istanze che serviranno da server di backend e frontend per
l'applicazione.

### Crea l'istanza di backend

Crea anzitutto l'istanza di backend che esegue MongoDB. Questo server archivia
gli elementi di promemoria.

Fai clic sul pulsante [Crea istanza][spotlight-create-instance].

*   Seleziona un [nome][spotlight-instance-name] e una
    [zona][spotlight-instance-zone] per questa istanza.

*   Seleziona [f1-micro][spotlight-machine-type]. Questa selezione comporterà
    minori addebiti.

    *   [Ulteriori informazioni sui prezzi][pricing]

*   Seleziona [Ubuntu 14.04 LTS][spotlight-boot-disk] come immagine disco di
    avvio per questo tutorial.

*   Nel [Selettore firewall][spotlight-firewall], seleziona **Consenti traffico
    HTTP**. Questa azione apre la porta 80 (HTTP) per accedere all'app.

*   Fai clic sul pulsante [Crea][spotlight-submit-create] per creare l'istanza.

Nota: una volta creata l'istanza, sul tuo account di fatturazione inizieranno a
essere addebitati i costi in base ai prezzi stabiliti per GCE. Potrai rimuovere
l'istanza in un secondo momento per evitare costi aggiuntivi.

### Crea l'istanza di frontend

Mentre la VM di backend è in avvio, crea la VM di frontend che esegue
l'applicazione di promemoria Node.js. Utilizza la stessa configurazione
dell'istanza di backend.

## Configurazione

Installa un database MongoDB sull'istanza di backend per salvare i tuoi dati.

I [pulsanti SSH][spotlight-ssh-buttons] nella tabella consentono di aprire una
sessione SSH per l'istanza in una finestra separata.

Per questo tutorial, connettiti utilizzando Cloud Shell. Cloud Shell è uno
strumento a riga di comando integrato per la console.

### Apri Cloud Shell

Apri Cloud Shell facendo clic
<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>
sull'[icona][spotlight-open-devshell] nella barra di navigazione nella parte
superiore della console.

### Attendi il completamento della creazione dell'istanza

La creazione delle istanze deve essere completata prima che il tutorial possa
procedere. L'attività può essere monitorata facendo clic sul
[menu di notifica][spotlight-notification-menu] nella barra di navigazione in
alto.

## Connessione all'istanza di backend

### Connettiti all'istanza

Inserisci il seguente comando per SSH nella VM. Se è la prima volta che utilizzi
SSH da Cloud Shell, devi creare una chiave privata. Inserisci il nome e la zona
dell'istanza che hai creato.

```bash
gcloud compute --project "{{project-id}}" ssh --zone <backend-zone> <backend-name>
```

### Installa il database di backend

Una volta stabilita la connessione SSH all'istanza di backend, utilizza i
seguenti comandi per installare il database di backend.

Aggiorna i pacchetti e installa MongoDB. Quando ti viene chiesto se vuoi
continuare, digita `Y`:

```bash
sudo apt-get update
```

```bash
sudo apt-get install mongodb
```

### Esegui il database

Una volta installato, il servizio MongoDB è stato avviato. Per modificare il
modo in cui viene eseguito, devi arrestarlo.

```bash
sudo service mongodb stop
```

Crea una directory per MongoDB ed esegui il servizio MongoDB in background sulla
porta 80.

```bash
sudo mkdir $HOME/db
```

```bash
sudo mongod --dbpath $HOME/db --port 80 --fork --logpath /var/tmp/mongodb
```

Successivamente, chiudi la sessione SSH utilizzando il comando `exit`:

```bash
exit
```

## Connessione all'istanza di frontend

### Installa ed esegui l'applicazione web sulla VM frontend

Il server backend è in esecuzione, quindi è il momento di installare
l'applicazione web di frontend.

### Connettiti all'istanza

Immetti il seguente comando per SSH nella VM. Inserisci la zona e il nome
dell'istanza che hai creato.

```bash
gcloud compute --project "{{project-id}}" ssh --zone <frontend-zone> <frontend-name>
```

### Installa le dipendenze

Ora che la connessione all'istanza di frontend è stata stabilita, aggiorna i
pacchetti e installa git, Node.js e npm. Quando ti viene chiesto se vuoi
continuare, digita `Y`:

```bash
sudo apt-get update
```

```bash
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
```

```bash
sudo apt-get install git nodejs
```

### Installa ed esegui l'applicazione web frontend

Clona l'applicazione di esempio e installa le dipendenze dell'applicazione.

```bash
git clone https://github.com/GoogleCloudPlatform/todomvc-mongodb.git
```

```bash
cd todomvc-mongodb; npm install
```

```bash
sed -i -e 's/8080/80/g' server.js
```

Avvia l'applicazione web di promemoria con il seguente comando, inserendo gli
[indirizzi IP interni][spotlight-internal-ip] per le istanze che hai creato.

```bash
sudo nohup nodejs server.js --be_ip <backend-internal-ip> --fe_ip <frontend-internal-ip> &
```

Successivamente, chiudi la sessione SSH utilizzando il comando `exit`:

```bash
exit
```

### Visita la tua applicazione

Visita il server web all'indirizzo IP indicato nella colonna
[IP esterno][spotlight-external-ip] accanto alla tua istanza di frontend.

## Pulizia

Per rimuovere le tue istanze, seleziona la
[casella di controllo][spotlight-instance-checkbox] accanto ai nomi delle
istanze e fai clic sul [pulsante Elimina][spotlight-delete-button].

## Conclusione

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

È tutto.

Ecco cosa puoi fare successivamente:

*   Trova esempi di Google Cloud Platform
    [su GitHub](http://googlecloudplatform.github.io/).

*   Scopri come impostare il
    [bilanciamento del carico](https://cloud.google.com/compute/docs/load-balancing/).

*   Scopri come
    [trasferire i file nella tua macchina virtuale](https://cloud.google.com/compute/docs/instances/transfer-files/).

*   Scopri come
    [eseguire i container](https://cloud.google.com/compute/docs/containers).

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
