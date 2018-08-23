# Inleiding tot Cloud IoT Core

<walkthrough-tutorial-url url="https://cloud.google.com/iot/docs/quickstart"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="https://github.com/GoogleCloudPlatform/nodejs-docs-samples.git" key="repo-url"></walkthrough-watcher-constant>

## Inleiding

Google Cloud Internet of Things (IoT) Core is een volledig beheerde service voor het veilig verbinden en beheren van IoT-apparaten, of het nu gaat om enkele of miljoenen. In deze training leert u hoe u de opdrachtregeltool `gcloud` gebruikt om een Cloud IoT Core-apparaatregister te maken en een apparaat toe te voegen. Ook wordt beschreven hoe een MQTT-voorbeeld moet worden uitgevoerd om een apparaat te verbinden en telemetriegebeurtenissen ervan te publiceren.

Met deze training leert u het volgende:

  *  Een Cloud Pub/Sub-onderwerp maken
  *  Een apparaatregister maken
  *  Een apparaat aan het register toevoegen
  *  Inloggegevens voor het apparaat instellen
  *  Een abonnement op het Pub/Sub-onderwerp maken om berichten te verzenden en te ontvangen
  *  Een virtueel apparaat verbinden en telemetriegegevens bekijken

## Project instellen

In Google Cloud Platform worden resources ingedeeld in projecten. Zo kunt u alle gerelateerde resources voor een app op één plek verzamelen.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## Google Cloud Shell gebruiken

Tijdens deze training werkt u in de Cloud Shell.

### Google Cloud Shell openen

Open Cloud Shell door in de navigatiebalk bovenaan de console op het <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[pictogram][spotlight-open-devshell] te klikken.

### Google Cloud API's inschakelen

Hierdoor wordt de Cloud IoT Core API ingeschakeld.

<walkthrough-enable-apis apis="cloudiot.googleapis.com"></walkthrough-enable-apis>

## Uw eerste onderwerp maken

Een onderwerp is een benoemde resource waarnaar apparaten berichten verzenden. Maak je eerste onderwerp met de volgende opdracht:

```bash
gcloud pubsub topics create my-topic
```

Later gaat u verschillende berichten naar dit onderwerp verzenden.

## De Node.js-voorbeeldbestanden voor Cloud IoT Core uit GitHub klonen

U gebruikt het MQTT-voorbeeld om berichten naar Cloud IoT Core te verzenden.

Opmerking: Als de map al bestaat, verwijdert u de eerdere bestanden voordat u gaat klonen:

```bash
rm -rf nodejs-docs-samples
```

Gebruik de volgende opdracht om het voorbeeldprogramma te klonen:

```bash
git clone {{repo-url}}
```

## Machtiging verlenen aan het Cloud IoT Core-serviceaccount

Gebruik het hulpscript in de map `/iot/scripts` om het serviceaccount `cloud-iot@system.gserviceaccount.com` toe te voegen aan het Cloud Pub/Sub-onderwerp met de rol Uitgever.

### Navigeer naar de map 'iot':

```bash
cd nodejs-docs-samples/iot
```

### Installeer afhankelijkheden:

```bash
npm --prefix ./scripts install
```

### Voer het hulpscript uit:

```bash
node scripts/iam.js my-topic
```

Met het script wordt het Cloud IoT Core-serviceaccount gemachtigd voor het onderwerp `my-topic`.

## Een apparaatregister maken

Een apparaatregister bevat apparaten en definieert eigenschappen die door alle apparaten in het register worden gedeeld. Maak uw apparaatregister met de volgende opdracht:

```bash
gcloud iot registries create my-registry \
    --project={{project-id}} \
    --region=us-central1 \
    --event-notification-config=topic=projects/{{project-id}}/topics/my-topic
```

## Uw ondertekeningssleutels genereren

Voor verificatie bij Cloud IoT Core heeft een apparaat een privésleutel en een openbare sleutel nodig. Gebruik de volgende opdracht om uw ondertekeningssleutels te genereren:

```bash
./scripts/generate_keys.sh
```

Met dit script worden RS256- en ES256-sleutels in de PEM-indeling gemaakt, maar u heeft alleen de RS256-sleutels nodig voor deze training. De privésleutel moet veilig worden opgeslagen op het apparaat en wordt gebruikt om de verificatie-JWT ([JSON Web Token][web-token-docs]) te ondertekenen. De openbare sleutel wordt opgeslagen in het apparaatregister.

