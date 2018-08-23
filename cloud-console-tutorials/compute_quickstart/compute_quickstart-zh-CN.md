# Compute Engine 快速入门

## 使用 MongoDB 构建待办事项应用

<walkthrough-tutorial-duration duration="15"></walkthrough-tutorial-duration>

在本快速入门中，您要使用 Compute Engine 创建一个双层应用。前端虚拟机运行 Node.js 待办事项网络应用，后端虚拟机运行 MongoDB。

本教程会分步指导您完成如下任务：

*   创建和配置两台虚拟机
*   设置防火墙规则
*   使用 SSH 在您的虚拟机上安装软件包

## 项目设置

Google Cloud Platform 按项目来组织资源。这可以让您在一个位置集中管理一个应用需要的所有相关资源。

<walkthrough-project-billing-setup permissions="compute.instances.create"></walkthrough-project-billing-setup>

## 导航到 Compute Engine

打开控制台左侧的[菜单][spotlight-console-menu]。

然后选择 **Compute Engine** 部分。

<walkthrough-menu-navigation sectionid="COMPUTE_SECTION"></walkthrough-menu-navigation>

## 创建实例

您要创建 2 个实例，分别作为应用的后端和前端服务器。

### 创建后端实例

首先，创建用来运行 MongoDB 的后端实例。此服务器用来存储待办事项。

点击[创建实例][spotlight-create-instance]按钮。

*   选择此实例的[名称][spotlight-instance-name]和[地区][spotlight-instance-zone]。

*   选择 [f1-micro][spotlight-machine-type]。这会产生较少量的费用。

    *   [详细了解价格][pricing]

*   选择 [Ubuntu 14.04 LTS][spotlight-boot-disk] 作为本教程的启动磁盘映像。

*   在[防火墙选择器][spotlight-firewall]中，选择**允许 HTTP 流量**。此时会打开端口 80 (HTTP) 以访问应用。

*   点击[创建][spotlight-submit-create]按钮创建实例。

注意：创建实例后，我们就会根据 GCE 价格开始向您的结算帐号收取费用。您应在稍后移除实例，避免产生额外的费用。

### 创建前端实例

在启动后端虚拟机后，我们来创建运行 Node.js 待办事项应用的前端实例。使用与后端实例相同的配置。

## 设置

您将在后端实例上安装 MongoDB 数据库以保存数据。

表中的 [SSH 按钮][spotlight-ssh-buttons]会在单独的窗口中打开一个 SSH 会话来连接到您的实例。

在本教程中，您要使用 Cloud Shell 建立连接。Cloud Shell 是控制台的内置命令行工具。

### 打开 Cloud Shell

点击控制台顶部导航栏中的<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[图标][spotlight-open-devshell]即可打开
Cloud Shell。

### 等待实例创建完成

您需要完成实例的创建，之后才能继续按本教程的说明操作。您可以点击顶部导航栏中的[通知菜单][spotlight-notification-menu]来跟踪活动。

## 连接到后端实例

### 连接到实例

输入以下命令，以通过 SSH 登录到虚拟机。如果这是您第一次通过 Cloud Shell 使用 SSH，则需要创建私钥。输入您创建的实例的名称和所在的地区。

```bash
gcloud compute --project "{{project-id}}" ssh --zone
<backend-zone> <backend-name>
```

### 安装后端数据库

在通过 SSH 连接到后端实例后，请使用以下命令安装后端数据库：

更新软件包并安装 MongoDB。当系统询问您是否要继续时，请输入 `Y`。

```bash
sudo apt-get update
```

```bash
sudo apt-get install mongodb
```

### 运行数据库

安装 MongoDB 服务后，系统就会启动该服务。您必须停止此服务，以便更改其运行方式。

```bash
sudo service mongodb stop
```

为 MongoDB 创建一个目录，然后使用端口 80 在后台运行 MongoDB 服务。

```bash
sudo mkdir $HOME/db
```

```bash
sudo mongod --dbpath $HOME/db --port 80 --fork --logpath /var/tmp/mongodb
```

