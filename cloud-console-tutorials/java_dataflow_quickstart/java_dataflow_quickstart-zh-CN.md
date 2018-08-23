# Dataflow 字数统计教程

<walkthrough-tutorial-url url="https://cloud.google.com/dataflow/docs/quickstarts/quickstart-java-maven"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="dataflow-intro" key="directory"></walkthrough-watcher-constant>
<walkthrough-watcher-constant value="dataflow-intro" key="job-name"></walkthrough-watcher-constant>

## 简介

本教程通过运行一个使用 Java 的简单示例管道，介绍 Cloud Dataflow 服务的基本知识。

Dataflow 管道分为批处理管道和流处理管道。批处理管道**处理文件或数据库表等有界输入，流处理管道**处理来自 Cloud Pub/Sub 等来源的无界输入。本教程中的示例是批处理管道，它统计莎士比亚作品集的字数。

在开始之前，您将需要检查 Cloud Platform 项目中的先决条件并执行初始设置。

## 项目设置

Google Cloud Platform 按项目来组织资源。这可以让您在一个地方集中管理一个应用需要的所有相关资源。

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>
<walkthrough-project-permissions permissions="dataflow.jobs.create"></walkthrough-project-permissions>

## 设置 Cloud Dataflow

要使用 Dataflow，请启用 Cloud Dataflow API 并打开 Cloud Shell。

### 启用 Google Cloud API

<walkthrough-enable-apis apis="compute.googleapis.com,dataflow,cloudresourcemanager.googleapis.com,logging,storage_component,storage_api,bigquery,pubsub">
</walkthrough-enable-apis>

### 打开 Cloud Shell

Cloud Shell 是控制台的内置命令行工具。您将使用 Cloud Shell 来部署应用。

点击控制台顶部导航栏中的<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[图标][spotlight-open-devshell]即可打开 Cloud Shell。

## 在 Cloud Shell 上安装 Cloud Dataflow 示例

要使用 Java 版 Cloud Dataflow SDK，您的开发环境需要具备 Java、Google Cloud SDK、Java 版 Cloud Dataflow SDK 以及用于管理 SDK 依赖项的 Apache Maven。
本教程所使用的 Cloud Shell 已安装了 Java、Google Cloud SDK 和 Maven。

或者，您也可以在[本地机器][dataflow-java-tutorial]上执行此教程。

### 使用 Maven 命令下载示例和 Java 版 Cloud Dataflow SDK

在您运行此命令后，Maven 会创建项目结构和配置文件，以便下载相应版本的 Cloud Dataflow SDK。

```bash
mvn archetype:generate \
    -DarchetypeArtifactId=google-cloud-dataflow-java-archetypes-examples \
    -DarchetypeGroupId=com.google.cloud.dataflow \
    -DarchetypeVersion=2.1.0 \
    -DgroupId=com.example \
    -DartifactId={{directory}} \
    -Dversion="0.1" \
    -DinteractiveMode=false \
    -Dpackage=com.example
```

  *  `archetypeArtifactId` 和 `archetypeGroupId` 用于定义示例项目结构。
  *  `groupId` 是您的组织的 Java 程序包名称前缀，例如 `com.mycompany`。
  *  `artifactId` 用于设置所创建的 Jar 文件的名称。在本教程中，我们使用默认值 (`{{directory}}`)。

在 Cloud Shell 中执行 Maven 命令。

### 更改目录

将工作目录更改为 `{{directory}}`。

```bash
cd {{directory}}
```

如果需要，可在 `{{directory}}` 目录的 `src` 子目录中查看该示例的代码。

## 设置 Cloud Storage 存储分区

Cloud Dataflow 使用 Cloud Storage 存储分区来存储输出数据并缓存管道代码。

### 运行 gsutil mb

在 Cloud Shell 中，使用命令 `gsutil mb` 创建 Cloud Storage 存储分区。

```bash
gsutil mb gs://{{project-id-no-domain}}
```

如需详细了解 `gsutil` 工具，请参阅该[文档][gsutil-docs]。

## 创建并启动管道

在 Cloud Dataflow 中，数据处理工作用管道**表示。管道读取输入数据，对该数据执行转换，然后生成输出数据。管道的转换可能包括将数据过滤、分组、比较或合并。

如果需要，可在 `{{directory}}` 目录的 `src` 子目录中查看该示例的代码。

### 在 Dataflow 服务上启动您的管道

