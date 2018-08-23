# Démarrage rapide avec Compute Engine

## Créer une application Liste de tâches avec MongoDB

<walkthrough-tutorial-duration duration="15"></walkthrough-tutorial-duration>

Dans ce guide de démarrage rapide, vous allez utiliser Compute Engine pour créer
une application à deux niveaux. La VM frontend exécute une application Web Liste
de tâches Node.js, tandis que la VM backend exécute MongoDB.

Ce tutoriel vous guide pour les opérations suivantes :

*   Créer et configurer deux VM
*   Configurer les règles de pare-feu
*   Utiliser SSH pour installer des packages sur les VM

## Configuration du projet

Google Cloud Platform organise les ressources en projets. Vous pouvez ainsi
collecter toutes les ressources associées à une application au même endroit.

<walkthrough-project-billing-setup permissions="compute.instances.create"></walkthrough-project-billing-setup>

## Accéder à Compute Engine

Ouvrez le [menu][spotlight-console-menu] situé sur le côté gauche de la console.

Sélectionnez ensuite la section **Compute Engine**.

<walkthrough-menu-navigation sectionid="COMPUTE_SECTION"></walkthrough-menu-navigation>

## Créer des instances

Vous allez créer deux instances (serveurs backend et frontend) pour
l'application.

### Créer l'instance backend

Créez tout d'abord l'instance backend qui exécute MongoDB. Ce serveur stocke les
tâches à effectuer.

Cliquez sur le bouton [Créer une instance][spotlight-create-instance].

*   Sélectionnez un [nom][spotlight-instance-name] et une
    [zone][spotlight-instance-zone] pour cette instance.

*   Sélectionnez [f1-micro][spotlight-machine-type]. Cela entraînera moins de
    frais.

    *   [En savoir plus sur la tarification][pricing]

*   Sélectionnez [Ubuntu 14.04 LTS][spotlight-boot-disk] en tant qu'image du
    disque de démarrage pour ce tutoriel.

*   Dans le [sélecteur de pare-feu][spotlight-firewall], sélectionnez
    **Autoriser le trafic HTTP**. Cela ouvre le port 80 (HTTP) pour l'accès à
    l'application.

*   Cliquez sur le bouton [Créer][spotlight-submit-create] pour créer
    l'instance.

Remarque : Une fois l'instance créée, des frais sont facturés sur votre compte
de facturation conformément aux tarifs de GCE. Vous supprimerez l'instance
ultérieurement afin de ne payer aucuns frais supplémentaires.

### Créer l'instance frontend

Pendant que la VM backend fonctionne, créez l'instance frontend qui exécute
l'application Liste de tâches Node.js. Utilisez la même configuration que pour
l'instance backend.

## Procéder à la configuration

Vous allez installer une base de données MongoDB sur l'instance backend pour
enregistrer vos données.

Les [boutons SSH][spotlight-ssh-buttons] de la table permettent d'ouvrir une
session SSH sur votre instance dans une fenêtre distincte.

Pour ce tutoriel, vous devez vous connecter à l'aide de Cloud Shell. Cloud Shell
est un outil de ligne de commande intégré pour la console.

### Ouvrir Cloud Shell

Pour ouvrir Cloud Shell, cliquez sur
l'<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[icône][spotlight-open-devshell]
dans la barre de navigation située en haut de la console.

### Patienter pendant la création de l'instance

Avant de pouvoir continuer ce tutoriel, vous devez attendre que les instances
soient créées. Pour suivre l'activité, cliquez sur le
[menu de notification][spotlight-notification-menu] dans la barre de navigation
située en haut de la console.

## Se connecter à l'instance backend

### Se connecter à l'instance

Saisissez la commande suivante pour vous connecter en SSH à la VM. Si vous
utilisez le SSH depuis Cloud Shell pour la première fois, vous devez créer une
clé privée. Saisissez la zone et le nom de l'instance que vous avez créée.

```bash
gcloud compute --project "{{id-projet}}" ssh --zone <zone-backend> <nom-backend>
```

### Installer la base de données backend

Une fois la connexion SSH à l'instance backend établie, utilisez les commandes
suivantes pour installer la base de données backend :

Mettez à jour les packages et installez MongoDB. Lorsque vous êtes invité à
poursuivre l'installation, saisissez `Y` :

```bash
sudo apt-get update
```

```bash
sudo apt-get install mongodb
```

### Exécuter la base de données

Le service MongoDB a démarré lors de l'installation. Vous devez l'arrêter pour
pouvoir modifier son mode d'exécution.

```bash
sudo service mongodb stop
```

Créez un répertoire pour MongoDB, puis exécutez le service MongoDB en
arrière-plan sur le port 80.