随后，使用 `exit` 命令退出 SSH 会话：

```bash
exit
```

## 连接到前端实例

### 在前端虚拟机上安装并运行网页应用

此时，后端服务器已处于正常运行状态，可以安装前端网页应用了。

### 连接到实例

输入以下命令，以通过 SSH 登录到虚拟机。输入您所创建的实例的名称和所在的地区。

```bash
gcloud compute --project "{{project-id}}" ssh --zone <frontend-zone> <frontend-name>
```

### 安装依赖项

至此，您已经连接到前端实例，接下来请更新软件包并安装 git、Node.js 和 npm。系统询问您是否要继续时，请输入 `Y`。

```bash
sudo apt-get update
```

```bash
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
```

```bash
sudo apt-get install git nodejs
```

### 安装并运行前端网页应用

克隆示例应用并安装应用依赖项。

```bash
git clone https://github.com/GoogleCloudPlatform/todomvc-mongodb.git
```

```bash
cd todomvc-mongodb; npm install
```

```bash
sed -i -e 's/8080/80/g' server.js
```

使用以下命令启动待办事项网页应用，输入您创建的实例的[内部 IP 地址][spotlight-internal-ip]。

```bash
sudo nohup nodejs server.js --be_ip <backend-internal-ip> --fe_ip <frontend-internal-ip> &
```

随后使用 `exit` 命令退出 SSH 会话：

```bash
exit
```

### 访问应用

使用前端实例旁边的[外部 IP][spotlight-external-ip]列中列出的 IP 地址，访问网络服务器。

## 清理

若要移除实例，请选中实例名称旁边的[复选框][spotlight-instance-checkbox]，然后点击[“删除”按钮][spotlight-delete-button]。

## 总结

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

大功告成！

接下来，您可以执行以下操作：

*   [访问 GitHub](http://googlecloudplatform.github.io/)，查找 Google Cloud Platform
    示例。

*   了解如何设置[负载平衡](https://cloud.google.com/compute/docs/load-balancing/)。

*   了解如何[将文件传输到虚拟机](https://cloud.google.com/compute/docs/instances/transfer-files/)。

*   了解如何[运行容器](https://cloud.google.com/compute/docs/containers)。

[pricing]: https://cloud.google.com/compute/#compute-engine-pricing
[spotlight-boot-disk]: walkthrough://spotlight-pointer?cssSelector=vm-set-boot-disk
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-control-panel]: walkthrough://spotlight-pointer?cssSelector=#p6n-action-bar-container-main
[spotlight-create-instance]: walkthrough://spotlight-pointer?spotlightId=gce-zero-new-vm,gce-vm-list-new
[spotlight-delete-button]: walkthrough://spotlight-pointer?cssSelector=.p6n-icon-delete
[spotlight-external-ip]: walkthrough://spotlight-pointer?cssSelector=.p6n-external-link
[spotlight-firewall]: walkthrough://spotlight-pointer?spotlightId=gce-vm-add-firewall
[spotlight-instance-checkbox]: walkthrough://spotlight-pointer?cssSelector=.p6n-checkbox-form-label
[spotlight-instance-name]: walkthrough://spotlight-pointer?spotlightId=gce-vm-add-name
[spotlight-instance-zone]: walkthrough://spotlight-pointer?spotlightId=gce-vm-add-zone-select
[spotlight-internal-ip]: walkthrough://spotlight-pointer?cssSelector=gce-internal-ip
[spotlight-machine-type]: walkthrough://spotlight-pointer?spotlightId=gce-add-machine-type-select
[spotlight-notification-menu]: walkthrough://spotlight-pointer?cssSelector=.p6n-notification-dropdown,.cfc-icon-notifications
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-ssh-buttons]: walkthrough://spotlight-pointer?cssSelector=gce-connect-to-instance
[spotlight-submit-create]: walkthrough://spotlight-pointer?spotlightId=gce-submit
[spotlight-vm-list]: walkthrough://spotlight-pointer?cssSelector=vm2-instance-list%20.p6n-checkboxed-table
