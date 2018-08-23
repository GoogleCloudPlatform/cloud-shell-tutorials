# App Engine 快速入門導覽課程

<walkthrough-tutorial-url url="https://cloud.google.com/appengine/docs/python/quickstart"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="https://github.com/GoogleCloudPlatform/python-docs-samples" key="repo-url"></walkthrough-watcher-constant>
<walkthrough-watcher-constant value="python-docs-samples/appengine/standard/hello_world" key="repo-dir"></walkthrough-watcher-constant>

## 簡介

本教學課程將說明如何使用 `gcloud` 指令，將範例 [Python](https://python.org/) 應用程式部署至 Google App Engine。

您會執行下列程序：

  *  **建立專案**

     建立專案之後，您就能將程式碼、VM 和其他資源整合在一起，以便進行開發和監控。

  *  **建置並執行「Hello, world!」應用程式**

     您將會瞭解如何直接在瀏覽器中透過 Google Cloud Shell 執行應用程式，並使用 `gcloud` 指令將應用程式部署至網路。

  *  **教學課程結束後...**

     部署完成之後，您就能實際測試應用程式。如果不符合需求，您也可以將其移除並重新建立一個新的應用程式。

[「Python」和 Python 標誌是 Python Software Foundation 的商標或註冊商標。](walkthrough://footnote)

## 專案設定

如要部署應用程式，您必須先建立專案。

Google Cloud Platform 會將資源彙整至專案中，方便您集中收納單一應用程式的所有相關資源。

<walkthrough-devshell-precreate></walkthrough-devshell-precreate>

<walkthrough-project-setup></walkthrough-project-setup>

## 使用 Google Cloud Shell

Cloud Shell 是主控台專用的內建指令列工具，我們將會使用這項工具來部署應用程式。

### 開啟 Google Cloud Shell

請點選主控台頂端導覽列中的 <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon> [圖示](walkthrough://spotlight-pointer?spotlightId=devshell-activate-button)來開啟 Cloud Shell。

### 複製範例程式碼

使用 Cloud Shell 複製並瀏覽至「Hello World」程式碼，隨後範例程式碼就會從您的專案存放區複製到 Cloud Shell。

注意：如果目錄已存在，請移除先前的檔案再開始複製。

請在 Cloud Shell 中輸入下列指令：

```bash
git clone {{repo-url}}
```

接著，請切換至教學課程目錄：

```bash
cd {{repo-dir}}
```

## 設定部署作業

您現在所在的位置是範例程式碼的主目錄。接下來，我們將帶您瞭解與應用程式設定相關的檔案。

### 探索應用程式

輸入下列指令即可查看應用程式的程式碼：

```bash
cat main.py
```

這是採用 [webapp2](https://webapp2.readthedocs.io/) 網路架構的簡易 Python 應用程式，這組 Python 指令碼會使用 HTTP 標頭和「`Hello, World!`」訊息來回應要求。

### 檢視您的設定

Google App Engine 使用 YAML 檔案來指定部署作業設定。
`app.yaml` 檔案中包含應用程式的相關資訊，例如執行階段環境、網址處理常式等等。

輸入下列指令即可查看您的設定檔：

```bash
cat app.yaml```

這個設定檔會提供此應用程式的相關資訊，由上而下為：

  *  這組程式碼是在 `python` 執行階段環境中執行。
  *  這個應用程式具備「執行緒安全」``特性，因此一個執行個體可以同時處理多項要求。「執行緒安全」是一種相當先進的功能，如果應用程式的設計不符合執行緒安全的相關需求，就有可能產成錯誤行為。
  *  如果網址的路徑符合規則運算式 `/.*` (所有網址均適用)，則提交至該網址的所有要求都應該由「主要」``Python 模組中的應用程式物件處理。

這個檔案的語法是 [YAML](http://www.yaml.org)。如需完整的設定選項清單，請參閱 [`app.yaml`][app-yaml-reference] 參考資料。

## 測試應用程式

### 在 Cloud Shell 上測試應用程式

Cloud Shell 可讓您在部署應用程式前先進行測試，確保應用程式能夠正常運作，就像在本機上進行偵錯一樣。

如要測試應用程式，請輸入下列指令：

```bash
dev_appserver.py $PWD```

### 使用「網頁預覽」來預覽應用程式

應用程式正在 Cloud Shell 中執行時，您可以透過[網頁預覽](walkthrough://spotlight-pointer?spotlightId=devshell-web-preview-button)<walkthrough-web-preview-icon></walkthrough-web-preview-icon>功能連接至通訊埠 8080，藉此存取您的應用程式。

### 終止預覽執行個體

在 Cloud Shell 中按下 `Ctrl+C`，即可終止應用程式的執行個體。

## 部署至 Google App Engine

### 建立應用程式

如要部署應用程式，您必須先在某個區域中建立應用程式：

```bash
gcloud app create
```

注意事項：如果您已建立應用程式，則可略過這個步驟。

### 使用 Cloud Shell 進行部署

您可以使用 Cloud Shell 來部署應用程式，操作指令如下：

```bash
gcloud app deploy app.yaml --project {{project-id}}
```

### 瀏覽應用程式

恭喜！您的應用程式已部署完成。應用程式的預設網址是 [{{project-gae-url}}](http://{{project-gae-url}})，點選這個網址即可瀏覽您的應用程式。

### 查看應用程式狀態

您可以在 App Engine 資訊主頁中查看應用程式的狀態。

開啟主控台左側的[選單](walkthrough://spotlight-pointer?spotlightId=console-nav-menu)。

選取 [**App Engine**] 區段。

<walkthrough-menu-navigation sectionid="APPENGINE_SECTION"></walkthrough-menu-navigation>

## 結論

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

您已成功部署 App Engine 應用程式！

後續步驟如下：

**下載 Google Cloud SDK 並在本機上進行開發**

在本機上安裝 [Google Cloud SDK][cloud-sdk-installer]。

**建置下一個應用程式**

瞭解如何搭配其他 Google Cloud Platform 產品來使用 App Engine：

<walkthrough-tutorial-card label="django" url="python/django/appengine" icon="APPENGINE_SECTION">
**執行 Django** 開發在 App Engine 上執行的 Django 應用程式。 </walkthrough-tutorial-card>

<walkthrough-tutorial-card label="datastore" url="appengine/docs/python/datastore/" icon="DATASTORE_SECTION">
**瞭解如何使用 Cloud Datastore** Cloud Datastore 是具高度擴充性的 NoSQL
資料庫，能夠針對您的應用程式提供相關的資料庫功能。 </walkthrough-tutorial-card>

[app-yaml-reference]: https://cloud.google.com/appengine/docs/standard/python/config/appref
[cloud-sdk-installer]: https://cloud.google.com/sdk/downloads#interactive
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-web-preview]: walkthrough://spotlight-pointer?spotlightId=devshell-web-preview-button
