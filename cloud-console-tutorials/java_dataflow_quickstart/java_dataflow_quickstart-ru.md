# Руководство по Dataflow WordCount

<walkthrough-tutorial-url url="https://cloud.google.com/dataflow/docs/quickstarts/quickstart-java-maven"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="dataflow-intro" key="directory"></walkthrough-watcher-constant>
<walkthrough-watcher-constant value="dataflow-intro" key="job-name"></walkthrough-watcher-constant>

## Введение

В этом руководстве мы рассмотрим, как запустить конвейер в сервисе Cloud Dataflow на Java.

В Dataflow существует два типа конвейеров: *пакетные* (например, для обработки данных из файлов или таблиц БД) и *потоковые* (например, для обработки данных из Cloud Pub/Sub). В этом примере используется пакетный конвейер, который подсчитывает слова в собрании сочинений Шекспира.

Прежде всего нужно проверить, включены ли нужные функции в проекте Cloud Platform, и выполнить начальную настройку.

## Настройка проекта

В проекте будут собраны все ресурсы, которые вы используете в своем приложении.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>
<walkthrough-project-permissions permissions="dataflow.jobs.create"></walkthrough-project-permissions>

## Настройка Cloud Dataflow

Чтобы использовать Dataflow, включите Cloud Dataflow API и откройте Cloud Shell.

### Активация Google Cloud API

<walkthrough-enable-apis apis="compute.googleapis.com,dataflow,cloudresourcemanager.googleapis.com,logging,storage_component,storage_api,bigquery,pubsub">
</walkthrough-enable-apis>

### Откройте Cloud Shell

Cloud Shell – это встроенный интерфейс командной строки для консоли. Развертывание приложения будет выполнено с его помощью.

Откройте Cloud Shell. Для этого нажмите <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[значок][spotlight-open-devshell] на панели навигации в верхней части консоли.

## Установите образцы кода Cloud Dataflow в Cloud Shell

Чтобы использовать Cloud Dataflow SDK для Java, в локальной среде разработки необходимо установить Java SDK, Google Cloud SDK, Cloud Dataflow SDK для Java и Apache Maven для управления зависимостями. В Cloud Shell уже установлены все необходимые компоненты.

Вы также можете пройти это учебное руководство [на своем локальном компьютере][dataflow-java-tutorial].

### Скачайте примеры и Cloud Dataflow SDK для Java с помощью команды Maven

В результате выполнения этой команды Maven будут созданы структура проекта и файл конфигурации для скачивания нужной версии Cloud Dataflow SDK.

```bash
mvn archetype:generate \
    -DarchetypeArtifactId=google-cloud-dataflow-java-archetypes-examples \
    -DarchetypeGroupId=com.google.cloud.dataflow \
    -DarchetypeVersion=2.1.0 \
    -DgroupId=com.example \
    -DartifactId={{directory}} \
    -Dversion="0.1" \
    -DinteractiveMode=false \
    -Dpackage=com.example
```

  *  Параметры `archetypeArtifactId` и `archetypeGroupId` определяют структуру проекта.
  *  `groupId` – это префикс названия пакета Java вашей организации, например `com.mycompany`.
  *  Параметр `artifactId` устанавливает название создаваемого jar-файла. Для целей этого руководства используйте значение по умолчанию (`{{directory}}`).

Выполните команду Maven в Cloud Shell.

### Выберите каталог

Перейдите в каталог `{{directory}}`.

```bash
cd {{directory}}
```

Код, который используется в этом примере, можно найти в подкаталоге `src`, расположенном в каталоге `{{directory}}`.

## Установите сегмент Cloud Storage

Cloud Dataflow хранит выходные данные и кеширует код конвейера с помощью сегментов Cloud Storage.

### Выполните команду gsutil mb

Создайте сегмент Cloud Storage. Для этого выполните команду `gsutil mb` в Cloud Shell.

```bash
gsutil mb gs://{{project-id-no-domain}}
```

Подробнее о работе с `gsutil` можно узнать из [документации][gsutil-docs].

