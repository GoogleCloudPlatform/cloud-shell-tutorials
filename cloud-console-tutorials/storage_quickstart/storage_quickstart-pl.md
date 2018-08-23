# Krótkie wprowadzenie do Cloud Storage

## Witamy w Google Cloud Storage

<walkthrough-tutorial-url url="https://cloud.google.com/storage/docs/quickstart-console"></walkthrough-tutorial-url>

Google Cloud Storage to zaawansowane i oszczędne rozwiązanie do przechowywania obiektów nieuporządkowanych. Doskonale nadaje się do udostępniania treści w internecie, przechowywania danych do analiz czy też archiwizowania ich i tworzenia ich kopii zapasowych.

W tym samouczku pokażemy Ci, jak łatwe jest przechowywanie obiektów w Cloud Storage. Oto co będziesz robić:

  *  **Utworzenie zasobnika**

     Zasobniki zawierają obiekty (pliki dowolnego typu), które chcesz przechowywać w Cloud Storage.

  *  **Przesłanie i udostępnienie obiektów**

     Aby rozpocząć pracę z zasobnikiem, prześlij do niego obiekt i skonfiguruj go jako publicznie dostępny.

  *  **Czyszczenie danych**

     Na koniec usuń zasobnik i obiekt utworzony podczas pracy z samouczkiem.

Kończąc samouczek, usuniesz zasobnik i obiekt, więc nie obciążymy Cię żadnymi kosztami.

## Konfiguracja projektu

Do utworzenia zasobów Cloud Storage wymaga skonfigurowania projektu.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## Tworzenie zasobnika

W Cloud Storage obiekty są przechowywane w zasobnikach. Aby utworzyć zasobnik, musisz przejść do przeglądarki Cloud Storage.

Otwórz [menu][spotlight-menu] po lewej stronie konsoli.

Wybierz sekcję **Storage**.

<walkthrough-menu-navigation sectionid="STORAGE_SECTION"></walkthrough-menu-navigation>

## Tworzenie zasobnika

Zanim zaczniesz przesyłać obiekty, musisz utworzyć zasobnik do ich przechowywania. Dzięki zasobnikom łatwiej jest organizować obiekty i kontrolować do nich dostęp.

  1. Kliknij [Utwórz zasobnik](walkthrough://spotlight-pointer?cssSelector=#p6ntest-cloudstorage-create-first-bucket-button,)

  1. Na stronie tworzenia zasobnika zdefiniuj jego właściwości. Oto kilka rzeczy, o których warto pamiętać:

     *  **Nazwa**: Twoja nazwa musi być unikalna. Jeśli wybierzesz nazwę, która jest już przypisana do innego zasobnika w Cloud Storage, wyświetli się błąd.
     *  **Domyślna klasa pamięci**: to klasa pamięci domyślnie przypisana do obiektów Twojego zasobnika. Wybór zależy od tego, jak często i skąd będzie następować dostęp do danych. Klasa pamięci ma wpływ na koszty.
     *  **Lokalizacja**: dobrze, aby dane były łatwo dostępne zarówno dla aplikacji, jak i dla użytkowników, którzy z nich korzystają. Dostępne opcje zależą od wyboru klasy pamięci.

Na potrzeby samouczka nie ma znaczenia, jaką klasę pamięci i lokalizację wybierzesz, ponieważ pod koniec i tak usuniesz zasobnik.

  1. Kliknij [Utwórz][spotlight-create-button].

## Przesyłanie obiektu

Po utworzeniu zasobnika możesz rozpocząć przesyłanie obiektów.

  1. U góry strony kliknij [Prześlij pliki][spotlight-upload-file].

  1. Wybierz plik do przesłania. Możesz przesłać plik dowolnego typu.

     Nie masz pliku? [Utwórz przykładowy plik][create-sample-file], a potem kliknij [Odśwież zasobnik][spotlight-refresh-bucket] u góry strony, aby zobaczyć go w zasobniku. Wskazówka: możesz również przesyłać pliki, przeciągając i upuszczając je w obszarze pod nazwą zasobnika.

## Usuwanie zasobnika

Usuńmy teraz utworzony przed chwilą zasobnik. Usunięcie zasobnika powoduje także usunięcie jego zawartości.

  1. U góry tabeli kliknij [Zasobniki][spotlight-buckets-link], aby wrócić do listy zasobników.

  1. Zaznacz pole wyboru obok zasobnika. Jeśli w tym projekcie są inne zasobniki i nie możesz znaleźć tych, których szukasz, skorzystaj z paska wyszukiwania, aby przefiltrować listę zasobników.

  1. U góry strony kliknij [Usuń][spotlight-delete-buckets] i potwierdź usunięcie.

## Podsumowanie

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Gratulacje!

Teraz gdy już wiesz, jak przechowywać obiekty w Cloud Storage, być może zainteresuje Cię również, jak można wypróbować tę wiedzę w praktyce i [hostować witrynę statyczną](https://cloud.google.com/storage/docs/hosting-static-website).

Możesz też nauczyć się korzystać z Cloud Storage za pomocą [narzędzia wiersza poleceń gsutil](https://cloud.google.com/storage/docs/quickstart-gsutil).

Dowiedz się, jak zacząć [bezpłatnie](https://cloud.google.com/free) korzystać z Cloud Storage i innych usług GCP.

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
