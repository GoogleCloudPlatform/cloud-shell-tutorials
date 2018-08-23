# Руководство по Dataflow WordCount

<walkthrough-tutorial-url url="https://cloud.google.com/dataflow/docs/quickstarts/quickstart-python"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="dataflow-intro" key="directory"></walkthrough-watcher-constant>
<walkthrough-watcher-constant value="dataflow-intro" key="job-name"></walkthrough-watcher-constant>

## Введение

В этом руководстве мы рассмотрим, как запустить конвейер в сервисе Cloud Dataflow на Python.

В Dataflow существует два типа конвейеров: *пакетные* (например, для обработки данных из файлов или таблиц БД) и *потоковые* (например, для обработки данных из Cloud Pub/Sub). В этом примере используется пакетный конвейер, который подсчитывает слова в собрании сочинений Шекспира.

Прежде всего нужно проверить, включены ли нужные в проекте Cloud Platform, и выполнить начальную настройку.

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

Для работы Python-версии Cloud Dataflow в локальной среде разработки необходимо установить Python SDK, Google Cloud SDK и Cloud Dataflow SDK.
Кроме того, для управления зависимостями используется pip (система управления пакетами Python).

В Cloud Shell уже установлены все необходимые компоненты. Вы также можете пройти это учебное руководство [на своем локальном компьютере][dataflow-python-tutorial].

### Скачайте примеры и Cloud Dataflow SDK для Python в командной строке pip

В результате выполнения этой команды pip будет загружена и установлена нужная версия Cloud Dataflow SDK.

```bash
pip install --user google-cloud-dataflow
```

Запустите командную строку pip в Cloud Shell.

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

### Запустите конвейер в Cloud Dataflow

Запустите конвейер в сервисе Cloud Dataflow с помощью Python. Такой конвейер будет называться *заданием*.

```bash
python -m apache_beam.examples.wordcount \
  --project {{project-id}} \
  --runner DataflowRunner \
  --temp_location gs://{{project-id-no-domain}}/temp \
  --output gs://{{project-id-no-domain}}/results/output \
  --job_name {{job-name}}
```

  *  Параметр `output` указывает сегмент, в котором будут храниться результаты задания.

### Задание выполняется

Двоичный файл теперь находится в ранее созданном сегменте хранилища. Сейчас идет создание экземпляров Compute Engine. Входной файл будет разбит таким образом, чтобы его можно было обрабатывать параллельно на нескольких машинах.

Примечание. После того как появится сообщение JOB_STATE_DONE, Cloud Shell можно будет закрыть.

## Включите мониторинг заданий

На странице Cloud Dataflow проверьте статус конвейера.

### Страница мониторинга Cloud Dataflow

Откройте страницу мониторинга Cloud Dataflow.

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

Выберите раздел **Compute Engine**.

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
  *  [Сведения о модели программирования Cloud Dataflow][df-pipelines]
  *  [Apache Beam SDK в GitHub][beam-sdk]

Настройка локальной среды:

  *  [Запуск Dataflow с помощью Java и Eclipse][df-eclipse]
  *  [Запуск Dataflow с помощью Java и Maven][df-maven]

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
