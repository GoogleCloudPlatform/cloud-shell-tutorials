# Samouczek Dataflow – liczenie słów

<walkthrough-tutorial-url url="https://cloud.google.com/dataflow/docs/quickstarts/quickstart-python"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="dataflow-intro" key="directory"></walkthrough-watcher-constant>
<walkthrough-watcher-constant value="dataflow-intro" key="job-name"></walkthrough-watcher-constant>

## Wstęp

W tym samouczku zapoznasz się z podstawami działania usługi Cloud Dataflow, uruchamiając prosty przykładowy potok w Pythonie.

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

Wersja usługi Cloud Dataflow korzystająca z Pythona wymaga środowiska programistycznego obejmującego język Python oraz pakiety Google Cloud SDK i Cloud Dataflow SDK dla Pythona.
Dodatkowo Cloud Dataflow wykorzystuje pip – menedżera pakietów Pythona – do zarządzania zależnościami SDK.

W wersji Cloud Shell używanej w tym samouczku Python i pip są już zainstalowane. Jeśli wolisz, możesz również zapoznać się z samouczkiem [na swoim komputerze lokalnym][dataflow-python-tutorial].

### Pobranie fragmentów kodu i pakietu SDK Cloud Dataflow dla Pythona przy pomocy polecenia pip

Gdy uruchomisz to polecenie, pip pobierze i zainstaluje odpowiednią wersję Cloud Dataflow SDK.

```bash
pip install --user google-cloud-dataflow
```

Uruchom polecenie narzędzia pip w Cloud Shell.

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

### Uruchamianie potoku w usłudze Dataflow

Uruchom swój potok w usłudze Cloud Dataflow za pomocą Pythona. Uruchomiony potok jest nazywany *zadaniem*.

```bash
python -m apache_beam.examples.wordcount \
  --project {{identyfikator-projektu}} \
  --runner DataflowRunner \
  --temp_location gs://{{identyfikator-projektu-bez-domeny}}/temp \
  --output gs://{{identyfikator-projektu-bez-domeny}}/results/output \
  --job_name {{nazwa_zadania}}
```

  *  Parametr `output` określa zasobnik używany w przykładowym pakiecie WordCount do zapisywania wyników zadania.

### Twoje zadanie jest uruchomione

Gratulacje! Twój plik binarny został zebrany w utworzonym wcześniej zasobniku pamięci i tworzone są instancje Compute Engine. Cloud Dataflow podzieli plik wejściowy w taki sposób, aby można było przetwarzać dane równolegle na wielu komputerach.

Uwaga: kiedy wyświetli się komunikat „JOB_STATE_DONE”, możesz zamknąć Cloud Shell.

## Monitorowanie zadania

Sprawdź postęp swojego potoku na stronie Cloud Dataflow.

### Strona interfejsu monitorującego w Cloud Dataflow

Przejdź na stronę interfejsu monitorującego w Cloud Dataflow.

Otwórz [menu][spotlight-console-menu] po lewej stronie konsoli.

Wybierz sekcję **Dataflow**.

<walkthrough-menu-navigation sectionid="DATAFLOW_SECTION"></walkthrough-menu-navigation>

### Wybór zadania

Kliknij zadanie, by wyświetlić jego szczegóły.

### Szczegóły potoku i dane

Zapoznaj się z potokiem po lewej stronie i informacjami o zadaniu po prawej. Aby wyświetlić szczegółowy stan zadania, kliknij [Logi][spotlight-job-logs]. Kliknij etap potoku, by wyświetlić związane z nim wartości.

Gdy zadanie zostanie zakończone, zobaczysz zmianę jego stanu, a instancje Compute Engine, których to zadanie używa, zatrzymają się automatycznie.

## Wyświetlanie danych wyjściowych

Po uruchomieniu zadania możesz zapoznać się z plikami wyjściowymi w Cloud Storage.

### Otwarcie strony Cloud Storage

Otwórz [menu][spotlight-console-menu] po lewej stronie konsoli.

Wybierz sekcję **Compute Engine**.

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
  *  [Poznać model programowania Cloud Dataflow][df-pipelines]
  *  [Odkryć Apache Beam SDK w serwisie GitHub][beam-sdk]

Skonfiguruj środowisko lokalne:

  *  [Użyj Javy i Eclipse do uruchomienia Dataflow][df-eclipse]
  *  [Użyj Javy i narzędzia Maven do uruchomienia Dataflow][df-maven]

[beam-sdk]: https://github.com/apache/beam/tree/master/sdks/python
[dataflow-python-tutorial]: https://cloud.google.com/dataflow/docs/quickstarts/quickstart-python
[df-eclipse]: https://cloud.google.com/dataflow/docs/quickstarts/quickstart-java-eclipse
[df-maven]: https://cloud.google.com/dataflow/docs/quickstarts/quickstart-java-maven
[df-pipelines]: https://cloud.google.com/dataflow/model/programming-model-beam
[gsutil-docs]: https://cloud.google.com/storage/docs/gsutil
[spotlight-buckets-link]: walkthrough://spotlight-pointer?cssSelector=.p6n-cloudstorage-path-link
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-delete-bucket]: walkthrough://spotlight-pointer?cssSelector=#p6n-cloudstorage-delete-buckets
[spotlight-job-logs]: walkthrough://spotlight-pointer?cssSelector=#p6n-dax-job-logs-toggle
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[wordcount]: https://beam.apache.org/get-started/wordcount-example/
