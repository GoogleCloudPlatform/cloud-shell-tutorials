# Cloud IoT Core 简介

<walkthrough-tutorial-url url="https://cloud.google.com/iot/docs/quickstart"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="https://github.com/GoogleCloudPlatform/nodejs-docs-samples.git" key="repo-url"></walkthrough-watcher-constant>

## 简介

Google Cloud Internet of Things (IoT) Core 是一项完全托管的服务，可帮助您安全地连接和管理 IoT 设备（数量从几个到数百万个不等）。本教程向您介绍如何使用 `gcloud` 命令行工具创建 Cloud IoT Core 设备注册表并添加设备，以及如何运行 MQTT 示例以连接设备并发布设备遥测事件。

本教程将分步指导您完成：

  *  创建 Cloud Pub/Sub 主题
  *  创建设备注册表
  *  将设备添加到注册表
  *  在设备上设置凭据
  *  创建对 Pub/Sub 主题的订阅以收发消息
  *  连接虚拟设备并查看遥测数据

## 项目设置

Google Cloud Platform 按项目来组织资源。这可以让您在一个地方集中管理一个应用需要的所有相关资源。

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## 使用 Google Cloud Shell

在本教程中，您将在 Cloud Shell 中完成所有工作。

### 打开 Google Cloud Shell

点击控制台顶部导航栏中的相应<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[图标][spotlight-open-devshell]即可打开 Cloud Shell。

### 开启 Google Cloud API

此操作会启用 Cloud IoT Core API。

<walkthrough-enable-apis apis="cloudiot.googleapis.com"></walkthrough-enable-apis>

## 创建您的第一个主题

主题是设备向其发送消息的命名资源。使用以下命令创建您的第一个主题：

```bash
gcloud pubsub topics create my-topic
```

稍后，您将向此主题发送几条消息。

## 从 GitHub 克隆 Cloud IoT Core Node.js 示例文件

您将使用 MQTT 示例向 Cloud IoT Core 发送消息。

注意：如果相应目录已经存在，请在克隆之前移除之前的文件：

```bash
rm -rf nodejs-docs-samples
```

使用以下命令克隆示例程序：

```bash
git clone {{repo-url}}
```

## 向 Cloud IoT Core 服务帐号授予权限

使用 `/iot/scripts` 文件夹中的帮助程序脚本，向 Cloud Pub/Sub 主题添加具有发布者角色的 `cloud-iot@system.gserviceaccount.com` 服务帐号。

### 转到 iot 目录：

```bash
cd nodejs-docs-samples/iot
```

### 安装依赖项：

```bash
npm --prefix ./scripts install
```

### 运行帮助程序脚本：

```bash
node scripts/iam.js my-topic
```

该脚本会向 Cloud IoT Core 服务帐号授予有关 `my-topic` 主题的权限。

## 创建设备注册表

设备注册表包含相关设备并定义了其包含的所有设备所共有的属性。使用以下命令创建设备注册表：

```bash
gcloud iot registries create my-registry \
    --project={{project-id}} \
    --region=us-central1 \
    --event-notification-config=topic=projects/{{project-id}}/topics/my-topic
```

## 生成签名密钥

为了对 Cloud IoT Core 进行身份验证，设备需要一个私钥和一个公钥。通过运行以下命令来生成您的签名密钥：

```bash
./scripts/generate_keys.sh
```

此脚本会创建 PEM 格式的 RS256 和 ES256 密钥，但您在本教程中只需要 RS256 密钥。私钥必须安全地存储在设备中，并用于对身份验证 JWT（[JSON 网络令牌][web-token-docs]）进行签名。公钥存储在设备注册表中。

## 创建设备并将其添加到注册表中

运行以下命令来创建一个设备并将其添加到注册表中：

```bash
gcloud iot devices create my-node-device \
    --project={{project-id}} \
    --region=us-central1 \
    --registry=my-registry \
    --public-key path=rsa_cert.pem,type=rs256
```

## 连接您的设备并查看遥测数据

在这一步，您会将消息从虚拟设备发送到 Pub/Sub。然后，您将提取并查看这些消息。

### 转到 MQTT 示例目录：

```bash
cd mqtt_example
```

### 安装 Node.js 依赖项：

```bash
npm install
```

### 运行以下命令，以使用 MQTT 网桥将虚拟设备连接到 Cloud IoT Core：

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

输出结果显示示例设备正在向遥测主题发布消息。目前已发布了 25 条消息。

## 创建对设备主题的订阅

运行以下命令来创建订阅，这样您就能查看设备发布的消息了：

```bash
gcloud pubsub subscriptions create \
    projects/{{project-id}}/subscriptions/my-subscription \
    --topic=my-topic
```

## 提取已发布的消息

使用以下命令提取设备发布的消息：

```bash
gcloud pubsub subscriptions pull --auto-ack \
    projects/{{project-id}}/subscriptions/my-subscription
```

运行此命令会返回设备发布的消息。这些消息包含以下数据：`my-registry/my-node-device-payload-&lt;INTEGER&gt;`、`MESSAGE_ID` 以及设备相关信息的 `ATTRIBUTES` 列表。`MESSAGE_ID` 是由服务器分配的唯一 ID。

注意：Cloud Pub/Sub 不保证消息的顺序。您也有可能在 Cloud Shell 中只看到一条消息。在这种情况下，请尝试多次运行上述命令，直到看到另一条消息时为止。

## 在 Google Cloud Platform Console 中查看资源

`gcloud` 命令行教程到此结束，但是，您也可以使用 GCP Console 查看您刚刚创建的资源。

打开控制台左侧的[菜单][spotlight-console-menu]。

然后选择 **IoT Core**。

<walkthrough-menu-navigation sectionid="IOT_SECTION"></walkthrough-menu-navigation>

您还可通过此界面创建和管理设备注册表和设备。

## 总结

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

恭喜！您刚刚通过使用 `gcloud` 命令行工具逐步了解了 Cloud IoT Core 的基本概念，并使用 GCP Console 查看了 Cloud IoT Core 资源。接下来就开始创建出色的应用吧！如需了解详情，请参阅 [IoT Core 文档](https://cloud.google.com/iot/docs/)。

### 以下是接下来可执行的操作

在 GitHub 上查看更多 Cloud IoT Core 示例：

  *  [C](https://github.com/GoogleCloudPlatform/cpp-docs-samples/tree/master/iot/mqtt-ciotc)
  *  [Java](https://github.com/GoogleCloudPlatform/java-docs-samples/tree/master/iot/api-client)
  *  [Node.js](https://github.com/GoogleCloudPlatform/nodejs-docs-samples/tree/master/iot)
  *  [Python](https://github.com/GoogleCloudPlatform/python-docs-samples/tree/master/iot/api-client)

[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[web-token-docs]: https://cloud.google.com/iot/docs/how-tos/credentials/jwts
