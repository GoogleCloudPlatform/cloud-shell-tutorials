# Cloud IoT Core の概要

<walkthrough-tutorial-url url="https://cloud.google.com/iot/docs/quickstart"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="https://github.com/GoogleCloudPlatform/nodejs-docs-samples.git" key="repo-url"></walkthrough-watcher-constant>

## はじめに

Google Cloud Internet of Things（IoT）Core は、数台から数百万台の IoT 端末を安全に接続して管理するためのフルマネージド サービスです。このチュートリアルでは、`gcloud` コマンドライン ツールを使用して Cloud IoT Core 端末レジストリを作成し、端末を追加する方法を説明します。また、MQTT サンプルを実行して端末を接続し、端末のテレメトリー イベントを公開する方法も示します。

このチュートリアルの内容:

  *  Cloud Pub/Sub トピックを作成する
  *  端末レジストリを作成する
  *  レジストリに端末を追加する
  *  端末に認証情報を設定する
  *  Pub/Sub トピックへのサブスクリプションを作成して、メッセージを送受信する
  *  仮想端末を接続して、テレメトリー データを表示する

## プロジェクトのセットアップ

Google Cloud Platform がリソースを整理してプロジェクトに格納します。これによって、1 つのアプリケーションの関連リソースすべてを 1 か所にまとめることができます。

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## Google Cloud Shell の使用

このチュートリアルでは、すべての作業を Cloud Shell で行います。

### Google Cloud Shell を開く

コンソールの上部にあるナビゲーション バーの<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[アイコン][spotlight-open-devshell]をクリックして、Cloud Shell を開きます。

### Google Cloud API を有効にする

Cloud IoT Core API が有効になります。

<walkthrough-enable-apis apis="cloudiot.googleapis.com"></walkthrough-enable-apis>

## 最初のトピックの作成

トピックとは、端末がメッセージを送信する宛先となる名前付きリソースのことです。次のコマンドを使用して最初のトピックを作成します。

```bash
gcloud pubsub topics create my-topic
```

後でこのトピックにメッセージをいくつか送信します。

## GitHub からの Cloud IoT Core Node.js サンプル ファイルのクローン作成

MQTT サンプルを使用して、Cloud IoT Core にメッセージを送信します。

注: ディレクトリがすでに存在する場合は、クローン作成の前に以前のファイルを削除します。

```bash
rm -rf nodejs-docs-samples
```

次のコマンドを使用して、サンプル プログラムのクローンを作成します。

```bash
git clone {{repo-url}}
```

## Cloud IoT Core サービス アカウントへの権限の付与

`/iot/scripts` フォルダのヘルパー スクリプトを使用して、Cloud Pub/Sub トピックにパブリッシャーの役割を持つ `cloud-iot@system.gserviceaccount.com` サービス アカウントを追加します。

### iot ディレクトリに移動します。

```bash
cd nodejs-docs-samples/iot
```

### 依存関係をインストールします。

```bash
npm --prefix ./scripts install
```

### ヘルパー スクリプトを実行します。

```bash
node scripts/iam.js my-topic
```

スクリプトにより、`my-topic` トピックの Cloud IoT Core サービス アカウントに権限が付与されます。

## 端末レジストリの作成

端末レジストリには端末が含まれていて、レジストリ内のすべての端末で共有されるプロパティが定義されます。次のコマンドを使用して端末レジストリを作成します。

```bash
gcloud iot registries create my-registry \
    --project={{project-id}} \
    --region=us-central1 \
    --event-notification-config=topic=projects/{{project-id}}/topics/my-topic
```

## 署名鍵の生成

Cloud IoT Core 認証するには、端末に秘密鍵と公開鍵が必要です。次のコマンドを実行して署名鍵を生成してください。

```bash
./scripts/generate_keys.sh
```

このスクリプトは、RS256 キーと ES256 キーを PEM 形式で作成しますが、このチュートリアルでは RS256 キーのみが必要です。秘密鍵は端末に安全に保存し、Authentication JWT（[JSON ウェブトークン][web-token-docs]）に署名する場合に使用します。公開鍵は、端末レジストリに格納されます。

## 端末の作成とレジストリへの追加

次のコマンドを実行して端末を作成し、レジストリに追加します。

```bash
gcloud iot devices create my-node-device \
    --project={{project-id}} \
    --region=us-central1 \
    --registry=my-registry \
    --public-key path=rsa_cert.pem,type=rs256
```

## 端末の接続とテレメトリー データの表示

この手順では、仮想端末から Pub/Sub にメッセージを送信します。送信したら、メッセージを pull して表示します。

### MQTT サンプル ディレクトリに移動します。

```bash
cd mqtt_example
```

### Node.js 依存関係をインストールします。

```bash
npm install
```

### 次のコマンドを実行して、MQTT ブリッジを使用して仮想端末を Cloud IoT Core に接続します。

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

出力には、仮想端末がテレメトリー トピックにメッセージを公開していることが示されます。25 個のメッセージが公開されます。

## 端末のトピックへのサブスクリプションを作成する

次のコマンドを実行してサブスクリプションを作成し、端末で公開されたメッセージを表示できるようにします。

```bash
gcloud pubsub subscriptions create \
    projects/{{project-id}}/subscriptions/my-subscription \
    --topic=my-topic
```

## 公開されたメッセージを pull する

次のコマンドを使用して、端末で公開されたメッセージを pull します。

```bash
gcloud pubsub subscriptions pull --auto-ack \
    projects/{{project-id}}/subscriptions/my-subscription
```

このコマンドを実行すると、端末により公開されたメッセージが返されます。メッセージには、`my-registry/my-node-device-payload-&lt;INTEGER&gt;`、`MESSAGE_ID`、端末に関する情報からなる `ATTRIBUTES` リストが含まれています。`MESSAGE_ID` は、サーバーから割り当てられた一意の ID です。

注: Cloud Pub/Sub では、メッセージの順序は保証されません。Cloud Shell にメッセージが 1 通しか表示されないこともあります。その場合は、残りのメッセージが表示されるまで、同じコマンドを複数回実行してください。

## Google Cloud Platform Console でのリソースの表示

これで `gcloud` コマンドラインのチュートリアルは終了ですが、GCP Console を使用して作成したリソースを表示することもできます。

コンソールの左側にある[メニュー][spotlight-console-menu]を開きます。

[**IoT Core**] を選択します。

<walkthrough-menu-navigation sectionid="IOT_SECTION"></walkthrough-menu-navigation>

UI を使って、端末レジストリや端末を作成し、管理することもできます。

## まとめ

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

以上でチュートリアルは終了です。`gcloud` コマンドライン ツールを使用して Cloud IoT Core の基本概念を説明し、GCP Console を使用して Cloud IoT Core リソースを表示しました。次のステップは、実際のアプリケーションの作成です。詳細については、[IoT Core のドキュメント](https://cloud.google.com/iot/docs/)をご覧ください。

### 次にできる操作

GitHub でその他の Cloud IoT Core サンプルを見る。

  *  [C](https://github.com/GoogleCloudPlatform/cpp-docs-samples/tree/master/iot/mqtt-ciotc)
  *  [Java](https://github.com/GoogleCloudPlatform/java-docs-samples/tree/master/iot/api-client)
  *  [Node.js](https://github.com/GoogleCloudPlatform/nodejs-docs-samples/tree/master/iot)
  *  [Python](https://github.com/GoogleCloudPlatform/python-docs-samples/tree/master/iot/api-client)

[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[web-token-docs]: https://cloud.google.com/iot/docs/how-tos/credentials/jwts
