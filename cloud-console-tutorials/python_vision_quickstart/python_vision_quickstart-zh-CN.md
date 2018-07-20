# Cloud Vision API

<walkthrough-test-start-page url="/start?tutorial=python_vision_quickstart_v2"></walkthrough-test-start-page>

<walkthrough-tutorial-url url="https://cloud.google.com/vision/docs/label-tutorial"></walkthrough-tutorial-url>

<walkthrough-watcher-constant value="https://github.com/GoogleCloudPlatform/python-docs-samples.git" key="repo-url"></walkthrough-watcher-constant>

<walkthrough-watcher-constant value="python-docs-samples" key="repo-name"></walkthrough-watcher-constant>

<walkthrough-devshell-precreate></walkthrough-devshell-precreate>

## 简介

本教程将使用一个 `LABEL_DETECTION` 请求向您详细介绍一个基本的 Vision API 应用。`LABEL_DETECTION`
请求会根据图片内容使用相应的标签（或“标记”）自动对图片进行注释。例如，一张谷仓的图片可能会生成“谷仓”、“农场”标签或其他一些类似的注释。

以下是您将要完成的步骤：

*   **运行您的标签检测应用** 您将了解如何直接在浏览器中使用 Google Cloud Shell 运行应用。
*   **应用部署后…** 应用将会正式上线，您可以测试应用；或者，您可以将应用移除，重新开始构建新应用。

[“Python”和 Python 徽标是 Python Software Foundation
的商标或注册商标。](walkthrough://footnote)

# 项目设置

您需要通过项目启用 Cloud Vision API。

Google Cloud Platform 按项目来组织资源。这可以让您在一个地方集中管理一个应用需要的所有相关资源。

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## 启用 Vision API

您的项目必须启用 Vision API 才能接受请求。

### 转到 API Manager

API Manager 会设置为您的项目启用哪些 API。

打开在 Cloud Console 的左侧的
[menu](walkthrough://spotlight-pointer?spotlightId=console-nav-menu)。

然后，选择 **API 和服务**部分。

<walkthrough-menu-navigation sectionid="API_SECTION"></walkthrough-menu-navigation>

### 查看可用的 API

要启用 API，请点击[启用 API](walkthrough://spotlight-pointer?cssSelector=.p6n-action-bar-button)
按钮。

### 选择 Vision API

点击 [Vision API](walkthrough://spotlight-pointer?spotlightId=api-vision.googleapis.com) 链接。

### 启用 Vision API

要启用 Vision API，请点击[启用](walkthrough://spotlight-pointer?spotlightId=api-enable-vision.googleapis.com)按钮。在本教程的后面，您需要为项目创建凭据。

## 使用 Google Cloud Shell

Cloud Shell 是控制台的内置命令行工具。您将使用 Cloud Shell 来运行应用。

### 打开 Google Cloud Shell

点击控制台顶部导航栏中的<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>
[图标](walkthrough://spotlight-pointer?spotlightId=devshell-activate-button)，打开
Cloud Shell。

### 克隆示例代码

使用 Cloud Shell 克隆并转到“Hello World”代码。示例代码会从您的项目代码库克隆至 Cloud Shell。

注意：如果相应目录已经存在，请在克隆之前移除之前的文件：

```bash
rm -rf {{repo-name}}
```

克隆示例代码库：

```bash
git clone {{repo-url}}
```

然后，切换到教程目录：

```bash
cd {{repo-name}}/vision/cloud-client/quickstart
```

## 配置您的部署

您现已在包含示例代码的主目录中，这时需要了解一下用于配置您的应用的文件。

### 浏览应用

输入以下命令以查看您的应用代码：

```bash
cat quickstart.py
```

`quickstart.py` 文件用于指定请求信息的格式，例如请求类型和内容。展开下方的各个部分可了解详情。

向 Vision API 发出的请求是作为 JSON 对象提供的。如需全面了解此类请求的具体结构，请参阅 [Vision API
参考信息][vision-request-doc]。只有当您调用 `execute` 时，您的 JSON
请求才会被发送。您可以利用这种模式根据需要传递此类请求并调用 `execute`。

## 测试应用

您需要设置凭据才能使用该 API。要使用 Cloud
API，您需要为自己的应用设置合适的[凭据][auth-doc]。这样一来，您的应用就能向服务验证其身份并获取执行任务的授权。然后，您需要使用示例映像来测试该
API。

### 创建服务帐号

您需要创建服务帐号才能对您的 API 请求进行身份验证。如果您已经创建过服务帐号，系统会继续使用该帐号。

```bash
gcloud iam service-accounts create vision-quickstart
```

### 创建凭据

接下来，创建服务帐号密钥并将其设置为您的默认凭据。

```bash
gcloud iam service-accounts keys create key.json --iam-account    vision-quickstart@{{project-id}}.iam.gserviceaccount.com
```

```bash
export GOOGLE_APPLICATION_CREDENTIALS=key.json
```

<walkthrough-test-code-output text="created key"></walkthrough-test-code-output>

### 测试应用

要使用示例映像测试您的应用，请输入：

```bash
python quickstart.py
```

源代码中指定了映像资源 `resources/wakeupcat.jpg`。（[查看映像][cat-picture]）

## 总结

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

恭喜！您已准备好使用 Cloud Vision API 了。

接下来，您可以执行以下操作：

*   浏览[面部检测][face-tutorial]教程。
*   试用[文档文字][document-text-tutorial]教程。
*   查看[示例应用][vision-samples]。
*   下载 [Google Cloud SDK][get-cloud-sdk] 以在本地机器上运行。

[auth-doc]: https://cloud.google.com/vision/docs/auth
[cat-picture]: https://raw.githubusercontent.com/GoogleCloudPlatform/python-docs-samples/master/vision/cloud-client/quickstart/resources/wakeupcat.jpg
[document-text-tutorial]: https://cloud.google.com/vision/docs/fulltext-annotations
[face-tutorial]: https://cloud.google.com/vision/docs/face-tutorial
[get-cloud-sdk]: https://cloud.google.com/sdk/
[vision-request-doc]: https://cloud.google.com/vision/reference/rest
[vision-samples]: https://cloud.google.com/vision/docs/samples
