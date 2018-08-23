# Cloud Storage 快速入门

## 欢迎使用 Google Cloud Storage！

<walkthrough-tutorial-url url="https://cloud.google.com/storage/docs/quickstart-console"></walkthrough-tutorial-url>

Google Cloud Storage 是适用于非结构化对象的一种功能强大且经济有效的存储解决方案，非常适合托管实时网页内容、存储用于分析的数据、归档和备份等各种服务。

在本教程中，我们将向您展示如何轻松地开始在 Cloud Storage 中存储对象。您将执行以下操作：

  *  **创建存储分区**

     存储分区用于保存您要在 Cloud Storage 中存储的对象（任何类型的文件）。

  *  **上传和共享对象**

     要开始使用您的存储分区，只需上传对象并开放其访问权限即可。

  *  **清理**

     在最后一步中，您将删除之前为本教程创建的存储分区和对象。

由于您最终会删除自己的存储分区和对象，因此不必担心因试用本教程而需要付费。

## 项目设置

Cloud Storage 需要通过项目来创建资源。

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## 创建存储分区

在 Cloud Storage 中，您将对象存储在存储分区中。要创建存储分区，您需要转到 Cloud Storage 浏览器。

打开控制台左侧的[菜单][spotlight-menu]。

然后，选择**存储**部分。

<walkthrough-menu-navigation sectionid="STORAGE_SECTION"></walkthrough-menu-navigation>

## 创建存储分区

在开始上传对象之前，您需要创建一个“存储分区”来存储它们。存储分区可帮助您整理对象并控制对这些对象的访问。

  1. 点击[创建存储分区](walkthrough://spotlight-pointer?cssSelector=#p6ntest-cloudstorage-create-first-bucket-button,)。

  1. 在创建存储分区的页面上，指定存储分区的属性。以下是需要注意的事项：

     *  **名称：**使用独特的名称。如果您输入的名称与 Cloud Storage 中另一个存储分区的名称相同，将会出现错误。
     *  **默认存储类别：**这是默认分配给存储分区对象的存储类别。您的选择主要取决于对象的预期访问频率，以及您是否在全球范围内提供数据。存储类别会影响您的费用。
     *  **位置：**您需要让自己的数据靠近访问这些数据的应用和用户。可用的选项取决于您所选择的存储类别。

在此次试用中，您可以采用任何存储类别和位置，因为最后您将删除存储分区。

  1. 点击[创建][spotlight-create-button]

## 上传对象

创建存储分区之后，您就可以开始上传对象了。

  1. 点击页面顶部的[上传文件][spotlight-upload-file]。

  1. 选择要上传的文件。您可以上传任何类型的文件。

     没有文件？[创建一个示例文件][create-sample-file]，然后点击页面顶部的[刷新存储分区][spotlight-refresh-bucket]，以便能在您的存储分区中看到该文件。（提示：您也可以通过将对象拖放到存储分区名称下方的空间来上传对象。）

## 删除存储分区

现在让我们删除刚刚创建的存储分区。删除存储分区也会删除其内容。

  1. 在表格的顶部，点击[存储分区][spotlight-buckets-link]以返回到存储分区列表。

  1. 选中您的存储分区旁边的复选框。如果此项目中有其他存储分区，并且您在查找自己的存储分区时需要帮助，可使用搜索栏来过滤存储分区列表。

  1. 在页面顶部，点击[删除][spotlight-delete-buckets]并确认删除操作。

## 总结

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

恭喜！

现在您已经知道如何开始在 Cloud Storage 中存储对象，欢迎您继续了解如何[托管静态网站](https://cloud.google.com/storage/docs/hosting-static-website)，以便将所学知识付诸实践。

或者学习如何借助 [gsutil 命令行工具](https://cloud.google.com/storage/docs/quickstart-gsutil)使用 Cloud Storage。

了解如何开始[免费](https://cloud.google.com/free)使用 Cloud Storage 和其他 GCP 服务 。

[create-sample-file]: walkthrough://create-sample-storage-file
[spotlight-buckets-link]: walkthrough://spotlight-pointer?cssSelector=.p6n-cloudstorage-path-link
[spotlight-create-bucket]: walkthrough://spotlight-pointer?cssSelector=#p6ntest-cloudstorage-create-first-bucket-button,#p6n-cloudstorage-create-bucket
[spotlight-create-button]: walkthrough://spotlight-pointer?cssSelector=#p6ntest-gcs-create-bucket-button
[spotlight-delete-buckets]: walkthrough://spotlight-pointer?spotlightId=gcs-action-bar-delete-bucket
[spotlight-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-public-link]: walkthrough://spotlight-pointer?cssSelector=.p6n-cloudstorage-browser-public-label
[spotlight-refresh-bucket]: walkthrough://spotlight-pointer?spotlightId=gcs-action-bar-refresh-objects
[spotlight-share-public]: walkthrough://spotlight-pointer?cssSelector=.p6n-cloudstorage-browser-public-checkbox
[spotlight-upload-file]: walkthrough://spotlight-pointer?spotlightId=gcs-action-bar-upload-file
