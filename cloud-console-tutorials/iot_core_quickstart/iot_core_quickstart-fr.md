# Présentation de Cloud IoT Core

<walkthrough-tutorial-url url="https://cloud.google.com/iot/docs/quickstart"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="https://github.com/GoogleCloudPlatform/nodejs-docs-samples.git" key="repo-url"></walkthrough-watcher-constant>

## Présentation

Google Cloud Internet of Things (IoT) Core est un service entièrement géré qui permet de connecter et de gérer des appareils IdO (quelques-uns ou des millions) en toute sécurité. Ce tutoriel vous explique comment créer un registre d'appareils et ajouter des appareils à ce registre à l'aide de l'outil de ligne de commande `gcloud`. Vous pouvez également exécuter l'exemple MQTT présenté ici pour découvrir comment connecter un appareil et publier les événements de télémétrie qui lui sont associés.

Ce didacticiel vous guide à travers les étapes suivantes :

  *  Création d'un sujet Cloud Pub/Sub
  *  Création d'un registre d'appareils
  *  Ajout d'un appareil au registre
  *  Configuration d'identifiants sur l'appareil
  *  Création d'un abonnement au sujet Pub/Sub afin d'envoyer et de recevoir des messages
  *  Connexion à un appareil virtuel et affichage des données de télémétrie

## Configuration du projet

Google Cloud Platform organise les ressources en projets. Vous pouvez ainsi collecter toutes les ressources associées à une application au même endroit.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## Utiliser Google Cloud Shell

Dans ce didacticiel, vous allez travailler exclusivement dans Cloud Shell.

### Ouvrir Google Cloud Shell

Pour ouvrir Cloud Shell, cliquez sur l'<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[icône][spotlight-open-devshell] dans la barre de navigation située en haut de la console.

### Activer les API Google Cloud

Cette action va activer l'API Cloud IoT Core.

<walkthrough-enable-apis apis="cloudiot.googleapis.com"></walkthrough-enable-apis>

## Créer votre premier sujet

Un sujet est une ressource nommée à laquelle les appareils envoient des messages. Créez votre premier sujet à l'aide de la commande suivante :

```bash
gcloud pubsub topics create my-topic
```

Vous enverrez plusieurs messages pour ce sujet ultérieurement.

## Cloner les fichiers d'exemple Node.js pour Cloud IoT Core depuis GitHub

Vous utiliserez l'exemple MQTT pour envoyer des messages à Cloud IoT Core.

Remarque : Si le répertoire existe déjà, supprimez les anciens fichiers avant d'effectuer le clonage :

```bash
rm -rf nodejs-docs-samples
```

Clonez le programme d'exemple à l'aide de la commande suivante :

```bash
git clone {{repo-url}}
```

## Accorder des autorisations au compte de service Cloud IoT Core

Utilisez le script d'aide qui se trouve dans le dossier `/iot/scripts` pour ajouter le compte de service `cloud-iot@system.gserviceaccount.com` au sujet Cloud Pub/Sub. Vous devez attribuer le rôle d'éditeur à ce compte.

### Accédez au répertoire iot :

```bash
cd nodejs-docs-samples/iot
```

### Installez les dépendances :

```bash
npm --prefix ./scripts install
```

### Exécutez le script d'aide :

```bash
node scripts/iam.js my-topic
```

Le script accorde des autorisations au compte de service Cloud IoT Core pour le sujet `my-topic`.

## Créer un registre d'appareils

Un registre d'appareils permet de regrouper des appareils. Il permet également de définir des propriétés partagées par tous ces appareils. Créez votre registre d'appareils à l'aide de la commande suivante :

```bash
gcloud iot registries create my-registry \
    --project={{project-id}} \
    --region=us-central1 \
    --event-notification-config=topic=projects/{{project-id}}/topics/my-topic
```

## Générer vos clés de signature

Pour s'authentifier sur Cloud IoT Core, un appareil doit disposer d'une clé privée et d'une clé publique. Générez vos clés de signature en exécutant la commande suivante :

```bash
./scripts/generate_keys.sh
```

Ce script génère des clés RS256 et ES256 au format PEM. Toutefois, pour ce tutoriel, vous n'aurez besoin que des clés RS256. La clé privée doit être stockée en toute sécurité sur l'appareil et sert à signer le processus d'authentification JWT ([Jetons Web JSON][web-token-docs]). La clé publique est stockée dans le registre d'appareils.

