# Cloud Vision API

<walkthrough-test-start-page url="/start?tutorial=python_vision_quickstart_v2"></walkthrough-test-start-page>

<walkthrough-tutorial-url url="https://cloud.google.com/vision/docs/label-tutorial"></walkthrough-tutorial-url>

<walkthrough-watcher-constant value="https://github.com/GoogleCloudPlatform/python-docs-samples.git" key="repo-url"></walkthrough-watcher-constant>

<walkthrough-watcher-constant value="python-docs-samples" key="repo-name"></walkthrough-watcher-constant>

<walkthrough-devshell-precreate></walkthrough-devshell-precreate>

## Inleiding

In deze training leert u hoe u een eenvoudige Vision API-app maakt met het
verzoek `LABEL_DETECTION`. Het verzoek `LABEL_DETECTION` voorziet een afbeelding
van een label (of 'tag'). Dit label wordt geselecteerd op basis van de inhoud
van de afbeelding. Een plaatje van een schuur krijgt bijvoorbeeld het label
'schuur', 'boerderij' of een vergelijkbare annotatie.

Dit zijn de stappen die u uitvoert:

*   **Uw app voor labeldetectie uitvoeren.** U leert hoe u met Google Cloud
    Shell uw app rechtstreeks vanuit uw browser uitvoert.
*   **Na de training...** U heeft een echte app gemaakt. U kunt ermee
    experimenteren of de app verwijderen en een nieuwe maken.

[Python en de logo's van Python zijn handelsmerken of gedeponeerde handelsmerken
van de Python Software Foundation.](walkthrough://footnote)

# Project instellen

U moet de Cloud Vision API inschakelen via een project.

Google Cloud Platform deelt resources in projecten in. Zo kunt u alle
gerelateerde resources voor een applicatie op één plek verzamelen.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## De Vision API inschakelen

De Vision API moet voor uw project zijn ingeschakeld om verzoeken te kunnen
accepteren.

### Naar API-beheer navigeren

In API-beheer kunt u instellen welke API's zijn ingeschakeld voor uw project.

Open het [menu](walkthrough://spotlight-pointer?spotlightId=console-nav-menu)
aan de linkerkant van de console.

Selecteer vervolgens het gedeelte **API's en services**.

<walkthrough-menu-navigation sectionid="API_SECTION"></walkthrough-menu-navigation>

### Beschikbare API's bekijken

Klik op de knop
[API inschakelen](walkthrough://spotlight-pointer?cssSelector=.p6n-action-bar-button)
om API's in te
schakelen.

### Vision API selecteren

Klik op de link [Vision API](walkthrough://spotlight-pointer?spotlightId=api-vision.googleapis.com).

### Vision API inschakelen

Klik op de knop [Inschakelen](walkthrough://spotlight-pointer?spotlightId=api-enable-vision.googleapis.com) om de Vision API in te
schakelen. Later in deze training maken we toegangsgegevens voor uw project.

## Google Cloud Shell gebruiken

Cloud Shell is een ingebouwde opdrachtregeltool voor de console. U gaat Cloud
Shell gebruiken om uw app uit te voeren.

### Google Cloud Shell openen

Open Cloud Shell door in de navigatiebalk bovenaan de console op het
<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>
[pictogram](walkthrough://spotlight-pointer?spotlightId=devshell-activate-button)
te klikken.

### De voorbeeldcode klonen

Gebruik Cloud Shell om naar de Hello World-code te navigeren en deze te klonen.
De voorbeeldcode wordt gekloond van uw projectopslagplaats naar de Cloud Shell.

Opmerking: Als de map al bestaat, verwijdert u de eerdere bestanden voordat u
gaat klonen:

```bash
rm -rf {{repo-name}}
```

Een voorbeeldopslagplaats klonen:

```bash
git clone {{repo-url}}
```

Schakel vervolgens over naar de trainingsmap:

```bash
cd {{repo-name}}/vision/cloud-client/quickstart
```

## Uw implementatie configureren

U bevindt zich nu in de hoofdmap voor de voorbeeldcode. U gaat kijken naar de
bestanden die de configuratie van uw app bepalen.

### De app verkennen

Voer de volgende opdracht in om uw app-code te bekijken:

```bash
cat quickstart.py
```

Het bestand `quickstart.py` verzorgt de indeling van de verzoekinformatie, zoals
het type verzoek en de content. Vouw de onderstaande gedeelten uit voor meer
informatie.

Verzoeken aan de Vision API worden als JSON-objecten aangeboden. Bekijk de
[Vision API-referentie][vision-request-doc] voor volledige informatie over de
specifieke structuur van zo'n verzoek. Uw JSON-verzoek wordt alleen verzonden
als u de aanroep `execute` gebruikt. Dankzij dit patroon kunt u dergelijke
verzoeken rondsturen en waar nodig `execute` aanroepen.

## De app testen

U moet toegangsgegevens instellen om de API te kunnen gebruiken. Als u een Cloud
API wilt gebruiken, moet u de juiste [toegangsgegevens][auth-doc] voor uw app
instellen. Zo kan uw app de identiteit bevestigen bij de service en toestemming
krijgen om taken uit te voeren. Vervolgens test u de API met
voorbeeldafbeeldingen.

### Een serviceaccount maken

U moet een serviceaccount maken om uw API-verzoeken te verifiëren. Als u al een
serviceaccount heeft gemaakt, wordt dit opnieuw gebruikt.

```bash
gcloud iam service-accounts create vision-quickstart
```

### Toegangsgegevens maken

Maak vervolgens een serviceaccountsleutel en stel deze in als uw standaard
toegangsgegevens.

```bash
gcloud iam service-accounts keys create key.json --iam-account    vision-quickstart@{{project-id}}.iam.gserviceaccount.com
```

```bash
export GOOGLE_APPLICATION_CREDENTIALS=key.json
```

<walkthrough-test-code-output text="created key"></walkthrough-test-code-output>

### Uw app testen

Voer het volgende in om uw app te testen met een voorbeeldafbeelding:

```bash
python quickstart.py
```

De afbeeldingsresource `resources/wakeupcat.jpg` wordt in de bron
gespecificeerd. ([Afbeelding bekijken][cat-picture])

## Conclusie

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Gefeliciteerd. U bent klaar om de Cloud Vision API te gebruiken.

U kunt nu het volgende doen:

*   De training [Gezichtsdetectie][face-tutorial] doornemen
*   De training [Tekst in documenten][document-text-tutorial] doornemen
*   De [voorbeeld-apps][vision-samples] bekijken
*   De [Google Cloud-SDK][get-cloud-sdk] downloaden en op uw lokale computer
    uitvoeren

[auth-doc]: https://cloud.google.com/vision/docs/auth
[cat-picture]: https://raw.githubusercontent.com/GoogleCloudPlatform/python-docs-samples/master/vision/cloud-client/quickstart/resources/wakeupcat.jpg
[document-text-tutorial]: https://cloud.google.com/vision/docs/fulltext-annotations
[face-tutorial]: https://cloud.google.com/vision/docs/face-tutorial
[get-cloud-sdk]: https://cloud.google.com/sdk/
[vision-request-doc]: https://cloud.google.com/vision/reference/rest
[vision-samples]: https://cloud.google.com/vision/docs/samples
