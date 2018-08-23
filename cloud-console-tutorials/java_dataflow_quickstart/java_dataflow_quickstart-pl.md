# Samouczek Dataflow – liczenie słów

<walkthrough-tutorial-url url="https://cloud.google.com/dataflow/docs/quickstarts/quickstart-java-maven"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="dataflow-intro" key="directory"></walkthrough-watcher-constant>
<walkthrough-watcher-constant value="dataflow-intro" key="job-name"></walkthrough-watcher-constant>

## Wstęp

W tym samouczku zapoznasz się z podstawami działania usługi Cloud Dataflow, uruchamiając prosty przykładowy potok w Javie.

Potoki Dataflow mogą być *wsadowe* (przetwarzanie ograniczonych danych wejściowych, np. pliku lub tabeli bazy danych) albo *strumieniowe* (przetwarzanie nieograniczonych danych wejściowych ze źródła takiego jak np. Cloud Pub/Sub). W tym samouczku przedstawiony jest potok wsadowy służący do liczenia słów w dziełach Szekspira.

Zanim zaczniesz, musisz sprawdzić wymagania wstępne w Twoim projekcie Cloud Platform i wykonać początkową konfigurację.

## Konfiguracja projektu

Google Cloud Platform organizuje zasoby w projekty. Dzięki temu wszystkie zasoby powiązane z jedną aplikacją są przechowywane w jednym miejscu.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>
<walkthrough-project-permissions permissions="dataflow.jobs.create"></walkthrough-project-permissions>

## Konfigurowanie Cloud Dataflow

Aby używać Dataflow, włącz interfejsy Cloud Dataflow API i otwórz Cloud Shell.

### Włączanie interfejsów API Google Cloud

<walkthrough-enable-apis apis="compute.googleapis.com,dataflow,cloudresourcemanager.googleapis.com,logging,storage_component,storage_api,bigquery,pubsub">
</walkthrough-enable-apis>

### Otwieranie Cloud Shell

Cloud Shell to wbudowane narzędzie wiersza poleceń konsoli. Użyjesz go, aby wdrożyć aplikację.

Kliknij [ikonę][spotlight-open-devshell] <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon> na pasku nawigacyjnym u góry konsoli, aby otworzyć Cloud Shell.

## Instalowanie fragmentów kodu Cloud Dataflow w Cloud Shell

Jeśli chcesz używać pakietu SDK Cloud Dataflow dla Javy, Twoje środowisko programistyczne musi obejmować język Java, pakiet SDK Google Cloud, pakiet SDK Cloud Dataflow dla Javy oraz Apache Maven do zarządzania zależnościami między pakietami SDK. W tym samouczku jest używana wersja Cloud Shell z już zainstalowanymi: Javą, pakietem SDK Google Cloud oraz Maven.

Jeśli wolisz, możesz również zapoznać się z samouczkiem [na swoim komputerze lokalnym][dataflow-java-tutorial].

### Pobranie fragmentów kodu i pakietu SDK Cloud Dataflow dla Javy przy pomocy polecenia Maven

Po uruchomieniu tego polecenia narzędzie Maven utworzy strukturę projektu i plik konfiguracyjny wykorzystywany do pobrania odpowiedniej wersji Cloud Dataflow SDK.

```bash
mvn archetype:generate \
    -DarchetypeArtifactId=google-cloud-dataflow-java-archetypes-examples \
    -DarchetypeGroupId=com.google.cloud.dataflow \
    -DarchetypeVersion=2.1.0 \
    -DgroupId=com.example \
    -DartifactId={{katalog}} \
    -Dversion="0.1" \
    -DinteractiveMode=false \
    -Dpackage=com.example
```

  *  Parametry `archetypeArtifactId` i `archetypeGroupId` służą do zdefiniowania przykładowej struktury projektu.
  *  Parametr `groupId` określa prefiks nazwy pakietu Javy należącego do Twojej organizacji, na przykład `com.mycompany`.
  *  Parametr `artifactId` określa nazwę utworzonego pliku jar. W tym samouczku użyj wartości domyślnej (`{{katalog}}`).

Uruchom polecenie narzędzia Maven w Cloud Shell.

### Zmiana katalogu

Zmień katalog roboczy na `{{katalog}}`.

```bash
cd {{katalog}}
```

Jeśli chcesz zobaczyć kod używany w tym przykładzie, znajdziesz go w podkatalogu `src` katalogu `{{katalog}}`.

## Konfigurowanie zasobnika Cloud Storage

Cloud Dataflow wykorzystuje zasobniki Cloud Storage do przechowywania danych wyjściowych i buforowania kodu potoku.

### Uruchamianie polecenia gsutil mb

Użyj w Cloud Shell polecenia `gsutil mb` do utworzenia zasobnika Cloud Storage.

```bash
gsutil mb gs://{{identyfikator-projektu-bez-domeny}}
```

Więcej informacji na temat narzędzia `gsutil` znajdziesz w [dokumentacji][gsutil-docs].

## Tworzenie i uruchamianie potoku

W Cloud Dataflow praca związana z przetwarzaniem danych jest przedstawiana w postaci *potoku*. Potok odczytuje dane wejściowe, przeprowadza transformacje tych danych, a potem generuje dane wyjściowe. Do tych transformacji należy między innymi filtrowanie, grupowanie, porównywanie i łączenie danych.

Jeśli chcesz zobaczyć kod używany w tym przykładzie, znajdziesz go w podkatalogu `src` katalogu `{{katalog}}`.