## Een apparaat maken en aan het register toevoegen

Voer de volgende opdracht uit om een apparaat te maken en aan het register toe te voegen:

```bash
gcloud iot devices create my-node-device \
    --project={{project-id}} \
    --region=us-central1 \
    --registry=my-registry \
    --public-key path=rsa_cert.pem,type=rs256
```

## Uw apparaat verbinden en telemetriegegevens bekijken

In deze stap verzendt u berichten van een virtueel apparaat naar Pub/Sub. Vervolgens haalt u de berichten op en bekijkt u ze.

### Navigeer naar de MQTT-voorbeeldmap:

```bash
cd mqtt_example
```

### Installeer de Node.js-afhankelijkheden:

```bash
npm install
```

### Voer de volgende opdracht uit om een virtueel apparaat te verbinden met Cloud IoT Core met behulp van de MQTT-brug:

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

De uitvoer laat zien dat het virtuele apparaat berichten publiceert naar het telemetrieonderwerp. Er worden vijfentwintig berichten gepubliceerd.

## Een abonnement op het onderwerp van het apparaat maken

Voer de volgende opdracht uit om een abonnement te maken, waarmee u de berichten kunt bekijken die door uw apparaat zijn gepubliceerd:

```bash
gcloud pubsub subscriptions create \ projects/{{project-id}}/subscriptions/my-subscription \ --topic=my-topic
```

## Gepubliceerde berichten ophalen

Gebruik de volgende opdracht om de berichten op te halen die door het apparaat zijn gepubliceerd:

```bash
gcloud pubsub subscriptions pull --auto-ack \ projects/{{project-id}}/subscriptions/my-subscription
```

Als u deze opdracht uitvoert, worden de berichten geretourneerd die door het apparaat zijn gepubliceerd. De berichten bevatten de volgende gegevens: `my-registry/my-node-device-payload-&lt;INTEGER&gt;`, een `MESSAGE_ID` en een `ATTRIBUTES`-lijst met informatie over het apparaat. De `MESSAGE_ID` is een unieke ID die door de server is toegewezen.

Opmerking: Cloud Pub/Sub kan niet garanderen dat berichten in de juiste volgorde worden afgeleverd. Het is ook mogelijk dat er maar één bericht wordt weergegeven in Cloud Shell. Voer in dat geval de opdracht meerdere malen uit, totdat ook de andere berichten worden weergegeven.

## Resources in de Google Cloud Platform-console bekijken

U bent hiermee aan het einde gekomen van de training voor de `gcloud`-opdrachtregel, maar u kunt ook de GCP-console gebruiken om de resources te bekijken die u zojuist heeft gemaakt.

Open het [menu][spotlight-console-menu] aan de linkerkant van de console.

Selecteer vervolgens **IoT Core**.

<walkthrough-menu-navigation sectionid="IOT_SECTION"></walkthrough-menu-navigation>

Met de gebruikersinterface kunt u ook apparaatregisters en apparaten maken en beheren.

## Conclusie

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Gefeliciteerd U heeft zojuist kennisgemaakt met de basisbeginselen van Cloud IoT Core met behulp van de `gcloud`-opdrachtregeltool en u heeft de GCP-console gebruikt om Cloud IoT Core-resources te bekijken. De volgende stap is om geweldige apps te maken. Zie de [documentatie van IoT Core](https://cloud.google.com/iot/docs/) voor meer informatie.

### U kunt nu het volgende doen:

Meer Cloud IoT Core-voorbeelden op GitHub bekijken:

  *  [C](https://github.com/GoogleCloudPlatform/cpp-docs-samples/tree/master/iot/mqtt-ciotc)
  *  [Java](https://github.com/GoogleCloudPlatform/java-docs-samples/tree/master/iot/api-client)
  *  [Node.js](https://github.com/GoogleCloudPlatform/nodejs-docs-samples/tree/master/iot)
  *  [Python](https://github.com/GoogleCloudPlatform/python-docs-samples/tree/master/iot/api-client)

[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[web-token-docs]: https://cloud.google.com/iot/docs/how-tos/credentials/jwts
