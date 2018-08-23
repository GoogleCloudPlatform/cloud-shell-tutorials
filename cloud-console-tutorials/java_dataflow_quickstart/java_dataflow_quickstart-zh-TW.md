# Dataflow WordCount 教學課程

<walkthrough-tutorial-url url="https://cloud.google.com/dataflow/docs/quickstarts/quickstart-java-maven"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="dataflow-intro" key="directory"></walkthrough-watcher-constant>
<walkthrough-watcher-constant value="dataflow-intro" key="job-name"></walkthrough-watcher-constant>

## 簡介

在本教學課程中，您將使用 Java 來執行一個簡單的管道範例，藉此瞭解 Cloud Dataflow 服務的基本概念。

Dataflow 管道分為「**批次**」(處理相連的輸入資料，例如檔案或資料庫表格) 和「**串流**」(處理來自 Cloud Pub/Sub 等來源的獨立輸入資料)。本教學課程中的範例屬於批次管道，您將會透過這個管道計算莎士比亞作品集中的字數。

在開始之前，您必須先檢查 Cloud Platform 專案是否符合相關的先決條件，接著進行初始設定。

## 專案設定

Google Cloud Platform 會將資源彙整至專案中，方便您集中收納單一應用程式的所有相關資源。

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>
<walkthrough-project-permissions permissions="dataflow.jobs.create"></walkthrough-project-permissions>

## 設定 Cloud Dataflow

如要使用 Dataflow，請先啟用 Cloud Dataflow API 並開啟 Cloud Shell。

### 啟用 Google Cloud API

<walkthrough-enable-apis apis="compute.googleapis.com,dataflow,cloudresourcemanager.googleapis.com,logging,storage_component,storage_api,bigquery,pubsub">
</walkthrough-enable-apis>

### 開啟 Cloud Shell

Cloud Shell 是主控台專用的內建指令列工具，您將會使用這項工具來部署應用程式。