使用 Apache Maven 的 `mvn exec` 命令在该服务上启动您的管道。
正在运行的管道称为“作业”**。

```bash
mvn compile exec:java \
  -Dexec.mainClass=com.example.WordCount \
  -Dexec.args="--project={{project-id}} \
  --stagingLocation=gs://{{project-id-no-domain}}/staging/ \
  --output=gs://{{project-id-no-domain}}/output \
  --runner=DataflowRunner \
  --jobName={{job-name}}"
```

  *  `stagingLocation` 是一个存储分区，Cloud Dataflow 将使用它来存储用于运行管道的二进制文件和其他数据。该位置可以在多个作业中共享。
  *  `output` 是 WordCount 示例用于存储作业结果的存储分区。

### 您的作业正在运行

恭喜！您的二进制文件现已暂存到您在前面创建的存储分区。系统正在创建 Compute Engine 实例。Cloud Dataflow 将拆分您的输入文件，以便能够使用多个机器并行处理您的数据。

注意：当您看到“作业已完成”消息后即可关闭 Cloud Shell。

如果要清理生成的 Maven 项目，请在 Cloud Shell 中运行 `cd .. && rm -R
{{directory}}` 来删除该目录。

## 监控作业

在 Cloud Dataflow 监控界面页面上查看您的管道的进度。

### 转到 Cloud Dataflow 页面

打开控制台左侧的[菜单][spotlight-console-menu]。

然后选择 **Dataflow** 部分。

<walkthrough-menu-navigation sectionid="DATAFLOW_SECTION"></walkthrough-menu-navigation>

### 选择作业

点击作业可查看其详情。

### 浏览管道详情和指标

浏览左侧的管道和右侧的作业信息。要查看详细的作业状态，请点击[日志][spotlight-job-logs]。尝试点击管道中的步骤查看其指标。

作业完成后，您将看到作业状态发生改变，并且该作业所使用的 Compute Engine 实例将自动停止。

## 查看输出

作业开始运行后，您可以在 Cloud Storage 中查看输出文件。

### 转到 Cloud Storage 页面

打开控制台左侧的[菜单][spotlight-console-menu]。

然后选择**存储**部分。

<walkthrough-menu-navigation sectionid="STORAGE_SECTION"></walkthrough-menu-navigation>

### 转到存储分区

在存储分区列表中，选择您在前面创建的存储分区。如果您使用建议的名称，它将被命名为 `{{project-id}}`。

该存储分区包含暂存文件夹和输出文件夹。Dataflow 会将输出分片保存，因此存储分区会包含多个输出文件。

## 清理

为了避免我们向您收取 Cloud Storage 使用费，请删除您已创建的存储分区。

### 返回至存储分区浏览器

点击[存储分区][spotlight-buckets-link]链接。

### 选择存储分区

勾选您创建的存储分区旁边的复选框。

### 删除存储分区

点击[删除][spotlight-delete-bucket]并确认删除操作。

## 总结

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

接下来，您可以执行以下操作：

  *  [详细了解字数统计示例][wordcount]
  *  [了解 Cloud Dataflow 编程模型][df-model]
  *  [在 GitHub 上浏览 Cloud Dataflow SDK][df-sdk]

设置本地环境：

  *  [使用 Eclipse 运行 Dataflow][df-eclipse]
  *  [使用 Python 运行 Dataflow][df-python]

[dataflow-java-tutorial]: https://cloud.google.com/dataflow/docs/quickstarts/quickstart-java-maven
[df-eclipse]: https://cloud.google.com/dataflow/docs/quickstarts/quickstart-java-eclipse
[df-model]: https://cloud.google.com/dataflow/model/programming-model-beam
[df-python]: https://cloud.google.com/dataflow/docs/quickstarts/quickstart-python
[df-sdk]: https://github.com/apache/beam/tree/master/sdks/java
[gsutil-docs]: https://cloud.google.com/storage/docs/gsutil
[spotlight-buckets-link]: walkthrough://spotlight-pointer?cssSelector=.p6n-cloudstorage-path-link
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-delete-bucket]: walkthrough://spotlight-pointer?cssSelector=#p6n-cloudstorage-delete-buckets
[spotlight-job-logs]: walkthrough://spotlight-pointer?cssSelector=#p6n-dax-job-logs-toggle
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[wordcount]: https://beam.apache.org/get-started/wordcount-example/
