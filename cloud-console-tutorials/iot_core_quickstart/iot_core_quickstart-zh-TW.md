# Cloud IoT Core 簡介

<walkthrough-tutorial-url url="https://cloud.google.com/iot/docs/quickstart"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="https://github.com/GoogleCloudPlatform/nodejs-docs-samples.git" key="repo-url"></walkthrough-watcher-constant>

## 簡介

Google Cloud Internet of Things (IoT) Core 是一項完全由 Google 代管的服務，可讓您以安全的方式連結及管理任意數量的 IoT 裝置 (甚至多達數百萬部)。本教學課程將示範如何使用 `gcloud` 指令列工具來建立 Cloud IoT Core 裝置登錄檔及新增裝置。另外，我們也會介紹如何執行 MQTT 範本來連結裝置及發佈裝置遙測事件。

本教學課程將逐步說明下列事項：

  *  建立 Cloud Pub/Sub 主題
  *  建立裝置登錄檔
  *  將裝置新增至登錄檔
  *  為裝置設定憑證
  *  為 Pub/Sub 主題建立訂閱項目，以傳送及接收訊息
  *  連結虛擬裝置及查看遙測資料

## 專案設定

Google Cloud Platform 會將資源彙整至專案中，方便您集中一處收集單一應用程式的所有相關資源。

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## 使用 Google Cloud Shell

在本教學課程中，您將會透過 Cloud Shell 執行所有工作。

### 開啟 Google Cloud Shell

