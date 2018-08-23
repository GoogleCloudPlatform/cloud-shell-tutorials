# Tutoriel de Dataflow WordCount

<walkthrough-tutorial-url url="https://cloud.google.com/dataflow/docs/quickstarts/quickstart-java-maven"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="dataflow-intro" key="directory"></walkthrough-watcher-constant>
<walkthrough-watcher-constant value="dataflow-intro" key="job-name"></walkthrough-watcher-constant>

## Présentation

Dans ce tutoriel, vous allez apprendre les principes de base de l'exécution d'un pipeline avec Java sur le service Cloud Dataflow grâce à un exemple très simple.

Les pipelines Dataflow peuvent correspondre à un traitement par *lots* (traitement d'une source de données d'entrée limitée, comme un fichier ou une table de base de données). Ils peuvent également correspondre à un traitement par *flux* (traitement d'un flux de données d'entrée non limité, provenant d'une source telle que Cloud Pub/Sub). Dans cet exemple, il s'agit d'un pipeline par lots dont le but est de comptabiliser les mots dans les œuvres de Shakespeare.

Avant de commencer, vous devez vérifier les conditions requises pour votre projet Cloud Platform et effectuer la configuration initiale.

## Configuration du projet

Google Cloud Platform organise les ressources en projets. Vous pouvez ainsi collecter toutes les ressources associées à une application au même endroit.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>
<walkthrough-project-permissions permissions="dataflow.jobs.create"></walkthrough-project-permissions>

## Configurer Cloud Dataflow

Pour utiliser Dataflow, activez les API Cloud Dataflow, puis ouvrez Cloud Shell.

### Activer les API Google Cloud

<walkthrough-enable-apis apis="compute.googleapis.com,dataflow,cloudresourcemanager.googleapis.com,logging,storage_component,storage_api,bigquery,pubsub">
</walkthrough-enable-apis>

### Ouvrir Cloud Shell

Cloud Shell est un outil de ligne de commande intégré pour la console. Vous allez l'utiliser pour déployer votre application.

Pour ouvrir Cloud Shell, cliquez sur l'<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[icône][spotlight-open-devshell] dans la barre de navigation située en haut de la console.

## Installer des exemples de Cloud Dataflow sur Cloud Shell

Pour utiliser le SDK Cloud Dataflow pour Java, votre environnement de développement doit être équipé de Java, du SDK Google Cloud, du SDK Cloud Dataflow pour Java et d'Apache Maven pour la gestion des dépendances des SDK. Ce tutoriel utilise un environnement Cloud Shell dans lequel Java, le SDK Google Cloud et Maven sont déjà installés.

Vous pouvez également suivre ce tutoriel [sur votre machine locale][dataflow-java-tutorial].

### Télécharger des exemples et le SDK Cloud Dataflow pour Java à l'aide de la commande Maven

Lorsque vous exécutez cette commande, Maven crée une structure de projet et un fichier de configuration pour télécharger la bonne version du SDK Cloud Dataflow.

```bash
mvn archetype:generate \
    -DarchetypeArtifactId=google-cloud-dataflow-java-archetypes-examples \
    -DarchetypeGroupId=com.google.cloud.dataflow \
    -DarchetypeVersion=2.1.0 \
    -DgroupId=com.example \
    -DartifactId={{directory}} \
    -Dversion="0.1" \
    -DinteractiveMode=false \
    -Dpackage=com.example
```

*   `archetypeArtifactId` et `archetypeGroupId` sont utilisés pour définir la
    structure de l'exemple de projet.
*   `groupId` est le préfixe du nom de package Java de votre organisation (par
    exemple, `com.mycompany`).
*   `artifactId` définit le nom du fichier .jar créé. Utilisez la valeur par
    défaut (`{{directory}}`) pour ce tutoriel.

Exécutez la commande Maven dans Cloud Shell.

### Changer de répertoire

Remplacez le répertoire de travail par `{{directory}}`.

```bash
cd {{directory}}
```

Pour accéder au code de cet exemple, consultez le sous-répertoire `src` du
répertoire `{{directory}}`.

## Configurer un bucket Cloud Storage

Cloud Dataflow utilise des buckets Cloud Storage pour stocker les données de sortie et mettre en cache votre code de pipeline.

### Exécuter gsutil mb

Dans Cloud Shell, utilisez la commande `gsutil mb` pour créer un bucket Cloud Storage.

```bash
gsutil mb gs://{{project-id-no-domain}}
```

Pour en savoir plus sur l'outil `gsutil`, consultez la [documentation][gsutil-docs].

## Créer et lancer un pipeline

Dans Cloud Dataflow, un *pipeline* représente votre tâche de traitement de données. Il lit les données d'entrée, effectue des transformations sur celles-ci, puis produit des données de sortie. Les transformations effectuées par un pipeline peuvent inclure le filtrage, le regroupement, la comparaison ou la fusion de données.

Pour accéder au code de cet exemple, consultez le sous-répertoire `src` du
répertoire `{{directory}}`.

### Lancer un pipeline sur le service Dataflow

Utilisez la commande `mvn exec` d'Apache Maven pour lancer votre pipeline sur le service.
Le pipeline en cours d'exécution est appelé *tâche*.

```bash
mvn compile exec:java \
  -Dexec.mainClass=com.example.WordCount \
  -Dexec.args="--project={{project-id}} \
  --stagingLocation=gs://{{project-id-no-domain}}/staging/ \
  --output=gs://{{project-id-no-domain}}/output \
  --runner=DataflowRunner \
  --jobName={{job-name}}"
```

  *  `stagingLocation` est le bucket de stockage dans lequel Cloud Dataflow stocke les binaires et les autres données pour l'exécution du pipeline. Cet emplacement peut être partagé par plusieurs tâches.
  *  `output` est le bucket utilisé par l'exemple WordCount pour stocker les résultats de la tâche.

### Tâche en cours d'exécution

Félicitations ! Votre binaire est en cours de simulation dans le bucket de stockage que vous avez créé, et les instances Compute Engine sont en cours de création. Cloud Dataflow va diviser votre fichier d'entrée pour que vos données soient traitées en parallèle sur plusieurs machines.

Remarque : Lorsque le message "Tâche terminée" s'affiche, vous pouvez fermer Cloud Shell.

Si vous souhaitez nettoyer le projet Maven que vous avez généré, exécutez la
commande `cd .. && rm -R{{directory}}` dans Cloud Shell pour supprimer le
répertoire.

## Contrôler votre tâche

Vérifiez la progression du pipeline sur la page de l'interface utilisateur de surveillance de Cloud Dataflow.

### Accéder à la page Cloud Dataflow

Ouvrez le [menu][spotlight-console-menu] situé sur le côté gauche de la console.

Sélectionnez ensuite la section **Dataflow**.

<walkthrough-menu-navigation sectionid="DATAFLOW_SECTION"></walkthrough-menu-navigation>

### Sélectionner votre tâche

Cliquez sur votre tâche pour afficher les détails.

### Explorer les détails et les métriques d'un pipeline

Explorez le pipeline sur la gauche de l'écran et les informations de la tâche sur la droite. Pour consulter l'état détaillé d'une tâche, cliquez sur [Journaux][spotlight-job-logs]. Cliquez sur une étape du pipeline pour afficher ses métriques.

Une fois la tâche terminée, son état est modifié et les instances Compute Engine utilisées sont automatiquement arrêtées.

## Consulter les fichiers de sortie

Maintenant que votre tâche s'est exécutée, vous pouvez consulter les fichiers de sortie dans Cloud Storage.

### Accéder à la page Cloud Storage

Ouvrez le [menu][spotlight-console-menu] situé sur le côté gauche de la console.

Sélectionnez ensuite la section **Storage**.

<walkthrough-menu-navigation sectionid="STORAGE_SECTION"></walkthrough-menu-navigation>

### Accéder au bucket de stockage

Dans la liste des buckets, sélectionnez le bucket que vous avez créé
précédemment. Si vous avez utilisé le nom suggéré, il s'appelle
`{{project-id}}`.

Le bucket contient un dossier de préproduction et des dossiers de sortie. Dataflow enregistre les sorties en segments. Plusieurs fichiers de sortie vont donc être créés.

## Effectuer un nettoyage

Afin d'éviter d'être facturé pour l'utilisation de Cloud Storage, supprimez le bucket que vous avez créé.

### Revenir au navigateur de buckets

Cliquez sur le lien [Buckets][spotlight-buckets-link].

### Sélectionner le bucket

Cochez la case à côté du bucket que vous avez créé.

### Supprimer le bucket

Cliquez sur [Supprimer][spotlight-delete-bucket], puis confirmez la suppression.

## Conclusion

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Liste des opérations que vous pouvez effectuer :

  *  [En savoir plus sur l'exemple WordCount][wordcount]
  *  [En savoir plus sur le modèle de programmation de Cloud Dataflow][df-model]
  *  [Découvrir le SDK Cloud Dataflow sur GitHub][df-sdk]

Configurez votre environnement local :

  *  [Utiliser Eclipse pour exécuter Dataflow][df-eclipse]
  *  [Utiliser Python pour exécuter Dataflow][df-python]

[dataflow-java-tutorial]: https://cloud.google.com/dataflow/docs/quickstarts/quickstart-java-maven
[df-eclipse]: https://cloud.google.com/dataflow/docs/quickstarts/quickstart-java-eclipse
[df-model]: https://cloud.google.com/dataflow/model/programming-model-beam
[df-python]: https://cloud.google.com/dataflow/docs/quickstarts/quickstart-python
[df-sdk]: https://github.com/apache/beam/tree/master/sdks/java
[gsutil-docs]: https://cloud.google.com/storage/docs/gsutil
[spotlight-buckets-link]: walkthrough://spotlight-pointer?cssSelector=.p6n-cloudstorage-path-link
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-delete-bucket]: walkthrough://spotlight-pointer?cssSelector=#p6n-cloudstorage-delete-buckets
[spotlight-job-logs]: walkthrough://spotlight-pointer?cssSelector=#p6n-dax-job-logs-toggle
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[wordcount]: https://beam.apache.org/get-started/wordcount-example/
