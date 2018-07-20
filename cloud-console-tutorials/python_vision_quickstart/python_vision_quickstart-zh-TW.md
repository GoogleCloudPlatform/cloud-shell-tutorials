# Cloud Vision API

<walkthrough-test-start-page url="/start?tutorial=python_vision_quickstart_v2"></walkthrough-test-start-page>

<walkthrough-tutorial-url url="https://cloud.google.com/vision/docs/label-tutorial"></walkthrough-tutorial-url>

<walkthrough-watcher-constant value="https://github.com/GoogleCloudPlatform/python-docs-samples.git" key="repo-url"></walkthrough-watcher-constant>

<walkthrough-watcher-constant value="python-docs-samples" key="repo-name"></walkthrough-watcher-constant>

<walkthrough-devshell-precreate></walkthrough-devshell-precreate>

## 簡介

本教學課程將使用 `LABEL_DETECTION` 要求逐步介紹基本的 Vision API 應用程式。`LABEL_DETECTION`
要求會以根據圖片內容選出的標籤 (或標記) 為圖片加上註解。舉例來說，穀倉的圖片可能會產生「穀倉」、「農場」等標籤或其他類似的註解。

您需要完成下列步驟：

*   **執行標籤偵測應用程式：**我們會說明如何直接在瀏覽器中運用 Google Cloud Shell 執行應用程式。
*   **執行應用程式後...** 您可以實際測試應用程式；如果不符需求，也可以將其移除，再重新開始。

[「Python」和 Python 標誌是 Python Software Foundation
的商標或註冊商標。](walkthrough://footnote)

# 專案設定

您必須透過專案啟用 Cloud Vision API。

Google Cloud Platform 會將資源整理到專案中，方便您集中收集單一應用程式的所有相關資源。

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## 啟用 Vision API

您的專案必須啟用 Vision API 才能接受要求。

### 前往 API 管理員

API 管理員會決定要為您的專案啟用哪些 API。

開啟主控台左側的
[選單](walkthrough://spotlight-pointer?spotlightId=console-nav-menu) 。

接著選取 [API 和服務] ****專區。

<walkthrough-menu-navigation sectionid="API_SECTION"></walkthrough-menu-navigation>

### 查看可用的 API

如要啟用 API，請點選 [[啟用 API](walkthrough://spotlight-pointer?cssSelector=.p6n-action-bar-button)] 按鈕。

### 選取 Vision API

點選 [[Vision API](walkthrough://spotlight-pointer?spotlightId=api-vision.googleapis.com)] 連結。

### 啟用 Vision API

如要啟用 Vision API，請點選 [[啟用](walkthrough://spotlight-pointer?spotlightId=api-enable-vision.googleapis.com)] 按鈕。我們會在教學課程後半說明如何為專案建立憑證。

## 使用 Google Cloud Shell

Cloud Shell 是主控台專用的內建指令列工具。接下來我們將說明如何使用 Cloud Shell 執行應用程式。

### 開啟 Google Cloud Shell

請點選主控台頂端導覽列中的 <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>
[[圖示](walkthrough://spotlight-pointer?spotlightId=devshell-activate-button)]，
開啟 Cloud Shell。

### 複製範例程式碼

使用 Cloud Shell 複製並瀏覽至「Hello World」程式碼，隨後範例程式碼就會從您的專案存放區複製到 Cloud Shell。

注意：如果目錄已存在，請移除先前的檔案再開始複製：

```bash
rm -rf {{repo-name}}
```

複製範例存放區：

```bash
git clone {{repo-url}}
```

接著切換至教學課程目錄：

```bash
cd {{repo-name}}/vision/cloud-client/quickstart
```

## 設定部署作業

您目前位於範例程式碼的主目錄中。接下來說明與應用程式設定相關的檔案。

### 探索應用程式

輸入下列指令即可查看應用程式的程式碼：

```bash
cat quickstart.py
```

`quickstart.py` 檔案會為您的要求資訊建立格式，例如要求類型和內容。展開下列各個區段即可瞭解詳情。

系統會以 JSON 物件的形式將要求提供給 Vision API。如要全面瞭解這類要求的特定結構，請參閱 [Vision API
參考資料][vision-request-doc]。只有在呼叫 `execute` 時，系統才會傳送 JSON 要求。這種模式可讓您視需要傳送這類要求並呼叫
`execute`。

## 測試應用程式

您必須設定憑證才能使用這個 API。如要使用 Cloud
API，您必須為應用程式設定正確的[憑證][auth-doc]，讓應用程式能夠向服務驗證其身分並取得授權以執行工作。接下來說明如何使用範例圖片測試 API。

### 建立服務帳戶

您必須建立服務帳戶以便驗證 API 要求。如果您先前已建立服務帳戶，系統會沿用該帳戶。

```bash
gcloud iam service-accounts create vision-quickstart
```

### 建立憑證

接著請建立服務帳戶金鑰，並將其設為預設憑證。

```bash
gcloud iam service-accounts keys create key.json --iam-account    vision-quickstart@{{project-id}}.iam.gserviceaccount.com
```

```bash
export GOOGLE_APPLICATION_CREDENTIALS=key.json
```

<walkthrough-test-code-output text="created key"></walkthrough-test-code-output>

### 測試應用程式

如要使用範例圖片測試應用程式，請輸入：

```bash
python quickstart.py
```

圖片資源 `resources/wakeupcat.jpg` 已在來源中指定。([查看圖片][cat-picture])

## 結論

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

恭喜！您已經瞭解如何使用 Cloud Vision API 了！

以下是您可執行的後續步驟：

*   參加[臉部偵測][face-tutorial]的逐步教學課程。
*   嘗試[文件文字][document-text-tutorial]教學課程。
*   查看[範例應用程式][vision-samples]。
*   下載 [Google Cloud SDK][get-cloud-sdk] 並在本機上執行。

[auth-doc]: https://cloud.google.com/vision/docs/auth
[cat-picture]: https://raw.githubusercontent.com/GoogleCloudPlatform/python-docs-samples/master/vision/cloud-client/quickstart/resources/wakeupcat.jpg
[document-text-tutorial]: https://cloud.google.com/vision/docs/fulltext-annotations
[face-tutorial]: https://cloud.google.com/vision/docs/face-tutorial
[get-cloud-sdk]: https://cloud.google.com/sdk/
[vision-request-doc]: https://cloud.google.com/vision/reference/rest
[vision-samples]: https://cloud.google.com/vision/docs/samples
