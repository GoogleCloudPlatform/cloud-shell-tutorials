# Cloud Pub/Sub 簡介

<walkthrough-tutorial-url url="https://cloud.google.com/pubsub/quickstart-console"></walkthrough-tutorial-url></walkthrough-test-start-page>

<walkthrough-devshell-precreate></walkthrough-devshell-precreate>

## 簡介

Cloud Pub/Sub 是一套全面管理化的即時通訊服務，可讓您在不同應用程式之間收發訊息。本教學課程將簡單說明如何透過 `gcloud` 指令使用 Cloud Pub/Sub 的指令列介面。

## 專案設定

Google Cloud Platform 會將資源彙整至專案中，方便您集中收納單一應用程式的所有相關資源。

請注意，Cloud Pub/Sub 需要有專案才能建立訊息。

<walkthrough-project-setup></walkthrough-project-setup>

## 建立您的第一個主題

### 開啟 Google Cloud Shell

Cloud Shell 是主控台專用的內建指令列工具，您將會使用這項工具來設定 Cloud Pub/Sub。

請點選主控台頂端導覽列中的 <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon> [圖示](walkthrough://spotlight-pointer?spotlightId=devshell-activate-button)來開啟 Cloud Shell。

### 建立主題

「主題」是您可以對其傳送訊息的具名資源。請使用下列指令來建立您的第一個主題：

```bash
gcloud pubsub topics create my-topic
```

## 新增訂閱項目

如要接收訊息，您必須先建立訂閱項目，且訂閱項目須對應至特定主題。請使用下列指令來建立您的第一個訂閱項目：

```bash
gcloud pubsub subscriptions \
    create my-sub --topic my-topic \
    --ack-deadline=60
```

這個指令會建立一個名為「`my-sub`」的訂閱項目，並將這個訂閱項目附加至「`my-topic`」主題。發佈至「`my-topic`」的所有訊息都會傳送至這個訂閱項目。

您可能會注意到「`--ack-deadline=60`」這段指令。「`ack-deadline`」代表的是「確認期限」``，也就是說，這個新的訂閱項目會有 60 秒的「確認期限」``。我們稍後會再說明這個部分。

## 列出主題和訂閱項目

在傳送第一則訊息之前，請先確認是否已成功建立主題和訂閱項目。請使用下列指令來列出主題和訂閱項目：

```bash
gcloud pubsub topics list
```

```bash
gcloud pubsub subscriptions list
```

## 將訊息發佈至主題

請使用下列指令來傳送 2 則訊息：

```bash
gcloud pubsub topics publish my-topic --message hello
```

```bash
gcloud pubsub topics publish my-topic --message goodbye
```

上述的每個指令都會傳送一則訊息。第一則訊息是「`hello`」，第二則是「`goodbye`」。成功發佈訊息之後，您應該會看到伺服器傳回的訊息 ID，這是伺服器自動指派給每則訊息的唯一識別碼。

## 從訂閱項目中提取訊息

### 提取訊息

現在，請使用下列指令來提取訊息：

```bash
gcloud pubsub subscriptions \
    pull --auto-ack --limit=2 my-sub
```

您應該會看到剛剛發佈的 2 則訊息。訊息中會包含相關資料、「`hello`」和「`goodbye`」，以及 `MESSAGE_ID`。`MESSAGE_ID` 是伺服器指派給該則訊息的唯一識別碼。

注意事項：Cloud Pub/Sub 無法保證訊息的顯示順序，您也有可能只看到一則訊息。如果發生這種情況，請反覆執行相同的指令，直到另一則訊息出現為止。

### 確認和確認期限

提取並正確處理訊息之後，您必須通知 Cloud Pub/Sub 您已成功收到訊息，這個動作稱為「**確認**」。

您可能會注意到與「`pull`」指令一同傳送的「`--auto-ack`」標記，「`--auto-ack`」標記會自動提取並確認訊息。

## 手動確認

### 傳送新訊息

請使用下列指令來傳送新訊息：

```bash
gcloud pubsub \
    topics publish my-topic --message thanks
```

### 重新提取訊息

請使用下列指令來提取訊息：

```bash
gcloud pubsub subscriptions \
    pull my-sub
```

使用這個指令之後，您應該會看到「`thanks`」訊息、`MESSAGE_ID` 和 `ACK_ID`。`ACK_ID` 是您可以用來確認訊息的另一組 ID。

### 確認訊息

提取訊息之後，您必須在「**確認期限**」所示時間內確認訊息。舉例來說，如果您按照本教學課程所示範的做法，將訂閱項目的「**確認期限**」設為 60 秒，那麼您就必須在提取訊息後的 60 秒內確認訊息，否則 Cloud Pub/Sub 將重新傳送訊息。

請使用下列指令來確認訊息 (利用複製/貼上功能，以實際 ID 取代 `ACK_ID`)：

```bash
gcloud pubsub subscriptions ack \
    my-sub --ack-ids ACK_ID
```

## 在 Pub/Sub UI 中查看主題和訂閱項目

`gcloud` 指令列的教學課程到此告一段落。但在課程結束前，我們想介紹一下 Google Cloud Console 上的 UI。

您也可以在「Pub/Sub」區段中查看主題和訂閱項目。

### 前往「Pub/Sub」區段

開啟主控台左側的[選單](walkthrough://spotlight-pointer?spotlightId=console-nav-menu)。

選取 [**Pub/Sub**] 區段。

<walkthrough-menu-navigation sectionid="CLOUDPUBSUB_SECTION"></walkthrough-menu-navigation>

您也可以在這個 UI 中建立及管理主題和訂閱項目。

### 刪除主題

勾選您所建立主題旁的核取方塊並點選 [[刪除]按鈕](walkthrough://spotlight-pointer?cssSelector=.p6n-icon-delete)，即可永久刪除該主題。

## 結論

恭喜！

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

您已概略瞭解如何透過 `gcloud` 指令列工具使用 Cloud Pub/Sub，也對 Cloud Pub/Sub 的 UI 有了基本的認識。接下來，您就可以開始製作出色的應用程式了！詳情請參閱 [Pub/Sub 說明文件][pubsub-docs]。

以下是您可以採取的後續步驟：

[瀏覽程式碼範例](https://cloud.google.com/pubsub/docs/quickstart-client-libraries)

[pubsub-docs]: https://cloud.google.com/pubsub/docs/
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-delete-button]: walkthrough://spotlight-pointer?cssSelector=.p6n-icon-delete
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
