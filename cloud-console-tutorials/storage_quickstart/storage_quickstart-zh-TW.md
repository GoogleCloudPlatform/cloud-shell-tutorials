# Cloud Storage 快速入門導覽課程

## 歡迎使用 Google Cloud Storage！

<walkthrough-tutorial-url url="https://cloud.google.com/storage/docs/quickstart-console"></walkthrough-tutorial-url>

Google Cloud Storage 是功能強大、成本效益高的儲存空間解決方案，非常適合非結構化物件。另外，這項服務在代管即時網路內容、儲存分析用資料、封存及備份資料等方面也有相當卓越的成效。

本教學課程將說明如何透過 Cloud Storage 輕鬆儲存物件，您將會進行下列程序：

  *  **建立值區**

     系統會將您要儲存在 Cloud Storage 中的物件 (檔案類型不限) 保留在值區中。

  *  **上傳及共用物件**

     上傳物件並將其設為公開來開始使用值區。

  *  **清除**

     在最後一個步驟中，您將會刪除在本教學課程中建立的值區和物件。

您建立的值區和物件都會在體驗結束時刪除，因此我們不會向您收取任何費用，請放心進行本教學課程。

## 專案設定

Cloud Storage 需要有專案才能建立資源。

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## 建立值區

在 Cloud Storage 中，物件會儲存在值區中。如要建立值區，請前往 Cloud Storage 瀏覽器。

開啟主控台左側的[[選單](walkthrough://spotlight-pointer?spotlightId=console-nav-menu)]。

選取 **儲存空間** 區段。

<walkthrough-menu-navigation sectionid="STORAGE_SECTION"></walkthrough-menu-navigation>

## 建立值區

在開始上傳物件之前，您必須先建立用來儲存物件的「值區」。值區可協助您將物件排序及控管物件的存取權限。

  1. 點選 [[建立 Bucket](walkthrough://spotlight-pointer?cssSelector=#p6ntest-cloudstorage-create-first-bucket-button,)]

  1. 在值區建立頁面中設定值區的屬性。進行這項操作時，請注意以下事項：

     *  **名稱：**請勿使用重複的名稱。如果您輸入的名稱與 Cloud Storage 中其他值區的名稱相同，系統會顯示錯誤訊息。
     *  **預設儲存空間級別：**這是系統指派給您值區中物件的預設儲存空間級別。選取這項設定的主要考量因素包括您預期的物件存取頻率，以及是否要向全世界公開這些資料。請注意，儲存空間級別會影響您需要支付的費用。
     *  **位置：**建議您將資料儲存在靠近應用程式且使用者可輕鬆存取的位置。視您選取的儲存空間級別而定，可用的位置選項可能不同。

由於您會在本次測試執行作業結束後刪除值區，因此可以隨意選擇儲存空間級別和位置。

  1. 點選 [[建立](walkthrough://spotlight-pointer?cssSelector=#p6ntest-gcs-create-bucket-button)]

## 上傳物件

您已建立值區，因此可以開始上傳物件。

  1. 點選頁面頂端的 [[上傳檔案](walkthrough://spotlight-pointer?spotlightId=gcs-action-bar-upload-file)]

  1. 選取要上傳的檔案 (檔案類型不限)。

     沒有既有的檔案嗎？您可以[[建立範例檔案](walkthrough://create-sample-storage-file)]，然後點選頁面頂端的 [[重新整理值區](walkthrough://spotlight-pointer?spotlightId=gcs-action-bar-refresh-objects)]。接下來，您就會看到該檔案出現在值區中 (秘訣：您也可以將物件拖曳至值區名稱下方的空白處來上傳物件)。

## 刪除值區

現在，請刪除您剛剛建立的值區。不過請注意，刪除值區之後，當中的內容也會一併遭到移除。

  1. 點選資料表頂端的 [[值區](walkthrough://spotlight-pointer?cssSelector=.p6n-cloudstorage-path-link)]，即可返回值區清單。

  1. 勾選值區旁的方塊。如果這項專案中有多個值區而導致您找不到所需值區，您可以利用搜尋列來篩選值區清單。

  1. 點選頁面頂端的 [[刪除](walkthrough://spotlight-pointer?spotlightId=gcs-action-bar-delete-bucket)]，然後確認刪除值區。

## 結論

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

恭喜！

您現在已經學會如何在 Cloud Storage 中儲存物件。如要實際應用，建議您繼續瞭解如何[代管靜態網站](https://cloud.google.com/storage/docs/hosting-static-website)。

或者，您也可以學習如何透過 [gsutil 指令列工具](https://cloud.google.com/storage/docs/quickstart-gsutil)使用 Cloud Storage。

瞭解如何開始[免費](https://cloud.google.com/free)使用 Cloud Storage 和其他 GCP 服務。

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