請點選主控台頂端導覽列中的 <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon> [圖示](walkthrough://spotlight-pointer?spotlightId=devshell-activate-button)來開啟 Cloud Shell。

## 在 Cloud Shell 上安裝 Cloud Dataflow 範例

如想使用 Java 版的 Cloud Dataflow SDK，您的開發環境必須具備 Java、Google Cloud SDK,、Java 版 Cloud Dataflow SDK，以及用來管理 SDK 依附元件的 Apache Maven。本教學課程中使用的 Cloud Shell 已安裝 Java、Google Cloud SDK 及 Maven，因此請您放心。

如有需要，您也可以[在本機上][dataflow-java-tutorial]進行本教學課程。

### 使用 Maven 指令來下載範例和 Java 版的 Cloud Dataflow SDK

在您執行這個指令之後，Maven 就會建立專案結構和設定檔，以下載合適的 Cloud Dataflow SDK 版本。

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

  *  「`archetypeArtifactId`」和「`archetypeGroupId`」的作用為定義範例專案結構。
  *  「`groupId`」是您所屬機構的 Java 套件名稱前置字串，例如「`com.mycompany`」。
  *  「`artifactId`」會設定所建立 jar 檔案的名稱。為順利進行本教學課程，請使用預設值「`{{directory}}`」。

在 Cloud Shell 中執行 Maven 指令。

### 變更目錄

將工作目錄變更為「`{{directory}}`」。

```bash
cd {{directory}}
```

如要查看這個範例的程式碼，請參閱「`{{directory}}`」目錄中的「`src`」子目錄。

## 設定 Cloud Storage 值區

Cloud Dataflow 會使用 Cloud Storage 值區來儲存輸出資料及快取管道程式碼。

### 執行 gsutil mb

在 Cloud Shell 中，使用「`gsutil mb`」指令來建立 Cloud Storage 值區。

```bash
gsutil mb gs://{{project-id-no-domain}}
```

如要進一步瞭解「`gsutil`」工具，請參閱[這篇說明文件][gsutil-docs]。

## 建立和啟動管道

在 Cloud Dataflow 中，資料處理工作會以「**管道**」的形式呈現。管道會讀取和轉換輸入資料，接著產生輸出資料。管道可能執行的轉換作業包括篩選、分組、比較或整合資料。

如要查看這個範例的程式碼，請參閱「`{{directory}}`」目錄中的「`src`」子目錄。

### 在 Dataflow 服務上啟動管道

請使用 Apache Maven 的「`mvn exec`」指令，在服務上啟動管道。執行中的管道稱為「工作」**。

```bash
mvn compile exec:java \
  -Dexec.mainClass=com.example.WordCount \
  -Dexec.args="--project={{project-id}} \
  --stagingLocation=gs://{{project-id-no-domain}}/staging/ \
  --output=gs://{{project-id-no-domain}}/output \
  --runner=DataflowRunner \
  --jobName={{job-name}}"
```

  *  「`stagingLocation`」是 Cloud Dataflow 用來儲存執行管道所需的二進位檔和其他資料的值區，這個位置可由多項工作共用。
  *  「`output`」是 WordCount 範例用來儲存工作結果的值區。

### 系統已開始執行您的工作

恭喜！二進位檔已準備就緒，就存放在您先前建立的 Storage 值區中。系統正在建立 Compute Engine 執行個體。Cloud Dataflow 會分割您的輸入檔案，以便在多部機器上平行處理資料。

注意事項：畫面上顯示「工作結束」訊息時，即可關閉 Cloud Shell。

如想清除您建立的 Maven 專案，請在 Cloud Shell 中執行「`cd .. && rm -R {{directory}}`」來刪除目錄。

## 監控工作

您可以在 Cloud Dataflow Monitoring UI 頁面中查看管道的工作進度。

### 前往 Cloud Dataflow 頁面

開啟主控台左側的[選單](walkthrough://spotlight-pointer?spotlightId=console-nav-menu)。

選取 [**Dataflow**] 專區。

<walkthrough-menu-navigation sectionid="DATAFLOW_SECTION"></walkthrough-menu-navigation>

### 選取工作

點選所需工作，即可檢視相關詳情。

### 查看管道詳細資料和相關指標

畫面左側會顯示管道資料，右側則為工作相關資訊。如要進一步瞭解工作狀態，請點選 [[記錄](walkthrough://spotlight-pointer?cssSelector=#p6n-dax-job-logs-toggle)]。點選管道中的任一步驟，即可查看相關指標。

工作完成時，您會看到工作狀態發生改變，這項工作使用的 Compute Engine 執行個體也會自動停止運作。

## 查看輸出資料

工作已執行完畢，因此您可以瀏覽儲存在 Cloud Storage 中的輸出檔案。

### 前往 Cloud Storage 頁面

開啟主控台左側的[選單](walkthrough://spotlight-pointer?spotlightId=console-nav-menu)。

選取 [**儲存空間**] 專區。

<walkthrough-menu-navigation sectionid="STORAGE_SECTION"></walkthrough-menu-navigation>

### 前往 Storage 值區

在值區清單中，選取您先前建立的值區。如果您使用的是系統建議的名稱，則值區名稱為「`{{project-id}}`」。

這個值區中會包含暫存資料夾和輸出資料夾。Dataflow 會以資料分割的方式儲存輸出內容，因此這個值區會有多個輸出檔案。

## 清除

請刪除您建立的值區，以免系統向您收取 Cloud Storage 的使用費用。

### 返回值區瀏覽器

點選 [[Bucket](walkthrough://spotlight-pointer?cssSelector=.p6n-cloudstorage-path-link)] 連結。

### 選取值區

找出您建立的值區，接著勾選旁邊的方塊。

### 刪除值區

點選 [[刪除](walkthrough://spotlight-pointer?cssSelector=#p6n-cloudstorage-delete-buckets)]，並確認您要刪除該項目。

## 結論

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

後續課程與相關資源：

  *  [進一步瞭解 WordCount 範例][wordcount]
  *  [瞭解 Cloud Dataflow 程式設計模型][df-model]
  *  [探索 GitHub 上的 Cloud Dataflow SDK][df-sdk]

設定本機環境：

  *  [使用 Eclipse 來執行 Dataflow][df-eclipse]
  *  [使用 Python 來執行 Dataflow][df-python]

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
