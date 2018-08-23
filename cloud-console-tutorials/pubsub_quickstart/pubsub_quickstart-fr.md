# Présentation de Cloud Pub/Sub

<walkthrough-tutorial-url url="https://cloud.google.com/pubsub/quickstart-console"></walkthrough-tutorial-url></walkthrough-test-start-page>

<walkthrough-devshell-precreate></walkthrough-devshell-precreate>

## Présentation

Cloud Pub/Sub est un service de messagerie en temps réel entièrement géré qui vous permet d'envoyer et de recevoir des messages avec différentes applications indépendantes. Ce tutoriel présente brièvement l'interface de ligne de commande de Cloud Pub/Sub et l'utilisation de la commande `gcloud`.

## Configuration du projet

Google Cloud Platform organise les ressources en projets. Vous pouvez ainsi collecter toutes les ressources associées à une application au même endroit.

Cloud Pub/Sub a besoin d'un projet pour configurer des messages.

<walkthrough-project-setup></walkthrough-project-setup>

## Créer votre premier sujet

### Ouvrir Google Cloud Shell

Cloud Shell est un outil de ligne de commande intégré pour la console. Vous allez l'utiliser pour configurer Cloud Pub/Sub.

Pour ouvrir Cloud Shell, cliquez sur l'<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[icône][spotlight-open-devshell] dans la barre de navigation située en haut de la console.

### Créer un sujet

Un sujet est une ressource nommée à laquelle vous envoyez des messages. Créez votre premier sujet à l'aide de la commande suivante :

```bash
gcloud pubsub topics create my-topic
```

## Ajouter un abonnement

Pour recevoir des messages, vous devez créer des abonnements. Un abonnement doit être associé à un sujet. Créez votre premier abonnement à l'aide de la commande suivante :

```bash
gcloud pubsub subscriptions \
    create my-sub --topic my-topic \
    --ack-deadline=60
```

Cette commande permet de créer un abonnement nommé `my-sub`, qui est associé au sujet `my-topic`. Tous les messages publiés pour `my-topic` seront envoyés à cet abonnement.

Vous avez peut-être remarqué l'option `--ack-deadline=60`. Le terme `ack-deadline` fait référence au `délai de confirmation`. Ce nouvel abonnement dispose d'un `délai de confirmation` de 60 secondes. Nous vous expliquerons cette fonctionnalité un peu plus loin.

## Répertorier les sujets et les abonnements

Avant d'envoyer votre premier message, vérifiez que votre sujet et votre abonnement ont bien été créés. Vous pouvez répertorier les sujets et les abonnements à l'aide des commandes suivantes :

```bash
gcloud pubsub topics list
```

```bash
gcloud pubsub subscriptions list
```

## Publier des messages sur un sujet

Envoyez deux messages à l'aide des commandes suivantes :

```bash
gcloud pubsub topics publish my-topic --message hello
```

```bash
gcloud pubsub topics publish my-topic --message goodbye
```

Chacune de ces commandes envoie un message. Le premier message est `hello` et le second est `goodbye`. Lorsque votre message est publié, l'ID du message (messageId) est renvoyé par le serveur. Il s'agit d'un identifiant unique attribué automatiquement par le serveur à chaque message.

## Extraire des messages de l'abonnement

### Extraire des messages

Exécutez maintenant la commande suivante pour extraire les messages :

```bash
gcloud pubsub subscriptions \
    pull --auto-ack --limit=2 my-sub
```

Les deux messages que vous venez de publier doivent s'afficher. Ils présentent les données `hello` et `goodbye`, ainsi que leurs `MESSAGE_ID` respectifs. Le `MESSAGE_ID` correspond à l'identifiant unique attribué par le serveur au message.

Remarque : Cloud Pub/Sub ne garantit pas l'ordre des messages. Il se peut également qu'un seul message s'affiche. Dans ce cas, répétez l'exécution de la même commande plusieurs fois, jusqu'à ce que l'autre message apparaisse.

### Confirmation et délai de confirmation

Une fois que vous avez extrait un message et que vous l'avez traité de façon appropriée, vous devez informer Cloud Pub/Sub que vous avez bien reçu ce message. Cette opération est appelée **confirmation**.

Vous avez peut-être remarqué que l'indicateur `--auto-ack` était également communiqué en même temps que la commande `pull`.
L'indicateur `--auto-ack` permet d'extraire et de confirmer le message automatiquement.

## Confirmation manuelle

### Envoyer un nouveau message

Envoyez un nouveau message à l'aide de la commande suivante :

```bash
gcloud pubsub \
    topics publish my-topic --message thanks
```

### Extraire à nouveau des messages

Exécutez la commande suivante pour extraire les messages :

```bash
gcloud pubsub subscriptions \
    pull my-sub
```

Le message `thanks` et les identifiants `MESSAGE_ID` et `ACK_ID` s'affichent. `ACK_ID` est un autre identifiant que vous pouvez utiliser pour confirmer le message.

### Confirmer le message

Après avoir extrait un message, vous devez le confirmer avant la fin du **délai de confirmation**. Par exemple, si un abonnement est configuré avec un **délai de confirmation** de 60 secondes, comme dans ce tutoriel, vous devez confirmer le message dans les 60 secondes suivant son extraction. Si vous ne le faites pas, Cloud Pub/Sub renverra le message.

Confirmez le message à l'aide de la commande suivante (remplacez `ACK_ID` par l'ID réel en effectuant un copier/coller) :

```bash
gcloud pubsub subscriptions ack \
    my-sub --ack-ids ACK_ID
```

## Afficher le sujet et l'abonnement dans l'interface utilisateur Pub/Sub

Nous en avons terminé avec les lignes de commande `gcloud` de ce tutoriel. Toutefois, avant de conclure, examinons l'interface utilisateur de Google Cloud Console.

Vous pouvez également voir les sujets et abonnements dans la section "Pub/Sub".

### Accéder à la section "Pub/Sub"

Ouvrez le [menu][spotlight-console-menu] situé sur le côté gauche de la console.

Ensuite, sélectionnez la section **Pub/Sub**.

<walkthrough-menu-navigation sectionid="CLOUDPUBSUB_SECTION"></walkthrough-menu-navigation>

L'interface utilisateur vous permet également de créer et de gérer des sujets et des abonnements.

### Supprimer le sujet

Cochez la case en regard du sujet que vous avez créé, puis cliquez sur le bouton [Supprimer][spotlight-delete-button] pour le supprimer définitivement.

## Conclusion

Félicitations !

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Vous venez de découvrir les concepts clés de Cloud Pub/Sub à l'aide de l'outil de ligne de commande `gcloud`. Vous avez aussi eu un aperçu de l'interface utilisateur de Cloud Pub/Sub. La prochaine étape consiste à créer vos applications. Pour en savoir plus, consultez la [documentation relative à Pub/Sub][pubsub-docs].

Liste des opérations que vous pouvez effectuer :

[Consulter des exemples de code](https://cloud.google.com/pubsub/docs/quickstart-client-libraries)

[pubsub-docs]: https://cloud.google.com/pubsub/docs/
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-delete-button]: walkthrough://spotlight-pointer?cssSelector=.p6n-icon-delete
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
