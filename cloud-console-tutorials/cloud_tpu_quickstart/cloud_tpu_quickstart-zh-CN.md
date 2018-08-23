# TPU 使用快速入门

<walkthrough-tutorial-url url="https://cloud.google.com/tpu/docs/quickstart"></walkthrough-tutorial-url>

## 简介

您可以使用[张量处理单元][tpu-docs] (TPU) 加快特定 [TensorFlow][tensor-flow] 机器学习工作负载的处理速度。本教程介绍了如何创建 Cloud TPU 以及如何使用它运行基本的 TensorFlow 模型。

## 项目设置

Google Cloud Platform 按项目来组织资源。这可以让您在一个地方集中管理一个应用需要的所有相关资源。

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## 配置 Cloud SDK

### 打开 Cloud Shell

Cloud Shell 是控制台的内置命令行工具，可用来连接您的 TPU。

点击控制台顶部导航栏中的<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[图标][spotlight-open-devshell]即可打开 Cloud Shell。

### 指定地区

使用以下命令指定您创建 TPU 资源时计划使用的地区：

```bash
gcloud config set compute/zone us-central1-c
```

本例使用的是 `us-central1-c` 地区。

要查看可用的地区，请访问 Cloud TPU 文档网站：

[Cloud TPU 区域和地区][tpu-regions]

## 创建资源

本快速入门要求使用 Compute Engine 虚拟机实例。映像中包含 `gcloud beta` 命令行工具以及在 Cloud TPU 资源上运行 TensorFlow 所需的 TensorFlow 候选版本。

### 创建 Compute Engine VM

使用 `gcloud` 命令行工具创建 VM 实例。

```bash
gcloud compute instances create tpu-demo-vm \
  --machine-type=n1-standard-4 \
  --boot-disk-size=500GB \
  --image-project=ml-images \
  --image-family=tf-1-8 \
  --scopes=cloud-platform
```

### 启用 TPU API

如果您还没有激活 TPU API，请将其激活。

<walkthrough-enable-apis apis="tpu.googleapis.com"></walkthrough-enable-apis>

### 创建 TPU 资源

使用 `gcloud beta compute tpus create` 命令创建新的 Cloud TPU 资源。在本例中，我们将 `--range` 标志设置为 `10.240.1.0/29`。

```bash
gcloud beta compute tpus create demo-tpu \
  --range=10.240.1.0/29 --version=1.8
```

## 运行 TensorFlow 示例

连接到您的实例，并使用指向您 TPU 网络端点的 RPC（远程过程调用）创建 TensorFlow 程序。

### 连接到您的实例

输入以下命令，以通过 SSH 登录到虚拟机。如果这是您第一次通过 Cloud Shell 使用 SSH，您需要创建私钥：

```bash
gcloud compute ssh tpu-demo-vm
```

### 为您的 TPU 命名

在该实例中，使用您为 TPU 选择的名称设置环境变量。本例中使用的是“demo-tpu”。

```bash
export TPU_NAME="demo-tpu"
```

### 创建应用

创建一个指向您的 Cloud TPU 端点且运行一个简单计算的 Python 应用。

```bash
nano cloud-tpu.py
```

复制并粘贴以下文件内容：

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

### 运行应用

运行 TensorFlow 程序。

```bash
python cloud-tpu.py
```

您可以随意创建并运行使用此 TPU 设备的其他 TensorFlow 程序。

完成实验后，退出实例。

```bash
exit
```

## 删除资源

为避免系统因本快速入门中使用的资源向您的 Google Cloud Platform 帐号收取费用，请执行以下操作：

### 删除相关 TPU 资源和 VM 实例

使用 gcloud 命令行工具删除您的 Cloud TPU 资源。

```bash
gcloud beta compute tpus delete demo-tpu
```

使用 `gcloud` 命令行工具删除您的 Compute Engine 实例。

```bash
gcloud compute instances delete tpu-demo-vm
```

### 删除 VPC 网络

转到 Google Cloud Platform Console 中的“VPC 网络”部分。

<walkthrough-menu-navigation sectionid="VIRTUAL_NETWORK_SECTION"></walkthrough-menu-navigation>

导航到 [VPC 网络对等互连][spotlight-network-peering]部分，然后选择 Google 在 Cloud TPU 设置过程中自动创建的 VPC 网络。对等项条目的 ID 会以 `cp-to-tp-peering` 开头。

点击页面顶部的**删除**。

### 删除 VPC 路由

导航到[路由][spotlight-routes-list]部分，然后选择 Google 在 Cloud TPU 设置过程中自动创建的路由。对等项条目的 ID 会以 `peering-route` 开头。

点击页面顶部的**删除**。

## 总结

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

恭喜！

您已成功创建一个使用 Cloud TPU 的应用！

如需了解详情，请访问 Cloud TPU 文档网站：

[https://cloud.google.com/tpu/][tpu-docs]

[request-tpu-quota]: https://services.google.com/fb/forms/cloud-tpu-beta-request/
[spotlight-network-peering]: walkthrough://spotlight-pointer?cssSelector=#cfctest-section-nav-item-peering_list
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-routes-list]: walkthrough://spotlight-pointer?cssSelector=#cfctest-section-nav-item-routes_list
[tensor-flow]: https://www.tensorflow.org/
[tpu-docs]: https://cloud.google.com/tpu/docs/
[tpu-regions]: https://cloud.google.com/tpu/docs/regions