### Uruchamianie potoku w usłudze Dataflow

Uruchom swój potok w usłudze za pomocą polecenia narzędzia Apache Maven `mvn exec`.
Uruchomiony potok jest nazywany *zadaniem*.

```bash
mvn compile exec:java \
  -Dexec.mainClass=com.example.WordCount \
  -Dexec.args="--project={{identyfikator-projektu}} \
  --stagingLocation=gs://{{identyfikator-projektu-bez-domeny}}/staging/ \
  --output=gs://{{identyfikator-projektu-bez-domeny}}/output \
  --runner=DataflowRunner \
  --jobName={{nazwa-zadania}}"
```

  *  Parametr `stagingLocation` określa zasobnik pamięci, w którym Cloud Dataflow będzie zapisywać pliki binarne i inne dane na potrzeby uruchomionego potoku. Ta lokalizacja może być wykorzystywana przez wiele zadań.
  *  Parametr `output` określa zasobnik używany w przykładowym pakiecie WordCount do zapisywania wyników zadania.

### Twoje zadanie zostało uruchomione

Gratulacje! Twój plik binarny został zebrany w utworzonym wcześniej zasobniku pamięci i tworzone są instancje Compute Engine. Cloud Dataflow podzieli plik wejściowy w taki sposób, aby można było przetwarzać dane równolegle na wielu komputerach.

Uwaga: kiedy zobaczysz komunikat o ukończeniu zadania, możesz zamknąć Cloud Shell.

Jeśli chcesz wyczyścić wygenerowany projekt Maven, wykonaj `cd .. && rm -R
{{katalog}}` w Cloud Shell, aby usunąć katalog.

## Monitorowanie zadania

Sprawdź postęp swojego potoku na stronie interfejsu monitorującego w Cloud Dataflow.

### Na stronie Cloud Dataflow

Otwórz [menu][spotlight-console-menu] po lewej stronie konsoli.

Wybierz sekcję **Dataflow**.

<walkthrough-menu-navigation sectionid="DATAFLOW_SECTION"></walkthrough-menu-navigation>

### Wybór zadania

Kliknij zadanie, by wyświetlić jego szczegóły.

### Szczegóły potoku i dane

Zapoznaj się z potokiem po lewej stronie i informacjami o zadaniu po prawej. Aby wyświetlić szczegółowy stan zadania, kliknij [Logi][spotlight-job-logs]. Kliknij etap potoku, by wyświetlić związane z nim wartości.

Gdy zadanie zostanie zakończone, zobaczysz zmianę jego stanu, a instancje Compute Engine, których to zadanie używa, zatrzymają się automatycznie.

## Wyświetlanie danych wyjściowych

Po uruchomieniu zadania możesz zapoznać się z plikami wyjściowymi w Cloud Storage.

### Otwarcie strony Cloud Storage

Otwórz [menu][spotlight-console-menu] po lewej stronie konsoli.

Wybierz sekcję **Storage**.

<walkthrough-menu-navigation sectionid="STORAGE_SECTION"></walkthrough-menu-navigation>

### Przejście do zasobnika pamięci

Na liście zasobników zaznacz utworzony wcześniej zasobnik. Jeśli została użyta nazwa sugerowana, jego nazwą będzie `{{identyfikator-projektu}}`.

Zasobnik ten zawiera folder tymczasowego przechowywania oraz foldery wyjściowe. Dataflow zapisuje dane wyjściowe we fragmentach, dlatego zasobnik będzie zawierać kilka plików wyjściowych.

## Czyszczenie danych

Jeśli chcesz uniknąć naliczania opłat za korzystanie z usługi Cloud Storage, usuń utworzony zasobnik.

### Powrót do przeglądarki zasobników

Kliknij link [Zasobniki][spotlight-buckets-link].

### Wybór zasobnika

Zaznacz pole wyboru obok utworzonego zasobnika.

### Usuwanie zasobnika

Kliknij [Usuń][spotlight-delete-bucket] i potwierdź usunięcie.

## Podsumowanie

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Oto, co możesz teraz zrobić:

  *  [Poczytać więcej o przykładzie Word Count][wordcount]
  *  [Poznać model programowania Cloud Dataflow][df-model]
  *  [Odkryć Cloud Dataflow SDK w serwisie GitHub][df-sdk]

Skonfiguruj środowisko lokalne:

  *  [Użyj Eclipse do uruchomienia Dataflow][df-eclipse]
  *  [Użyj Pythona do uruchomienia Dataflow][df-python]

[dataflow-java-tutorial]: https://cloud.google.com/dataflow/docs/quickstarts/quickstart-java-maven
[df-eclipse]: https://cloud.google.com/dataflow/docs/quickstarts/quickstart-java-eclipse
[df-model]: https://cloud.google.com/dataflow/model/programming-model-beam
[df-python]: https://cloud.google.com/dataflow/docs/quickstarts/quickstart-python
[df-sdk]: https://github.com/apache/beam/tree/master/sdks/java
[gsutil-docs]: https://cloud.google.com/storage/docs/gsutil
[spotlight-buckets-link]: walkthrough://spotlight-pointer?cssSelector=.p6n-cloudstorage-path-link
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-delete-bucket]: walkthrough://spotlight-pointer?cssSelector=#p6n-cloudstorage-delete-buckets
[spotlight-job-logs]: walkthrough://spotlight-pointer?cssSelector=#p6n-dax-job-logs-toggle
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[wordcount]: https://beam.apache.org/get-started/wordcount-example/
