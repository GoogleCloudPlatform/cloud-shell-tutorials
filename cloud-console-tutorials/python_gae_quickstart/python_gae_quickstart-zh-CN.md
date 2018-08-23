# App Engine 快速入门

<walkthrough-tutorial-url url="https://cloud.google.com/appengine/docs/python/quickstart"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="https://github.com/GoogleCloudPlatform/python-docs-samples" key="repo-url"></walkthrough-watcher-constant>
<walkthrough-watcher-constant value="python-docs-samples/appengine/standard/hello_world" key="repo-dir"></walkthrough-watcher-constant>

## 简介

本教程将向您介绍如何使用 `gcloud` 命令将示例 [Python](https://python.org/) 应用部署到 Google App Engine。

以下是您需要执行的操作。

  *  **创建项目**

     项目用于将代码、VM 和其他资源整合在一起，方便开发和监控。

  *  **构建并运行您的“Hello, world!”应用**

     您将学习如何直接在浏览器中使用 Google Cloud Shell 来运行应用。最后，您将使用 `gcloud` 命令将您的应用部署到网络中。

  *  **本教程结束后…**

     部署完成后，应用将会正式上线，您可以进行试用；或者，您可以将应用移除，重新开始构建新应用。

[“Python”和 Python 徽标是 Python Software Foundation 的商标或注册商标。](walkthrough://footnote)

## 项目设置

要部署应用，您需要先创建一个项目。

Google Cloud Platform 以项目的形式来组织资源。这可以让您在一个地方集中管理一个应用需要的所有相关资源。

<walkthrough-devshell-precreate></walkthrough-devshell-precreate>

<walkthrough-project-setup></walkthrough-project-setup>

## 使用 Google Cloud Shell

Cloud Shell 是控制台的内置命令行工具。我们将使用 Cloud Shell 来部署应用。

### 打开 Google Cloud Shell

点击控制台顶部导航栏中的<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[图标][spotlight-open-devshell]，打开 Cloud Shell。

### 克隆示例代码

使用 Cloud Shell 克隆并转到“Hello World”代码。示例代码会从您的项目代码库克隆至 Cloud Shell。

注意：如果相应目录已经存在，请在克隆之前移除之前的文件。

在 Cloud Shell 中输入：

```bash
git clone {{repo-url}}
```

然后，切换到教程目录：

```bash
cd {{repo-dir}}
```

## 配置您的部署

您现已在包含示例代码的主目录中，让我们了解一下用于配置应用的文件。

### 浏览应用

输入以下命令以查看您的应用代码：

```bash
cat main.py
```

该应用是一个简单的 Python 应用，使用了 [webapp2](https://webapp2.readthedocs.io/) Web 框架。此 Python 脚本对请求作出响应并提供 HTTP 标头和消息 `Hello, World!`。

### 浏览您的配置

Google App Engine 使用 YAML 文件来指定部署的配置。
`app.yaml` 文件包含有关您的应用的信息，例如运行时环境和网址处理程序等等。

输入以下命令以查看您的配置文件：

```bash
cat app.yaml
```

该配置文件自上而下详细描述了有关此应用的以下信息：

  *  此代码在 `python` 运行时环境中运行。
  *  该应用为 `threadsafe`，因此同一实例可同时处理多个请求。Threadsafe 是一项高级功能，如果您的应用不是专门设计为 threadsafe 的话，那么可能会出现异常行为。
  *  所有针对路径与正则表达式 `/.*` 匹配的网址（即所有网址）发出的请求都应由 `main` Python 模块中的应用对象处理。

该文件采用 [YAML](http://www.yaml.org) 语法。有关配置选项的完整列表，请参见 [`app.yaml`][app-yaml-reference] 参考。

## 测试应用

### 在 Cloud Shell 上测试应用

利用 Cloud Shell，您可以在部署之前先对应用进行测试，确保其能按预期正常运行，就像在本地机器上进行调试一样。

要测试应用，请输入：

```bash
dev_appserver.py $PWD
```

### 使用“网络预览”来预览您的应用

您的应用现在正在 Cloud Shell 上运行。您可以使用[网络预览][spotlight-web-preview]<walkthrough-web-preview-icon></walkthrough-web-preview-icon>连接到端口 8080，以访问该应用。

### 终止预览实例

在 Cloud Shell 中按 `Ctrl+C` 终止应用的实例。

## 部署到 Google App Engine

### 创建应用

为了部署应用，您需要在某个地区创建一个应用：

```bash
gcloud app create
```

注意：如果您已经创建应用，则可以跳过此步骤。

### 使用 Cloud Shell 进行部署

您可以使用 Cloud Shell 来部署应用。要部署应用，请输入：

```bash
gcloud app deploy app.yaml --project {{project-id}}
```

### 访问应用

恭喜！您的应用已部署。您的应用的默认网址为 [{{project-gae-url}}](http://{{project-gae-url}})。点击网址进行访问。

### 查看应用状态

您可以在 App Engine 信息中心监控应用的状态，对应用进行检查。

打开控制台左侧的[菜单][spotlight-console-menu]。

然后，选择 **App Engine** 部分。

<walkthrough-menu-navigation sectionid="APPENGINE_SECTION"></walkthrough-menu-navigation>

## 总结

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

您成功部署了一个 App Engine 应用！

下面是一些后续步骤：

**下载 Google Cloud SDK 并在本地进行开发**

在本地机器上安装 [Google Cloud SDK][cloud-sdk-installer]。

**构建您的下一个应用**

了解如何将 App Engine 与其他 Google Cloud Platform 产品结合使用：

<walkthrough-tutorial-card label="django" url="python/django/appengine" icon="APPENGINE_SECTION">
  **运行 Django**
  开发在 App Engine 上运行的 Django 应用。
</walkthrough-tutorial-card>

<walkthrough-tutorial-card label="datastore" url="appengine/docs/python/datastore/" icon="DATASTORE_SECTION">
  **了解如何使用 Cloud Datastore**
  Cloud Datastore 是一个可大规模扩展的 NoSQL 数据库，可在您的应用中使用。
</walkthrough-tutorial-card>

[app-yaml-reference]: https://cloud.google.com/appengine/docs/standard/python/config/appref
[cloud-sdk-installer]: https://cloud.google.com/sdk/downloads#interactive
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-web-preview]: walkthrough://spotlight-pointer?spotlightId=devshell-web-preview-button
