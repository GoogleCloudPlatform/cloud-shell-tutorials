# Introduzione a Cloud IoT Core

<walkthrough-tutorial-url url="https://cloud.google.com/iot/docs/quickstart"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="https://github.com/GoogleCloudPlatform/nodejs-docs-samples.git" key="repo-url"></walkthrough-watcher-constant>

## Presentazione

Google Cloud Internet of Things (IoT) Core è un servizio completamente gestito per connettere e gestire in sicurezza da pochi a milioni di dispositivi IoT. Questo tutorial mostra come utilizzare lo strumento a riga di comando `gcloud` per creare un registro dispositivi Cloud IoT Core e aggiungere un dispositivo. Mostra inoltre come eseguire un'applicazione di esempio MQTT per connettere un dispositivo e pubblicare eventi di telemetria del dispositivo.

Questo tutorial ti guiderà attraverso i seguenti processi:

  *  Creazione di un argomento Cloud Pub/Sub
  *  Creazione di un registro dispositivi
  *  Aggiunta di un dispositivo al registro
  *  Impostazione delle credenziali sul dispositivo
  *  Creazione di una sottoscrizione all'argomento Pub/Sub per inviare e ricevere messaggi
  *  Collegamento di un dispositivo virtuale e visualizzazione dei dati di telemetria

## Configurazione del progetto

Google Cloud Platform organizza le risorse in progetti. Ciò consente di raccogliere tutte le risorse correlate per una singola applicazione in una sola posizione.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## Utilizzare Google Cloud Shell

In questo tutorial, tutto il lavoro verrà svolto in Cloud Shell.

### Apri Google Cloud Shell

Apri Cloud Shell facendo clic sull'[icona][spotlight-open-devshell] 
<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>
nella barra di navigazione nella parte superiore della console.

### Abilita le API di Google Cloud

Questa operazione abiliterà l'API Cloud IoT Core.

<walkthrough-enable-apis apis="cloudiot.googleapis.com"></walkthrough-enable-apis>

## Crea il tuo primo argomento

Un argomento è una risorsa denominata a cui i dispositivi inviano messaggi. Crea il tuo primo argomento con il seguente comando:

```bash
gcloud pubsub topics create my-topic
```

In seguito invierai diversi messaggi a questo argomento.

## Clona i file di esempio Node.js di Cloud IoT Core da GitHub

Utilizzerai l'applicazione di esempio MQTT per inviare messaggi a Cloud IoT Core.

Nota: se la directory esiste già, rimuovi i file creati in precedenza prima di eseguire la clonazione:

```bash
rm -rf nodejs-docs-samples
```

Clona il programma di esempio con il seguente comando:

```bash
git clone {{repo-url}}
```

## Concedi l'autorizzazione all'account di servizio Cloud IoT Core

Tramite lo script di supporto situato nella cartella `/iot/scripts`, aggiungi l'account di servizio
`cloud-iot@system.gserviceaccount.com` all'argomento Cloud Pub/Sub con il ruolo Publisher.

### Passa alla directory iot:

```bash
cd nodejs-docs-samples/iot
```

### Installa le dipendenze:

```bash
npm --prefix ./scripts install
```

### Esegui lo script di supporto:

```bash
node scripts/iam.js my-topic
```

Lo script concede l'autorizzazione all'account di servizio Cloud IoT Core sull'argomento
`my-topic`.

## Crea un registro dispositivi

Un registro dispositivi contiene i dispositivi e definisce le proprietà condivise da tutti i dispositivi inclusi. Crea il tuo registro dispositivi con il seguente comando:

```bash
gcloud iot registries create my-registry \
    --project={{project-id}} \
    --region=us-central1 \
    --event-notification-config=topic=projects/{{project-id}}/topics/my-topic
```

## Genera le tue chiavi di firma

Per autenticarsi su Cloud IoT Core, un dispositivo deve disporre di una chiave privata e una chiave pubblica. Genera le tue chiavi di firma eseguendo il comando sotto:

```bash
./scripts/generate_keys.sh
```

