# Snelstartgids voor Cloud Storage

## Welkom bij Google Cloud Storage.

<walkthrough-tutorial-url url="https://cloud.google.com/storage/docs/quickstart-console"></walkthrough-tutorial-url>

Google Cloud Storage is een effectieve en voordelige oplossing voor de opslag van ongestructureerde objecten. De oplossing kan voor veel doeleinden worden gebruikt: van het hosten van live webcontent tot het opslaan van gegevens voor analyses, archiveren en het maken van back-ups.

In deze training leert u hoe eenvoudig het is om objecten op te slaan in Cloud Storage. Dit is wat u gaat doen:

  *  **Een bucket maken**

     Buckets bevatten de objecten (elk type bestand) die u in Cloud Storage wilt opslaan.

  *  **Objecten uploaden en delen**

     Start met het gebruik van uw bucket door een object te uploaden en openbaar beschikbaar te stellen.

  *  **Opschonen**

     Tot slot verwijdert u het object en de bucket die u voor deze training heeft gemaakt.

Aangezien u uw bucket en object na afloop verwijdert, hoeft u zich geen zorgen te maken dat er kosten in rekening worden gebracht voor deze training.

## Project instellen

Cloud Storage vereist een project om resources te maken.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## Een bucket maken

In Cloud Storage slaat u uw objecten op in buckets. U moet naar de Cloud Storage-browser gaan om een bucket te maken.

Open het [menu][spotlight-menu] aan de linkerkant van de console.

Selecteer vervolgens het gedeelte **Opslag**.

<walkthrough-menu-navigation sectionid="STORAGE_SECTION"></walkthrough-menu-navigation>

## Een bucket maken

Voordat u objecten kunt uploaden, moet u een bucket maken waarin u deze objecten opslaat. Met buckets kunt u uw objecten ordenen en de toegang ertoe beheren.

  1. Klik op [Bucket maken](walkthrough://spotlight-pointer?cssSelector=#p6ntest-cloudstorage-create-first-bucket-button,).

  1. Geef op de pagina voor het maken van de bucket de eigenschappen van de bucket op. Hier volgt een aantal zaken waarmee u rekening moet houden:

     *  **Naam:** Bedenk een unieke naam. Er wordt een foutmelding weergegeven als u een naam invoert die overeenkomt met de naam van een andere bucket in Cloud Storage.
     *  **Standaard opslagklasse:** Dit is de opslagklasse die standaard wordt toegewezen aan de objecten in uw bucket. Uw keuze hangt met name af van uw verwachtingen met betrekking tot de omvang van het gebruik van de objecten en van het feit of u de gegevens wereldwijd beschikbaar stelt. De opslagklasse is van invloed op uw kosten.
     *  **Locatie:** U kunt de gegevens het beste in de buurt van de apps en de gebruikers van deze gegevens bewaren. De beschikbare keuzen zijn afhankelijk van de opslagklasse die u kiest.

Voor deze oefening zijn alle opslagklassen en locaties geschikt, aangezien u de bucket na afloop weer verwijdert.

  1. Klik op [Maken][spotlight-create-button].

## Een object uploaden

Nu u een bucket heeft, kunt u objecten uploaden.

  1. Klik bovenaan de pagina op [Bestanden uploaden][spotlight-upload-file].

  1. Selecteer een bestand dat u wilt uploaden. U kunt elk type bestand uploaden.

     Heeft u geen bestand? [Maak een voorbeeldbestand][create-sample-file] en klik vervolgens op [Bucket vernieuwen][spotlight-refresh-bucket] bovenaan de pagina om het bestand in uw bucket te bekijken. (Tip: U kunt objecten ook uploaden door ze te slepen en neer te zetten in de ruimte onder uw bucketnaam.)

## De bucket verwijderen

Laten we nu de bucket verwijderen die u zojuist heeft gemaakt. Als u een bucket verwijdert, wordt ook de inhoud ervan verwijderd.

  1. Klik bovenaan de tabel op [Buckets][spotlight-buckets-link] om terug te gaan naar de lijst met buckets.

  1. Vink het vakje naast uw bucket aan. Als dit project andere buckets bevat en u hulp nodig heeft om uw bucket te vinden, kunt u de zoekbalk gebruiken om de lijst met buckets te filteren.

  1. Klik bovenaan de pagina op [Verwijderen][spotlight-delete-buckets] en bevestig de verwijdering.

## Conclusie

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Gefeliciteerd.

Nu u weet hoe u objecten in Cloud Storage kunt opslaan, wilt u misschien leren hoe u deze online beschikbaar kunt stellen door [een statische website te hosten](https://cloud.google.com/storage/docs/hosting-static-website).

Of ontdek hoe u Cloud Storage kunt gebruiken met [de gsutil-opdrachtregeltool](https://cloud.google.com/storage/docs/quickstart-gsutil).

Ontdek hoe u [gratis](https://cloud.google.com/free) aan de slag kunt gaan met Cloud Storage en andere GCP-services.

[create-sample-file]: walkthrough://create-sample-storage-file
[spotlight-buckets-link]: walkthrough://spotlight-pointer?cssSelector=.p6n-cloudstorage-path-link
[spotlight-create-bucket]: walkthrough://spotlight-pointer?cssSelector=#p6ntest-cloudstorage-create-first-bucket-button,#p6n-cloudstorage-create-bucket
[spotlight-create-button]: walkthrough://spotlight-pointer?cssSelector=#p6ntest-gcs-create-bucket-button
[spotlight-delete-buckets]: walkthrough://spotlight-pointer?spotlightId=gcs-action-bar-delete-bucket
[spotlight-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-public-link]: walkthrough://spotlight-pointer?cssSelector=.p6n-cloudstorage-browser-public-label
[spotlight-refresh-bucket]: walkthrough://spotlight-pointer?spotlightId=gcs-action-bar-refresh-objects
[spotlight-share-public]: walkthrough://spotlight-pointer?cssSelector=.p6n-cloudstorage-browser-public-checkbox
[spotlight-upload-file]: walkthrough://spotlight-pointer?spotlightId=gcs-action-bar-upload-file
