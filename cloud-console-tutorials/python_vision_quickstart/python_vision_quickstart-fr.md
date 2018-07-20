# API Cloud Vision

<walkthrough-test-start-page url="/start?tutorial=python_vision_quickstart_v2"></walkthrough-test-start-page>

<walkthrough-tutorial-url url="https://cloud.google.com/vision/docs/label-tutorial"></walkthrough-tutorial-url>

<walkthrough-watcher-constant value="https://github.com/GoogleCloudPlatform/python-docs-samples.git" key="repo-url"></walkthrough-watcher-constant>

<walkthrough-watcher-constant value="python-docs-samples" key="repo-name"></walkthrough-watcher-constant>

<walkthrough-devshell-precreate></walkthrough-devshell-precreate>

## Présentation

Ce tutoriel vous présente une application de base de l'API Vision à l'aide d'une
requête `LABEL_DETECTION`. Une requête `LABEL_DETECTION` annote une image avec
un libellé (ou un "tag") qui est sélectionné en fonction du contenu de l'image.
Par exemple, l'image d'une grange peut produire le libellé "grange", "ferme" ou
toute autre annotation similaire.

Voici la procédure que vous allez suivre :

*   **Exécuter une application de détection de thèmes** : vous allez découvrir
    comment exécuter votre application avec Google Cloud Shell directement
    depuis votre navigateur.
*   **Une fois le didacticiel terminé :** votre application sera réelle et vous
    pourrez la tester ou la supprimer pour en créer une autre.

[Python et les logos Python sont des marques ou des marques déposées de Python
Software Foundation.](walkthrough://footnote)

# Configuration du projet

Vous devez activer l'API Cloud Vision via un projet.

Google Cloud Platform organise les ressources en projets. Vous pouvez ainsi
collecter toutes les ressources associées à une seule application au même
endroit.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## Activer l'API Vision

Vous devez activer l'API Vision pour votre projet afin d'accepter des requêtes.

### Accéder au gestionnaire d'API

Le gestionnaire d'API définit les API à activer pour votre projet.

Ouvrez le [menu](walkthrough://spotlight-pointer?spotlightId=console-nav-menu)
situé à gauche de la console.

Puis, sélectionnez la section **API et services**.

<walkthrough-menu-navigation sectionid="API_SECTION"></walkthrough-menu-navigation>

### Afficher les API disponibles

Pour activer les API, cliquez sur le bouton [Activer des
API](walkthrough://spotlight-pointer?cssSelector=.p6n-action-bar-button).

### Sélectionner l'API Vision

Cliquez sur le lien de l'[API Vision](walkthrough://spotlight-pointer?spotlightId=api-vision.googleapis.com).

### Activer l'API Vision

Cliquez sur le bouton [Activer](walkthrough://spotlight-pointer?spotlightId=api-enable-vision.googleapis.com) pour activer
l'API Vision. Vous créerez des identifiants pour votre projet dans la suite de
ce tutoriel.

## Utiliser Google Cloud Shell

Cloud Shell est un outil de ligne de commande intégré pour la console. Vous
allez l'utiliser pour exécuter votre application.

### Ouvrir Google Cloud Shell

Pour ouvrir Cloud Shell, cliquez sur
l'[icône](walkthrough://spotlight-pointer?spotlightId=devshell-activate-button)
<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>
dans la barre de navigation située en haut de la console.

### Cloner l'exemple de code

Utilisez Cloud Shell pour cloner et parcourir le code de l'application
Hello World. L'exemple de code est cloné à partir du dépôt de votre projet vers
Cloud Shell.

Remarque : Si le répertoire existe déjà, supprimez les anciens fichiers avant
d'effectuer le clonage :

```bash
rm -rf {{repo-name}}
```

Clonez un exemple de dépôt :

```bash
git clone {{repo-url}}
```

Ensuite, accédez au répertoire du tutoriel :

```bash
cd {{repo-name}}/vision/cloud-client/quickstart
```

## Configurer le déploiement

Vous vous trouvez maintenant dans le répertoire principal pour l'exemple de
code. Vous allez examiner les fichiers de configuration de votre application.

### Explorer l'application

Saisissez la commande suivante pour afficher le code de votre application :

```bash
cat quickstart.py
```

Le fichier `quickstart.py` formate les informations de votre requête, comme le
type de requête et son contenu. Développez chaque section ci-dessous pour en
savoir plus.

Les requêtes effectuées avec l'API Vision sont fournies par des objets JSON.
Consultez la [documentation de référence de l'API Vision][vision-request-doc]
pour en savoir plus sur la structure spécifique d'une telle requête. Votre
requête JSON n'est envoyée que lorsque vous appelez la fonction `execute`. Ce
schéma vous permet de transmettre ces requêtes et d'appeler la fonction
`execute` selon vos besoins.

## Tester l'application

La configuration d'identifiants est requise pour utiliser l'API. Pour utiliser
une API Cloud, vous devez configurer les [identifiants][auth-doc] appropriés
pour votre application. Elle pourra ainsi authentifier son identité auprès du
service et obtenir la permission de réaliser des tâches. Vous testerez ensuite
l'API avec des exemples d'images.

### Créer un compte de service

Vous devez créer un compte de service pour authentifier vos requêtes d'API. Si
vous en avez déjà créé un, il sera réutilisé.

```bash
gcloud iam service-accounts create vision-quickstart
```

### Créer des identifiants

Ensuite, créez une clé de compte de service et définissez-la comme identifiant
par défaut.

```bash
gcloud iam service-accounts keys create key.json --iam-account    vision-quickstart@{{project-id}}.iam.gserviceaccount.com
```

```bash
export GOOGLE_APPLICATION_CREDENTIALS=key.json
```

<walkthrough-test-code-output text="created key"></walkthrough-test-code-output>

### Tester l'application

Pour tester votre application avec un exemple d'image, saisissez ce qui suit :

```bash
python quickstart.py
```

La ressource de l'image `resources/wakeupcat.jpg` est indiquée dans la source.
([Afficher l'image][cat-picture])

## Conclusion

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Félicitations ! Vous êtes prêt à utiliser l'API Cloud Vision.

Liste des opérations que vous pouvez effectuer :

*   Suivez le tutoriel sur la [détection de visages][face-tutorial].
*   Suivez le tutoriel sur la [détection de documents
    texte][document-text-tutorial].
*   Consultez les [exemples d'application][vision-samples].
*   Téléchargez le [SDK Google Cloud][get-cloud-sdk] afin de l'exécuter sur
    votre machine locale.

[auth-doc]: https://cloud.google.com/vision/docs/auth
[cat-picture]: https://raw.githubusercontent.com/GoogleCloudPlatform/python-docs-samples/master/vision/cloud-client/quickstart/resources/wakeupcat.jpg
[document-text-tutorial]: https://cloud.google.com/vision/docs/fulltext-annotations
[face-tutorial]: https://cloud.google.com/vision/docs/face-tutorial
[get-cloud-sdk]: https://cloud.google.com/sdk/
[vision-request-doc]: https://cloud.google.com/vision/reference/rest
[vision-samples]: https://cloud.google.com/vision/docs/samples
