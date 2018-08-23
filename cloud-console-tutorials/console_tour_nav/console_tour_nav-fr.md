# Présentation de Cloud Console

<walkthrough-tutorial-duration duration="5"></walkthrough-tutorial-duration>

## Présentation

Ce tutoriel détaille les principales fonctionnalités de Cloud Console, dans l'optique de vous préparer à créer et gérer vos applications sur Google Cloud Platform.

Il aborde les concepts suivants :

  *  Projets et ressources GCP
  *  Vue d'ensemble des ressources et journaux d'activité
  *  Navigation et recherche dans la console
  *  Gestion des utilisateurs et des autorisations
  *  Support technique
  *  Ligne de commande GCP intégrée au navigateur

C'est parti !

## Utiliser les ressources GCP

Les ressources GCP sont les composants fondamentaux sur lesquels reposent tous les services Google Cloud. Elles sont hiérarchisées et vous permettent d'organiser votre travail sur GCP.

Les projets forment le premier niveau de la hiérarchie des ressources. Ils contiennent d'autres ressources de bas niveau, telles que des buckets Cloud Storage et des instances Compute Engine.

[En savoir plus sur les ressources GCP][gcp-resources]

### Navigation entre les projets

Naviguez facilement entre vos projets GCP à l'aide l'[outil de sélection de champ d'application][spotlight-project-select] de Cloud Console. Lorsque vous passez d'un projet à un autre, la vue s'adapte automatiquement au second projet et à l'ensemble de ses ressources enfants.

<walkthrough-project-setup></walkthrough-project-setup>

## Naviguer dans les services Google Cloud

### Navigation entre les services

Les services Google Cloud sont accessibles dans le [menu de navigation de gauche][spotlight-console-menu]. Ils sont organisés par familles de produits : Big data, Calcul, Réseau, etc.

### Épinglage de section

Si vous accédez régulièrement à un service, épinglez la section correspondante dans la partie supérieure du menu de navigation. Pour ce faire, passez la souris sur la section et cliquez sur l'icône en forme d'épingle.

Ouvrez le menu de navigation, puis sélectionnez **Accueil** pour continuer.

<walkthrough-menu-navigation sectionid="HOME_SECTION"></walkthrough-menu-navigation>

## Afficher la vue d'ensemble d'un projet

### Tableau de bord de la page d'accueil

Le tableau de bord de la page d'accueil offre une vue d'ensemble du projet GCP sélectionné. Il présente les métriques clés, les données de facturation et d'autres informations utiles.

### Personnalisation

Vous pouvez personnaliser votre tableau de bord en cliquant sur [Personnaliser][spotlight-customize-dashboard].
Chaque fiche peut être masquée, affichée ou déplacée dans une zone différente de la page. En outre, vous pouvez personnaliser chacune d'entre elles à l'aide des options du menu à développer qui s'affiche lorsque vous passez le pointeur de la souris sur la fiche.

## Afficher les activités de vos ressources GCP

Le [Flux d'activité][spotlight-activity-stream] vous permet de visualiser toutes les activités relatives à vos ressources GCP.

Assurez le suivi des mises à jour apportées à un projet par les membres de votre équipe pour identifier les problèmes et auditer les accès. Filtrez facilement le flux pour trouver exactement ce que vous recherchez.

## Lancer une recherche dans Cloud Console

La [barre de recherche][spotlight-search-bar] de Cloud Console vous permet d'accéder rapidement aux produits Google Cloud et à toutes vos ressources sur GCP.

Essayez de rechercher **App Engine** ou le nom de l'un de vos projets.

## Obtenir de l'aide à tout moment

Si vous rencontrez des difficultés ou si vous avez besoin d'aide pour naviguer dans GCP, notre équipe de support est à votre disposition.

[En savoir plus sur le support](http://cloud.google.com/support)

Accédez au support depuis le menu de navigation.

<walkthrough-menu-navigation sectionid="SUPPORT_SECTION"></walkthrough-menu-navigation>

## Gérer les utilisateurs et les autorisations

Google Cloud Identity and Access Management (Cloud IAM) vous permet de créer et gérer des autorisations pour vos ressources GCP.

[En savoir plus sur IAM](https://cloud.google.com/iam/docs/)

Lorsque votre équipe s'agrandit, vous pouvez accorder des accès à vos collègues à l'aide de Cloud IAM dans la section "IAM et administration".

Ajoutez des utilisateurs, des groupes ou des comptes de service, puis attribuez-leur des rôles leur permettant de disposer des autorisations dont ils ont besoin.

<walkthrough-menu-navigation sectionid="IAM_ADMIN_SECTION"></walkthrough-menu-navigation>

## Accéder à la ligne de commande depuis votre navigateur

Google Cloud Shell vous permet d'accéder en ligne de commande à vos ressources cloud directement depuis votre navigateur. Vous pouvez ainsi facilement gérer vos projets et vos ressources sans avoir à installer le SDK Google Cloud ou d'autres outils sur votre système.

Avec <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[Cloud Shell][spotlight-open-devshell], l'outil de ligne de commande gcloud et les autres utilitaires du SDK Cloud dont vous avez besoin sont toujours disponibles au moment opportun, parfaitement à jour et entièrement authentifiés.

[En savoir plus sur Cloud Shell](https://cloud.google.com/shell/)

## Continuer à évoluer dans GCP

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Vous devriez désormais vous sentir à l'aise pour naviguer dans Cloud Console et disposer de bases suffisamment solides pour explorer de nouveaux services et produits.

Notre [documentation détaillée](https://cloud.google.com/docs/) contient également de nombreuses informations : présentation des produits, guides de démarrage rapide, documents de référence sur les API, etc.

Revenez à la page "Premiers pas" pour découvrir d'autres didacticiels.
<walkthrough-menu-navigation sectionid="ONBOARDING_SECTION"></walkthrough-menu-navigation>

[gcp-resources]: https://cloud.google.com/resource-manager/docs/cloud-platform-resource-hierarchy
[spotlight-activity-stream]: walkthrough://spotlight-pointer?cssSelector=.mat-tab-link:nth-of-type(2)
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-customize-dashboard]: walkthrough://spotlight-pointer?cssSelector=.cfc-customize-button
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-project-select]: walkthrough://spotlight-pointer?spotlightId=purview-switcher
[spotlight-search-bar]: walkthrough://spotlight-pointer?cssSelector=.p6n-search-bar,.pcc-platform-bar-search-bar