請點選主控台頂端導覽列中的 <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon> [圖示](逐步操作說明：//spotlight-pointer?spotlightId=devshell-activate-button)來開啟 Cloud Shell。

### 開啟 Google Cloud API

執行這項操作會啟用 Cloud IoT Core API。

<walkthrough-enable-apis apis="cloudiot.googleapis.com"></walkthrough-enable-apis>

## 建立第一個主題

「主題」是您可以透過裝置對其傳送訊息的具名資源。請使用下列指令來建立您的第一個主題：

```bash
gcloud pubsub topics create my-topic
```

您稍後會向這個主題傳送數則訊息。

## 從 GitHub 複製 Cloud IoT Core Node.js 範例檔案

您將會使用 MQTT 範本來向 Cloud IoT Core 傳送訊息。

注意事項：如果系統中已有目錄，請移除先前的檔案再開始複製：

```bash
rm -rf nodejs-docs-samples
```

請使用下列指令來複製範例程式：

```bash
git clone {{repo-url}}
```

## 授予權限給 Cloud IoT Core 服務帳戶

使用「`/iot/scripts`」資料夾中的輔助指令碼，以「發佈者」的角色在 Cloud Pub/Sub 主題中新增 `cloud-iot@system.gserviceaccount.com` 服務帳戶。

### 前往 IoT 目錄：

```bash
cd nodejs-docs-samples/iot
```

### 安裝依附元件：

```bash
npm --prefix ./scripts install
```

### 執行輔助指令碼：

```bash
node scripts/iam.js my-topic
```

這組指令碼會將「`my-topic`」主題的相關權限授予 Cloud IoT Core 服務帳戶。

## 建立裝置登錄檔

裝置登錄檔中包含各種裝置，這類登錄檔會定義當中所有裝置共用的屬性。請使用以下指令來建立裝置登錄檔：

```bash
gcloud iot registries create my-registry \
    --project={{project-id}} \
    --region=us-central1 \
    --event-notification-config=topic=projects/{{project-id}}/topics/my-topic
```

## 產生簽署金鑰

如要為 Cloud IoT Core 進行驗證，裝置必須擁有私密金鑰和公開金鑰。請使用以下指令來產生簽署金鑰：

```bash
./scripts/generate_keys.sh
```

這組指令碼會產生採用 PEM 格式的 RS256 和 ES256 金鑰。不過在本教學課程中，您只需要使用 RS256 金鑰。請務必將私密金鑰妥善儲存在裝置中，您必須使用這組金鑰來簽署驗證 JWT ([JSON Web Token][web-token-docs])。另一方面，公開金鑰則會儲存在裝置登錄檔中。

## 建立裝置並將其新增至登錄檔

如要建立裝置並將其新增至登錄檔，請執行下列指令：

```bash
gcloud iot devices create my-node-device \
    --project={{project-id}} \
    --region=us-central1 \
    --registry=my-registry \
    --public-key path=rsa_cert.pem,type=rs256
```

## 連結裝置及查看遙測資料

在這個步驟中，您將會透過虛擬裝置傳送訊息至 Pub/Sub。接著，您就可以提取及查看訊息。

### 前往 MQTT 範本目錄：

```bash
cd mqtt_example
```

### 安裝 Node.js 依附元件：

```bash
npm install
```

### 請執行下列指令，透過 MQTT 橋接將虛擬裝置連結至 Cloud IoT Core：

```bash
node cloudiot_mqtt_example_nodejs.js \
    --projectId={{project-id}} \
    --registryId=my-registry \
    --deviceId=my-node-device \
    --privateKeyFile=../rsa_private.pem \
    --numMessages=25 \
    --algorithm=RS256 \
    --mqttBridgePort=443
```

系統會向您顯示虛擬裝置正在向遙測主題發佈訊息，且目前已發佈二十五則訊息。

## 為裝置主題建立訂閱項目

請執行下列指令來建立訂閱項目，方便您查看裝置發佈的訊息：

```bash
gcloud pubsub subscriptions create \
    projects/{{project-id}}/subscriptions/my-subscription \
    --topic=my-topic
```

## 提取已發佈的訊息

請使用下列指令來提取裝置發佈的訊息：

```bash
gcloud pubsub subscriptions pull --auto-ack \
    projects/{{project-id}}/subscriptions/my-subscription
```

在您執行這個指令之後，系統會傳回裝置發佈的訊息。訊息中會包含下列資料：`my-registry/my-node-device-payload-&lt;INTEGER&gt;`、`MESSAGE_ID`，以及裝置相關資訊的「`ATTRIBUTES`」清單。`MESSAGE_ID` 是伺服器指派的唯一識別碼。

注意事項：Cloud Pub/Sub 無法保證訊息的顯示順序，您也有可能只會在 Cloud Shell 中看到一則訊息。如果發生這種情況，請反覆執行相同的指令，直到其他訊息出現為止。

## 在 Google Cloud Platform 主控台查看資源

`gcloud` 指令列教學課程到此結束，但您還是可以使用 GCP 主控台來查看您剛剛建立的資源。

開啟主控台左側的[選單](逐步操作說明：//spotlight-pointer?spotlightId=console-nav-menu)。

選取 [**IoT Core**]。

<walkthrough-menu-navigation sectionid="IOT_SECTION"></walkthrough-menu-navigation>

您也可以利用 UI 來建立及管理裝置登錄檔和裝置。

## 結論

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

恭喜！您已概略瞭解如何透過 `gcloud` 指令列工具使用 Cloud IoT Core，也已利用 GCP 主控台來查看 Cloud IoT Core 資源。接下來，您就可以開始製作出色的應用程式了！詳情請參閱 [IoT Core 說明文件](https://cloud.google.com/iot/docs/)。

### 以下是您可以執行的後續步驟

前往 GitHub 瀏覽更多 Cloud IoT Core 範例：

  *  [C](https://github.com/GoogleCloudPlatform/cpp-docs-samples/tree/master/iot/mqtt-ciotc)
  *  [Java](https://github.com/GoogleCloudPlatform/java-docs-samples/tree/master/iot/api-client)
  *  [Node.js](https://github.com/GoogleCloudPlatform/nodejs-docs-samples/tree/master/iot)
  *  [Python](https://github.com/GoogleCloudPlatform/python-docs-samples/tree/master/iot/api-client)

[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[web-token-docs]: https://cloud.google.com/iot/docs/how-tos/credentials/jwts
