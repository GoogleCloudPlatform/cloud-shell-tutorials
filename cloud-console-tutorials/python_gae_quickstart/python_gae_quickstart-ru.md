# Быстрая настройка App Engine

<walkthrough-tutorial-url url="https://cloud.google.com/appengine/docs/python/quickstart"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="https://github.com/GoogleCloudPlatform/python-docs-samples" key="repo-url"></walkthrough-watcher-constant>
<walkthrough-watcher-constant value="python-docs-samples/appengine/standard/hello_world" key="repo-dir"></walkthrough-watcher-constant>

## Введение

Из этого руководства вы узнаете, как развернуть пример приложения на [Python](https://python.org/) в Google App Engine из командной строки `gcloud`.

Вот из каких этапов состоит это руководство:

  *  **Создание проекта**

     В проекте будет собран весь код, виртуальные машины и другие ресурсы вашего приложения. Такой подход позволяет упростить разработку и мониторинг.

  *  **Создание и запуск приложения "Hello, world!"**

     Вы узнаете, как запускать приложение в Google Cloud Shell – прямо в браузере. В конце руководства вы опубликуете свое приложение в Интернете через интерфейс командной строки `gcloud`.

  *  **Что дальше?**

     Приложение будет запущено в сервисе. Вы сможете поэкспериментировать с ним или же удалить, а затем создать новое.

[Python и логотип Python являются зарегистрированными товарными знаками Python Software Foundation.](walkthrough://footnote)

## Настройка проекта

Чтобы развернуть приложение, нужно сначала создать проект.

В проекте будут собраны все ресурсы, которые вы используете в своем приложении.

<walkthrough-devshell-precreate></walkthrough-devshell-precreate>

<walkthrough-project-setup></walkthrough-project-setup>

## Активация Google Cloud Shell

Cloud Shell – это встроенный интерфейс командной строки для консоли. Развертывание приложения будет выполнено с помощью этой программы.

### Запуск Google Cloud Shell

Откройте Cloud Shell. Для этого нажмите <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[значок][spotlight-open-devshell] на панели навигации в верхней части консоли.

### Клонирование примера кода

Клонируйте пример кода Hello World из хранилища проекта в Cloud Shell.

Примечание. Если каталог уже существует, удалите из него файлы перед клонированием. Для этого введите следующую команду.

В Cloud Shell введите следующую команду:

```bash
git clone {{repo-url}}
```

Чтобы перейти в каталог с руководствами:

```bash
cd {{repo-dir}}
```

## Настройка развертывания

Перед вами корневой каталог с примером кода. Здесь хранятся файлы конфигурации приложения.

### Просмотр кода приложения

Чтобы просмотреть код приложения, введите следующую команду:

```bash
cat main.py
```

Это простое приложение Python на базе веб-платформы [webapp2](https://webapp2.readthedocs.io/). Этот скрипт Python отправляет HTTP-заголовок и сообщение `Hello, World!` в ответ на запрос.

### Просмотр конфигурации

В Google App Engine используются yaml-файлы конфигурации развертывания.
В файлах `app.yaml` содержится информация о приложении, например о среде выполнения или обработчиках URL.

Чтобы просмотреть файл конфигурации, введите следующую команду:

```bash
cat app.yaml
```

Этот файл конфигурации сообщает о приложении следующие сведения (сверху вниз):

  *  Этот код работает в среде выполнения `python`.
  *  Это приложение с параметром `threadsafe`, поэтому один и тот же экземпляр может обрабатывать несколько одновременных запросов. Этот параметр следует использовать только в приложениях, поддерживающих потокобезопасность. В противном случае приложение может работать нестабильно.
  *  Каждый запрос к URL, путь которого соответствует регулярному выражению `/.*` (все URL), должен быть обработан объектом приложения в модуле Python `main`.

Файл имеет формат [YAML](http://www.yaml.org). Полный список параметров конфигурации доступен в справочнике по [`app.yaml`][app-yaml-reference].

## Проверка работы приложения

### Протестируйте приложение в Cloud Shell

В Cloud Shell вы можете протестировать приложение перед развертыванием. Это похоже на процесс отладки на локальном компьютере.

Чтобы протестировать приложение, введите следующую команду:

```bash
dev_appserver.py $PWD
```

### Откройте приложение в браузере

Приложение запущено в Cloud Shell. Чтобы открыть его, нажмите [Просмотреть в браузере][spotlight-web-preview]<walkthrough-web-preview-icon></walkthrough-web-preview-icon> (соединение будет установлено по порту 8080).

### Завершите предварительный просмотр

Чтобы удалить экземпляр приложения, нажмите `Ctrl+C` в окне Cloud Shell.

## Развертывание в Google App Engine

### Создайте приложение

Создайте приложение в регионе:

```bash
gcloud app create
```

Примечание. Если приложение уже создано, переходите к следующему действию.

### Разверните приложение в Cloud Shell

Чтобы развернуть приложение с помощью Cloud Shell, введите команду:

```bash
gcloud app deploy app.yaml --project {{project-id}}
```

### Откройте приложение

Поздравляем! Ваше приложение развернуто. Его URL по умолчанию: [{{project-gae-url}}](http://{{project-gae-url}}). Нажмите на эту ссылку, чтобы открыть приложение.

### Проверьте состояние приложения

Просмотреть состояние приложения можно на панели управления App Engine.

Просто откройте [меню][spotlight-console-menu] в левой части консоли.

Перейдите в раздел **App Engine**.

<walkthrough-menu-navigation sectionid="APPENGINE_SECTION"></walkthrough-menu-navigation>

## Заключение

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Вы успешно развернули приложение App Engine.

Вот что можно сделать дальше:

**Скачайте Google Cloud SDK и запустите его на локальном компьютере**

Установите [Google Cloud SDK][cloud-sdk-installer] на локальном компьютере.

**Создайте ещё одно приложение**

Узнайте, как использовать другие продукты Google Cloud Platform в приложении App Engine:

<walkthrough-tutorial-card label="django" url="python/django/appengine" icon="APPENGINE_SECTION">
  **Попробуйте Django**
Создайте приложение Django на базе App Engine.
</walkthrough-tutorial-card>

<walkthrough-tutorial-card label="datastore" url="appengine/docs/python/datastore/" icon="DATASTORE_SECTION">
  **Попробуйте Cloud Datastore**
Масштабируемая база данных NoSQL для ваших приложений.
</walkthrough-tutorial-card>

[app-yaml-reference]: https://cloud.google.com/appengine/docs/standard/python/config/appref
[cloud-sdk-installer]: https://cloud.google.com/sdk/downloads#interactive
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-web-preview]: walkthrough://spotlight-pointer?spotlightId=devshell-web-preview-button