```bash
sudo mkdir $HOME/db
```

```bash
sudo mongod --dbpath $HOME/db --port 80 --fork --logpath /var/tmp/mongodb
```

Quittez ensuite la session SSH en utilisant la commande `exit` :

```bash
exit
```

## Se connecter à l'instance frontend

### Installer et exécuter l'application Web sur la VM frontend

Le serveur backend est en cours d'exécution. Il est donc temps d'installer
l'application Web frontend.

### Se connecter à l'instance

Saisissez la commande suivante pour vous connecter en SSH à la VM. Saisissez la
zone et le nom de l'instance que vous avez créée.

```bash
gcloud compute --project "{{id-projet}}" ssh --zone <zone-frontend> <nom-frontend>
```

### Installer les dépendances

Maintenant que vous êtes connecté à votre instance frontend, mettez à jour les
packages et installez git, Node.js et npm. Lorsque vous êtes invité à poursuivre
l'opération, saisissez `Y`.

```bash
sudo apt-get update
```

```bash
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
```

```bash
sudo apt-get install git nodejs
```

### Installer et exécuter l'application Web frontend

Clonez l'exemple d'application, puis installez les dépendances d'application.

```bash
git clone https://github.com/GoogleCloudPlatform/todomvc-mongodb.git
```

```bash
cd todomvc-mongodb; npm install
```

```bash
sed -i -e 's/8080/80/g' server.js
```

Démarrez l'application Web Liste de tâches à l'aide de la commande suivante, en
saisissant les [adresses IP internes][spotlight-internal-ip] pour les instances
que vous avez créées.

```bash
sudo nohup nodejs server.js --be_ip <adresse-IP-interne-backend> --fe_ip <adresse-IP-interne-frontend> &
```

Quittez ensuite la session SSH en utilisant la commande `exit` :

```bash
exit
```

### Accéder à l'application

Accédez à votre serveur Web à l'aide de l'adresse IP indiquée dans la colonne
[Adresse IP externe][spotlight-external-ip] située à côté de votre instance
frontend.

## Effectuer un nettoyage

Pour supprimer vos instances, cochez la [case][spotlight-instance-checkbox]
située à côté du nom de l'instance en question, puis cliquez sur le bouton
[Supprimer][spotlight-delete-button].

## Conclusion

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Vous avez terminé.

Pour aller plus loin :

*   Recherchez des
    [exemples Google Cloud Platform sur GitHub](http://googlecloudplatform.github.io/).

*   Apprenez à configurer
    l'[équilibrage de charge](https://cloud.google.com/compute/docs/load-balancing/).

*   Découvrez comment
    [transférer des fichiers sur votre machine virtuelle](https://cloud.google.com/compute/docs/instances/transfer-files/).

*   Apprenez à
    [exécuter des conteneurs](https://cloud.google.com/compute/docs/containers).

[pricing]: https://cloud.google.com/compute/#compute-engine-pricing
[spotlight-boot-disk]: walkthrough://spotlight-pointer?cssSelector=vm-set-boot-disk
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-control-panel]: walkthrough://spotlight-pointer?cssSelector=#p6n-action-bar-container-main
[spotlight-create-instance]: walkthrough://spotlight-pointer?spotlightId=gce-zero-new-vm,gce-vm-list-new
[spotlight-delete-button]: walkthrough://spotlight-pointer?cssSelector=.p6n-icon-delete
[spotlight-external-ip]: walkthrough://spotlight-pointer?cssSelector=.p6n-external-link
[spotlight-firewall]: walkthrough://spotlight-pointer?spotlightId=gce-vm-add-firewall
[spotlight-instance-checkbox]: walkthrough://spotlight-pointer?cssSelector=.p6n-checkbox-form-label
[spotlight-instance-name]: walkthrough://spotlight-pointer?spotlightId=gce-vm-add-name
[spotlight-instance-zone]: walkthrough://spotlight-pointer?spotlightId=gce-vm-add-zone-select
[spotlight-internal-ip]: walkthrough://spotlight-pointer?cssSelector=gce-internal-ip
[spotlight-machine-type]: walkthrough://spotlight-pointer?spotlightId=gce-add-machine-type-select
[spotlight-notification-menu]: walkthrough://spotlight-pointer?cssSelector=.p6n-notification-dropdown,.cfc-icon-notifications
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-ssh-buttons]: walkthrough://spotlight-pointer?cssSelector=gce-connect-to-instance
[spotlight-submit-create]: walkthrough://spotlight-pointer?spotlightId=gce-submit
[spotlight-vm-list]: walkthrough://spotlight-pointer?cssSelector=vm2-instance-list%20.p6n-checkboxed-table
