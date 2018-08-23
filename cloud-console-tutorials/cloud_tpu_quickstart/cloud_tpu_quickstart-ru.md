# Краткое руководство по работе с TPU

<walkthrough-tutorial-url url="https://cloud.google.com/tpu/docs/quickstart"></walkthrough-tutorial-url>

## Введение

С помощью [тензорных процессоров][tpu-docs] (TPU) можно ускорить выполнение определенных рабочих нагрузок машинного обучения [TensorFlow][tensor-flow]. Из этого руководства вы узнаете, как создать Cloud TPU и запустить на нем базовую модель TensorFlow.

## Настройка проекта

В проекте будут собраны все ресурсы, которые вы используете в своем приложении.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## Настройка Cloud SDK

### Запуск Cloud Shell

Cloud Shell – это встроенный интерфейс командной строки для консоли. Подключение к TPU будет выполнено с его помощью.

Откройте Cloud Shell. Для этого нажмите <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[значок][spotlight-open-devshell] на панели навигации в верхней части консоли.

### Выбор зоны

Чтобы указать зону, в которой будет создан ресурс TPU, выполните следующую команду:

```bash
gcloud config set compute/zone us-central1-c
```

В этом примере используйте зону `us-central1-c`.

Список доступных зон см. в документации по Cloud TPU:

[Регионы и зоны Cloud TPU][tpu-regions]

## Создание ресурсов

В этом руководстве используется экземпляр ВМ Compute Engine. Образ содержит командную строку `gcloud beta` и версию релиз-кандидат TensorFlow, необходимую для запуска TensorFlow на ресурсах Cloud TPU.

### Создание ВМ Compute Engine

Создайте экземпляр ВМ с помощью `gcloud`.

```bash
gcloud compute instances create tpu-demo-vm \
  --machine-type=n1-standard-4 \
  --boot-disk-size=500GB \
  --image-project=ml-images \
  --image-family=tf-1-8 \
  --scopes=cloud-platform
```

### Включение TPU API

Если TPU API отключен, включите его.

<walkthrough-enable-apis apis="tpu.googleapis.com"></walkthrough-enable-apis>

### Создание ресурса TPU

Создайте ресурс Cloud TPU с помощью команды `gcloud beta compute tpus create`. В этом примере установите для флага `--range` значение `10.240.1.0/29`.

```bash
gcloud beta compute tpus create demo-tpu \
  --range=10.240.1.0/29 --version=1.8
```

## Запуск программы TensorFlow

Подключитесь к своему экземпляру и создайте программу TensorFlow с помощью вызова удаленных процедур (RPC) в конечной точке TPU.

### Подключение к экземпляру

Подключитесь к ВМ по SSH с помощью следующей команды (если вы впервые используете SSH в Cloud Shell, потребуется создать закрытый ключ):

```bash
gcloud compute ssh tpu-demo-vm
```

### Добавление названия TPU

Задайте для экземпляра переменную среды с тем же названием, что и у TPU, например demo-tpu.

```bash
export TPU_NAME="demo-tpu"
```

### Создание приложения

Создайте приложение Python, выполняющее простое вычисление в конечной точке Cloud TPU.

```bash
nano cloud-tpu.py
```

Вставьте в файл следующий код:

```python
import os
import tensorflow as tf
from tensorflow.contrib import tpu
from tensorflow.contrib.cluster_resolver import TPUClusterResolver

def axy_computation(a, x, y):
  return a * x + y

inputs = [
    3.0,
    tf.ones([3, 3], tf.float32),
    tf.ones([3, 3], tf.float32),
]

tpu_computation = tpu.rewrite(axy_computation, inputs)

tpu_grpc_url = TPUClusterResolver(
    tpu=[os.environ['TPU_NAME']]).get_master()

with tf.Session(tpu_grpc_url) as sess:
  sess.run(tpu.initialize_system())
  sess.run(tf.global_variables_initializer())
  output = sess.run(tpu_computation)
  print(output)
  sess.run(tpu.shutdown_system())

print('Готово.')
```

### Запуск приложения

Запустите программу TensorFlow.

```bash
python cloud-tpu.py
```

Вы можете создать и запустить ещё несколько программ TensorFlow, использующих это устройство TPU.

После того как вы закончите работу, отключитесь от экземпляра.

```bash
exit
```

## Удаление ресурсов

Чтобы с вашего аккаунта Google Cloud Platform в дальнейшем не списывалась плата за ресурсы, использованные в этом руководстве, выполните следующие действия.

### Удаление ресурса TPU и экземпляра ВМ

Удалите ресурс Cloud TPU с помощью gcloud.

```bash
gcloud beta compute tpus delete demo-tpu
```

Удалите экземпляр Compute Engine с помощью `gcloud`.

```bash
gcloud compute instances delete tpu-demo-vm
```

### Удаление сети VPC

Откройте раздел "Сеть VPC" в Google Cloud Platform Console.

<walkthrough-menu-navigation sectionid="VIRTUAL_NETWORK_SECTION"></walkthrough-menu-navigation>

В разделе [Точки обмена данными VPC][spotlight-network-peering] выберите сеть VPC, которая была создана автоматически при настройке Cloud TPU. Ее идентификатор начинается с `cp-to-tp-peering`.

В верхней части страницы нажмите **Удалить**.

### Удаление маршрута VPC

В разделе [Маршруты][spotlight-routes-list] выберите маршрут, который был создан автоматически при настройке Cloud TPU. Его идентификатор начинается с `peering-route`.

В верхней части страницы нажмите **Удалить**.

## Заключение

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Поздравляем!

Вы создали приложение на базе Cloud TPU.

Дополнительную информацию см. в документации по Cloud TPU:

[https://cloud.google.com/tpu/][tpu-docs]

[request-tpu-quota]: https://services.google.com/fb/forms/cloud-tpu-beta-request/
[spotlight-network-peering]: walkthrough://spotlight-pointer?cssSelector=#cfctest-section-nav-item-peering_list
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-routes-list]: walkthrough://spotlight-pointer?cssSelector=#cfctest-section-nav-item-routes_list
[tensor-flow]: https://www.tensorflow.org/
[tpu-docs]: https://cloud.google.com/tpu/docs/
[tpu-regions]: https://cloud.google.com/tpu/docs/regions
