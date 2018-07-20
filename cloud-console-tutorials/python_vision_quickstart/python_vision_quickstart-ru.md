# Cloud Vision API

<walkthrough-test-start-page url="/start?tutorial=python_vision_quickstart_v2"></walkthrough-test-start-page>

<walkthrough-tutorial-url url="https://cloud.google.com/vision/docs/label-tutorial"></walkthrough-tutorial-url>

<walkthrough-watcher-constant value="https://github.com/GoogleCloudPlatform/python-docs-samples.git" key="repo-url"></walkthrough-watcher-constant>

<walkthrough-watcher-constant value="python-docs-samples" key="repo-name"></walkthrough-watcher-constant>

<walkthrough-devshell-precreate></walkthrough-devshell-precreate>

## Введение

В этом руководстве представлена информация о базовом приложении на основе
Vision API, использующем функцию `LABEL_DETECTION`. Эта функция ``создает метки
(или "теги") для картинок в зависимости от их содержания. Например, для
изображения сарая будет выбрана метка "сарай", "ферма" и т. п.

Вот из каких этапов состоит это руководство:

*   **Запуск приложения для создания меток** Вы узнаете, как запускать
    приложение в Google Cloud Shell – интерфейсе командной строки, который
    запускается прямо в браузере.
*   **Далее…** Приложение будет запущено в сервисе. Вы сможете
    поэкспериментировать с ним или же удалить, а затем создать новое.

[Python и логотип Python являются зарегистрированными товарными знаками
Python Software Foundation.](walkthrough://footnote)

# Настройка проекта

Чтобы включить Cloud Vision API, потребуется выбрать проект.

В проекте будут собраны все ресурсы, которые вы используете в своем приложении.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## Включение Vision API

Чтобы принимать запросы, необходимо включить в проекте Vision API.

### Откройте диспетчер API

В диспетчере API можно включить нужные API для проекта.

Для этого откройте
[меню](walkthrough://spotlight-pointer?spotlightId=console-nav-menu) в левой
части консоли.

Перейдите в раздел **API и сервисы**.

<walkthrough-menu-navigation sectionid="API_SECTION"></walkthrough-menu-navigation>

### Просмотрите доступные API

Чтобы включить API, нажмите кнопку
[Включить API](walkthrough://spotlight-pointer?cssSelector=.p6n-action-bar-button).

### Выберите Vision API

Нажмите на ссылку [Vision API](walkthrough://spotlight-pointer?spotlightId=api-vision.googleapis.com).

### Включите Vision API

Чтобы активировать Vision API, нажмите кнопку [Включить](walkthrough://spotlight-pointer?spotlightId=api-enable-vision.googleapis.com).
Учетные данные для вашего проекта будут созданы чуть позже.

## Запуск Google Cloud Shell

Cloud Shell – это встроенный интерфейс командной строки для консоли. Запуск
приложения будет выполнен с помощью этой программы.

### Запустите Google Cloud Shell

Откройте Cloud Shell. Для этого нажмите
<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>
[значок](walkthrough://spotlight-pointer?spotlightId=devshell-activate-button)
на панели навигации вверху консоли.

### Клонируйте пример кода

Клонируйте пример кода Hello World из хранилища проекта в Cloud Shell.

Примечание. Если каталог уже существует, удалите из него файлы перед
клонированием. Для этого введите следующую команду:

```bash
rm -rf {{repo-name}}
```

Чтобы клонировать пример хранилища:

```bash
git clone {{repo-url}}
```

Чтобы перейти в каталог с руководствами:

```bash
cd {{repo-name}}/vision/cloud-client/quickstart
```

## Настройка развертывания

Перед вами корневой каталог с примером кода. Здесь хранятся файлы конфигурации
приложения.

### Просмотрите код приложения

Чтобы просмотреть код приложения, введите следующую команду:

```bash
cat quickstart.py
```

Файлы `quickstart.py` содержат информацию о запросе – например, его тип и
содержание. Подробнее об этом читайте в разделах ниже.

Запросы к Vision API передаются в формате объектов JSON. Подробнее о структуре
запроса можно узнать [здесь][vision-request-doc]. Этот шаблон позволяет
передавать запросы в формате JSON с помощью функции `execute`.``

## Тестирование приложения

Чтобы использовать Cloud API, нужно настроить [учетные данные][auth-doc] для
вашего приложения. Без них приложение не сможет получать доступ к сервису и
выполнять задачи. Затем протестируйте API на примерах изображений.

### Создайте сервисный аккаунт

Создайте сервисный аккаунт для аутентификации запросов API. Можно использовать
существующий сервисный аккаунт.

```bash
gcloud iam service-accounts create vision-quickstart
```

### Создайте учетные данные

Создайте ключ сервисного аккаунта, который будет использоваться по умолчанию для
авторизации вызовов.

```bash
gcloud iam service-accounts keys create key.json --iam-account    vision-quickstart@{{project-id}}.iam.gserviceaccount.com
```

```bash
export GOOGLE_APPLICATION_CREDENTIALS=key.json
```

<walkthrough-test-code-output text="created key"></walkthrough-test-code-output>

### Протестируйте приложение

Чтобы протестировать приложение на примере изображения, введите следующую
команду:

```bash
python quickstart.py
```

В коде указано изображение `resources/wakeupcat.jpg`. ([Просмотреть
изображение][cat-picture])

## Заключение

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Поздравляем! Настройка Cloud Vision API завершена.

Вот что можно сделать дальше:

*   ознакомьтесь с руководством по системе [распознавания лиц][face-tutorial];
*   прочитайте руководство по [извлечению текста
    документа][document-text-tutorial];
*   изучите [примеры приложений][vision-samples];
*   скачайте [Google Cloud SDK][get-cloud-sdk] и запустите на локальном
    компьютере.

[auth-doc]: https://cloud.google.com/vision/docs/auth
[cat-picture]: https://raw.githubusercontent.com/GoogleCloudPlatform/python-docs-samples/master/vision/cloud-client/quickstart/resources/wakeupcat.jpg
[document-text-tutorial]: https://cloud.google.com/vision/docs/fulltext-annotations
[face-tutorial]: https://cloud.google.com/vision/docs/face-tutorial
[get-cloud-sdk]: https://cloud.google.com/sdk/
[vision-request-doc]: https://cloud.google.com/vision/reference/rest
[vision-samples]: https://cloud.google.com/vision/docs/samples
