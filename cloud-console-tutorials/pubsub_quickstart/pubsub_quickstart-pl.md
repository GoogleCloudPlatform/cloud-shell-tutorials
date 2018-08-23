# Wprowadzenie do Cloud Pub/Sub

<walkthrough-tutorial-url url="https://cloud.google.com/pubsub/quickstart-console"></walkthrough-tutorial-url></walkthrough-test-start-page>

<walkthrough-devshell-precreate></walkthrough-devshell-precreate>

## Wstęp

Cloud Pub/Sub to w pełni zarządzana usługa do komunikacji w czasie rzeczywistym, która umożliwia wysyłanie i odbieranie wiadomości między niezależnymi aplikacjami. Ten samouczek zawiera krótkie wprowadzenie, jak używać narzędzia `gcloud` do obsługi interfejsu wiersza poleceń Cloud Pub/Sub.

## Konfiguracja projektu

Google Cloud Platform organizuje zasoby w projekty. Dzięki temu wszystkie zasoby powiązane z jedną aplikacją są przechowywane w jednym miejscu.

Aby można było skonfigurować wiadomości, Cloud Pub/Sub wymaga utworzenia projektu.

<walkthrough-project-setup></walkthrough-project-setup>

## Tworzenie pierwszego tematu

### Otwieranie Google Cloud Shell

Cloud Shell to wbudowane narzędzie wiersza poleceń konsoli. Użyjesz go do skonfigurowania Cloud Pub/Sub.

Kliknij [ikonę][spotlight-open-devshell] <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon> na pasku nawigacyjnym u góry konsoli, aby otworzyć Cloud Shell.

### Tworzenie tematu

Temat to nazwany zasób, do którego wysyłane będą wiadomości. Utwórz pierwszy temat przy pomocy tego polecenia:

```bash
gcloud pubsub topics create my-topic
```

## Dodawanie subskrypcji

Aby odbierać wiadomości, utwórz subskrypcje. Subskrypcja musi mieć odpowiedni temat. Utwórz pierwszą subskrypcję przy pomocy tego polecenia:

```bash
gcloud pubsub subscriptions \
    create my-sub --topic my-topic \
    --ack-deadline=60
```

To polecenie tworzy subskrypcję o nazwie `my-sub` powiązaną z tematem `my-topic`. Wszystkie wiadomości publikowane w temacie `my-topic` będą dostarczane w ramach tej subskrypcji.

Zwróć uwagę na opcję `--ack-deadline=60`. `ack-deadline` oznacza `Termin potwierdzenia`. Nasza nowa subskrypcja ma 60-sekundowy `Termin potwierdzenia`. Wyjaśnimy to nieco później.

## Wyświetlanie listy tematów i subskrypcji

Zanim wyślesz pierwszą wiadomość, sprawdź, czy temat i subskrypcja zostały pomyślnie utworzone. Wyświetl listę tematów i subskrypcji przy pomocy tego polecenia:

```bash
gcloud pubsub topics list
```

```bash
gcloud pubsub subscriptions list
```

## Publikowanie wiadomości w temacie

Wyślij dwie wiadomości, używając tych poleceń:

```bash
gcloud pubsub topics publish my-topic --message hello
```

```bash
gcloud pubsub topics publish my-topic --message goodbye
```

Każde z tych poleceń powoduje wysłanie wiadomości. Pierwsza wiadomość brzmi `hello`, a druga – `goodbye`. Gdy wiadomość zostanie opublikowana, serwer powinien odesłać jej identyfikator (messageId). To unikalny identyfikator automatycznie przypisywany przez serwer do każdej wiadomości.

## Pobieranie wiadomości z subskrypcji

### Pobieranie wiadomości

Pobierz teraz wiadomości za pomocą tego polecenia:

```bash
gcloud pubsub subscriptions \
    pull --auto-ack --limit=2 my-sub
```

Prawdopodobnie wyświetliły Ci się dwie opublikowane przed chwilą wiadomości. Wiadomości mają treść `hello` i `goodbye`, a także `MESSAGE_ID`. `MESSAGE_ID` to unikalny identyfikator wiadomości przypisany przez serwer.

