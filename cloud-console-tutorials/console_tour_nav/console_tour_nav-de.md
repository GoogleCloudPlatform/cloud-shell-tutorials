# Cloud Console-Tour

<walkthrough-tutorial-duration duration="5"></walkthrough-tutorial-duration>

## Einführung

In dieser Anleitung erfahren Sie mehr zu den Hauptfunktionen der Cloud Console, um Ihre Anwendungen auf der Google Cloud Platform erstellen und verwalten zu können.

Sie lernen die folgenden Konzepte kennen:

  *  GCP-Projekte und -Ressourcen
  *  Übersicht über Ressourcen und Aktivitätsprotokolle
  *  In der Console navigieren und suchen
  *  Nutzer- und Berechtigungsverwaltung
  *  Technischer Support
  *  Browserbasierte Befehlszeile von GCP

Los geht's!

## GCP-Ressourcen verwenden

GCP-Ressourcen sind die Grundlage aller Google Cloud-Dienste. Die hierarchische Anordnung der Ressourcen erleichtert die Arbeit auf der GCP.

Die erste Ebene der Ressourcenhierarchie bilden Projekte. Sie enthalten untergeordnete Ressourcen wie Cloud Storage-Buckets und Compute Engine-Instanzen.

[Weitere Informationen zu GCP-Ressourcen][gcp-resources]

### Projekte aufrufen

In der Cloud Console können Sie Ihre GCP-Projekte bequem über die [Projektauswahl][spotlight-project-select] aufrufen. Durch den Wechsel zwischen Projekten wird die Ansicht an das jeweilige Projekt und dessen untergeordnete Ressourcen angepasst.

<walkthrough-project-setup></walkthrough-project-setup>

## Google Cloud-Dienste aufrufen

### Dienste aufrufen

Sie können Google Cloud-Dienste über das [linke Navigationsmenü][spotlight-console-menu] aufrufen. Dieses ist nach Produktbereichen wie Big Data, Compute, Netzwerk usw. unterteilt.

### Bereich anheften

Sie können regelmäßig genutzte Dienste oben an das Navigationsmenü anheften. Bewegen Sie einfach den Mauszeiger über den Bereich und klicken Sie auf das Reißzweckensymbol.

Öffnen Sie das Navigationsmenü und wählen Sie **Startseite** aus, um fortzufahren.

<walkthrough-menu-navigation sectionid="HOME_SECTION"></walkthrough-menu-navigation>

## Übersicht eines Projekts ansehen

### Dashboard auf der Startseite

Das Dashboard auf der Startseite bietet eine Übersicht des ausgewählten GCP-Projekts. Wichtige Messwerte, Abrechnungs- oder andere nützliche Informationen werden hervorgehoben.

### Anpassung

Sie können das Erscheinungsbild des Dashboards mit der [Option "Anpassen"][spotlight-customize-dashboard] ändern.
Alle Karten auf der Seite lassen sich aus- und einblenden sowie neu anordnen. Jede Karte kann außerdem benutzerdefinierte Optionen enthalten, die über das Dreipunkt-Menü zugänglich sind, wenn Sie den Mauszeiger über die Karte bewegen.

## Aktivitäten in GCP-Ressourcen ansehen

Mit dem [Aktivitäten-Stream][spotlight-activity-stream] können Sie alle Aktivitäten in Ihren GCP-Ressourcen an einem Ort anzeigen.

Sie haben unter anderem die Möglichkeit, die von Ihren Teamkollegen durchgeführten Aktualisierungen an einem Projekt einzusehen, Probleme zu ermitteln und den Zugriff zu überwachen. Sie können den Feed nach bestimmten Informationen filtern.

## In Cloud Console suchen

Über die [Suchleiste][spotlight-search-bar] der Cloud Console können Sie Google Cloud-Produkte und jede Ihrer Ressourcen auf der GCP schnell aufrufen.

Suchen Sie testweise nach **App Engine** oder dem Namen eines Ihrer Projekte.

## Jederzeit Support anfordern

Wenn Sie Fragen haben oder Unterstützung brauchen, um sich auf der GCP zurechtzufinden, steht Ihnen unser Supportteam zur Verfügung.

[Weitere Informationen zum Support](http://cloud.google.com/support)

Rufen Sie den Support über das Navigationsmenü auf.

<walkthrough-menu-navigation sectionid="SUPPORT_SECTION"></walkthrough-menu-navigation>

## Nutzer und Berechtigungen verwalten

Mit Google Cloud Identity and Access Management (Cloud IAM) können Sie Berechtigungen für Ihre GCP-Ressourcen verwalten und erstellen.

[Weitere Informationen zu IAM](https://cloud.google.com/iam/docs/)

Neuen Teammitgliedern gewähren Sie im Abschnitt "IAM & Verwaltung" mithilfe von Cloud IAM Zugriff.

Sie können Nutzer, Gruppen oder Dienstkonten hinzufügen und ihnen eine beliebige Anzahl von Rollen mit den erforderlichen Berechtigungen zuweisen.

<walkthrough-menu-navigation sectionid="IAM_ADMIN_SECTION"></walkthrough-menu-navigation>

## Befehlszeile über den Browser aufrufen

Google Cloud Shell bietet eine Befehlszeile, mit der Sie direkt von Ihrem Browser aus auf Ihre Cloud-Ressourcen zugreifen können. Sie können Ihre Projekte und Ressourcen dadurch einfach und ohne Installation von Google Cloud SDK oder anderen Tools auf Ihrem Computer verwalten.

Mit [Cloud Shell][spotlight-open-devshell] sind das Cloud SDK-Befehlszeilentool<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon> und andere wichtige Hilfsmittel jederzeit auf dem aktuellsten Stand verfügbar und vollständig authentifiziert.

[Weitere Informationen zu Cloud Shell](https://cloud.google.com/shell/)

## GCP-Tour fortsetzen

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Sie sollten jetzt mit der Bedienung der Cloud Console vertraut sein und wissen, wie Sie neue Dienste und Produkte erkunden können.

Unsere [detaillierte Dokumentation](https://cloud.google.com/docs/) bietet außerdem umfassende Informationen, angefangen von Produktübersichten bis hin zu Schnellstartanleitungen und API-Referenzen.

Kehren Sie für weitere Anleitungen zur Seite "Erste Schritte" zurück.
<walkthrough-menu-navigation sectionid="ONBOARDING_SECTION"></walkthrough-menu-navigation>

[gcp-resources]: https://cloud.google.com/resource-manager/docs/cloud-platform-resource-hierarchy
[spotlight-activity-stream]: walkthrough://spotlight-pointer?cssSelector=.mat-tab-link:nth-of-type(2)
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-customize-dashboard]: walkthrough://spotlight-pointer?cssSelector=.cfc-customize-button
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-project-select]: walkthrough://spotlight-pointer?spotlightId=purview-switcher
[spotlight-search-bar]: walkthrough://spotlight-pointer?cssSelector=.p6n-search-bar,.pcc-platform-bar-search-bar
