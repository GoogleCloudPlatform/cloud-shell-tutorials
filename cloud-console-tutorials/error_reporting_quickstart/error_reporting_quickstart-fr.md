# Stackdriver Error Reporting

## Présentation

Stackdriver Error Reporting rassemble et présente les erreurs produites par les services cloud.

Suivez ce tutoriel pour découvrir l'interface Web de Error Reporting. Vous apprendrez à répertorier les erreurs de vos applications, à les explorer en détail et à apporter des corrections.

## Configuration du projet

<walkthrough-project-setup></walkthrough-project-setup>

## Générer des erreurs

Avant de poursuivre, vous devez signaler des erreurs artificielles à l'aide d'une commande `gcloud`.

En situation réelle, les erreurs sont directement signalées par l'application en cours d'exécution. Une fois ce tutoriel terminé, nous vous invitons à en apprendre davantage sur la configuration de Error Reporting.

### Ouvrir Google Cloud Shell

Pour ouvrir Cloud Shell, cliquez sur l'<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[icône][spotlight-open-devshell] dans la barre de navigation située en haut de la console.

### Signaler quelques erreurs

Cliquez sur le bouton **Copier dans le presse-papiers** en haut à droite du script suivant, puis exécutez ce dernier dans Cloud Shell pour générer des exemples d'erreurs.

```bash
COUNTER=0
while [  $COUNTER -lt 11 ]; do
    gcloud beta error-reporting events report --service tutorial --service-version v$((COUNTER/10+1)) \
        --message "java.lang.RuntimeException: Error rendering template $COUNTER
          at com.example.TestClass.test(TestClass.java:51)
          at com.example.AnotherClass(AnotherClass.java:25)
          at javax.servlet.http.HttpServlet.service (HttpServlet.java:617)
          at javax.servlet.http.HttpServlet.service (HttpServlet.java:717)"
    if [ $COUNTER -lt 3 ]; then
      gcloud beta error-reporting events report --service tutorial --service-version v1 \
          --message "java.lang.ArrayIndexOutOfBoundsException: $COUNTER
            at com.example.AppController.createUser(AppController.java:42)
            at com.example.User(User.java:31)
            at javax.servlet.http.HttpServlet.service (HttpServlet.java:617)
            at javax.servlet.http.HttpServlet.service (HttpServlet.java:717)"
    fi
    if [ $COUNTER -eq 10 ]; then
      echo "Toutes les erreurs artificielles sont signalées."
    fi
    let COUNTER=COUNTER+1
done
```

### Fermer Cloud Shell

Fermez Cloud Shell, puis cliquez sur *Continuer*.

## Répertorier les erreurs de l'application

Stackdriver Error Reporting vous permet d'avoir un aperçu des erreurs signalées.

### Ouvrir Error Reporting

Ouvrez le [menu][spotlight-console-menu] situé sur le côté gauche de la console.

Ensuite, faites défiler le menu jusqu'à la catégorie **Stackdriver**, puis sélectionnez **Error Reporting**.

<walkthrough-menu-navigation sectionid="CRASH_SECTION"></walkthrough-menu-navigation>

### Trier par *Première occurrence*

L'analyse des traces de la pile permet de regrouper les erreurs qui se produisent dans l'application et d'éliminer les doublons. Chaque élément de la liste s'accompagne d'un résumé. Vous pouvez ainsi déterminer à quel moment l'erreur a commencé à apparaître, à quelle fréquence elle survient et si elle s'est produite récemment.

Par défaut, les erreurs sont triées en fonction des *occurrences*. Cliquez sur l'en-tête de la colonne *Première occurrence* pour voir les erreurs qui ont commencé à se produire récemment.

### Recevoir des notifications en cas d'erreur

Vous avez la possibilité d'être averti par un e-mail ou une notification push mobile lorsqu'une nouvelle erreur se produit dans le projet. Pour recevoir ces notifications, cliquez sur *Activer les notifications*.

Cliquez sur *Continuer* lorsque vous avez terminé.

## Comprendre les détails d'une erreur

### Ouvrir un rapport d'erreurs

Cliquez sur une erreur de la liste pour afficher ses détails.

### Associer un problème à cette erreur

Cette page fournit des informations sur une erreur, ainsi que son historique.

Après avoir examiné une nouvelle erreur, vous allez généralement créer une entrée pour cette erreur dans l'outil de suivi des problèmes de votre équipe. Cette entrée peut être associée à l'erreur consignée dans Stackdriver Error Reporting.

Pour ce faire :

  *  Cliquez sur *Associer à un problème* en haut de l'écran (vous devrez peut-être ouvrir le menu **Autres actions** pour afficher ce lien).
  *  Saisissez `http://example.com/issues/1234` dans la boîte de dialogue.
  *  Cliquez sur *Enregistrer*.

### Explorer les traces de la pile

Les cadres des traces de pile qui ne proviennent pas du code de votre application sont masqués pour plus de lisibilité.

Cliquez sur *Tout afficher* dans un exemple d'erreur pour faire apparaître les cadres des différentes piles du framework.

## Conclusion

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Félicitations ! Vous avez terminé le tutoriel Stackdriver Error Reporting.

Liste des opérations que vous pouvez effectuer :

### Configurer Error Reporting pour votre projet

Découvrez comment configurer Error Reporting pour vos services en cours d'exécution dans la [documentation de configuration][errors-setup].

### Consulter d'autres tutoriels Stackdriver

Déboguez une application de production en vous appuyant sur le démarrage rapide de [Stackdriver Debugger][debug-quickstart].

Comprenez la latence de vos applications avec le démarrage rapide de [Stackdriver Trace][trace-quickstart].

[debug-quickstart]: https://cloud.google.com/debugger/docs/quickstart
[errors-setup]: https://cloud.google.com/error-reporting/docs/how-to
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[trace-quickstart]: https://cloud.google.com/trace/docs/quickstart
