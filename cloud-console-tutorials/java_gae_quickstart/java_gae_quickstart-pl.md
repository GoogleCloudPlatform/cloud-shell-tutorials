# Krótkie wprowadzenie do App Engine

<walkthrough-test-start-page url="/getting-started?tutorial=java_gae_quickstart_2"/>

<walkthrough-tutorial-url url="https://cloud.google.com/appengine/docs/java/quickstart"/>

<walkthrough-watcher-constant key="repo-url" value="https://github.com/GoogleCloudPlatform/appengine-try-java" />

<walkthrough-watcher-constant key="repo-name" value="appengine-try-java"/>

## Wstęp

Z tego samouczka dowiesz się, jak wdrożyć przykładową aplikację w języku
[Java][java] w Google App Engine za pomocą wtyczki Maven App Engine Plugin.

Wykonasz następujące czynności.

*   **Napiszesz i uruchomisz własną aplikację „Hello, world!”**

    Dowiesz się, jak uruchomić swoją aplikację bezpośrednio w przeglądarce,
    korzystając z Google Cloud Shell. Na koniec wdrożysz stworzoną aplikację
    w internecie, używając do tego wtyczki Maven App Engine Plugin.

*   **Po napisaniu aplikacji…**

    Twoja aplikacja jest prawdziwa – po wdrożeniu możesz z nią eksperymentować
    albo usunąć ją i stworzyć nową aplikację.

[Java is a registered trademark of Oracle and/or its affiliates.](walkthrough://footnote)

<walkthrough-devshell-precreate/>

## Konfiguracja projektu

Żeby wdrożyć aplikację, musisz najpierw utworzyć projekt.

Google Cloud Platform organizuje zasoby w projekty. Dzięki temu wszystkie zasoby
powiązane z jedną aplikacją są przechowywane w jednym miejscu.

<walkthrough-project-setup/>

## Korzystanie z Google Cloud Shell

Cloud Shell to wbudowane narzędzie wiersza poleceń konsoli. Będziemy z niego
korzystać, żeby wdrożyć napisaną aplikację.

### Uruchamianie Google Cloud Shell

Otwórz Cloud Shell, klikając <walkthrough-cloud-shell-icon/>
[icon](walkthrough://spotlight-pointer?spotlightId=devshell-activate-button) na
pasku nawigacyjnym w górnej części konsoli.

### Kopiowanie przykładowego kodu

Użyj Cloud Shell, żeby skopiować kod „Hello World” i przejść do niego.
Przykładowy kod zostanie skopiowany z repozytorium projektu do Cloud Shell.

Uwaga: Jeżeli katalog już istnieje, przed skopiowaniem kodu usuń zawarte w nim
pliki:

```bash
rm -rf {{repo-name}}
```

W Cloud Shell wpisz:

```bash
git clone {{repo-url}}
```

Potem przejdź do katalogu samouczka:

```bash
cd {{repo-name}}
```

## Konfiguracja wdrożenia

Jesteś teraz w katalogu głównym przykładowego kodu. Przyjrzyjmy się plikom,
które służą do konfigurowania Twojej aplikacji.

### Przeglądanie kodu aplikacji

Wpisz to polecenie, aby wyświetlić kod swojej aplikacji:

```bash
cat src/main/java/myapp/DemoServlet.java
```

Ten serwlet odpowiada na każde żądanie, wysyłając odpowiedź zawierającą
wiadomość `Hello, world!`.

### Przeglądanie konfiguracji

W przypadku języka Java Google App Engine korzysta z plików XML, które zawierają
konfigurację wdrożenia.

Wpisz to polecenie, aby wyświetlić plik konfiguracji:

```bash
cat pom.xml
```

Aplikacja `helloworld` używa narzędzia Maven. Oznacza to, że musisz określić
model obiektu projektu (POM), który zawiera informacje dotyczące projektu
i szczegóły konfiguracji używane przez Maven do utworzenia projektu.

## Testowanie aplikacji

### Testowanie aplikacji w Cloud Shell

Cloud Shell pozwala Ci przetestować aplikację przed jej wdrożeniem, dzięki czemu
możesz sprawdzić, czy działa ona zgodnie z założeniami. Przypomina to
debugowanie na komputerze lokalnym.

Aby przetestować aplikację, wpisz:

```bash
mvn appengine:run
```

<walkthrough-test-code-output
  text="module .* running at|Dev App Server is now running" />

### Wyświetlenie aplikacji za pomocą funkcji Podgląd w przeglądarce

Twoja aplikacja jest teraz uruchomiona w Cloud Shell. Aby ją zobaczyć,
skorzystaj z Podglądu w przeglądarce <walkthrough-web-preview-icon/> i połącz
się z portem 8080. [Pokaż mi, jak to
zrobić](walkthrough://spotlight-pointer?spotlightId=devshell-web-preview-button)

### Zamykanie instancji podglądu

Aby usunąć aplikację, naciśnij klawisze `Ctrl+C` w Cloud Shell.

## Wdrożenie aplikacji w Google App Engine

### Utworzenie aplikacji

Żeby wdrożyć napisaną aplikację, trzeba utworzyć ją w regionie:

```bash
gcloud app create
```

Uwaga: Jeżeli aplikacja została już utworzona, możesz pominąć ten krok.

### Wdrażanie za pomocą Cloud Shell

Teraz możesz skorzystać z Cloud Shell, żeby wdrożyć swoją aplikację.

Najpierw wybierz projekt, którego chcesz użyć:

```bash
gcloud config set project {{project-id}}
```

Potem przeprowadź wdrożenie aplikacji:

```bash
mvn appengine:deploy
```

<walkthrough-test-code-output text="Deployed (module|service)" />

### Przechodzenie do aplikacji

Twoja aplikacja została wdrożona. Jej domyślny adres URL to
[{{project-gae-url}}](http://{{project-gae-url}}). Kliknij go, żeby przejść do
aplikacji.

### Wyświetlanie stanu aplikacji

Możesz sprawdzać działanie swojej aplikacji, monitorując jej stan na panelu App
Engine.

Otwórz [menu](walkthrough://spotlight-pointer?spotlightId=console-nav-menu) po
lewej stronie konsoli.

Wybierz sekcję **App Engine**.

<walkthrough-menu-navigation sectionId="APPENGINE_SECTION"/>

## Podsumowanie

<walkthrough-conclusion-trophy/>

Gratulacje! Udało Ci się wdrożyć aplikację App Engine! Oto co jeszcze możesz
zrobić:

**Pobierz pakiet SDK Google Cloud i programuj na komputerze lokalnym**

[Google Cloud SDK][cloud-sdk-installer]

**Stwórz kolejną aplikację**

Dowiedz się, jak korzystać z App Engine w innych usługach Google Cloud Platform:

<walkthrough-tutorial-card
  url="appengine/docs/java/datastore/"
  icon="DATASTORE_SECTION"
  label="datastore">
**Dowiedz się, jak korzystać z usługi Cloud Datastore**
Cloud Datastore to wysoce skalowalna baza danych NoSQL dla aplikacji.
</walkthrough-tutorial-card>

<walkthrough-tutorial-card
  url="appengine/docs/java/googlecloudstorageclient/setting-up-cloud-storage/"
  icon="STORAGE_SECTION"
  label="cloudStorage">
**Dowiedz się, jak korzystać z usługi Cloud Storage**
Cloud Storage to prosta w obsłudze usługa pamięci masowej obiektów o dużych możliwościach.
</walkthrough-tutorial-card>

[java]: https://java.com/
[cloud-sdk-installer]: https://cloud.google.com/sdk/downloads#interactive
