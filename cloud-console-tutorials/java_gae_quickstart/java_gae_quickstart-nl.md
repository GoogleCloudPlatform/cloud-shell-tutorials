# Snelstartgids voor App Engine

<walkthrough-test-start-page url="/getting-started?tutorial=java_gae_quickstart_2"/>

<walkthrough-tutorial-url url="https://cloud.google.com/appengine/docs/java/quickstart"/>

<walkthrough-watcher-constant key="repo-url" value="https://github.com/GoogleCloudPlatform/appengine-try-java" />

<walkthrough-watcher-constant key="repo-name" value="appengine-try-java"/>

## Inleiding

In deze training leert u hoe u een voorbeeld van een [Java][java]-app in Google
App Engine implementeert met behulp van de Maven App Engine Plugin.

Dit zijn de stappen die u uitvoert.

*   **Uw 'Hello, world!'-app bouwen en uitvoeren**

    U leert hoe u met Google Cloud Shell een app rechtstreeks in uw browser kunt
    uitvoeren. Aan het einde van de training gebruikt u de Maven App Engine
    Plugin om de app online te implementeren.

*   **Na implementatie van de app**

    De app werkt echt en u kunt er na de implementatie mee experimenteren. U
    kunt de app ook verwijderen en opnieuw beginnen.

[Java is a registered trademark of Oracle and/or its affiliates.](walkthrough://footnote)

<walkthrough-devshell-precreate/>

## Project instellen

Als u een app wilt implementeren, moet u eerst een project maken.

Google Cloud Platform deelt resources in projecten in. Zo kunt u alle
gerelateerde resources voor een app op dezelfde plaats verzamelen.

<walkthrough-project-setup/>

## Google Cloud Shell gebruiken

Cloud Shell is een ingebouwde opdrachtregeltool van de console. We gaan Cloud
Shell gebruiken om onze app te implementeren.

### Google Cloud Shell openen

Open Cloud Shell door in de navigatiebalk bovenaan de console op
<walkthrough-cloud-shell-icon/>
[icon](walkthrough://spotlight-pointer?spotlightId=devshell-activate-button) te
klikken.

### De voorbeeldcode klonen

Gebruik Cloud Shell om naar de 'Hello, world!'-code te navigeren. De
voorbeeldcode wordt uit uw projectopslagplaats naar Cloud Shell gekloond.

Opmerking: Als de map al bestaat, moet u de eerdere bestanden verwijderen
voordat u gaat klonen:

```bash
rm -rf {{repo-name}}
```

Voer in Cloud Shell het volgende in:

```bash
git clone {{repo-url}}
```

Ga daarna naar de trainingsmap:

```bash
cd {{repo-name}}
```

## Uw implementatie configureren

U bevindt zich nu in de hoofdmap voor de voorbeeldcode. We bekijken de bestanden
die de configuratie van uw app bepalen.

### De app verkennen

Voer de volgende opdracht in om uw app-code te bekijken:

```bash
cat src/main/java/myapp/DemoServlet.java
```

Deze servlet beantwoordt elk verzoek door een reactie met het bericht `Hello,
world!` te sturen.

### Uw configuratie verkennen

Voor Java gebruikt Google App Engine XML-bestanden om de configuratie van een
implementatie te specificeren.

Voer de volgende opdracht in om uw configuratiebestand te bekijken:

```bash
cat pom.xml
```

De `helloworld`-app gebruikt Maven. Dit betekent dat u een projectobjectmodel
(POM) moet opgeven. Dit bevat informatie over het project en de
configuratiedetails die door Maven worden gebruikt om het project te ontwerpen.

## Uw app testen

### Uw app testen in Cloud Shell

Met Cloud Shell kunt u uw app testen voordat u deze implementeert. Zo weet u
zeker dat de app naar behoren werkt. Het werkt net als bij foutopsporing op uw
lokale computer.

Voer de volgende code in om uw app te testen:

```bash
mvn appengine:run
```

<walkthrough-test-code-output
  text="module .* running at|Dev App Server is now running" />

### Een voorbeeld van uw app bekijken met 'Voorbeeld op het web'

Uw app wordt nu in Cloud Shell uitgevoerd. U heeft toegang tot de app door via
'Voorbeeld op het web' <walkthrough-web-preview-icon/> verbinding te maken met
poort 8080. [Laat me zien
hoe](walkthrough://spotlight-pointer?spotlightId=devshell-web-preview-button)

### De voorbeeldinstantie beëindigen

Beëindig de instantie van de app door in Cloud Shell op `Ctrl+C` te drukken.

## In Google App Engine implementeren

### Een app maken

Als u de app wilt implementeren, moet u een app in een regio maken:

```bash
gcloud app create
```

Opmerking: Als u al een app heeft gemaakt, kunt u deze stap overslaan.

### Met Cloud Shell implementeren

Nu kunt u Cloud Shell gebruiken om uw app te implementeren.

Stel eerst in welk project u wilt gebruiken:

```bash
gcloud config set project {{project-id}}
```

Implementeer vervolgens de app:

```bash
mvn appengine:deploy
```

<walkthrough-test-code-output text="Deployed (module|service)" />

### Naar uw app gaan

Uw app is geïmplementeerd. De standaard-URL van uw app is
[{{project-gae-url}}](http://{{project-gae-url}}). Klik op de URL om naar de app
te gaan.

### De status van uw app bekijken

U kunt de status van uw app op het App Engine-dashboard controleren.

Open het [menu](walkthrough://spotlight-pointer?spotlightId=console-nav-menu)
aan de linkerkant van de console.

Selecteer vervolgens het gedeelte **App Engine**.

<walkthrough-menu-navigation sectionId="APPENGINE_SECTION"/>

## Afsluiting

<walkthrough-conclusion-trophy/>

Gefeliciteerd. U heeft een App Engine-app geïmplementeerd. Hieronder vindt u een
aantal vervolgstappen:

**De Google Cloud-SDK downloaden en lokaal ontwikkelen**

[Google Cloud SDK][cloud-sdk-installer]

**Uw volgende app bouwen**

Ontdek hoe u App Engine met andere Google Cloud Platform-producten gebruikt:

<walkthrough-tutorial-card
  url="appengine/docs/java/datastore/"
  icon="DATASTORE_SECTION"
  label="datastore">
**Ontdek hoe u Cloud Datastore gebruikt**
Cloud Datastore is een uiterst schaalbare NoSQL-database voor uw applicaties.
</walkthrough-tutorial-card>

<walkthrough-tutorial-card
  url="appengine/docs/java/googlecloudstorageclient/setting-up-cloud-storage/"
  icon="STORAGE_SECTION"
  label="cloudStorage">
**Ontdek hoe u Cloud Storage gebruikt**
Cloud Storage is een krachtige en eenvoudige service voor objectopslag.
</walkthrough-tutorial-card>

[java]: https://java.com/
[cloud-sdk-installer]: https://cloud.google.com/sdk/downloads#interactive
