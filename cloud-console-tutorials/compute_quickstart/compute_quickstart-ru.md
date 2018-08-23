# Быстрая настройка Compute Engine

## Здесь вы можете создать приложение "Список задач" на базе MongoDB.

<walkthrough-tutorial-duration duration="15"></walkthrough-tutorial-duration>

В ходе быстрой настройки с помощью Compute Engine будет создано двухуровневое
приложение. На интерфейсной ВМ будет запущено веб-приложение списка задач
Node.js, а на серверной – база данных MongoDB.

Следуя этому руководству, можно сделать следующее:

*   создать и настроить две ВМ;
*   настроить правила брандмауэра;
*   подключиться к ВМ по SSH и установить пакеты.

## Настройка проекта

В проекте будут собраны все ресурсы, которые вы используете в своем приложении.

<walkthrough-project-billing-setup permissions="compute.instances.create"></walkthrough-project-billing-setup>

## Переход к Compute Engine

Откройте [меню][spotlight-console-menu] в левой части консоли.

Выберите раздел **Compute Engine**.

<walkthrough-menu-navigation sectionid="COMPUTE_SECTION"></walkthrough-menu-navigation>

## Создание экземпляров

Создайте для приложения два экземпляра, которые будут использоваться как
внутренний и внешний сервер.

### Создание экземпляра серверного кода

Сначала создайте экземпляр серверного кода, на котором будет запущена база
данных MongoDB. В ней будет храниться информация о задачах.

