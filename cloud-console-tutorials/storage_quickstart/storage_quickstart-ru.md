# Быстрая настройка Cloud Storage

## Добро пожаловать в Google Cloud Storage!

<walkthrough-tutorial-url url="https://cloud.google.com/storage/docs/quickstart-console"></walkthrough-tutorial-url>

Google Cloud Storage – это мощный и экономичный сервис хранения неструктурированных объектов, отлично подходящий для хостинга веб-контента, хранения данных аналитики, архивирования и резервного копирования.

Пользоваться им исключительно просто. Ознакомившись с этим руководством, вы научитесь выполнять следующие действия:

  *  **Создавать сегменты**

     Сегменты – это разделы Cloud Storage, предназначенные для хранения файлов и папок.

  *  **Загружать объекты и предоставлять доступ к ним**

     Для начала загрузите объект и сделайте его общедоступным.

  *  **Удалять ненужные объекты**

     Удалите сегмент и объект, созданные в рамках данного руководства.

Поскольку в конце сегмент и объект будут удалены, оплата начисляться не будет.

## Настройка проекта

Для создания ресурсов в Cloud Storage нужен проект.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## Создание сегмента

Объекты Cloud Storage хранятся в сегментах. Создать сегмент можно на странице "Обзор".

Откройте [меню][spotlight-menu] в левой части консоли.

Выберите раздел **Storage**.

<walkthrough-menu-navigation sectionid="STORAGE_SECTION"></walkthrough-menu-navigation>

## Создание сегмента

Прежде чем загружать объекты, необходимо создать сегмент для их хранения. Сегменты помогают организовывать объекты и контролировать доступ к ним.

  1. Нажмите [Создать сегмент](walkthrough://spotlight-pointer?cssSelector=#p6ntest-cloudstorage-create-first-bucket-button,).

  1. На странице создания сегмента укажите его свойства. Обратите внимание на перечисленные ниже параметры.

     *  **Название.** Оно должно быть уникальным. Если название совпадет с названием другого сегмента в Cloud Storage, на экране появится сообщение об ошибке.
     *  **Класс хранилища по умолчанию.** Класс, по умолчанию присвоенный объектам сегмента. Выбор класса в основном зависит от того, как часто предполагается использовать объекты и будут ли данные предоставляться по всему миру. Класс хранилища влияет на объем расходов.
     *  **Местоположение.** Рекомендуется хранить данные рядом с приложениями и пользователями, которые будут к ним обращаться. Доступные местоположения зависят от класса хранилища.

Поскольку после завершения этого пробного запуска сегмент будет удален, можно выбрать любой класс хранилища и любое местоположение.

  1. Нажмите [Создать][spotlight-create-button].

## Загрузите объект

Теперь в созданный сегмент можно загрузить объекты.

  1. Вверху страницы нажмите [Загрузить файлы][spotlight-upload-file].

  1. Выберите любой файл для загрузки.

     [Создайте файл][create-sample-file], если нет готового, затем вверху страницы нажмите [Обновить][spotlight-refresh-bucket], чтобы увидеть этот файл в сегменте. (Совет. Объекты можно загрузить, перетаскивая их в область под названием сегмента.)

## Удаление сегмента

Теперь созданный сегмент можно удалить. При этом также будет удалено его содержимое.

  1. Вверху таблицы нажмите [Сегменты][spotlight-buckets-link], чтобы вернуться к списку сегментов.

  1. Установите флажок рядом с нужным сегментом. Если в проекте несколько сегментов, используйте фильтры в окне поиска.

  1. Вверху страницы нажмите кнопку [Удалить][spotlight-delete-buckets], а затем подтвердите операцию.

## Заключение

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Поздравляем!

Теперь вы знаете, как сохранять объекты в Cloud Storage. Возможно, вам захочется узнать, как их использовать в реальных условиях, [разместив статический сайт](https://cloud.google.com/storage/docs/hosting-static-website).

Вы также можете подробнее узнать, как работать в Cloud Storage [через интерфейс командной строки gsutil](https://cloud.google.com/storage/docs/quickstart-gsutil).

К слову, для Cloud Storage и других сервисов GCP предусмотрены [бесплатные](https://cloud.google.com/free) варианты использования.

[create-sample-file]: walkthrough://create-sample-storage-file
[spotlight-buckets-link]: walkthrough://spotlight-pointer?cssSelector=.p6n-cloudstorage-path-link
[spotlight-create-bucket]: walkthrough://spotlight-pointer?cssSelector=#p6ntest-cloudstorage-create-first-bucket-button,#p6n-cloudstorage-create-bucket
[spotlight-create-button]: walkthrough://spotlight-pointer?cssSelector=#p6ntest-gcs-create-bucket-button
[spotlight-delete-buckets]: walkthrough://spotlight-pointer?spotlightId=gcs-action-bar-delete-bucket
[spotlight-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-public-link]: walkthrough://spotlight-pointer?cssSelector=.p6n-cloudstorage-browser-public-label
[spotlight-refresh-bucket]: walkthrough://spotlight-pointer?spotlightId=gcs-action-bar-refresh-objects
[spotlight-share-public]: walkthrough://spotlight-pointer?cssSelector=.p6n-cloudstorage-browser-public-checkbox
[spotlight-upload-file]: walkthrough://spotlight-pointer?spotlightId=gcs-action-bar-upload-file
