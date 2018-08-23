# 有关 Cloud Pub/Sub 的简介

<walkthrough-tutorial-url url="https://cloud.google.com/pubsub/quickstart-console"></walkthrough-tutorial-url></walkthrough-test-start-page>

<walkthrough-devshell-precreate></walkthrough-devshell-precreate>

## 简介

Cloud Pub/Sub 是一项完全托管的实时消息传递服务，可让您在独立应用之间发送和接收消息。本教程通过讲解 `gcloud` 命令简要介绍了 Cloud Pub/Sub 命令行界面。

## 项目设置

Google Cloud Platform 以项目的形式来组织资源。这可以让您在一个地方集中管理一个应用需要的所有相关资源。

Cloud Pub/Sub 需要通过项目来设置消息。

<walkthrough-project-setup></walkthrough-project-setup>

## 创建您的第一个主题

### 打开 Google Cloud Shell

Cloud Shell 是控制台的内置命令行工具。您将使用 Cloud Shell 来设置 Cloud Pub/Sub。

点击控制台顶部导航栏中的<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[图标][spotlight-open-devshell]，打开 Cloud Shell。

### 创建主题

主题是您将向其发送消息的命名资源。使用以下命令创建您的第一个主题：

```bash
gcloud pubsub topics create my-topic
```

## 添加订阅

要接收消息，您需要创建订阅。订阅需要有相应的主题。使用以下命令创建您的第一个订阅：

```bash
gcloud pubsub subscriptions \
    create my-sub --topic my-topic \
    --ack-deadline=60
```

该命令创建一个名为 `my-sub` 并附加到主题 `my-topic` 的订阅。所有发布到 `my-topic` 的消息都将传递到此订阅。

您可能会注意到 `--ack-deadline=60` 选项。`ack-deadline` 代表 `Acknowledgement deadline`。此新订阅有 60 秒的 `Acknowledgement deadline`。我们稍后会解释这一点。

## 列出主题和订阅

在发送第一条消息前，请检查是否已成功创建主题和订阅。使用以下命令列出您的主题和订阅：

```bash
gcloud pubsub topics list
```

```bash
gcloud pubsub subscriptions list
```

## 将消息发布到主题

使用以下命令发送两条消息：

```bash
gcloud pubsub topics publish my-topic --message hello
```

```bash
gcloud pubsub topics publish my-topic --message goodbye
```

以上每个命令都会发送一条消息。第一条消息是 `hello`，第二条消息是 `goodbye`。如果成功发布消息，您应该会看到从服务器返回的消息 ID。这是由服务器自动分配给每条消息的唯一 ID。

## 从订阅中拉取消息

### 拉取消息

现在，使用以下命令拉取消息：

```bash
gcloud pubsub subscriptions \
    pull --auto-ack --limit=2 my-sub
```

您可能已经看到自己刚刚发布的两条消息。这些消息包含数据 `hello` 和 `goodbye` 以及 `MESSAGE_ID`。`MESSAGE_ID` 是服务器所分配消息的唯一 ID。

注意：Cloud Pub/Sub 不保证消息的顺序。您也可能只看到一条消息。在这种情况下，请尝试多次运行同一命令，直到看到另一条消息时为止。

### 确认和确认时限

在您拉取消息并正确处理消息后，必须通知 Cloud Pub/Sub 您已成功收到消息。该操作称为**确认**。

您可能已经注意到随 `pull` 命令一起传递的 `--auto-ack` 标记。
`--auto-ack` 标记用于自动拉取消息并进行确认。

## 手动确认

### 发送新消息

使用以下命令发送新消息：

```bash
gcloud pubsub \
    topics publish my-topic --message thanks
```

### 再次拉取消息

使用以下命令拉取消息：

```bash
gcloud pubsub subscriptions \
    pull my-sub
```

此时应该会显示 `thanks` 消息以及 `MESSAGE_ID` 和 `ACK_ID`。
`ACK_ID` 是可用于确认消息的另一个 ID。

### 确认消息

在您拉取消息后，需要在**确认时限**内确认消息。例如，如果一项订阅的**确认时限**配置为 60 秒 （就像我们在本教程中所配置的那样），您需要在拉取消息后的 60 秒内确认消息。否则，Cloud Pub/Sub 将重新发送该消息。

使用以下命令确认消息（通过复制/粘贴将 `ACK_ID` 替换为实际 ID）：

```bash
gcloud pubsub subscriptions ack \
    my-sub --ack-ids ACK_ID
```

## 在 Pub/Sub 界面中查看主题和订阅

`gcloud` 命令行教程至此结束，但在结束教程之前，我们在 Google Cloud Console 中看一下该界面。

您还可以在 Pub/Sub 部分查看主题和订阅。

### 导航到 Pub/Sub 部分

打开控制台左侧的[菜单][spotlight-console-menu]。

然后，选择 **Pub/Sub** 部分。

<walkthrough-menu-navigation sectionid="CLOUDPUBSUB_SECTION"></walkthrough-menu-navigation>

您还可通过此界面创建和管理主题与订阅。

### 删除主题

选中您创建的主题旁边的复选框，然后单击[“删除”按钮][spotlight-delete-button]永久删除该主题。

## 总结

恭喜！

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

您刚刚通过使用 `gcloud` 命令行工具了解了 Cloud Pub/Sub 的基本概念，并且看到了 Cloud Pub/Sub 界面。接下来就开始创建精彩应用吧！有关详情，请参阅 [Pub/Sub 文档][pubsub-docs]。

接下来，您可以执行以下操作：

[查看代码
示例](https://cloud.google.com/pubsub/docs/quickstart-client-libraries)

[pubsub-docs]: https://cloud.google.com/pubsub/docs/
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-delete-button]: walkthrough://spotlight-pointer?cssSelector=.p6n-icon-delete
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
