# Tour di Cloud Console

<walkthrough-tutorial-duration duration="5"></walkthrough-tutorial-duration>

## Presentazione

Questo tutorial illustra le funzionalità principali di Cloud Console che ti permettono di iniziare a creare e gestire le tue applicazioni su Google Cloud Platform.

Potrai apprendere i seguenti concetti:

  *  Risorse e progetti GCP
  *  Panoramica generale delle risorse e log delle attività
  *  Navigazione e ricerca nella console
  *  Gestione utenti e autorizzazioni
  *  Assistenza tecnica
  *  Riga di comando basata su browser di GCP

Iniziamo.

## Utilizzo delle risorse GCP

Le risorse GCP sono le componenti fondamentali che formano tutti i servizi Google Cloud. Le risorse sono organizzate in modo gerarchico e permettono di organizzare il lavoro su GCP.

I progetti sono il primo livello della gerarchia di risorse e contengono altre risorse di basso livello come i bucket di Cloud Storage e le istanze di Compute Engine.

[Ulteriori informazioni sulle risorse GCP][gcp-resources]

### Navigazione tra i progetti

Puoi navigare facilmente tra i progetti GCP utilizzando il [selettore dell'ambito][spotlight-project-select] in Cloud Console. Lo spostamento tra i progetti consente di adattare la visualizzazione a quella del progetto e di tutte le sue risorse figlio.

<walkthrough-project-setup></walkthrough-project-setup>

## Navigazione tra i servizi Google Cloud

### Navigazione tra i servizi

Puoi accedere ai servizi Google Cloud nel [menu di navigazione di sinistra][spotlight-console-menu] organizzato per area di prodotti come Big Data, Compute, Networking, ecc.

### Blocco delle sezioni

Se visiti con regolarità determinati servizi, puoi fissare la sezione corrispondente nella parte superiore del menu di navigazione passando con il puntatore del mouse sopra la voce della sezione e facendo clic sulla relativa icona.

Apri il menu di navigazione e seleziona **Home** per continuare.

<walkthrough-menu-navigation sectionid="HOME_SECTION"></walkthrough-menu-navigation>

## Guardare una panoramica generale di un progetto

### Dashboard della home page

La dashboard della home page fornisce una panoramica generale del progetto GCP selezionato ed evidenzia metriche chiave, dati di fatturazione e altre informazioni utili.

### Personalizzazione

Puoi personalizzare la tua dashboard facendo clic su [Personalizza][spotlight-customize-dashboard].
Puoi nascondere, mostrare e riordinare tutte le schede nella pagina. Inoltre, ogni scheda contiene opzioni personalizzate alle quali puoi accedere dal menu extra quando passi il mouse sopra una scheda.

## Visualizzazione delle attività nelle risorse GCP

Nella sezione [Flusso di attività][spotlight-activity-stream] puoi interpretare centralmente tutte le attività eseguite nelle varie risorse GCP.

Scopri gli elementi che i colleghi del tuo team stanno aggiornando in qualsiasi progetto per rilevare i problemi e controllare l'accesso. Puoi filtrare facilmente il feed per trovare esattamente ciò che cerchi.

## Ricerca in Cloud Console

La [barra di ricerca][spotlight-search-bar] consente di accedere rapidamente ai prodotti Google Cloud e a qualsiasi risorsa all'interno di GCP.

Prova a cercare **App Engine** o il nome di uno dei tuoi progetti.

## Assistenza continua

Se hai dei problemi o ti serve aiuto per qualsiasi aspetto di GCP, contatta il nostro team di assistenza.

[Ulteriori informazioni sull'assistenza](http://cloud.google.com/support)

Accedi all'assistenza dal menu di navigazione.

<walkthrough-menu-navigation sectionid="SUPPORT_SECTION"></walkthrough-menu-navigation>

## Gestione di utenti e autorizzazioni

Google Cloud Identity and Access Management (Cloud IAM) consente di gestire e creare le autorizzazioni per le risorse GCP.

[Ulteriori informazioni su IAM](https://cloud.google.com/iam/docs/)

Man mano che il tuo team cresce, puoi concedere l'accesso ai vari membri utilizzando Cloud IAM nella sezione "IAM e amministrazione".

Aggiungi utenti, gruppi o account di servizio e assegna loro tutti i ruoli necessari per concedere le autorizzazioni di cui hanno bisogno.

<walkthrough-menu-navigation sectionid="IAM_ADMIN_SECTION"></walkthrough-menu-navigation>

## Accesso alla riga di comando dal browser

Google Cloud Shell fornisce l'accesso a riga di comando alle risorse cloud direttamente dal tuo browser. Puoi gestire facilmente progetti e risorse senza dover installare l'SDK di Google Cloud o altri strumenti nel tuo sistema.

Con <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[Cloud Shell][spotlight-open-devshell], lo strumento a riga di comando gcloud di Cloud SDK e altre utilità necessarie sono sempre disponibili, aggiornati e completamente autenticati quando ne hai bisogno.

[Ulteriori informazioni su Cloud Shell](https://cloud.google.com/shell/)

## Continua a scoprire GCP

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Adesso dovresti avere delle conoscenze di base solide per utilizzare Cloud Console ed esplorare nuovi servizi e prodotti.

La nostra [documentazione dettagliata](https://cloud.google.com/docs/) fornisce inoltre moltissime informazioni, dalle panoramiche dei prodotti alle guide di avvio rapido, fino ai riferimenti per le API.

Torna alla pagina Per iniziare per guardare altri tutorial.
<walkthrough-menu-navigation sectionid="ONBOARDING_SECTION"></walkthrough-menu-navigation>

[gcp-resources]: https://cloud.google.com/resource-manager/docs/cloud-platform-resource-hierarchy
[spotlight-activity-stream]: walkthrough://spotlight-pointer?cssSelector=.mat-tab-link:nth-of-type(2)
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-customize-dashboard]: walkthrough://spotlight-pointer?cssSelector=.cfc-customize-button
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-project-select]: walkthrough://spotlight-pointer?spotlightId=purview-switcher
[spotlight-search-bar]: walkthrough://spotlight-pointer?cssSelector=.p6n-search-bar,.pcc-platform-bar-search-bar
