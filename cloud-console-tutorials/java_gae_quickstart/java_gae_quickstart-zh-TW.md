# App Engine 快速入門

<walkthrough-test-start-page url="/getting-started?tutorial=java_gae_quickstart_2"/>

<walkthrough-tutorial-url url="https://cloud.google.com/appengine/docs/java/quickstart"/>

<walkthrough-watcher-constant key="repo-url" value="https://github.com/GoogleCloudPlatform/appengine-try-java" />

<walkthrough-watcher-constant key="repo-name" value="appengine-try-java"/>

## 前言

本教學課程 說 明如何使用 App Engine Maven 外掛程式,將範例 [Java][java] 應用程式部署到 Google App Engine 。
以下是需要進行的步驟。

*   ** 建置及執行「 Hello, world! 」應用程式 **

    我們會先 說 明如何直接在瀏覽器中透過 Google Cloud Shell 執行應用程式,然後介紹使用 App Engine Maven
    外掛程式將應用程式部署到網路上的方式。

*   ** 教學課程結束後 ...**

    您可以在部署完成後實際測試應用程式;如果不符需求,也可以將其移除,再從頭開始。

[Java is a registered trademark of Oracle and/or its affiliates.](walkthrough://footnote)

<walkthrough-devshell-precreate/>

## 專案設定

如要部署應用程式,請先建立專案。

Google Cloud Platform 會將各項資源整理到專案中,方便您能將單一應用程式的所有相關資源收集在同一處。

<walkthrough-project-setup/>

## 使用 Google Cloud Shell

Cloud Shell 是主控台專用的 內 建指令列工具 。我們將使用 Cloud Shell 來部署應用程式。

### 開啟 Google Cloud Shell

按一下主控台頂端導覽列的 <walkthrough-cloud-shell-icon/>
[icon](walkthrough://spotlight-pointer?spotlightId=devshell-activate-button)
即可開啟 Cloud Shell 。

### 複製程式碼範例

使用 Cloud Shell 複製並瀏覽至「 Hello World 」程式碼。系統會將您專案存放區中的程式碼範例複製到 Cloud Shell 。

附註:如果這個目錄已經存在,請在複製前移除先前的檔案:

```bash
rm -rf {{repo-name}}
```

請在 Cloud Shell 中輸入:

```bash
git clone {{repo-url}}
```

然後,切換至教學課程目錄:

```bash
cd {{repo-name}}
```

## 設定您的部署作業

您目前位在程式碼範例的主要目錄中。接下來,我們將帶您瞭解與應用程式設定相關的檔案。

### 探索應用程式

輸入下列指令即可 查 看您應用程式的程式碼 :

```bash
cat src/main/java/myapp/DemoServlet.java
```

這個 Servlet 在回應任何要求時,會傳送含有 `Hello, world!` 訊息的回應。

### 探索您的設定

針對 Java 應用程式, Google App Engine 會利用 XML 檔案來指定部署作業的設定。

輸入下列指令即可 查 看您的設定檔 :

```bash
cat pom.xml
```

`helloworld` 應用程式使用的是 Maven ,這表示您必須指定一個專案物件模型 (POM) 。專案物件模型包含專案資訊,以及 Maven
用來建置專案的詳細設定資訊。

## 測試應用程式

### 在 Cloud Shell 上測試應用程式

Cloud Shell 可讓您在部署之前先測試應用程式,確認是否能 夠 正常執行 ,就像在本機上進行偵錯一樣。

如要測試應用程式,請輸入:

```bash
mvn appengine:run
```

<walkthrough-test-code-output
  text="module .* running at|Dev App Server is now running" />

### 利用「網頁預覽」功能來預覽應用程式

您的應用程式正在 Cloud Shell 上運作。如要使用這個應用程式,請用「網頁預覽」 <walkthrough-web-preview-icon/>
連線至通訊埠 8080 。
[操作示範](walkthrough://spotlight-pointer?spotlightId=devshell-web-preview-button)

### 終止預覽執行個體

在 Cloud Shell 中按下 `Ctrl+C` 即可終止應用程式的執行個體。

## 部署至 Google App Engine

### 建立應用程式

如要部署應用程式,請先在一個區域中建立一個應用程式:

```bash
gcloud app create
```

附註:若您已建立一個應用程式,可略過此步驟。

### 利用 Cloud Shell 進行部署作業

您現在可使用 Cloud Shell 部署應用程式。

首先,設定要使用的專案:

```bash
gcloud config set project {{project-id}}
```

接著部署您的應用程式:

```bash
mvn appengine:deploy
```

<walkthrough-test-code-output text="Deployed (module|service)" />

### 瀏覽應用程式

您的應用程式已部署完成,預設網址是 [{{project-gae-url}}](http://{{project-gae-url}}) 。點選網址即可開 啟
應用程式 。

### 查 看應用程式狀態

如要監控應用程式的狀態,您可隨時前往 App Engine 資訊主頁。 開 啟 主控台左側的
[選單](walkthrough://spotlight-pointer?spotlightId=console-nav-menu) 。

然後選取 **App Engine** 專區。

<walkthrough-menu-navigation sectionId="APPENGINE_SECTION"/>

## 總結

<walkthrough-conclusion-trophy/>

恭喜,您已成功部署 App Engine 應用程式! 接下來,建議您採取下列步驟:

** 下載 Google Cloud SDK 並在本機上進行開發作業 ** [Google Cloud SDK][cloud-sdk-installer]

** 建置您的下一個應用程式 **

瞭解 App Engine 與其他 Google Cloud Platform 產 品可如何搭配使用 :

<walkthrough-tutorial-card
  url="appengine/docs/java/datastore/"
  icon="DATASTORE_SECTION"
  label="datastore">
**瞭解如何使用 Cloud Datastore**
Cloud Datastore 是應用程式專用且彈性化的 NoSQL 資料庫。
</walkthrough-tutorial-card>

<walkthrough-tutorial-card
  url="appengine/docs/java/googlecloudstorageclient/setting-up-cloud-storage/"
  icon="STORAGE_SECTION"
  label="cloudStorage">
**瞭解如何使用 Cloud Storage**
Cloud Storage 是簡易但功能強大的物件儲存服務。
</walkthrough-tutorial-card>

[java]: https://java.com/
[cloud-sdk-installer]: https://cloud.google.com/sdk/downloads#interactive