Нажмите кнопку
[Создать экземпляр](walkthrough://spotlight-pointer?spotlightId=gce-zero-new-vm,gce-vm-list-newо).

*   Выберите [название][spotlight-instance-name] и
    [зону][spotlight-instance-zone] экземпляра.

*   Выберите [f1-micro][spotlight-machine-type]. Это позволит уменьшить расходы.

    *   [Подробнее о тарифах…][pricing]

*   В качестве образа загрузочного диска выберите
    [Ubuntu 14.04 LTS][spotlight-boot-disk].

*   В разделе [Брандмауэр][spotlight-firewall] выберите **Разрешить трафик
    HTTP**. Благодаря этому вы сможете обращаться к приложению через порт 80 по
    протоколу HTTP.

*   Нажмите кнопку [Создать][spotlight-submit-create].

Как только экземпляр будет создан, в соответствии с тарифами GCE с вашего счета
начнут списываться средства. Чтобы избежать дополнительных расходов, удалите
экземпляр.

### Создание экземпляра клиентского кода

Пока выполняется развертывание, создайте экземпляр клиентского кода, на котором
будет запускаться приложение списка задач на базе Node.js. Используйте ту же
конфигурацию, что и для экземпляра серверного кода.

## Настройка

Установите на экземпляр серверного кода СУБД MongoDB, в которой будут храниться
все данные.

Если нажать на одну из [кнопок SSH][spotlight-ssh-buttons] в таблице, в
отдельном окне откроется сеанс SSH для вашего экземпляра.

В этом руководстве описывается подключение через Cloud Shell – встроенный
интерфейс командной строки для консоли.

### Запуск Cloud Shell

Откройте Cloud Shell. Для этого нажмите на
<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[значок][spotlight-open-devshell]

на панели навигации в верхней части консоли.

### Ожидание создания экземпляра

Когда завершится создание экземпляров, нужный раздел в руководстве откроется
автоматически. При желании следите за процессом в
[меню уведомлений][spotlight-notification-menu]. Открыть его можно через панель
навигации в верхней части страницы.

## Подключение к экземпляру серверного кода

### Подключение к экземпляру

Подключитесь к экземпляру по SSH с помощью команды, представленной ниже. Если вы
впервые используете SSH в Cloud Shell, потребуется создать закрытый ключ.
Вставьте в команду имя и зону, которые вы задали.

```bash
gcloud compute --project "{{project-id}}" ssh --zone <backend-zone> <backend-name>
```

### Установка серверной базы данных

После подключения к экземпляру серверного кода по SSH установите серверную базу
данных.

Обновите пакеты и установите MongoDB. Когда появится запрос, введите `Y`:

```bash
sudo apt-get update
```

```bash
sudo apt-get install mongodb
```

### Запуск базы данных

Сразу после установки сервис MongoDB запускается автоматически. Чтобы изменить
параметры работы, его нужно остановить. Для этого выполните следующую команду:

```bash
sudo service mongodb stop
```

Создайте каталог и запустите службу MongoDB в фоновом режиме на порту 80:

```bash
sudo mkdir $HOME/db
```

```bash
sudo mongod --dbpath $HOME/db --port 80 --fork --logpath /var/tmp/mongodb
```

Выйдите из сеанса SSH, выполнив команду `exit`:

```bash
exit
```

## Подключение к экземпляру клиентского кода

### Установка и запуск веб-приложения на интерфейсной ВМ

Внутренний сервер работает, теперь надо установить интерфейсное веб-приложение.

### Подключение к экземпляру

Подключитесь к экземпляру по SSH с помощью команды, представленной ниже.
Вставьте в нее имя и зону, которые задали сами.

```bash
gcloud compute --project "{{project-id}}" ssh --zone <frontend-zone> <frontend-name>
```

### Установка зависимостей

Обновите пакеты и установите git, Node.js и npm. Когда появится запрос, введите
`Y`:

```bash
sudo apt-get update
```

```bash
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
```

```bash
sudo apt-get install git nodejs
```

### Установка и запуск интерфейсного веб-приложения

Скопируйте пример приложения и установите зависимости:

```bash
git clone https://github.com/GoogleCloudPlatform/todomvc-mongodb.git
```

```bash
cd todomvc-mongodb; npm install
```

```bash
sed -i -e 's/8080/80/g' server.js
```

Чтобы запустить веб-приложение списка задач, выполните следующую команду (для
созданных экземпляров введите [внутренние IP-адреса][spotlight-internal-ip]):

```bash
sudo nohup nodejs server.js --be_ip <backend-internal-ip> --fe_ip <frontend-internal-ip> &
```

Выйдите из сеанса SSH, выполнив команду `exit`:

```bash
exit
```

### Просмотр приложения

Подключитесь к веб-серверу по IP-адресу, указанному в столбце
[Внешний IP-адрес][spotlight-external-ip].

## Удаление экземпляра

Чтобы выполнить это действие, установите [флажки][spotlight-instance-checkbox]
рядом с названиями экземпляров и нажмите [Удалить][spotlight-delete-button].

## Заключение

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Вы прошли руководство.

Дополнительная информация:

*   Примеры Google Cloud Platform в сервисе
    [GitHub](http://googlecloudplatform.github.io/).

*   Подробнее о
    [балансировке нагрузки](https://cloud.google.com/compute/docs/load-balancing/)…

*   Как
    [переносить файлы на ВМ](https://cloud.google.com/compute/docs/instances/transfer-files/)…

*   Как
    [запускать контейнеры](https://cloud.google.com/compute/docs/containers)…

[pricing]: https://cloud.google.com/compute/#compute-engine-pricing
[spotlight-boot-disk]: walkthrough://spotlight-pointer?cssSelector=vm-set-boot-disk
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-control-panel]: walkthrough://spotlight-pointer?cssSelector=#p6n-action-bar-container-main
[spotlight-create-instance]: walkthrough://spotlight-pointer?spotlightId=gce-zero-new-vm,gce-vm-list-new
[spotlight-delete-button]: walkthrough://spotlight-pointer?cssSelector=.p6n-icon-delete
[spotlight-external-ip]: walkthrough://spotlight-pointer?cssSelector=.p6n-external-link
[spotlight-firewall]: walkthrough://spotlight-pointer?spotlightId=gce-vm-add-firewall
[spotlight-instance-checkbox]: walkthrough://spotlight-pointer?cssSelector=.p6n-checkbox-form-label
[spotlight-instance-name]: walkthrough://spotlight-pointer?spotlightId=gce-vm-add-name
[spotlight-instance-zone]: walkthrough://spotlight-pointer?spotlightId=gce-vm-add-zone-select
[spotlight-internal-ip]: walkthrough://spotlight-pointer?cssSelector=gce-internal-ip
[spotlight-machine-type]: walkthrough://spotlight-pointer?spotlightId=gce-add-machine-type-select
[spotlight-notification-menu]: walkthrough://spotlight-pointer?cssSelector=.p6n-notification-dropdown,.cfc-icon-notifications
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-ssh-buttons]: walkthrough://spotlight-pointer?cssSelector=gce-connect-to-instance
[spotlight-submit-create]: walkthrough://spotlight-pointer?spotlightId=gce-submit
[spotlight-vm-list]: walkthrough://spotlight-pointer?cssSelector=vm2-instance-list%20.p6n-checkboxed-table