Questo script crea chiavi RS256 ed ES256 in formato PEM, ma per questo tutorial sono necessarie solo le
chiavi RS256. La chiave privata deve essere memorizzata in modo sicuro sul dispositivo e viene utilizzata per firmare il JWT ([JSON Web Token][web-token-docs]) di autenticazione. La chiave pubblica è memorizzata nel registro dispositivi.

## Crea un dispositivo e aggiungilo al registro

Esegui il comando seguente per creare un dispositivo e aggiungerlo al registro:

```bash
gcloud iot devices create my-node-device \
    --project={{project-id}} \
    --region=us-central1 \
    --registry=my-registry \
    --public-key path=rsa_cert.pem,type=rs256
```

## Collega il dispositivo e visualizza i dati di telemetria

In questo passaggio, invierai messaggi da un dispositivo virtuale a Pub/Sub. Quindi, eseguirai il pull dei messaggi e li visualizzerai.

### Passa alla directory di esempio MQTT:

```bash
cd mqtt_example
```

### Installa le dipendenze Node.js:

```bash
npm install
```

### Esegui il comando sotto per connettere un dispositivo virtuale a Cloud IoT Core utilizzando il bridge MQTT:

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

L'output mostra che il dispositivo virtuale pubblica messaggi sull'argomento di telemetria. Vengono pubblicati venticinque messaggi.

## Crea una sottoscrizione all'argomento del dispositivo

Esegui il comando sotto per creare una sottoscrizione che consenta di visualizzare i messaggi pubblicati dal dispositivo:

```bash
gcloud pubsub subscriptions create \
    projects/{{project-id}}/subscriptions/my-subscription \
    --topic=my-topic
```

## Esegui il pull dei messaggi pubblicati

Esegui il pull dei messaggi pubblicati dal dispositivo con il seguente comando:

```bash
gcloud pubsub subscriptions pull --auto-ack \
    projects/{{project-id}}/subscriptions/my-subscription
```

L'esecuzione di questo comando restituisce i messaggi pubblicati dal dispositivo. I messaggi contengono i seguenti dati, `my-registry/my-node-device-payload-&lt;INTEGER&gt;`, `MESSAGE_ID` e un elenco `ATTRIBUTES` di informazioni relative al dispositivo. `MESSAGE_ID` è un ID univoco assegnato dal server.

Nota: Cloud Pub/Sub non garantisce l'ordine dei messaggi. È possibile anche che venga visualizzato un solo messaggio in Cloud Shell. In questo caso, prova a eseguire lo stesso comando più volte fino a visualizzare gli altri messaggi.

## Visualizza le risorse nella console di Google Cloud Platform

Prima di concludere il tutorial sulla riga di comando `gcloud`, puoi anche utilizzare la console di GCP per visualizzare le risorse appena create.

Apri il [menu][spotlight-console-menu] sul lato sinistro della console.

Seleziona quindi **IoT Core**.

<walkthrough-menu-navigation sectionid="IOT_SECTION"></walkthrough-menu-navigation>

L'interfaccia utente consente anche di creare e gestire registri dispositivi e dispositivi.

## Conclusione

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Complimenti! Hai appreso i concetti di base di Cloud IoT Core utilizzando lo strumento a riga di comando `gcloud` e hai usato la console di GCP per visualizzare le risorse Cloud IoT Core. Il passo successivo prevede la creazione di fantastiche applicazioni. Per ulteriori informazioni, consulta la [documentazione di IoT Core](https://cloud.google.com/iot/docs/).

### Ecco cosa puoi fare successivamente

Visualizza altri esempi di Cloud IoT Core su GitHub:

  *  [C](https://github.com/GoogleCloudPlatform/cpp-docs-samples/tree/master/iot/mqtt-ciotc)
  *  [Java](https://github.com/GoogleCloudPlatform/java-docs-samples/tree/master/iot/api-client)
  *  [Node.js](https://github.com/GoogleCloudPlatform/nodejs-docs-samples/tree/master/iot)
  *  [Python](https://github.com/GoogleCloudPlatform/python-docs-samples/tree/master/iot/api-client)

[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[web-token-docs]: https://cloud.google.com/iot/docs/how-tos/credentials/jwts
