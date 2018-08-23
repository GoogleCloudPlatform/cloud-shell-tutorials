# Compute Engine 快速入門導覽課程

## 使用 MongoDB 建構待辦事項應用程式

<walkthrough-tutorial-duration duration="15"></walkthrough-tutorial-duration>

本快速入門導覽課程將引導您利用 Compute Engine 建立具有 2 個層級的應用程式，包含用於執行 Node.js 待辦事項網路應用程式的前端
VM，以及用於執行 MongoDB 的後端 VM。

本教學課程將逐步說明下列事項：

*   建立並設定 2 個 VM
*   設定防火牆規則
*   使用 SSH 在 VM 上安裝套件

## 專案設定

Google Cloud Platform 會將資源彙整至專案中，方便您集中收納單一應用程式的所有相關資源。

<walkthrough-project-billing-setup permissions="compute.instances.create"></walkthrough-project-billing-setup>

## 前往 Compute Engine

開啟主控台左側的[選單](walkthrough://spotlight-pointer?spotlightId=console-nav-menu)。

選取 [Compute Engine] **區段**。

<walkthrough-menu-navigation sectionid="COMPUTE_SECTION"></walkthrough-menu-navigation>

## 建立執行個體

您將會建立 2 個執行個體，做為應用程式的後端伺服器與前端伺服器。

### 建立後端執行個體

首先，請建立執行 MongoDB 的後端執行個體 (這個伺服器用於儲存待辦項目)。

按一下
[[建立執行個體](walkthrough://spotlight-pointer?spotlightId=gce-zero-new-vm,gce-vm-list-new)]
按鈕。

*   選取這個執行個體的 [[名稱](walkthrough://spotlight-pointer?spotlightId=gce-vm-add-name)] 和
    [[區域](walkthrough://spotlight-pointer?spotlightId=gce-vm-add-zone-select)]。

*   選取
    [[f1-micro](walkthrough://spotlight-pointer?spotlightId=gce-add-machine-type-select)]
    可減少費用。

    *   [進一步瞭解費率][pricing]

*   選取
    [[Ubuntu 14.04 LTS](walkthrough://spotlight-pointer?cssSelector=vm-set-boot-disk)]
    做為本教學課程的開機磁碟映像檔。

*   選取[防火牆選取器](walkthrough://spotlight-pointer?spotlightId=gce-vm-add-firewall)中的 [**允許
    HTTP 流量**]，即會開啟通訊埠 80 (HTTP) 來存取應用程式。

*   按一下 [建立](walkthrough://spotlight-pointer?spotlightId=gce-submit) 按鈕來建立執行個體。

注意事項：執行個體建立完成後，系統就會根據 GCE 定價向您的帳單帳戶收費。您稍後可以移除執行個體，以免產生額外費用。

### 建立前端執行個體

後端 VM 處於啟用狀態時，建立用於執行 Node.js 待辦事項應用程式的前端執行個體 (設定與後端執行個體相同)。

## 設定

您會在後端執行個體上安裝 MongoDB 資料庫以儲存資料。

在資料表中按下 [[SSH](walkthrough://spotlight-pointer?cssSelector=gce-connect-to-instance)]
按鈕後，系統將在另一個視窗為您的執行個體開啟 SSH 工作階段。

在本教學課程中，您將會使用 Cloud Shell 進行連線 (Cloud Shell 是主控台專用的內建指令列工具)。

### 開啟 Cloud Shell

按一下主控台頂端導覽列中的 <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>
[圖示](walkthrough://spotlight-pointer?spotlightId=devshell-activate-button)來開啟 Cloud
Shell。

### 等待執行個體建立完成

您必須先完成執行個體建立作業，才能繼續教學課程。從頂端導覽列點選
[[通知選單](walkthrough://spotlight-pointer?cssSelector=.p6n-notification-dropdown,.cfc-icon-notifications)]
即可追蹤相關活動。

## 連線至後端執行個體

### 連線至執行個體

輸入下列指令來透過 SSH 登入 VM。如果這是您第一次透過 Cloud Shell 使用 SSH，則必須建立私密金鑰。請輸入您所建立的執行個體區域和名稱。

```bash
gcloud compute --project "{{project-id}}" ssh --zone <backend-zone> <backend-name>
```

### 安裝後端資料庫

您的後端執行個體已建立 SSH 連線，現在請使用以下指令安裝後端資料庫：

請更新套件並安裝 MongoDB。系統詢問您是否要繼續進行時，輸入「`Y`」：

```bash
sudo apt-get update
```

```bash
sudo apt-get install mongodb
```

### 執行資料庫

MongoDB 服務會在安裝完成後執行。您必須先停止該服務，才能變更其執行方式。

```bash
sudo service mongodb stop
```

為 MongoDB 建立目錄，然後在通訊埠 80 ，透過背景作業執行 MongoDB 服務。

```bash
sudo mkdir $HOME/db
```

```bash
sudo mongod --dbpath $HOME/db --port 80 --fork --logpath /var/tmp/mongodb
```

接著，使用 `exit` 指令結束 SSH 工作階段：

```bash
exit
```

## 連線至前端執行個體

### 在前端 VM 上安裝並執行網路應用程式

後端伺服器正在執行中，請安裝前端網路應用程式。

### 連線至執行個體

請輸入下列指令，透過 SSH 登入 VM，並輸入您建立的執行個體區域和名稱。

```bash
gcloud compute --project "{{project-id}}" ssh --zone <frontend-zone> <frontend-name>
```

### 安裝依附元件

您已連線至前端執行個體，現在請更新套件並安裝 git、Node.js 和 npm。系統詢問您是否要繼續進行時，請輸入「`Y`」：

```bash
sudo apt-get update
```

```bash
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
```

```bash
sudo apt-get install git nodejs
```

### 安裝並執行前端網路應用程式

複製範例應用程式並安裝應用程式的依附元件。

```bash
git clone https://github.com/GoogleCloudPlatform/todomvc-mongodb.git
```

```bash
cd todomvc-mongodb; npm install
```

```bash
sed -i -e 's/8080/80/g' server.js
```

使用以下指令，輸入您所建立的執行個體[內部 IP 位址](walkthrough://spotlight-pointer?cssSelector=gce-internal-ip)，以啟動待辦事項網路應用程式。

```bash
sudo nohup nodejs server.js --be_ip <backend-internal-ip> --fe_ip <frontend-internal-ip> &
```

接著，使用 `exit` 指令結束 SSH 工作階段：

```bash
exit
```

### 前往您的應用程式

請查看前端執行個體旁的[外部 IP](walkthrough://spotlight-pointer?cssSelector=.p6n-external-link)
欄，並透過所列的 IP 位址前往您的網路伺服器。

## 清除

如要刪除執行個體，請選取執行個體名稱旁的[核取方塊](walkthrough://spotlight-pointer?cssSelector=.p6n-checkbox-form-label)，並按一下
[[刪除](walkthrough://spotlight-pointer?cssSelector=.p6n-icon-delete)] 按鈕。

## 結論

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

這樣就設定完成了！

後續課程與相關資源：

*   尋找
    [GitHub 上的 Google Cloud Platform 範例](http://googlecloudplatform.github.io/)。

*   瞭解如何設定[負載平衡](https://cloud.google.com/compute/docs/load-balancing/)。

*   瞭解如何[將檔案移轉至虛擬機器](https://cloud.google.com/compute/docs/instances/transfer-files/)。

*   瞭解如何[執行容器](https://cloud.google.com/compute/docs/containers)。

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
