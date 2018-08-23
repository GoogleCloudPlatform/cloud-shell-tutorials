# Stackdriver Error Reporting

## Inleiding

In Stackdriver Error Reporting worden fouten verzameld en weergegeven die door cloudservices worden gemaakt.

Met deze training krijgt u een rondleiding door de webinterface van Error Reporting. U leert hoe u fouten in uw apps weergeeft, hoe u meer details kunt bekijken en wat u vervolgens kunt doen.

## Project instellen

<walkthrough-project-setup></walkthrough-project-setup>

## Fouten genereren

Voordat u verdergaat, moet u kunstmatige fouten melden. U gebruikt hiervoor een `gcloud`-opdracht.

In de praktijk zouden deze fouten rechtstreeks vanuit uw actieve app worden gemeld. Na deze training kunt u meer informatie vinden over het instellen van Error Reporting.

### Google Cloud Shell openen

Open Cloud Shell door in de navigatiebalk bovenaan de console op het <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[pictogram][spotlight-open-devshell] te klikken.

### Een aantal fouten melden

Klik op de knop **Kopiëren naar klembord** in de rechterbovenhoek van het volgende script en voer het uit in Cloud Shell om voorbeeldfouten te genereren.

```bash
COUNTER=0
while [  $COUNTER -lt 11 ]; do
    gcloud beta error-reporting events report --service tutorial --service-version v$((COUNTER/10+1)) \
        --message "java.lang.RuntimeException: Error rendering template $COUNTER
          at com.example.TestClass.test(TestClass.java:51)
          at com.example.AnotherClass(AnotherClass.java:25)
          at javax.servlet.http.HttpServlet.service (HttpServlet.java:617)
          at javax.servlet.http.HttpServlet.service (HttpServlet.java:717)"
    if [ $COUNTER -lt 3 ]; then
      gcloud beta error-reporting events report --service tutorial --service-version v1 \
          --message "java.lang.ArrayIndexOutOfBoundsException: $COUNTER
            at com.example.AppController.createUser(AppController.java:42)
            at com.example.User(User.java:31)
            at javax.servlet.http.HttpServlet.service (HttpServlet.java:617)
            at javax.servlet.http.HttpServlet.service (HttpServlet.java:717)"
    fi
    if [ $COUNTER -eq 10 ]; then
      echo "All artificial errors reported."
    fi
    let COUNTER=COUNTER+1
done
```

### Cloud Shell sluiten

Sluit Cloud Shell en klik op *Doorgaan* als u klaar bent.

## Uw appfouten weergeven

U gebruikt Stackdriver Error Reporting om de gerapporteerde fouten in één oogopslag te zien.

### Error Reporting openen

Open het [menu][spotlight-console-menu] aan de linkerkant van de console.

Scrol vervolgens naar de categorie **Stackdriver** en selecteer **Error Reporting**.

<walkthrough-menu-navigation sectionid="CRASH_SECTION"></walkthrough-menu-navigation>

### Op *Eerste melding* sorteren

Fouten die zich voordoen in uw app worden gegroepeerd en dubbele items worden verwijderd door hun stacktraces te analyseren. Elk item in deze lijst bevat een overzicht aan de hand waarvan u kunt bepalen wanneer de fout is begonnen, hoe vaak deze optrad en hoe recent deze is voorgekomen.

De standaardsortering is *Aantal voorvallen*. Klik op de kolomkop *Eerste melding* om de fouten te bekijken die onlangs begonnen op te treden.

### Aanmelden voor meldingen over nieuwe fouten

U kunt e-mails en pushmeldingen voor mobiel ontvangen wanneer zich in het project een nieuwe fout voordoet. Klik op *Meldingen inschakelen* om u op te geven voor deze meldingen.

Klik op *Doorgaan* als u klaar bent.

## Inzicht krijgen in de details van een fout

### Een foutrapport openen

Klik op een fout in deze lijst om de details te bekijken.

### Een probleem aan deze fout koppelen

Gebruik deze pagina om de informatie en de geschiedenis van een specifieke fout te onderzoeken.

Na het bekijken van een nieuwe fout registreert u vervolgens meestal een probleem in de issue tracker van uw team. Uw item in de issue tracker kan worden teruggekoppeld aan de fout in Stackdriver Error Reporting.

Dit doet u als volgt:

  *  Klik bovenaan op *Koppelen aan probleem* (mogelijk moet u het menu **Meer acties** openen om deze link weer te geven).
  *  Voer `http://example.com/issues/1234` in het dialoogvenster in.
  *  Klik op *Opslaan*.

### Stacktraces bekijken

Wij verbergen de stacktraceframes die niet afkomstig zijn van de code van uw app, zodat u zich kunt concentreren op uw code.

Klik op *Alles weergeven* in een foutvoorbeeld om de stackframes van het framework weer te geven.

## Conclusie

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Gefeliciteerd. U heeft de training van Stackdriver Error Reporting voltooid.

U kunt nu het volgende doen:

### Error Reporting instellen voor uw project

Ontdek hoe u Error Reporting voor uw actieve services instelt in de [installatiedocumentatie][errors-setup].

### Andere Stackdriver-trainingen bekijken

Fouten opsporen in een productie-app met de [snelstartgids van Stackdriver Debugger][debug-quickstart].

Inzicht krijgen in de wachttijd van uw app met de snelstartgids van [Stackdriver Trace][trace-quickstart].

[debug-quickstart]: https://cloud.google.com/debugger/docs/quickstart
[errors-setup]: https://cloud.google.com/error-reporting/docs/how-to
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[trace-quickstart]: https://cloud.google.com/trace/docs/quickstart
