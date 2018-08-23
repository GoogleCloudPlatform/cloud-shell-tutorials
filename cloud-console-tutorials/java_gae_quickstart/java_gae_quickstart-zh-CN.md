# App Engine 快速入门

<walkthrough-test-start-page url="/getting-started?tutorial=java_gae_quickstart_2"/>

<walkthrough-tutorial-url url="https://cloud.google.com/appengine/docs/java/quickstart"/>

<walkthrough-watcher-constant key="repo-url" value="https://github.com/GoogleCloudPlatform/appengine-try-java" />

<walkthrough-watcher-constant key="repo-name" value="appengine-try-java"/>

## 简介

本教程为您介绍如何使用 App Engine Maven 插件将一个示例 [Java][java] 应用部署至 Google App Engine。

以下是您需要执行的步骤。

*   **编译并运行您的"Hello, world!"应用**

    您将学习如何直接在浏览器中使用 Google Cloud Shell 运行您的应用。 最后，您将使用 App Engine Maven
    插件将您的应用部署至到网络上。

*   **部署应用之后…**

    您部署应用之后，该应用就可供使用了。您可以对其进行实验，或者将其移除以从头开始。

[Java is a registered trademark of Oracle and/or its affiliates.](walkthrough://footnote)

<walkthrough-devshell-precreate/>

## 项目设置

要部署应用，您需要先创建一个项目。

Google Cloud Platform 以使用项目的形式来整理资源， 这样，便于您可以将单同一个应用的所有相关资源收集集中到一起。

<walkthrough-project-setup/>

## 使用 Google Cloud Shell

Cloud Shell 是 Cloud Console 的内置命令行工具。 我们将使用 Cloud Shell 来部署应用。

### 打开 Google Cloud Shell

在 Cloud Console 顶部的导航栏中，点击 <walkthrough-cloud-shell-icon/>
[icon](walkthrough://spotlight-pointer?spotlightId=devshell-activate-button)，打开
Cloud Shell。

### 克隆示例代码

使用 Cloud Shell 导航至克隆"Hello World"代码并转到代码目录。 将该示例代码从项目代码库克隆到 Cloud Shell 中。

注意： 如果该目录已存在，请移除当前存在的文件，然后再进行克隆：

```bash
rm -rf {{repo-name}}
```

在 Cloud Shell 中输入：

```bash
git clone {{repo-url}}
```

然后，切换至教程目录：

```bash
cd {{repo-name}}
```

## 配置您的部署

您现在位于示例代码的主目录中。 我们来看一下应用的配置文件。

### 浏览应用

输入以下命令以查看您的应用代码：

```bash
cat src/main/java/myapp/DemoServlet.java
```

此 Servlet 在回应任何请求时，都会在发送的回应中包含消息 `Hello, world!`。

### 浏览您的配置

对于 Java，Google App Engine 使用 XML 文件来指定部署的配置。

输入以下命令来查看您的配置文件：

```bash
cat pom.xml
```

此 `Helloworld` 应用使用 Maven，这意味着您必须指定一个项目对象模型 (POM)，该 POM 应包含项目相关信息以及 Maven
在编译项目时所用的配置详情。

## 测试您的应用

### 在 Cloud Shell 中测试您的应用

Cloud Shell 允许用户在部署应用前先对其进行测试，以确保应用能够按照预期运行，就像在您的本地机器上进行调试一样。

要测试应用，请输入：

```bash
mvn appengine:run
```

<walkthrough-test-code-output
  text="module .* running at|Dev App Server is now running" />

### 使用"网络预览"预览您的应用

您的应用现已在 Cloud Shell 上运行。 您可以使用"网络预览"<walkthrough-web-preview-icon/>连接至端口
8080，以访问该应用。
[演示](walkthrough://spotlight-pointer?spotlightId=devshell-web-preview-button)

### 终止预览实例

在 Cloud Shell 中按下 `Ctrl+C` 终止应用的实例。

## 部署至 Google App Engine

### 创建一个应用

要部署应用，我们需要在一个区域中创建应用：

```bash
gcloud app create
```

注意： 如果您已经创建了一个应用，则可以跳过此步骤。

### 使用 Cloud Shell 进行部署

现在，您可以使用 Cloud Shell 来部署您的应用。

首先，设置要使用哪个项目：

```bash
gcloud config set project {{project-id}}
```

然后部署您的应用：

```bash
mvn appengine:deploy
```

<walkthrough-test-code-output text="Deployed (module|service)" />

### 访问您的应用

您的应用已成功部署！ 该应用的默认网址是
[{{project-gae-url}}](http://{{project-gae-url}})，点击此网址即可访问。

### 查看应用的状态

您可以在 App Engine 信息中心监控应用状态，以检查您的应用的运行状况。 打开在 Cloud Console 的左侧的
[menu](walkthrough://spotlight-pointer?spotlightId=console-nav-menu)。

然后，选择 **App Engine** 部分。

<walkthrough-menu-navigation sectionId="APPENGINE_SECTION"/>

## 结束

<walkthrough-conclusion-trophy/>

恭喜！ 您已成功部署了一个 App Engine 应用！ 接下来，您可以执行这些步骤：

**下载 Google Cloud SDK 并在本地进行开发**

[Google Cloud SDK][cloud-sdk-installer]

**构建您的下一个应用** 了解如何将 App Engine 与其他 Google Cloud Platform 产品配合使用：

<walkthrough-tutorial-card
  url="appengine/docs/java/datastore/"
  icon="DATASTORE_SECTION"
  label="datastore">
**了解如何使用 Cloud Datastore**
Cloud Datastore 是一个适用于您应用的高度可扩展的 NoSQL 数据库。
</walkthrough-tutorial-card>

<walkthrough-tutorial-card
  url="appengine/docs/java/googlecloudstorageclient/setting-up-cloud-storage/"
  icon="STORAGE_SECTION"
  label="cloudStorage">
**了解如何使用 Cloud Storage**
Cloud Storage 是一项功能强大、简单易用的对象存储服务。
</walkthrough-tutorial-card>

[java]: https://java.com/
[cloud-sdk-installer]: https://cloud.google.com/sdk/downloads#interactive
