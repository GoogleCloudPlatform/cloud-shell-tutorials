# Cloud Vision API

<walkthrough-test-start-page url="/start?tutorial=python_vision_quickstart_v2"></walkthrough-test-start-page>

<walkthrough-tutorial-url url="https://cloud.google.com/vision/docs/label-tutorial"></walkthrough-tutorial-url>

<walkthrough-watcher-constant value="https://github.com/GoogleCloudPlatform/python-docs-samples.git" key="repo-url"></walkthrough-watcher-constant>

<walkthrough-watcher-constant value="python-docs-samples" key="repo-name"></walkthrough-watcher-constant>

<walkthrough-devshell-precreate></walkthrough-devshell-precreate>

## Wstęp

W tym samouczku omawiamy podstawową aplikację Vision API, która używa żądania
`LABEL_DETECTION`. Żądanie `LABEL_DETECTION` oznacza obraz etykietą („tagiem”)
wybieraną na podstawie zawartości obrazu. Na przykład zdjęcie stodoły może
otrzymać etykietę „stodoła”, „gospodarstwo” itp.

Wykonasz następujące czynności:

*   **Uruchomisz aplikację wykrywającą etykiety**. Dowiesz się, jak uruchomić
    aplikację przy użyciu Google Cloud Shell bezpośrednio w przeglądarce.
*   **Po uruchomieniu aplikacji…** Twoja aplikacja jest prawdziwa – po wdrożeniu
    możesz z nią eksperymentować albo usunąć ją i stworzyć nową.

[„Python” i logo Python są znakami towarowymi lub zastrzeżonymi znakami
towarowymi należącymi do organizacji Python Software
Foundation.](walkthrough://footnote)

# Konfiguracja projektu

W projekcie musisz włączyć interfejs Cloud Vision API.

Google Cloud Platform organizuje zasoby w projekty. Dzięki temu wszystkie zasoby
powiązane z jedną aplikacją są przechowywane w jednym miejscu.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## Włączanie Vision API

Twój projekt musi mieć włączony interfejs Vision API, aby akceptować żądania.

### Otwórz menedżera API

Menedżer API ustawia interfejsy API, które mają być włączone w projekcie.

Otwórz [menu](walkthrough://spotlight-pointer?spotlightId=console-nav-menu) po
lewej stronie konsoli.

Potem wybierz sekcję **Interfejsy API i usługi**.

<walkthrough-menu-navigation sectionid="API_SECTION"></walkthrough-menu-navigation>

### Wyświetl dostępne interfejsy API

Do włączania interfejsów API służy przycisk
[Włącz API](walkthrough://spotlight-pointer?cssSelector=.p6n-action-bar-button).

### Wybierz Vision API

Kliknij link [Vision API](walkthrough://spotlight-pointer?spotlightId=api-vision.googleapis.com).

### Włącz Vision API

Aby włączyć Vision API, kliknij przycisk
[Włącz](walkthrough://spotlight-pointer?spotlightId=api-enable-vision.googleapis.com). W
dalszej części tego samouczka utworzysz dane logowania dla swojego projektu.

## Korzystanie z Google Cloud Shell

Cloud Shell to wbudowane narzędzie wiersza poleceń konsoli. Użyjesz go, aby
uruchomić aplikację.

### Otwórz Google Cloud Shell

Kliknij
[ikonę](walkthrough://spotlight-pointer?spotlightId=devshell-activate-button)
<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>
na pasku nawigacyjnym u góry konsoli, aby otworzyć Cloud Shell.

### Skopiuj przykładowy kod

Użyj Cloud Shell, żeby skopiować kod „Hello World” i przejść do niego
Przykładowy kod zostanie skopiowany z repozytorium projektu do Cloud Shell.

Uwaga: jeżeli katalog już istnieje, przed kopiowaniem usuń wcześniejsze pliki:

```bash
rm -rf {{repo-name}}
```

Skopiuj przykładowe repozytorium:

```bash
git clone {{repo-url}}
```

Potem przejdź do katalogu samouczka:

```bash
cd {{repo-name}}/vision/cloud-client/quickstart
```

## Konfigurowanie wdrożenia

Jesteś teraz w katalogu głównym przykładowego kodu. Przyjrzyjmy się plikom,
które służą do konfigurowania Twojej aplikacji.

### Szczegóły aplikacji

Wpisz to polecenie, aby wyświetlić kod swojej aplikacji:

```bash
cat quickstart.py
```

Plik `quickstart.py` formatuje informacje o Twoim żądaniu, takie jak typ i
zawartość żądania. Rozwiń sekcje poniżej, aby poznać więcej szczegółów.

Żądania do interfejsu Vision API są dostarczane jako obiekty JSON. Więcej
informacji na temat konkretnej struktury takiego żądania zawiera [dokumentacja
Vision API][vision-request-doc]. Żądanie JSON zostanie wysłane dopiero wtedy,
gdy wywołasz polecenie `execute`. Ten schemat umożliwia obieg takich żądań i
wywoływanie `execute` według potrzeb.

## Testowanie aplikacji

Aby używać interfejsu API, musisz skonfigurować dane logowania. Aby korzystać z
interfejsu Cloud API, musisz skonfigurować odpowiednie [dane
logowania][auth-doc] dla swojej aplikacji. Umożliwi to aplikacji
uwierzytelnianie jej tożsamości wobec usługi oraz uzyskiwanie autoryzacji do
wykonywania zadań. Potem przetestujesz interfejs API na przykładowych obrazach.

### Utwórz konto usługi

Musisz utworzyć konto usługi, które będzie wykorzystywane do uwierzytelniania
żądań do interfejsu API. Jeżeli takie konto już istnieje, zostanie ono ponownie
wykorzystane.

```bash
gcloud iam service-accounts create vision-quickstart
```

### Utwórz dane logowania

Potem utwórz klucz konta usługi i ustaw go jako domyślne dane logowania.

```bash
gcloud iam service-accounts keys create key.json --iam-account vision-quickstart@{{project-id}}.iam.gserviceaccount.com
```

```bash
export GOOGLE_APPLICATION_CREDENTIALS=key.json
```

<walkthrough-test-code-output text="created key"></walkthrough-test-code-output>

### Przetestuj aplikację

Aby przetestować aplikację przy użyciu przykładowego obrazu, wpisz:

```bash
python quickstart.py
```

Zasób z obrazem, `resources/wakeupcat.jpg`, jest wskazany w kodzie źródłowym.
([Wyświetl obraz][cat-picture])

## Podsumowanie

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Gratulacje! Możesz teraz używać Cloud Vision API.

Oto, co możesz teraz zrobić:

*   zapoznać się z samouczkiem na temat [wykrywania twarzy][face-tutorial];
*   przeczytać samouczek dotyczący [wykrywania tekstu w
    dokumencie][document-text-tutorial];
*   zobaczyć [przykładowe aplikacje][vision-samples];
*   pobrać [Google Cloud SDK][get-cloud-sdk], aby zarządzać aplikacją ze swojego
    komputera.

[auth-doc]: https://cloud.google.com/vision/docs/auth
[cat-picture]: https://raw.githubusercontent.com/GoogleCloudPlatform/python-docs-samples/master/vision/cloud-client/quickstart/resources/wakeupcat.jpg
[document-text-tutorial]: https://cloud.google.com/vision/docs/fulltext-annotations
[face-tutorial]: https://cloud.google.com/vision/docs/face-tutorial
[get-cloud-sdk]: https://cloud.google.com/sdk/
[vision-request-doc]: https://cloud.google.com/vision/reference/rest
[vision-samples]: https://cloud.google.com/vision/docs/samples
