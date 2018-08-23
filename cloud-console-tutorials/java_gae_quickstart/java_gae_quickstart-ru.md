# Быстрая настройка App Engine

<walkthrough-test-start-page url="/getting-started?tutorial=java_gae_quickstart_2"/>

<walkthrough-tutorial-url url="https://cloud.google.com/appengine/docs/java/quickstart"/>

<walkthrough-watcher-constant key="repo-url" value="https://github.com/GoogleCloudPlatform/appengine-try-java" />

<walkthrough-watcher-constant key="repo-name" value="appengine-try-java"/>

## Введение

Из этого руководства вы узнаете, как развернуть пример приложения на
[Java][java] в Google App Engine с помощью плагина App Engine Maven.

Вот из каких этапов состоит это руководство:

*   **Создание и запуск приложения "Hello, world!"**

    Вы узнаете, как запускать приложение в Google Cloud Shell – прямо в
    браузере. В конце руководства вы опубликуете свое приложение в Интернете
    через плагин App Engine Maven.

*   **Далее...**

    Приложение будет запущено в сервисе. Вы сможете поэкспериментировать с ним
    или же удалить, а затем создать новое.

[Java – это зарегистрированный товарный знак корпорации Oracle и ее
аффилированных лиц.](walkthrough://footnote)

<walkthrough-devshell-precreate/>

## Настройка проекта

Чтобы развернуть приложение, нужно создать проект.

В проекте будут собраны все ресурсы, которые вы используете в своем приложении.

<walkthrough-project-setup/>

## Активация Google Cloud Shell

Cloud Shell – это встроенный интерфейс командной строки для консоли.
Развертывание приложения будет выполнено с помощью этой программы.

### Запуск Google Cloud Shell

Чтобы открыть Cloud Shell, нажмите <walkthrough-cloud-shell-icon/>
[icon](walkthrough://spotlight-pointer?spotlightId=devshell-activate-button) на
панели навигации в верхней части консоли.

### Клонировать образец кода

Клонируйте пример кода Hello World из хранилища проекта в Cloud Shell. Чтобы
клонировать пример кода и перейти в его каталог,

Примечание. Если каталог уже существует, удалите все файлы в нем перед
клонированием:

```bash
rm -rf {{repo-name}}
```

в Cloud Shell введите следующее:

```bash
git clone {{repo-url}}
```

Чтобы перейти в каталог с руководствами:

```bash
cd {{repo-name}}
```

## Настройка развертывания

Перед вами корневой каталог с примером кода. Здесь хранятся файлы конфигурации
приложения.

### Просмотр кода приложения

Чтобы просмотреть код приложения,

введите следующую команду:

```bash
cat src/main/java/myapp/DemoServlet.java
```

Этот сервлет отправляет сообщение `Hello, world!` в ответ на любой запрос.

### Просмотр конфигурации

В Google App Engine используются XML-файлы конфигурации развертывания
Java-приложений.

Чтобы просмотреть файл конфигурации, введите следующую команду:

```bash
cat pom.xml
```

Поскольку в приложении `helloworld` используется инструмент Maven, необходимо
создать файл pom.xml, который содержит информацию о проекте и параметры его
конфигурации.

## Проверка работы приложения

### Протестируйте приложение в Cloud Shell

В Cloud Shell вы можете протестировать приложение перед развертыванием. Это
похоже на процесс отладки на локальном компьютере.

Чтобы протестировать приложение, введите следующую команду:

```bash
mvn appengine:run
```

<walkthrough-test-code-output
  text="module .* running at|Dev App Server is now running" />

### Откройте приложение в браузере

Приложение было запущено в Cloud Shell. Чтобы получить к нему доступ, нажмите
кнопку "Просмотреть в браузере" <walkthrough-web-preview-icon/> для подключения
к порту 8080.
[Показать](walkthrough://spotlight-pointer?spotlightId=devshell-web-preview-button)

### Завершите предварительный просмотр

Чтобы удалить экземпляр приложения, нажмите `Ctrl+C` в окне Cloud Shell.

## Развертывание в Google App Engine

### Создайте приложение

Прежде всего нужно создать приложение в регионе:

```bash
gcloud app create
```

Примечание. Если приложение уже создано, этот шаг можно пропустить.

### Разверните приложение в Cloud Shell

Теперь можно развернуть приложение с помощью Cloud Shell.

Сначала выберите нужный проект:

```bash
gcloud config set project {{project-id}}
```

Затем разверните приложение:

```bash
mvn appengine:deploy
```

<walkthrough-test-code-output text="Deployed (module|service)" />

### Откройте приложение

Ваше приложение развернуто. Его URL по умолчанию:
[{{project-gae-url}}](http://{{project-gae-url}}) Нажмите на эту ссылку, чтобы
открыть приложение.

### Просмотрите состояние приложения

Просмотреть статус приложения можно на панели управления App Engine.

Для этого откройте
[меню](walkthrough://spotlight-pointer?spotlightId=console-nav-menu) в левой
части консоли.

Затем перейдите в раздел **App Engine**.

<walkthrough-menu-navigation sectionId="APPENGINE_SECTION"/>

## Заключение

<walkthrough-conclusion-trophy/>

Поздравляем! Вы успешно развернули приложение App Engine. Вот что можно сделать
дальше:

**Скачайте Google Cloud SDK и запустите его на локальном компьютере**

[Google Cloud SDK][cloud-sdk-installer]

**Создайте ещё одно приложение**

Узнайте, как использовать другие продукты Google Cloud Platform в приложении
App Engine:

<walkthrough-tutorial-card
  url="appengine/docs/java/datastore/"
  icon="DATASTORE_SECTION"
  label="datastore">
**Попробуйте Cloud Datastore**
Масштабируемая база данных NoSQL для ваших приложений.
</walkthrough-tutorial-card>

<walkthrough-tutorial-card
  url="appengine/docs/java/googlecloudstorageclient/setting-up-cloud-storage/"
  icon="STORAGE_SECTION"
  label="cloudStorage">
**Попробуйте Cloud Storage**
Эффективный и удобный сервис для хранения объектов.
</walkthrough-tutorial-card>

[java]: https://java.com/
[cloud-sdk-installer]: https://cloud.google.com/sdk/downloads#interactive
