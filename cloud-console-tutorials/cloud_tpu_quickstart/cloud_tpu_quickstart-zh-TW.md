# 使用 TPU 的快速入門導覽課程

<walkthrough-tutorial-url url="https://cloud.google.com/tpu/docs/quickstart"></walkthrough-tutorial-url>

## 簡介

您可以使用 [Tensor Processing Unit][tpu-docs] (TPU) 來加快特定 [TensorFlow][tensor-flow] 作業的機器學習速度。本教學課程將說明如何建立 Cloud TPU，以及如何使用 Cloud TPU 來執行基本的 TensorFlow 模型。

## 專案設定

Google Cloud Platform 會將資源彙整至專案中，方便您集中收納單一應用程式的所有相關資源。

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## 設定 Cloud SDK

### 開啟 Cloud Shell

Cloud Shell 是主控台專用的內建指令列工具，可讓您連線至 TPU。

請點選主控台頂端導覽列中的 <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon> [圖示](逐步操作說明：//spotlight-pointer?spotlightId=devshell-activate-button)來開啟 Cloud Shell。

### 指定區域

請使用下列指令來指定您要建立 TPU 資源的目標區域：

```bash
gcloud config set compute/zone us-central1-c
```

在這個範例中，請使用「`us-central1-c`」區域。

如想瞭解您可以使用哪些區域，請造訪 Cloud TPU 說明文件網站：

[Cloud TPU 的區域和分區][tpu-regions]

## 建立資源

在這個快速入門導覽課程中，您必須使用 Compute Engine 虛擬機器執行個體。映像檔中包含 `gcloud beta` 指令列工具和必要的 TensorFlow 候選版本，以便您在 Cloud TPU 資源上執行 TensorFlow。

### 建立 Compute Engine VM

請使用 `gcloud` 指令列工具來建立 VM 執行個體。

```bash
gcloud compute instances create tpu-demo-vm \
  --machine-type=n1-standard-4 \
  --boot-disk-size=500GB \
  --image-project=ml-images \
  --image-family=tf-1-8 \
  --scopes=cloud-platform
```

### 啟用 TPU API

如果您尚未啟用 TPU API，請先啟用 TPU API。

<walkthrough-enable-apis apis="tpu.googleapis.com"></walkthrough-enable-apis>

### 建立 TPU 資源

請使用 `gcloud beta compute tpus create` 指令來建立新的 Cloud TPU 資源。在這個範例中，請將「`--range`」標記設為「`10.240.1.0/29`」。

```bash
gcloud beta compute tpus create demo-tpu \
  --range=10.240.1.0/29 --version=1.8
```

## 執行 TensorFlow 範例

透過指向您 TPU 網路端點的遠端程序呼叫 (RPC) 連線至您的執行個體，並且建立 TensorFlow 程式。

### 連線至執行個體

接下來，請透過 SSH 登入 VM。如果您是第一次透過 Cloud Shell 使用 SSH，系統會要求您建立私密金鑰。如要登入 VM，請使用下列指令：

```bash
gcloud compute ssh tpu-demo-vm
```

### 為 TPU 命名

在執行個體中，使用您為 TPU 選擇的名稱來設定環境變數。在這個範例中，請使用「demo-tpu」。

```bash
export TPU_NAME="demo-tpu"
```

### 建立應用程式

請建立指向您 Cloud TPU 端點的 Python 應用程式，並且執行簡單的運算作業。

```bash
nano cloud-tpu.py
```

複製並貼上以下檔案內容：

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

print('Done!')
```

### 執行應用程式

執行 TensorFlow 程式。

```bash
python cloud-tpu.py
```

您也可以視需求建立並執行多個使用 TPU 裝置的 TensorFlow 程式。

實驗完成後，請退出執行個體。

```bash
exit
```

## 刪除資源

您在本次快速入門導覽課程中使用的資源可能會產生費用。如要避免系統向您的 Google Cloud Platform 帳戶收取這筆費用，請按照下列指示操作：

### 刪除 TPU 資源和 VM 執行個體

使用 gcloud 指令列工具來刪除您的 Cloud TPU 資源。

```bash
gcloud beta compute tpus delete demo-tpu
```

使用 `gcloud` 指令列工具來刪除您的 Compute Engine 執行個體。

```bash
gcloud compute instances delete tpu-demo-vm
```

### 刪除虛擬私人雲端網路

前往 Google Cloud Platform 主控台的「VCP 網路」專區。

<walkthrough-menu-navigation sectionid="VIRTUAL_NETWORK_SECTION"></walkthrough-menu-navigation>

前往 [VCP 網路對等互連](逐步操作說明：//spotlight-pointer?cssSelector=#cfctest-section-nav-item-peering_list)專區，然後選取 Google 在您設定 Cloud TPU 時自動建立的虛擬私人雲端網路。對等互連項目的 ID 開頭為「`cp-to-tp-peering`」。

點選頁面頂端的 [**刪除**]。

### 刪除虛擬私人雲端路徑

前往[路徑](逐步操作說明：//spotlight-pointer?cssSelector=#cfctest-section-nav-item-routes_list)專區，然後選取 Google 在您設定 Cloud TPU 時自動建立的路徑。對等互連項目的 ID 開頭為「`peering-route`」。

點選頁面頂端的 [**刪除**]。

## 結論

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

恭喜！

您已成功建立使用 Cloud TPU 的應用程式！

如要瞭解詳情，請前往 Cloud TPU 說明文件網站：

[https://cloud.google.com/tpu/][tpu-docs]

[request-tpu-quota]: https://services.google.com/fb/forms/cloud-tpu-beta-request/
[spotlight-network-peering]: walkthrough://spotlight-pointer?cssSelector=#cfctest-section-nav-item-peering_list
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-routes-list]: walkthrough://spotlight-pointer?cssSelector=#cfctest-section-nav-item-routes_list
[tensor-flow]: https://www.tensorflow.org/
[tpu-docs]: https://cloud.google.com/tpu/docs/
[tpu-regions]: https://cloud.google.com/tpu/docs/regions
