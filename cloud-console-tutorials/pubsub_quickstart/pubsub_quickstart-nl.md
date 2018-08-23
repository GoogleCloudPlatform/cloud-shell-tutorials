# Inleiding tot Cloud Pub/Sub

<walkthrough-tutorial-url url="https://cloud.google.com/pubsub/quickstart-console"></walkthrough-tutorial-url></walkthrough-test-start-page>

<walkthrough-devshell-precreate></walkthrough-devshell-precreate>

## Inleiding

Cloud Pub/Sub is een volledig beheerde realtime service voor berichten, die u in staat stelt om berichten te verzenden en ontvangen tussen onafhankelijke apps. In deze training wordt kort beschreven hoe u de opdrachtregelinterface van Cloud Pub/Sub gebruikt met de opdracht `gcloud`.

## Project instellen

In Google Cloud Platform worden resources ingedeeld in projecten. Zo kunt u alle gerelateerde resources voor een app op één plek verzamelen.

Cloud Pub/Sub heeft een project nodig om berichten op te stellen.

<walkthrough-project-setup></walkthrough-project-setup>

## Uw eerste onderwerp maken

### Google Cloud Shell openen

Cloud Shell is een ingebouwde opdrachtregeltool voor de console. U gaat Cloud Shell gebruiken om Cloud Pub/Sub in te stellen.

Open Cloud Shell door in de navigatiebalk bovenaan de console op het <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[pictogram][spotlight-open-devshell] te klikken.

### Een onderwerp maken

Een onderwerp is een benoemde resource waarnaar u berichten kunt verzenden. Maak uw eerste onderwerp met de volgende opdracht:

```bash
gcloud pubsub topics create my-topic
```

## Een abonnement toevoegen

Als u berichten wilt ontvangen, moet u eerst abonnementen maken. Een abonnement moet een bijbehorend onderwerp hebben. Gebruik de volgende opdracht om uw eerste abonnement te maken:

```bash
gcloud pubsub subscriptions \ create my-sub --topic my-topic \ --ack-deadline=60
```

Met deze opdracht maakt u een abonnement, genaamd `my-sub`, dat is gekoppeld aan het onderwerp `my-topic`. Alle berichten die naar `my-topic` worden gepubliceerd, worden aan dit abonnement geleverd.

Mogelijk is u de optie `--ack-deadline=60` opgevallen. `ack-deadline` staat voor `bevestigingsdeadline`. Dit nieuwe abonnement heeft een `bevestigingsdeadline` van 60 seconden. We leggen dit straks nader uit.

## Onderwerpen en abonnementen weergeven

Controleer voordat u uw eerste bericht verzendt of het onderwerp en het abonnement zijn gemaakt. Gebruik de volgende opdracht om het onderwerp en het abonnement weer te geven:

```bash
gcloud pubsub topics list
```

```bash
gcloud pubsub subscriptions list
```

## Berichten naar het onderwerp publiceren

Gebruik de volgende opdrachten om twee berichten te verzenden:

```bash
gcloud pubsub topics publish my-topic --message hello
```

```bash
gcloud pubsub topics publish my-topic --message goodbye
```

Met beide opdrachten verzendt u een bericht. Het eerste bericht is `hello` en het tweede bericht is `goodbye`. Als u een bericht heeft gepubliceerd, wordt de bericht-ID weergegeven die is geretourneerd door de server. Deze unieke ID wordt door de server automatisch aan elk bericht toegekend.

## Berichten uit het abonnement ophalen

### Berichten ophalen

Haal nu de berichten op met de volgende opdracht:

```bash
gcloud pubsub subscriptions \ pull --auto-ack --limit=2 my-sub
```

Waarschijnlijk werden de twee berichten weergegeven die u net heeft gepubliceerd. De berichten bevatten de gegevens `hello` en `goodbye`, evenals de `MESSAGE_ID`. De `MESSAGE_ID` is een unieke ID van het bericht die door de server is toegekend.

