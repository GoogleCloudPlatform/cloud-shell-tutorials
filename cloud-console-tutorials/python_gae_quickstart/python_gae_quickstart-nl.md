# Snel aan de slag met App Engine

<walkthrough-tutorial-url url="https://cloud.google.com/appengine/docs/python/quickstart"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="https://github.com/GoogleCloudPlatform/python-docs-samples" key="repo-url"></walkthrough-watcher-constant>
<walkthrough-watcher-constant value="python-docs-samples/appengine/standard/hello_world" key="repo-dir"></walkthrough-watcher-constant>

## Inleiding

In deze training leert u hoe u in Google App Engine een voorbeeld van een [Python](https://python.org/)-app implementeert met de opdracht `gcloud`.

Dit zijn de stappen die u uitvoert.

  *  **Een project maken**

     In projecten worden code, VM's en andere resources gegroepeerd om het ontwikkelen en de controle te vereenvoudigen.

  *  **Het ontwikkelen en uitvoeren van uw 'Hello, world!'- app**

     U leert hoe u met Google Cloud Shell uw app rechtstreeks vanuit uw browser uitvoert. Aan het einde van de training gebruikt u de opdracht `gcloud` om uw app online te zetten.

  *  **Na de training...**

     U heeft een echte app gemaakt. U kunt er na de implementatie mee experimenteren of de app verwijderen en een nieuwe maken.

[Python en de logo's van Python zijn handelsmerken of gedeponeerde handelsmerken van de Python Software Foundation.](walkthrough://footnote)

## Project instellen

Als u een app wilt implementeren, moet u eerst een project maken.

In Google Cloud Platform worden resources ingedeeld in projecten. Zo kunt u alle gerelateerde resources voor een app op één plek verzamelen.

<walkthrough-devshell-precreate></walkthrough-devshell-precreate>

<walkthrough-project-setup></walkthrough-project-setup>

## Google Cloud Shell gebruiken

Cloud Shell is een ingebouwde opdrachtregeltool voor de console. We gaan Cloud Shell gebruiken om onze app te implementeren.

### Google Cloud Shell openen

Open Cloud Shell door in de navigatiebalk bovenaan de console op het <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[pictogram][spotlight-open-devshell] te klikken.

### De voorbeeldcode klonen

Gebruik Cloud Shell om naar de Hello World-code te navigeren en deze te klonen. De voorbeeldcode wordt gekloond van uw projectopslagplaats naar de Cloud Shell.

Opmerking: Als de map al bestaat, verwijdert u de eerdere bestanden voordat u gaat klonen.

Geef het volgende op in Cloud Shell:

```bash
git clone {{repo-url}}
```

Schakel vervolgens over naar de trainingsmap:

```bash
cd {{repo-dir}}
```

## Uw implementatie configureren

U bevindt zich nu in de hoofdmap voor de voorbeeldcode. We gaan de bestanden bekijken, waarmee uw app wordt geconfigureerd.

### De app verkennen

Voer de volgende opdracht in om uw appcode te bekijken:

```bash
cat main.py
```

Het is een eenvoudige Python-app die gebruikmaakt van het webframework [webapp2](https://webapp2.readthedocs.io/). Dit Python-script beantwoordt een verzoek met een HTTP-header en het bericht `Hello, World!`.

### Uw configuratie verkennen

Google App Engine maakt gebruik van YAML-bestanden om de configuratie van een implementatie op te geven.
`app.yaml`-bestanden bevatten informatie over uw app, zoals de runtimeomgeving, de URL-handlers enzovoort.

Voer de volgende opdracht in om uw configuratiebestand weer te geven:

```bash
cat app.yaml
```

Van boven naar beneden wordt in dit configuratiebestand het volgende over deze app vermeld:

  *  Deze code wordt uitgevoerd in de `python`-runtimeomgeving.
  *  De app is `threadveilig`, dus dezelfde instantie kan meerdere gelijktijdige verzoeken afhandelen. De functie waarbij meerdere threads veilig gelijktijdig kunnen worden uitgevoerd (threadsafe), is een geavanceerde functie en kan resulteren in onvoorspelbaar gedrag als uw app niet specifiek is ontworpen om threadveilig te zijn.
  *  Elk verzoek voor een URL, waarvan het pad overeenkomt met de reguliere expressie `/.*` (alle URL's) moet worden afgehandeld door het app-object in de Python-module `main`.

Dit bestand heeft de [YAML](http://www.yaml.org)-syntaxis. Bekijk de [`app.yaml`][app-yaml-reference]-informatie voor een volledige lijst met configuratieopties.

## Uw app testen

### Uw app testen in Cloud Shell

Met Cloud Shell kunt u uw app testen voordat u deze implementeert. Zo weet u zeker dat de app naar behoren werkt, net als bij foutopsporing op uw lokale computer.

Als u uw app wilt testen, voert u het volgende in:

```bash
dev_appserver.py $PWD
```

### Een voorbeeld van uw app bekijken met 'Online voorbeeld'

Uw app wordt nu uitgevoerd in Cloud Shell. U heeft toegang tot de app door via [Online voorbeeld][spotlight-web-preview]<walkthrough-web-preview-icon></walkthrough-web-preview-icon> verbinding te maken met poort 8080.

### Voorbeeldinstantie beëindigen

Beëindig de instantie van de app door in de Cloud Shell op `Ctrl+C` te drukken.

## Implementeren op Google App Engine

### Een app maken

Als u uw app wilt implementeren, moet u een app in een regio maken:

```bash
gcloud app create
```

Opmerking: Als u al een app heeft gemaakt, kunt u deze stap overslaan.

### Implementeren met Cloud Shell

U kunt Cloud Shell gebruiken om uw app te implementeren. Voer het volgende in om uw app te implementeren:

```bash
gcloud app deploy app.yaml --project {{project-id}}
```

### Naar uw app gaan

Gefeliciteerd Uw app is geïmplementeerd. De standaard-URL van uw app is [{{project-gae-url}}](http://{{project-gae-url}}). Klik op de URL om naar de app te gaan.

### De status van uw app bekijken

U kunt de status van uw app controleren op het App Engine-dashboard.

Open het [menu][spotlight-console-menu] aan de linkerkant van de console.

Selecteer vervolgens het gedeelte **App Engine**.

<walkthrough-menu-navigation sectionid="APPENGINE_SECTION"></walkthrough-menu-navigation>

## Conclusie

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

U heeft een App Engine-app geïmplementeerd.

Hier volgen enkele voorbeelden van wat u hierna kunt doen:

**De Google Cloud-SDK downloaden en lokaal ontwikkelen**

Installeer de [Google Cloud-SDK][cloud-sdk-installer] op uw lokale computer.

**Uw volgende app ontwikkelen**

Ontdek hoe u App Engine gebruikt met andere Google Cloud Platform-producten.

<walkthrough-tutorial-card label="django" url="python/django/appengine" icon="APPENGINE_SECTION">
  **Django uitvoeren**
Ontwikkel Django-apps die worden uitgevoerd op App Engine.
</walkthrough-tutorial-card>

<walkthrough-tutorial-card label="datastore" url="appengine/docs/python/datastore/" icon="DATASTORE_SECTION">
  **Cloud Datastore leren gebruiken**
Cloud Datastore is een uiterst schaalbare NoSQL-database voor uw apps.
</walkthrough-tutorial-card>

[app-yaml-reference]: https://cloud.google.com/appengine/docs/standard/python/config/appref
[cloud-sdk-installer]: https://cloud.google.com/sdk/downloads#interactive
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-web-preview]: walkthrough://spotlight-pointer?spotlightId=devshell-web-preview-button