Uwaga: Cloud Pub/Sub nie gwarantuje zachowania kolejności wiadomości. Możliwe jest także, że wyświetlona została tylko jedna wiadomość. W takim przypadku spróbuj wykonać to samo polecenie kilka razy, do momentu wyświetlenia drugiej wiadomości.

### Potwierdzenie i termin potwierdzenia

Po pobraniu i prawidłowym przetworzeniu wiadomości musisz powiadomić Cloud Pub/Sub o jej odebraniu. Czynność ta jest określana jako **potwierdzenie**.

Być może zauważysz flagę `--auto-ack` obok polecenia `pull`.
Flaga `--auto-ack` powoduje automatyczne pobranie i potwierdzenie odebrania wiadomości.

## Potwierdzanie ręczne

### Wysyłanie nowej wiadomości

Wyślij nową wiadomość, używając tego polecenia:

```bash
gcloud pubsub \
    topics publish my-topic --message thanks
```

### Ponowne pobieranie wiadomości

Pobierz wiadomości za pomocą:

```bash
gcloud pubsub subscriptions \
    pull my-sub
```

To powinno spowodować wyświetlenie wiadomości `thanks`, a także identyfikatorów `MESSAGE_ID` oraz `ACK_ID`. `ACK_ID` to kolejny identyfikator – używa się go do potwierdzania, że wiadomość została odebrana.

### Potwierdzanie odebrania wiadomości

Po pobraniu wiadomości trzeba potwierdzić jej odebranie przed upływem **terminu potwierdzenia**. Na przykład jeśli w subskrypcji skonfigurowano 60-sekundowy **termin potwierdzenia**, tak jak zrobiliśmy to w tym samouczku, konieczne będzie potwierdzenie odebrania wiadomości w ciągu 60 sekund po jej pobraniu. Jeżeli do tego nie dojdzie, Cloud Pub/Sub ponownie wyśle wiadomość.

Aby potwierdzić, że wiadomość została odebrana, użyj tego polecenia (zastąp `ACK_ID` rzeczywistą wartością – użyj funkcji kopiuj/wklej):

```bash
gcloud pubsub subscriptions ack \
    my-sub --ack-ids ACK_ID
```

## Wyświetlanie tematu i subskrypcji w interfejsie użytkownika Pub/Sub

To już koniec samouczka poświęconego narzędziu wiersza poleceń `gcloud`, ale zanim go zamkniesz, przyjrzyj się interfejsowi użytkownika Google Cloud Console.

W sekcji Pub/Sub możesz zapoznać się z tematami i subskrypcjami.

### Przechodzenie do sekcji Pub/Sub

Otwórz [menu][spotlight-console-menu] po lewej stronie konsoli.

Wybierz sekcję **Pub/Sub**.

<walkthrough-menu-navigation sectionid="CLOUDPUBSUB_SECTION"></walkthrough-menu-navigation>

Interfejs użytkownika pozwala również na tworzenie tematów oraz subskrypcji i zarządzanie nimi.

### Usuwanie tematu

Zaznacz pole wyboru obok utworzonego tematu i kliknij [przycisk Usuń][spotlight-delete-button], aby trwale usunąć temat.

## Podsumowanie

Gratulacje!

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Właśnie udało Ci się zapoznać z podstawowymi założeniami Cloud Pub/Sub z wykorzystaniem narzędzia wiersza poleceń `gcloud` i wiesz już, jak wygląda interfejs Cloud Pub/Sub. Pozostaje Ci już tylko tworzyć aplikacje. Aby dowiedzieć się więcej, zapoznaj się z [dokumentacją Pub/Sub][pubsub-docs].

Oto co możesz teraz zrobić:

[Wyświetl przykładowe fragmenty kodu](https://cloud.google.com/pubsub/docs/quickstart-client-libraries)

[pubsub-docs]: https://cloud.google.com/pubsub/docs/
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-delete-button]: walkthrough://spotlight-pointer?cssSelector=.p6n-icon-delete
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
