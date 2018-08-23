# Guida di avvio rapido di Cloud Storage

## Ti diamo il benvenuto in Google Cloud Storage.

<walkthrough-tutorial-url url="https://cloud.google.com/storage/docs/quickstart-console"></walkthrough-tutorial-url>

Google Cloud Storage è una soluzione di archiviazione potente ed economica per oggetti non strutturati, perfetta per ogni esigenza: dall'hosting di contenuti web live alla memorizzazione dei dati per analisi all'archiviazione e al backup.

In questo tutorial, ti mostreremo quanto è semplice iniziare ad archiviare oggetti in Cloud Storage. Eseguirai queste operazioni:

  *  **Creare un bucket**

     I bucket contengono gli oggetti (qualunque tipo di file) che intendi archiviare in Cloud Storage.

  *  **Caricare e condividere oggetti**

     Inizia a utilizzare il tuo bucket caricando un oggetto e rendendolo disponibile pubblicamente.

  *  **Effettuare la pulizia**

     Al termine, eliminerai il bucket e l'oggetto che hai creato nel tutorial.

Dal momento che il bucket e l'oggetto verranno eliminati, per lo svolgimento di questo tutorial non ti verrà addebitato alcun costo.

## Configurazione del progetto

Per creare risorse in Cloud Storage occorre avere un progetto.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## Creare un bucket

In Cloud Storage, gli oggetti vengono archiviati in bucket. Per creare un bucket, devi accedere al browser di Cloud Storage.

Apri il [menu][spotlight-menu] sul lato sinistro della console.

Seleziona quindi la sezione **Storage**.

<walkthrough-menu-navigation sectionid="STORAGE_SECTION"></walkthrough-menu-navigation>

## Creare un bucket

Per poter iniziare a caricare oggetti, è necessario creare un "bucket" in cui archiviarli. I bucket ti aiutano a organizzare i tuoi oggetti e a controllare l'accesso agli stessi.

  1. Fai clic su [Crea bucket](walkthrough://spotlight-pointer?cssSelector=#p6ntest-cloudstorage-create-first-bucket-button,)

  1. Nella pagina di creazione del bucket, specificane le proprietà. Alcuni elementi da tenere presenti:

     *  **Nome:** trova un nome che non hai usato prima. Se specifichi un nome già in uso per un altro bucket in Cloud Storage, verrà visualizzato un errore.
     *  **Classe di archiviazione predefinita:** questa è la classe di archiviazione assegnata agli oggetti del tuo bucket per impostazione predefinita. La tua scelta dipende principalmente dalla frequenza di accesso che prevedi per questi oggetti e dall'intenzione di fornire i dati a livello mondiale o meno. La classe di archiviazione influisce sul costo.
     *  **Località:** è preferibile di memorizzare i dati in prossimità delle applicazioni e degli utenti che vi accedono. Le scelte disponibili dipendono dalla selezione della classe di archiviazione.

Per l'esecuzione di questa prova, qualunque classe di archiviazione e località andranno bene, poiché al termine eliminerai il bucket.

  1. Fai clic su [Crea][spotlight-create-button].

## Caricare un oggetto

Ora che hai creato un bucket, puoi iniziare a caricare gli oggetti.

  1. Nella parte superiore della pagina, fai clic su [Carica file][spotlight-upload-file].

  1. Seleziona un file da caricare. Può essere di qualunque tipo.

     Non hai un file? [Crea un file di esempio][create-sample-file], quindi fai clic su [Aggiorna bucket][spotlight-refresh-bucket] nella parte superiore della pagina per vederlo nel tuo bucket. (Suggerimento: puoi anche caricare oggetti trascinandoli nello spazio sotto il nome del bucket).

## Eliminare il bucket

Ora eliminerai il bucket appena creato. Con l'eliminazione del bucket viene eliminato anche il suo contenuto.

  1. Nella parte superiore della tabella, fai clic su [Bucket][spotlight-buckets-link] per tornare all'elenco dei bucket.

  1. Seleziona la casella accanto al tuo bucket. Se il progetto ha anche altri bucket e hai bisogno di aiuto per trovare il tuo, usa la barra di ricerca per filtrare l'elenco dei bucket.

  1. Nella parte superiore della pagina, fai clic su [Elimina][spotlight-delete-buckets] e conferma l'eliminazione.

## Conclusione

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Complimenti.

Ora che sai come archiviare oggetti in Cloud Storage, può essere opportuno scoprire come utilizzare questa funzione in scenari reali tramite l'[hosting di un sito web statico](https://cloud.google.com/storage/docs/hosting-static-website).

In alternativa, impara a utilizzare Cloud Storage con [lo strumento a riga di comando gsutil](https://cloud.google.com/storage/docs/quickstart-gsutil).

Impara a utilizzare Cloud Storage e altri servizi GCP [gratuitamente](https://cloud.google.com/free).

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