## Créer un appareil et l'ajouter au registre

Exécutez la commande suivante pour créer un appareil et l'ajouter au registre :

```bash
gcloud iot devices create my-node-device \
    --project={{project-id}} \
    --region=us-central1 \
    --registry=my-registry \
    --public-key path=rsa_cert.pem,type=rs256
```

## Connecter votre appareil et afficher les données de télémétrie

Dans cette étape, vous allez envoyer des messages à partir d'un appareil virtuel vers Pub/Sub. Ensuite, vous allez extraire les messages et les afficher.

### Accédez au répertoire d'exemple MQTT :

```bash
cd mqtt_example
```

### Installez les dépendances Node.js :

```bash
npm install
```

### Exécutez la commande suivante pour connecter un appareil virtuel à Cloud IoT Core à l'aide du pont MQTT :

```bash
node cloudiot_mqtt_example_nodejs.js \
    --projectId={{project-id}} \
    --registryId=my-registry \
    --deviceId=my-node-device \
    --privateKeyFile=../rsa_private.pem \
    --numMessages=25 \
    --algorithm=RS256 \
    --mqttBridgePort=443
```

Le résultat montre que l'appareil virtuel publie des messages sur le sujet de télémétrie. Vingt-cinq messages sont publiés.

## Créer un abonnement associé au sujet de l'appareil

Exécutez la commande suivante pour créer un abonnement vous permettant d'afficher les messages publiés par votre appareil :

```bash
gcloud pubsub subscriptions create \
    projects/{{project-id}}/subscriptions/my-subscription \
    --topic=my-topic
```

## Extraire les messages publiés

Extrayez les messages publiés par l'appareil à l'aide de la commande suivante :

```bash
gcloud pubsub subscriptions pull --auto-ack \
    projects/{{project-id}}/subscriptions/my-subscription
```

En exécutant cette commande, vous obtenez les messages publiés par l'appareil. Les messages contiennent les données suivantes : `my-registry/my-node-device-payload-&lt;NOMBRE ENTIER&gt;`, `MESSAGE_ID` et une liste `ATTRIBUTES` contenant des informations sur l'appareil. Le `MESSAGE_ID` est un ID unique attribué au message par le serveur.

Remarque : Cloud Pub/Sub ne garantit pas l'ordre des messages. Il se peut également qu'un seul message s'affiche dans Cloud Shell. Dans ce cas, répétez l'exécution de la même commande plusieurs fois, jusqu'à ce que les autres messages apparaissent.

## Afficher les ressources dans la console Google Cloud Platform

Nous en avons terminé avec les lignes de commande `gcloud` de ce tutoriel. Avant de conclure, sachez que vous avez également la possibilité d'utiliser la console GCP pour afficher les ressources que vous venez de créer.

Ouvrez le [menu][spotlight-console-menu] situé sur le côté gauche de la console.

Ensuite, sélectionnez **IoT Core**.

<walkthrough-menu-navigation sectionid="IOT_SECTION"></walkthrough-menu-navigation>

L'interface utilisateur vous permet également de créer et gérer des registres d'appareils, ainsi que des appareils.

## Conclusion

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Félicitations ! Vous venez de découvrir les concepts clés de Cloud IoT Core à l'aide de l'outil de ligne de commande `gcloud`. Vous avez également utilisé la console GCP pour afficher des ressources Cloud IoT Core. L'étape suivante consiste à créer vos applications ! Pour en savoir plus, consultez la [documentation relative à IoT Core](https://cloud.google.com/iot/docs/).

### Liste des opérations que vous pouvez effectuer

Affichez plus d'exemples Cloud IoT Core sur GitHub :

  *  [C](https://github.com/GoogleCloudPlatform/cpp-docs-samples/tree/master/iot/mqtt-ciotc)
  *  [Java](https://github.com/GoogleCloudPlatform/java-docs-samples/tree/master/iot/api-client)
  *  [Node.js](https://github.com/GoogleCloudPlatform/nodejs-docs-samples/tree/master/iot)
  *  [Python](https://github.com/GoogleCloudPlatform/python-docs-samples/tree/master/iot/api-client)

[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[web-token-docs]: https://cloud.google.com/iot/docs/how-tos/credentials/jwts