Opmerking: Cloud Pub/Sub kan niet garanderen dat berichten in de juiste volgorde worden afgeleverd. Het is ook mogelijk dat maar één bericht werd weergegeven. Voer in dat geval de opdracht meerdere malen uit, totdat ook het andere bericht wordt weergegeven.

### Bevestiging en bevestigingsdeadline

Nadat u een bericht heeft opgehaald en verwerkt, moet u Cloud Pub/Sub laten weten dat u het bericht heeft ontvangen. Deze actie noemen we een **bevestiging**.

U heeft mogelijk opgemerkt dat de flag `--auto-ack` samen met de opdracht `pull` werd doorgegeven.
De flag `--auto-ack` zorgt ervoor dat het bericht automatisch wordt opgehaald en bevestigd.

## Handmatige bevestiging

### Een nieuw bericht versturen

Gebruik de volgende opdracht om een nieuw bericht te versturen:

```bash
gcloud pubsub \ topics publish my-topic --message thanks
```

### Berichten opnieuw ophalen

Haal de berichten op met:

```bash
gcloud pubsub subscriptions \ pull my-sub
```

Hiermee moet het bericht `thanks` worden weergegeven, evenals de `MESSAGE_ID` en `ACK_ID`. De `ACK_ID` is een andere ID die u kunt gebruiken om het bericht te bevestigen.

### Het bericht bevestigen

Nadat u een bericht heeft opgehaald, moet u het bevestigen voordat de **bevestigingsdeadline** is verstreken. Als voor een abonnement bijvoorbeeld een **bevestigingsdeadline** van 60 seconden is ingesteld, zoals in deze training, moet u het bericht bevestigen binnen 60 seconden nadat u het heeft opgehaald. Als u dit niet doet, wordt het bericht opnieuw verzonden door Cloud Pub/Sub.

Gebruik de volgende opdracht om het bericht te bevestigen (vervang de `ACK_ID` door de echte ID door deze te kopiëren en plakken):

```bash
gcloud pubsub subscriptions ack \ my-sub --ack-ids ACK_ID
```

## Het onderwerp en het abonnement bekijken in de Pub/Sub-gebruikersinterface

Dit is het einde van het gedeelte over de `gcloud`-opdrachtregel. Voordat we de training afsluiten, kijken we nog even naar de gebruikersinterface in de Google Cloud Console.

U kunt de onderwerpen en abonnementen ook bekijken in het gedeelte Pub/Sub.

### Naar het gedeelte Pub/Sub navigeren

Open het [menu][spotlight-console-menu] aan de linkerkant van de console.

Selecteer vervolgens het gedeelte **Pub/Sub**.

<walkthrough-menu-navigation sectionid="CLOUDPUBSUB_SECTION"></walkthrough-menu-navigation>

U kunt in de gebruikersinterface ook onderwerpen en abonnementen maken en beheren.

### Het onderwerp verwijderen

Vink het selectievakje aan naast het onderwerp dat u heeft gemaakt en klik op de [knop Verwijderen][spotlight-delete-button] om het onderwerp permanent te verwijderen.

## Conclusie

Gefeliciteerd

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

U heeft zojuist kennisgemaakt met de basisbeginselen van Cloud Pub/Sub en de `gcloud`-opdrachtregeltool gebruikt. Ook heeft u een eerste blik geworpen op de Cloud Pub/Sub-gebruikersinterface. Nu is het tijd om geweldige apps te maken. Raadpleeg [de Pub/Sub-documentatie][pubsub-docs] voor meer informatie.

U kunt nu het volgende doen:

[Codevoorbeelden bekijken](https://cloud.google.com/pubsub/docs/quickstart-client-libraries)

[pubsub-docs]: https://cloud.google.com/pubsub/docs/
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-delete-button]: walkthrough://spotlight-pointer?cssSelector=.p6n-icon-delete
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
