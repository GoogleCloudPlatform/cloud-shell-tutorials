# Démarrage rapide de Cloud Storage

## Bienvenue dans Google Cloud Storage

<walkthrough-tutorial-url url="https://cloud.google.com/storage/docs/quickstart-console"></walkthrough-tutorial-url>

Google Cloud Storage est une solution de stockage puissante et économique pour les objets non structurés. Elle est parfaitement adaptée à l'hébergement de contenus Web en direct, au stockage de données à des fins d'analyse, à l'archivage ou encore à la sauvegarde.

Dans ce tutoriel, nous vous montrons à quel point il est simple de commencer à stocker des objets dans Cloud Storage. Voici ce que vous allez faire :

  *  **Créer un bucket**

     Les buckets contiennent les objets (tout type de fichiers) que vous voulez stocker dans Cloud Storage.

  *  **Importer et partager des objets**

     Commencez à utiliser votre bucket en important un objet et en le rendant accessible à tous.

  *  **Effectuer un nettoyage**

     Lors de l'étape finale, vous supprimerez le bucket et l'objet que vous avez créés pour ce tutoriel.

Étant donné que vous supprimerez votre bucket et votre objet à la fin, la réalisation de ce tutoriel ne vous coûtera rien.

## Configuration du projet

Cloud Storage a besoin d'un projet pour créer des ressources.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## Créer un bucket

Dans Cloud Storage, vous stockez les objets dans des buckets. Pour créer un bucket, vous devez accéder au navigateur Cloud Storage.

Ouvrez le [menu][spotlight-menu] situé sur le côté gauche de la console.

Sélectionnez ensuite la section **Storage**.

<walkthrough-menu-navigation sectionid="STORAGE_SECTION"></walkthrough-menu-navigation>

## Créer un bucket

Avant de pouvoir importer des objets, vous devez créer un "bucket" dans lequel vous les stockerez. Les buckets vous aident à organiser vos objets et à contrôler leur accès.

  1. Cliquez sur [Créer un bucket](walkthrough://spotlight-pointer?cssSelector=#p6ntest-cloudstorage-create-first-bucket-button,).

  1. Sur la page de création du bucket, spécifiez ses propriétés. Voici quelques points à garder à l'esprit :

     *  **Nom** : utilisez un nom unique. Un message d'erreur s'affiche si le nom saisi est identique à celui d'un autre bucket de Cloud Storage.
     *  **Classe de stockage par défaut** : il s'agit de la classe de stockage attribuée par défaut aux objets ajoutés à votre bucket. Votre choix dépend principalement de la fréquence estimée pour l'accès aux objets, ainsi que de l'éventuelle diffusion des données à l'international. La classe de stockage a un impact sur le coût.
     *  **Zone géographique** : nous vous conseillons de conserver vos données à proximité des applications et des utilisateurs qui doivent y accéder. Les options disponibles dépendent de la classe de stockage sélectionnée.

Pour cette exécution test, le choix de la classe de stockage et de la zone géographique importe peu, étant donné que vous supprimerez le bucket à la fin.

  1. Cliquez sur [Créer][spotlight-create-button].

## Importer un objet et le rendre accessible à tous

Maintenant que votre bucket est créé, vous pouvez commencer à importer des objets.

  1. En haut de la page, cliquez sur [Importer des fichiers][spotlight-upload-file].

  1. Sélectionnez le fichier que vous voulez importer. Vous pouvez importer tout type de fichiers.

     Vous n'avez pas de fichier ? [Créez un exemple de fichier][create-sample-file], puis cliquez sur [Actualiser le bucket][spotlight-refresh-bucket] en haut de la page pour l'afficher dans votre bucket. (Astuce : vous pouvez également importer des objets en effectuant un glisser-déposer dans l'espace situé sous le nom de votre bucket.)

## Supprimer le bucket

Supprimez à présent le bucket que vous venez de créer. La suppression d'un bucket entraîne également celle de son contenu.

  1. Dans la partie supérieure du tableau, cliquez sur [Buckets][spotlight-buckets-link] pour revenir à la liste des buckets.

  1. Cochez la case située à côté de votre bucket. S'il existe d'autres buckets dans ce projet, vous pouvez utiliser la barre de recherche pour filtrer la liste des buckets et trouver le vôtre.

  1. Dans la partie supérieure de la page, cliquez sur [Supprimer][spotlight-delete-buckets], puis confirmez l'opération.

## Conclusion

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Félicitations !

Maintenant que vous savez stocker des objets dans Cloud Storage, vous pouvez découvrir comment appliquer vos connaissances en conditions réelles en [hébergeant un site Web statique](https://cloud.google.com/storage/docs/hosting-static-website).

Vous pouvez aussi apprendre à utiliser Cloud Storage avec l'[outil de ligne de commande gsutil](https://cloud.google.com/storage/docs/quickstart-gsutil).

Découvrez également comment [utiliser gratuitement](https://cloud.google.com/free) Cloud Storage et les autres services GCP.

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