## Создайте и запустите конвейер

В Cloud Dataflow задание обработки данных представлено в виде *конвейера*. Конвейер считывает входящие данные, затем преобразует их (фильтрует, группирует, сравнивает или объединяет), после чего формирует выходные данные.

Код, который используется в этом примере, можно найти в подкаталоге `src`, расположенном в каталоге `{{directory}}`.

### Запустите конвейер в Cloud Dataflow

Запустите конвейер в сервисе с помощью команды Apache Maven `mvn exec`.
Такой конвейер будет называться *заданием.*

```bash
mvn compile exec:java \
  -Dexec.mainClass=com.example.WordCount \
  -Dexec.args="--project={{project-id}} \
  --stagingLocation=gs://{{project-id-no-domain}}/staging/ \
  --output=gs://{{project-id-no-domain}}/output \
  --runner=DataflowRunner \
  --jobName={{job-name}}"
```

  *  Параметр `stagingLocation` указывает сегмент, в котором будут храниться двоичные файлы и другие данные для конвейера. Для разных заданий можно задавать одно и то же значение.
  *  Параметр `output` указывает сегмент, в котором будут храниться результаты задания.

### Задание выполняется

Двоичный файл теперь находится в ранее созданном сегменте хранилища. Сейчас идет создание экземпляров Compute Engine. Входной файл будет разбит таким образом, чтобы его можно было обрабатывать параллельно на нескольких машинах.

Примечание. После того как появится сообщение Job finished (Задание выполнено), Cloud Shell можно будет закрыть.

Чтобы удалить созданный проект Maven, удалите каталог с помощью команд `cd .. && rm -R {{directory}}` в Cloud Shell.

## Включите мониторинг заданий

На странице мониторинга Cloud Dataflow проверьте статус конвейера.

### Перейдите на страницу Cloud Dataflow

Откройте [меню][spotlight-console-menu] в левой части консоли.

Выберите раздел **Dataflow**.

<walkthrough-menu-navigation sectionid="DATAFLOW_SECTION"></walkthrough-menu-navigation>

### Выберите задание

Нажмите на задание, чтобы просмотреть сведения о нем.

### Изучите сведения о конвейере и его показатели

Конвейер расположен в левой части страницы, а вкладки с информацией – в правой. Проверить статус задания можно на вкладке [Журналы][spotlight-job-logs]. Чтобы просмотреть показатели, относящиеся к определенному этапу, нажмите на него.

Когда задание будет выполнено, статус изменится, а используемые экземпляры Compute Engine будут остановлены.

## Просмотрите результаты

Задание завершено. Теперь вы можете просмотреть файлы результатов в Cloud Storage.

### Откройте Cloud Storage

Откройте [меню][spotlight-console-menu] в левой части консоли.

Выберите раздел **Storage**.

<walkthrough-menu-navigation sectionid="STORAGE_SECTION"></walkthrough-menu-navigation>

### Откройте сегмент хранилища

Выберите ранее созданный сегмент `{{project-id}}` (если вы не меняли название по умолчанию).

Он содержит временную папку и папки с результатами. Dataflow сохраняет результаты по частям, поэтому файлов будет несколько.

## Удаление ненужных объектов

Удалите созданный сегмент, чтобы вам не начислялась плата за использование Cloud Storage.

### Вернитесь на страницу обзора сегментов

Нажмите на ссылку [Сегменты][spotlight-buckets-link].

### Выберите сегмент

Установите флажок рядом с названием созданного сегмента.

### Удалите сегмент

Нажмите кнопку [Удалить][spotlight-delete-bucket], а затем подтвердите операцию.

## Заключение

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Дополнительная информация:

  *  [Подробнее о WordCount…][wordcount]
  *  [Сведения о модели программирования Cloud Dataflow][df-model]
  *  [Cloud Dataflow SDK в GitHub][df-sdk]

Настройка локальной среды:

  *  [Запуск Dataflow с помощью Eclipse][df-eclipse]
  *  [Запуск Dataflow с помощью Python][df-python]

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
