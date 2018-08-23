# Cloud Console verkennen

<walkthrough-tutorial-duration duration="5"></walkthrough-tutorial-duration>

## Inleiding

In deze handleiding worden de belangrijkste functies van Cloud Console beschreven om u op weg te helpen met het ontwikkelen en beheren van uw apps op Google Cloud Platform.

U leert over de volgende concepten:

  *  GCP-projecten en -resources
  *  Overzicht van resources op hoog niveau en activiteitenlogboeken
  *  Navigeren en zoeken in de console
  *  Gebruikers- en rechtenbeheer
  *  Technische ondersteuning
  *  GCP's opdrachtregel vanuit de browser

Laten we nu aan de slag gaan.

## GCP-resources gebruiken

GCP-resources zijn de basiscomponenten waaruit alle Google Cloud-services bestaan. Resources zijn hiërarchisch gerangschikt en maken het gemakkelijker om uw werk op GCP te ordenen.

Projecten vormen het eerste niveau van de resourcehiërarchie. Zij bevatten andere resources op een lager niveau, zoals Cloud Storage-buckets en Compute Engine-instanties.

[Meer informatie over GCP-resources][gcp-resources]

### Projectnavigatie

Navigeer eenvoudig door uw GCP-projecten met de [bereikkiezer][spotlight-project-select] in Cloud Console. Wanneer u van project wisselt, wordt de weergave aan het betreffende project en alle onderliggende resources aangepast.

<walkthrough-project-setup></walkthrough-project-setup>

## Naar Google Cloud-services navigeren

### Servicenavigatie

Google Cloud-services zijn toegankelijk via het [navigatiemenu aan de linkerkant][spotlight-console-menu] en zijn geordend op productgebied, zoals Big Data, Compute, Networking, enzovoort.

### Secties vastzetten

Voor een service die u regelmatig bezoekt, kunt u de sectie boven in het navigatiemenu vastzetten door de muisaanwijzer op het sectie-item te plaatsen en op het pictogram voor vastzetten te klikken.

Open het navigatiemenu en selecteer **Homepage** om door te gaan.

<walkthrough-menu-navigation sectionid="HOME_SECTION"></walkthrough-menu-navigation>

## Een overzicht op hoog niveau van een project bekijken

### Homepage-dashboard

Het homepage-dashboard biedt een overzicht op hoog niveau van het geselecteerde GCP-project, waarbij belangrijke statistieken, facturering en andere nuttige informatie worden uitgelicht.

### Aanpassen

U kunt uw dashboard aanpassen door op [Aanpassen][spotlight-customize-dashboard] te klikken.
Elke kaart kan op de pagina worden verborgen, weergegeven en opnieuw worden gerangschikt. Elke kaart heeft ook custom opties die toegankelijk zijn via het overloopmenu dat verschijnt als u de muisaanwijzer op een kaart plaatst.

## Activiteit in uw GCP-resources bekijken

Met [Activiteitoverzicht][spotlight-activity-stream] kunt u vanaf één plek alle activiteiten overzien die plaatsvinden in uw GCP-resources.

Bekijk welke updates uw teamleden in een project uitvoeren om problemen op te sporen en de toegang te controleren. U kunt de feed eenvoudig filteren om precies te vinden wat u zoekt.

## Zoeken in Cloud Console

Met de [zoekbalk][spotlight-search-bar] in Cloud Console heeft u snel toegang tot Google Cloud-producten en al uw resources binnen GCP.

Voer eens een zoekopdracht uit naar **App Engine** of de naam van een van uw projecten.

## Ondersteuning op elk gewenst moment

Als u vast komt te zitten of hulp nodig heeft bij het navigeren door de wereld van GCP, staat ons ondersteuningsteam klaar om u te helpen.

[Meer informatie over ondersteuning](http://cloud.google.com/support)

Gebruik het navigatiemenu om toegang te krijgen tot de ondersteuning.

<walkthrough-menu-navigation sectionid="SUPPORT_SECTION"></walkthrough-menu-navigation>

## Gebruikers en rechten beheren

Met Google Cloud Identity en Access Management (Cloud IAM) kunt u rechten voor uw GCP-resources beheren en maken.

[Meer informatie over IAM](https://cloud.google.com/iam/docs/)

Naarmate uw team blijft groeien, kunt u met Cloud IAM toegang verlenen aan teamleden in de sectie 'IAM en beheer'.

Voeg gebruikers, groepen of serviceaccounts toe en wijs aan hen rollen toe, zodat ze over de rechten beschikken die ze nodig hebben.

<walkthrough-menu-navigation sectionid="IAM_ADMIN_SECTION"></walkthrough-menu-navigation>

## De opdrachtregel vanuit uw browser openen

Google Cloud Shell biedt u rechtstreeks vanuit uw browser via de opdrachtregel toegang tot uw cloudresources. U kunt uw projecten en resources eenvoudig beheren zonder dat u de Google Cloud-SDK of andere tools op uw systeem hoeft te installeren.

Met <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[Cloud Shell][spotlight-open-devshell] zijn de gcloud-opdrachtregeltool van Cloud-SDK en andere hulpprogramma's wanneer u ze nodig heeft altijd binnen handbereik, up-to-date en volledig geverifieerd.

[Meer informatie over Cloud Shell](https://cloud.google.com/shell/)

## GCP verder verkennen

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

U weet nu hoe u door Cloud Console navigeert en heeft een goede basis om nieuwe services en producten te ontdekken.

Onze [gedetailleerde documentatie](https://cloud.google.com/docs/) biedt ook een schat aan informatie van productoverzichten tot snelstartgidsen en informatie over API's.

Ga terug naar de pagina Aan de slag voor meer handleidingen.
<walkthrough-menu-navigation sectionid="ONBOARDING_SECTION"></walkthrough-menu-navigation>

[gcp-resources]: https://cloud.google.com/resource-manager/docs/cloud-platform-resource-hierarchy
[spotlight-activity-stream]: walkthrough://spotlight-pointer?cssSelector=.mat-tab-link:nth-of-type(2)
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-customize-dashboard]: walkthrough://spotlight-pointer?cssSelector=.cfc-customize-button
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-project-select]: walkthrough://spotlight-pointer?spotlightId=purview-switcher
[spotlight-search-bar]: walkthrough://spotlight-pointer?cssSelector=.p6n-search-bar,.pcc-platform-bar-search-bar
