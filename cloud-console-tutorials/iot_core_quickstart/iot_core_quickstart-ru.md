# Начало работы с Cloud IoT Core

<walkthrough-tutorial-url url="https://cloud.google.com/iot/docs/quickstart"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="https://github.com/GoogleCloudPlatform/nodejs-docs-samples.git" key="repo-url"></walkthrough-watcher-constant>

## Введение

Google Cloud Internet of Things (IoT) Core – это полностью управляемый сервис для работы с устройствами IoT. Из этого руководства вы узнаете, как создать хранилище устройств Cloud IoT Core и добавить в него устройство из командной строки `gcloud`. Вы также запустите пример приложения MQTT, подключите устройство и опубликуете его телеметрические данные.

Это руководство поможет:

  *  создать тему Cloud Pub/Sub;
  *  создать хранилище устройств;
  *  добавить устройство в хранилище;
  *  настроить учетные данные для устройства;
  *  создать подписку на тему Pub/Sub для отправки и получения сообщений;
  *  подключить виртуальное устройство и просмотреть телеметрические данные.

## Настройка проекта

В проекте будут собраны все ресурсы, которые вы используете в своем приложении.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## Активация Google Cloud Shell

Все описываемые действия выполняются в Cloud Shell.

### Запуск Google Cloud Shell

Откройте Cloud Shell. Для этого нажмите <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[значок][spotlight-open-devshell] на панели навигации в верхней части консоли.

### Активация Google Cloud API

Cloud IoT Core API будет включен автоматически.

<walkthrough-enable-apis apis="cloudiot.googleapis.com"></walkthrough-enable-apis>

## Создание первой темы

Тема – это именованный ресурс, на который устройства отправляют сообщения. Чтобы создать тему, выполните следующую команду:

```bash
gcloud pubsub topics create my-topic
```

Позже вы отправите несколько сообщений в эту тему.

## Клонирование файлов Node.js для Cloud IoT Core из GitHub

Пример приложения MQTT понадобится, чтобы отправлять сообщения в Cloud IoT Core.

Примечание. Если каталог уже существует, удалите из него файлы перед клонированием. Для этого введите следующую команду:

```bash
rm -rf nodejs-docs-samples
```

Чтобы клонировать пример программы, выполните следующую команду:

```bash
git clone {{repo-url}}
```

## Предоставление права доступа сервисному аккаунту Cloud IoT Core

Используя вспомогательный сценарий из папки `/iot/scripts`, добавьте сервисный аккаунт `cloud-iot@system.gserviceaccount.com` в тему Cloud Pub/Sub с ролью "Издатель".

### Перейдите в каталог iot/:

```bash
cd nodejs-docs-samples/iot
```

### Установите зависимости:

```bash
npm --prefix ./scripts install
```

### Запустите вспомогательный сценарий:

```bash
node scripts/iam.js my-topic
```

Сервисному аккаунту Cloud IoT Core будет предоставлен доступ к теме `my-topic`.

## Создание хранилища устройств

Хранилище устройств определяет свойства, общие для всех входящих в него устройств. Чтобы создать хранилище, выполните следующую команду:

```bash
gcloud iot registries create my-registry \
    --project={{project-id}} \
    --region=us-central1 \
    --event-notification-config=topic=projects/{{project-id}}/topics/my-topic
```

## Создание ключей подписи

Для аутентификации устройства в Cloud IoT Core нужна пара ключей (закрытый и открытый). Чтобы создать их, выполните следующую команду:

```bash
./scripts/generate_keys.sh
```

В результате выполнения этого скрипта будут созданы ключи RS256 и ES256 в формате PEM, но сейчас вам понадобятся только ключи RS256. Закрытый ключ должен храниться на устройстве и использоваться для аутентификации JWT ([JSON Web Token][web-token-docs]). Открытый ключ находится в хранилище устройств.

## Создание устройства и добавление его в хранилище

Чтобы создать устройство и добавить его в хранилище, выполните следующую команду:

```bash
gcloud iot devices create my-node-device \
    --project={{project-id}} \
    --region=us-central1 \
    --registry=my-registry \
    --public-key path=rsa_cert.pem,type=rs256
```

## Подключение устройства и просмотр телеметрических данных

Теперь вы отправите сообщения с виртуального устройства в Pub/Sub, а затем извлечете и просмотрите их.

### Откройте каталог с примером приложения MQTT:

```bash
cd mqtt_example
```

### Установите зависимости Node.js:

```bash
npm install
```

### Чтобы подключить виртуальное устройство к Cloud IoT Core по протоколу MQTT, выполните следующую команду:

```bash
node cloudiot_mqtt_example_nodejs.js \
    --projectId={{project-id}} \
    --registryId=my-registry \
    --deviceId=my-node-device \
    --privateKeyFile=../rsa_private.pem \
    --numMessages=25 \
    --algorithm=RS256 \
    --mqttBridgePort=443
```

Виртуальное устройство публикует сообщения в теме для публикации телеметрии. Уже опубликовано 25 сообщений.

## Создание подписки на тему устройства

Чтобы создать подписку для просмотра сообщений, опубликованных вашим устройством, выполните следующую команду:

```bash
gcloud pubsub subscriptions create \
    projects/{{project-id}}/subscriptions/my-subscription \
    --topic=my-topic
```

## Извлечение опубликованных сообщений

Чтобы извлечь опубликованные сообщения, выполните следующую команду:

```bash
gcloud pubsub subscriptions pull --auto-ack \
    projects/{{project-id}}/subscriptions/my-subscription
```

В результате будут извлечены сообщения, опубликованные этим устройством. Для каждого сообщения будут указаны следующие данные: `my-registry/my-node-device-payload-&lt;INTEGER&gt;`, `MESSAGE_ID` и список атрибутов `ATTRIBUTES` со сведениями об устройстве. Параметр `MESSAGE_ID` – это уникальный идентификатор сообщения, присваиваемый сервером.

Примечание. Сообщения могут отображаться не в том порядке, в каком они были опубликованы. Если вы видите в Cloud Shell только одно сообщение, выполните команду несколько раз, пока не отобразятся остальные.

## Просмотр ресурсов в консоли Google Cloud Platform

Итак, мы рассмотрели использование командной строки `gcloud`. Созданные ресурсы также можно просмотреть в консоли GCP.

Откройте [меню][spotlight-console-menu] в левой части консоли.

Выберите **IoT Core**.

<walkthrough-menu-navigation sectionid="IOT_SECTION"></walkthrough-menu-navigation>

В этом интерфейсе также можно создавать устройства и их хранилища и управлять ими.

## Заключение

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Вы познакомились с программой командной строки `gcloud` и с Cloud IoT Core, а также узнали, как просматривать ресурсы Cloud IoT Core в консоли GCP. Теперь вы можете создавать собственные приложения. Подробнее о Cloud IoT Core можно узнать [здесь](https://cloud.google.com/iot/docs/).

### Дополнительная информация

Другие примеры кода Cloud IoT Core на GitHub:

  *  [C](https://github.com/GoogleCloudPlatform/cpp-docs-samples/tree/master/iot/mqtt-ciotc)
  *  [Java](https://github.com/GoogleCloudPlatform/java-docs-samples/tree/master/iot/api-client)
  *  [Node.js](https://github.com/GoogleCloudPlatform/nodejs-docs-samples/tree/master/iot)
  *  [Python](https://github.com/GoogleCloudPlatform/python-docs-samples/tree/master/iot/api-client)

[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[web-token-docs]: https://cloud.google.com/iot/docs/how-tos/credentials/jwts
