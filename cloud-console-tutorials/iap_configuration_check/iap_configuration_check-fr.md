# Activer le service IAP pour GCE/GKE

Identity-Aware Proxy (IAP) sécurise uniquement le trafic passant par l'équilibreur de charge. Suivez la procédure ci-dessous pour protéger votre application contre d'éventuelles attaques.

[En savoir plus](https://cloud.google.com/iap/docs/)

## Voici la procédure à suivre :

### Vérifier la configuration du réseau

Si les adresses IP de l'équilibreur de charge (`130.211.0.0/22` et `35.191.0.0/16`) ne peuvent pas atteindre vos backends, le service IAP **ne fonctionne pas**.

Si aucune autre adresse IP ne peut accéder à vos backends, le trafic ignore votre règle d'accès IAP. Cela peut être utile dans certains cas, par exemple pour autoriser les systèmes de surveillance à se connecter aux backends.

### Surveiller la configuration du réseau

Si votre configuration change après l'activation du service IAP, la sécurité risque d'être compromise.
Déployez [Forseti Security][forseti-security], un outil Open Source géré par Google, pour surveiller en permanence la configuration de vos projets et envoyer des notifications.

### Mettre en œuvre une vérification des en-têtes signés

Découvrez comment [protéger votre application contre le contournement des règles d'accès IAP](https://cloud.google.com/iap/docs/signed-headers-howto), notamment dans les cas suivants :

  *  Désactivation accidentelle du service IAP par un administrateur du projet
  *  Erreurs de configuration du réseau
  *  Connexion d'un utilisateur sur la VM, puis connexion au serveur Web via l'hôte local

### Valider la configuration

Vous confirmez avoir lu la documentation et configuré la ressource GCE/GKE en conséquence.

[Démonstration][spotlight-config-reviewed]

[forseti-security]: https://opensource.google.com/projects/forseti-security
[spotlight-config-reviewed]: walkthrough://spotlight-pointer?spotlightId=iap-network-config-reviewed
