# Démarrage rapide d'App Engine

<walkthrough-test-start-page url="/getting-started?tutorial=java_gae_quickstart_2"/>

<walkthrough-tutorial-url url="https://cloud.google.com/appengine/docs/java/quickstart"/>

<walkthrough-watcher-constant key="repo-url" value="https://github.com/GoogleCloudPlatform/appengine-try-java" />

<walkthrough-watcher-constant key="repo-name" value="appengine-try-java"/>

## Introduction

Ce didacticiel explique comment déployer un exemple d'application [Java][java]
dans Google App Engine à l'aide du plug-in App Engine Maven.

Voici comment procéder.

*   **Créez, puis exécutez votre application "Hello world".**

    Tout d'abord, vous apprendrez comment exécuter votre application avec Google
    Cloud Shell depuis votre navigateur. Vous déploierez ensuite votre
    application sur le Web en utilisant le plug-in App Engine Maven.

*   **À la fin de ce didacticiel**

    Une fois votre application créée, vous pourrez la tester après l'avoir
    déployée, ou vous pourrez la supprimer et en créer une autre.

[Java is a registered trademark of Oracle and/or its affiliates.](walkthrough://footnote)

<walkthrough-devshell-precreate/>

## Configuration du projet

Pour déployer une application, vous devez d'abord créer un projet.

Google Cloud Platform organise les ressources en projets. Vous pouvez ainsi
collecter toutes les ressources associées à une application au même endroit.

<walkthrough-project-setup/>

## Utiliser Google Cloud Shell

Cloud Shell est un outil de ligne de commande intégré pour la console. Nous
allons l'utiliser pour déployer notre application.

## Ouvrir Google Cloud Shell

Pour ouvrir Cloud Shell, cliquez sur <walkthrough-cloud-shell-icon/>
[icon](walkthrough://spotlight-pointer?spotlightId=devshell-activate-button)
dans la barre de navigation située en haut de la console.

### Cloner l'exemple de code

Utilisez Cloud Shell pour cloner et parcourir le code de l'application
"Hello world". L'exemple de code est cloné à partir du dépôt de votre projet
vers Cloud Shell.

Remarque : Si le répertoire existe déjà, supprimez les fichiers existants avant
de procéder au clonage.

```bash
rm -rf {{repo-name}}
```

Dans Cloud Shell, saisissez ce qui suit:

```bash
git clone {{repo-url}}
```

Accédez ensuite au répertoire du didacticiel:

```bash
cd {{repo-name}}
```

## Configurer le déploiement

Vous vous trouvez maintenant dans le répertoire principal pour l'exemple de
code. Nous allons examiner les fichiers de configuration de votre application.

### Explorer l'application

Saisissez la commande suivante pour afficher le code de votre application :

```bash
cat src/main/java/myapp/DemoServlet.java
```

Ce servlet répond aux requêtes en envoyant une réponse contenant le message
`Hello, world!`.

### Explorer votre configuration

Pour Java, Google App Engine utilise des fichiers XML pour préciser la
configuration d'un déploiement.

Saisissez la commande suivante pour afficher le code de votre application :

```bash
cat pom.xml
```

L'application `helloworld` utilise Maven. Vous devez donc indiquer un modèle
d'objet du projet (POM) qui contient les informations relatives au projet et les
détails de configuration qui ont permis à Maven de le créer.

## Tester votre application

### Tester votre application dans Cloud Shell

Cloud Shell vous permet de tester votre application avant de la déployer. Vous
pouvez ainsi vérifier qu'elle s'exécute comme prévu, comme avec un débogage sur
votre machine locale.

Pour tester votre application, saisissez :

```bash
mvn appengine:run
```

<walkthrough-test-code-output
  text="module .* running at|Dev App Server is now running" />

### Prévisualiser votre application avec l'option "Aperçu sur le Web"

Votre application est désormais exécutée sur Cloud Shell. Vous pouvez y accéder
avec l'option "Aperçu sur le Web" <walkthrough-web-preview-icon/> pour vous
connecter via le port 8080.
[Démonstration](walkthrough://spotlight-pointer?spotlightId=devshell-web-preview-button)

### Arrêter l'instance prévisualisée

Arrêtez l'instance de l'application en appuyant sur Ctrl+C dans Cloud Shell.

## Déployer l'application dans Google App Engine

### Créer une application

Pour déployer notre application, nous devons créer une application dans une
région :

```bash
gcloud app create
```

Remarque : Si vous avez déjà créé une application, vous pouvez ignorer cette
étape.

### Déployer l'application avec Cloud Shell

Vous pouvez maintenant utiliser Cloud Shell pour déployer votre application.

Tout d'abord, sélectionnez le projet à utiliser :

```bash
gcloud config set project {{project-id}}
```

Déployez ensuite votre application :

```bash
mvn appengine:deploy
```

<walkthrough-test-code-output text="Deployed (module|service)" />

### Accéder à votre application

Votre application vient d'être déployée. Son URL par défaut est
[{{project-gae-url}}](http://{{project-gae-url}}). Cliquez sur l'URL pour
accéder à l'application.

### Afficher l'état de votre application

Vous pouvez surveiller votre application en contrôlant son état dans le tableau
de bord App Engine.

Ouvrez le [menu](walkthrough://spotlight-pointer?spotlightId=console-nav-menu)
situé à gauche de la console.

Sélectionnez ensuite la section **App Engine**.

<walkthrough-menu-navigation sectionId="APPENGINE_SECTION"/>

## Conclusion

<walkthrough-conclusion-trophy/> Félicitations ! Vous avez déployé une
application App Engine. Voici quelques étapes à suivre ensuite :

**Téléchargez le SDK Google Cloud et développez votre application en local.**

[Google Cloud SDK][cloud-sdk-installer]

**Créez votre prochaine application.**

Découvrez comment utiliser App Engine avec d'autres produits Cloud Platform :

<walkthrough-tutorial-card
  url="appengine/docs/java/datastore/"
  icon="DATASTORE_SECTION"
  label="datastore">
**Apprendre à utiliser Cloud Datastore**
Cloud Datastore est une base de données NoSQL pour vos applications, qui se distingue par une évolutivité élevée.
</walkthrough-tutorial-card>

<walkthrough-tutorial-card
  url="appengine/docs/java/googlecloudstorageclient/setting-up-cloud-storage/"
  icon="STORAGE_SECTION"
  label="cloudStorage">
**Apprendre à utiliser Cloud Storage**
Cloud Storage est un service de stockage d'objets puissant et simple.
</walkthrough-tutorial-card>

[java]: https://java.com/
[cloud-sdk-installer]: https://cloud.google.com/sdk/downloads#interactive
