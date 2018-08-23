# Démarrage rapide avec App Engine

<walkthrough-tutorial-url url="https://cloud.google.com/appengine/docs/python/quickstart"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="https://github.com/GoogleCloudPlatform/python-docs-samples" key="repo-url"></walkthrough-watcher-constant>
<walkthrough-watcher-constant value="python-docs-samples/appengine/standard/hello_world" key="repo-dir"></walkthrough-watcher-constant>

## Présentation

Ce tutoriel explique comment déployer un exemple d'application [Python](https://python.org/) dans Google App Engine à l'aide de la commande `gcloud`.

Voici comment procéder.

  *  **Créer un projet**

     Les projets regroupent le code, les VM, ainsi que d'autres ressources, ce qui facilite le développement et les opérations de surveillance.

  *  **Créer et exécuter une application "Hello World!"**

     Vous allez découvrir comment exécuter votre application avec Google Cloud Shell directement depuis votre navigateur. Pour conclure ce tutoriel, vous allez déployer votre application sur le Web à l'aide de la commande `gcloud`.

  *  **Après le didacticiel**

     Votre application sera réelle. Vous pourrez la tester après l'avoir déployée ou la supprimer pour en créer une autre.

[Python et les logos Python sont des marques ou des marques déposées de Python Software Foundation.](walkthrough://footnote)

## Configuration du projet

Pour déployer une application, vous devez d'abord créer un projet.

Google Cloud Platform organise les ressources en projets. Vous pouvez ainsi collecter toutes les ressources associées à une application au même endroit.

<walkthrough-devshell-precreate></walkthrough-devshell-precreate>

<walkthrough-project-setup></walkthrough-project-setup>

## Utiliser Google Cloud Shell

Cloud Shell est un outil de ligne de commande intégré pour la console. Nous allons l'utiliser pour déployer notre application.

### Ouvrir Google Cloud Shell

Pour ouvrir Cloud Shell, cliquez sur l'<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[icône][spotlight-open-devshell] dans la barre de navigation située en haut de la console.

### Cloner l'exemple de code

Utilisez Cloud Shell pour cloner et parcourir le code de l'application Hello World. L'exemple de code est cloné à partir du dépôt de votre projet vers Cloud Shell.

Remarque : Si le répertoire existe déjà, supprimez les anciens fichiers avant d'effectuer le clonage :

Dans Cloud Shell saisissez ce qui suit :

```bash
git clone {{repo-url}}
```

Ensuite, accédez au répertoire du tutoriel :

```bash
cd {{repo-dir}}
```

## Configurer le déploiement

Vous vous trouvez maintenant dans le répertoire principal pour l'exemple de code. Nous allons examiner les fichiers de configuration de votre application.

### Explorer l'application

Saisissez la commande suivante pour afficher le code de votre application :

```bash
cat main.py
```

Il s'agit d'une application Python simple qui utilise le framework Web [webapp2](https://webapp2.readthedocs.io/). Ce script Python répond à une requête composée d'un en-tête HTTP et du message `Hello, World!`.

### Découvrir votre configuration

Google App Engine utilise des fichiers YAML pour spécifier la configuration d'un déploiement.
Les fichiers `app.yaml` contiennent des informations relatives à votre application, telles que l'environnement d'exécution, les gestionnaires d'URL, etc.

Saisissez la commande suivante pour afficher votre fichier de configuration :

```bash
cat app.yaml
```

De haut en bas, ce fichier de configuration fournit les informations suivantes à propos de l'application :

  *  Ce code s'exécute dans l'environnement `python`.
  *  Cette application est dite `threadsafe` (à fil sécurisé) : la même instance peut traiter plusieurs requêtes simultanées. Threadsafe est une fonctionnalité avancée qui peut être source d'instabilité si votre application n'a pas été conçue spécialement dans cette optique.
  *  Toutes les requêtes adressées à une URL dont le chemin d'accès correspond à l'expression régulière `/.*` (toutes les URL) doivent être gérées par l'objet de l'application dans le module Python `main`.

Dans ce fichier, la syntaxe utilisée est [YAML](http://www.yaml.org). Pour obtenir la liste complète des options de configuration, consultez la documentation de référence sur [`app.yaml`][app-yaml-reference].

## Tester votre application

### Tester votre application dans Cloud Shell

Cloud Shell vous permet de tester votre application avant de la déployer. Vous pouvez ainsi vérifier qu'elle s'exécute comme prévu, comme si vous effectuiez son débogage sur votre machine locale.

Pour tester votre application, saisissez :

```bash
dev_appserver.py $PWD
```

### Prévisualiser votre application avec l'option "Aperçu sur le Web"

Votre application est désormais exécutée sur Cloud Shell. Vous pouvez y accéder avec l'option [Aperçu sur le Web][spotlight-web-preview]<walkthrough-web-preview-icon></walkthrough-web-preview-icon> en vous connectant via le port 8080.

### Arrêt de l'instance en cours de prévisualisation

Arrêtez l'instance de l'application en appuyant sur `Ctrl+C` dans Cloud Shell.

## Déployer une application dans Google App Engine

### Créer une application

Pour déployer votre application, vous devez la créer dans une région :

```bash
gcloud app create
```

Remarque : Si vous avez déjà créé une application, vous pouvez passer cette étape.

### Déployer l'application avec Cloud Shell

Vous pouvez utiliser Cloud Shell pour déployer votre application. Pour ce faire, saisissez :

```bash
gcloud app deploy app.yaml --project {{project-id}}
```

### Accéder à votre application

Félicitations ! Votre application a bien été déployée. Son URL par défaut est [{{project-gae-url}}](http://{{project-gae-url}}). Cliquez sur l'URL pour accéder à l'application.

### Afficher l'état de votre application

Vous pouvez surveiller votre application en contrôlant son état dans le tableau de bord App Engine.

Ouvrez le [menu][spotlight-console-menu] situé sur le côté gauche de la console.

Sélectionnez ensuite la section **App Engine**.

<walkthrough-menu-navigation sectionid="APPENGINE_SECTION"></walkthrough-menu-navigation>

## Conclusion

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Vous avez déployé une application App Engine.

Voici ce que vous pouvez faire ensuite :

**Télécharger le SDK Google Cloud et développer en local**

Installez le [SDK Google Cloud][cloud-sdk-installer] sur votre machine locale.

**Créer votre prochaine application**

Découvrez comment utiliser App Engine avec d'autres produits Google Cloud Platform :

<walkthrough-tutorial-card label="django" url="python/django/appengine" icon="APPENGINE_SECTION">
  **Exécuter Django**
Développez des applications Django exécutées sur App Engine.
</walkthrough-tutorial-card>

<walkthrough-tutorial-card label="datastore" url="appengine/docs/python/datastore/" icon="DATASTORE_SECTION">
  **Apprendre à utiliser Cloud Datastore**
Cloud Datastore est une base de données NoSQL qui offre une grande évolutivité pour vos applications.
</walkthrough-tutorial-card>

[app-yaml-reference]: https://cloud.google.com/appengine/docs/standard/python/config/appref
[cloud-sdk-installer]: https://cloud.google.com/sdk/downloads#interactive
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-web-preview]: walkthrough://spotlight-pointer?spotlightId=devshell-web-preview-button
