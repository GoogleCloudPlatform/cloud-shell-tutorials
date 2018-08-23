# Krótkie wprowadzenie do App Engine

<walkthrough-tutorial-url url="https://cloud.google.com/appengine/docs/python/quickstart"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="https://github.com/GoogleCloudPlatform/python-docs-samples" key="repo-url"></walkthrough-watcher-constant>
<walkthrough-watcher-constant value="python-docs-samples/appengine/standard/hello_world" key="repo-dir"></walkthrough-watcher-constant>

## Wstęp

W tym samouczku pokazujemy, jak wdrożyć przykładową aplikację w języku [Python](https://python.org/) w Google App Engine przy użyciu narzędzia wiersza poleceń `gcloud`.

Wykonasz następujące czynności:

  *  **Utworzenie projektu**

     Projekty są zestawami kodu, maszyn wirtualnych i innych zasobów zebranych razem, aby ułatwić Ci programowanie i monitorowanie.

  *  **Budowanie i uruchamianie aplikacji „Hello, world!”**

     Dowiesz się, jak uruchomić aplikację przy użyciu Google Cloud Shell bezpośrednio w przeglądarce. Na koniec wdrożysz aplikację w internecie za pomocą polecenia `gcloud`.

  *  **Po ukończeniu samouczka…**

     Twoja aplikacja jest prawdziwa – po wdrożeniu możesz z nią eksperymentować albo usunąć ją i stworzyć nową.

[„Python” i logo Python są znakami towarowymi lub zastrzeżonymi znakami towarowymi należącymi do organizacji Python Software Foundation.](walkthrough://footnote)

## Konfiguracja projektu

Aby wdrożyć aplikację, musisz najpierw utworzyć projekt.

Google Cloud Platform organizuje zasoby w projekty. Dzięki temu wszystkie zasoby powiązane z jedną aplikacją są przechowywane w jednym miejscu.

<walkthrough-devshell-precreate></walkthrough-devshell-precreate>

<walkthrough-project-setup></walkthrough-project-setup>

## Korzystanie z Google Cloud Shell

Cloud Shell to wbudowane narzędzie wiersza poleceń konsoli. Użyjesz go, aby wdrożyć swoją aplikację.

### Otwieranie Google Cloud Shell

Kliknij [ikonę][spotlight-open-devshell] <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon> na pasku nawigacyjnym u góry konsoli, aby otworzyć Cloud Shell.

### Kopiowanie przykładowego kodu

Użyj Cloud Shell, żeby skopiować kod „Hello World” i przejść do niego Przykładowy kod zostanie skopiowany z repozytorium projektu do Cloud Shell.

Uwaga: jeżeli katalog już istnieje, przed kopiowaniem usuń wcześniejsze pliki.
W Cloud Shell wpisz:

```bash
git clone {{repo-url}}
```

Potem przejdź do katalogu samouczka:

```bash
cd {{repo-dir}}
```

## Konfigurowanie wdrożenia

Jesteś teraz w katalogu głównym przykładowego kodu. Przyjrzymy się plikom, które konfigurują aplikację.

### Szczegóły aplikacji

Wpisz to polecenie, aby wyświetlić kod swojej aplikacji:

```bash
cat main.py
```

Jest to prosta aplikacja w Pythonie, która korzysta z internetowej platformy programistycznej [webapp2](https://webapp2.readthedocs.io/). Ten skrypt Pythona odpowiada na żądanie, wysyłając nagłówek HTTP i wiadomość `Hello, World!`.

### Szczegóły konfiguracji

Usługa Google App Engine wykorzystuje pliki YAML do określania konfiguracji wdrożeń.
Pliki `app.yaml` zawierają informacje o aplikacji, takie jak środowisko wykonawcze, procedury obsługi adresów URL itp.

Wpisz następujące polecenie, aby wyświetlić plik konfiguracyjny:

```bash
cat app.yaml
```

Ten plik konfiguracyjny zawiera następujące informacje o aplikacji (w tej kolejności):

  *  Ten kod działa w środowisku wykonawczym `python`.
  *  Ta aplikacja jest zaprojektowana jako `threadsafe` (bezpieczna wątkowo), więc ta sama instancja może obsługiwać kilka jednoczesnych żądań. Threadsafe jest zaawansowaną funkcją i może powodować błędne działanie, jeśli aplikacja nie jest do niej przystosowana.
  *  Każde żądanie odwołujące się do adresu URL, którego ścieżka odpowiada wyrażeniu regularnemu `/.*` (wszystkie adresy URL), powinno być obsługiwane przez obiekt aplikacji w module Pythona `main`.

Składnią tego pliku jest [YAML](http://www.yaml.org). Pełną listę opcji konfiguracyjnych zawiera dokumentacja pliku [`app.yaml`][app-yaml-reference].

## Testowanie aplikacji

### Testowanie aplikacji w Cloud Shell

Cloud Shell pozwala przetestować aplikację przed jej wdrożeniem, dzięki czemu możesz sprawdzić, czy wszystko działa zgodnie z założeniami – podobnie jak w przypadku debugowania na Twoim komputerze.

Aby przetestować swoją aplikację, wpisz:

```bash
dev_appserver.py $PWD
```

### Wyświetlenie podglądu aplikacji za pomocą funkcji „Podgląd w przeglądarce”

Twoja aplikacja działa już w Cloud Shell. Aby uzyskać do niej dostęp, skorzystaj z funkcji [Podgląd w przeglądarce][spotlight-web-preview]<walkthrough-web-preview-icon></walkthrough-web-preview-icon> i połącz się z portem 8080.

### Wyłączenie instancji próbnej

Zatrzymaj instancję aplikacji, naciskając klawisze `Ctrl+C` w Cloud Shell.

## Wdrażanie w Google App Engine

### Tworzenie aplikacji

Aby wdrożyć aplikację, musisz najpierw utworzyć aplikację w jednym z regionów:

```bash
gcloud app create
```

Uwaga: jeśli aplikacja już istnieje, możesz pominąć ten krok.

### Wdrażanie z użyciem Cloud Shell

Możesz użyć Cloud Shell do wdrożenia swojej aplikacji. Aby to zrobić, wpisz:

```bash
gcloud app deploy app.yaml --project {{project-id}}
```

### Przechodzenie do aplikacji

Gratulacje! Udało Ci się wdrożyć aplikację. Jej domyślny adres URL to [{{project-gae-url}}](http://{{project-gae-url}}). Kliknij go, by otworzyć aplikację.

### Wyświetlanie stanu aplikacji

Możesz sprawdzać swoją aplikację, monitorując jej stan w panelu App Engine.

Otwórz [menu][spotlight-console-menu] po lewej stronie konsoli.

Potem wybierz sekcję **App Engine**.

<walkthrough-menu-navigation sectionid="APPENGINE_SECTION"></walkthrough-menu-navigation>

## Podsumowanie

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Aplikacja App Engine została wdrożona.

Oto co jeszcze możesz zrobić:

**Pobierz pakiet Google Cloud SDK i programuj lokalnie**

Zainstaluj [pakiet Google Cloud SDK][cloud-sdk-installer] na swoim komputerze.

**Utwórz następną aplikację**

Dowiedz się, jak korzystać z App Engine z innymi usługami Google Cloud Platform:

<walkthrough-tutorial-card label="django" url="python/django/appengine" icon="APPENGINE_SECTION">
  **Uruchom Django**
Programuj aplikacje Django działające w App Engine.
</walkthrough-tutorial-card>

<walkthrough-tutorial-card label="datastore" url="appengine/docs/python/datastore/" icon="DATASTORE_SECTION">
  **Dowiedz się, jak korzystać z Cloud Datastore**
Cloud Datastore to wysoce skalowalna baza danych NoSQL dla aplikacji.
</walkthrough-tutorial-card>

[app-yaml-reference]: https://cloud.google.com/appengine/docs/standard/python/config/appref
[cloud-sdk-installer]: https://cloud.google.com/sdk/downloads#interactive
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-web-preview]: walkthrough://spotlight-pointer?spotlightId=devshell-web-preview-button
