# Cloud Pub/Sub の概要

<walkthrough-tutorial-url url="https://cloud.google.com/pubsub/quickstart-console"></walkthrough-tutorial-url></walkthrough-test-start-page>

<walkthrough-devshell-precreate></walkthrough-devshell-precreate>

## はじめに

Cloud Pub/Sub はフルマネージドのリアルタイム メッセージング サービスで、個別のアプリケーション間でメッセージを送受信できます。このチュートリアルでは、`gcloud` コマンドを使って Cloud Pub/Sub のコマンドライン インターフェースについて簡単に説明します。

## プロジェクトをセットアップする

Google Cloud Platform がリソースを整理してプロジェクトに格納します。これによって、1 つのアプリケーションの関連リソースすべてを 1 か所にまとめることができます。

メッセージを設定するには Cloud Pub/Sub にプロジェクトが必要です。

<walkthrough-project-setup></walkthrough-project-setup>

## 最初のトピックを作成する

### Google Cloud Shell を開く

Cloud Shell はコンソールに組み込まれたコマンドライン ツールです。ここでは、Cloud Shell を使用して Cloud Pub/Sub を設定します。

コンソールの上部にあるナビゲーション バーの<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[アイコン][spotlight-open-devshell]をクリックして、Cloud Shell を開きます。

### トピックを作成する

トピックとは、メッセージの送信先となる名前付きリソースのことです。次のコマンドを使用して最初のトピックを作成します。

```bash
gcloud pubsub topics create my-topic
```

## サブスクリプションを追加する

メッセージを受信するには、サブスクリプションを作成する必要があります。サブスクリプションには、対応するトピックが必要です。次のコマンドを使用して最初のサブスクリプションを作成します。

```bash
gcloud pubsub subscriptions \
    create my-sub --topic my-topic \
    --ack-deadline=60
```

このコマンドによって `my-sub` という名前のサブスクリプションが作成され、トピック `my-topic` に対応付けられます。`my-topic` に公開されるすべてのメッセージがこのサブスクリプションに配信されます。

`--ack-deadline=60` オプションが指定されていますが、この `ack-deadline` は`確認応答期限`を表します。この新しいサブスクリプションの`確認応答期限`は 60 秒です。これについては、後で説明します。

## トピックとサブスクリプションを一覧表示する

最初のメッセージを送信する前に、トピックとサブスクリプションが正しく作成されているか確認します。次のコマンドを使用してトピックとサブスクリプションを一覧表示します。

```bash
gcloud pubsub topics list
```

```bash
gcloud pubsub subscriptions list
```

## トピックにメッセージを公開する

次のコマンドを使って、メッセージを 2 通送信します。

```bash
gcloud pubsub topics publish my-topic --message hello
```

```bash
gcloud pubsub topics publish my-topic --message goodbye
```

各コマンドで 1 通のメッセージが送信されます。最初のメッセージは `hello` で、2 番目のメッセージは `goodbye` です。メッセージが正しく公開されると、サーバーから messageId が返されます。これはサーバーによってメッセージごとに自動的に割り当てられる一意の ID です。

## サブスクリプションからメッセージを pull する

### メッセージを pull する

次に、次のコマンドを使ってメッセージを pull します。

```bash
gcloud pubsub subscriptions \
    pull --auto-ack --limit=2 my-sub
```

先ほど公開した 2 通のメッセージが表示されるはずです。メッセージには、データ（`hello` および `goodbye`）と `MESSAGE_ID` が含まれています。`MESSAGE_ID` はサーバーがメッセージに割り当てた一意の ID です。

注: Cloud Pub/Sub では、メッセージの順番は保証されません。また、メッセージが 1 通しか表示されないこともあります。その場合は、残りのメッセージが表示されるまで、同じコマンドを複数回実行してみてください。

### 確認応答と確認応答期限

メッセージを pull し、正しく処理すると、メッセージを正しく受信したことを Cloud Pub/Sub に通知する必要があります。この操作のことを**確認応答**と呼びます。

`pull` コマンドに `--auto-ack` フラグが指定されていることに気付いたかと思います。`--auto-ack` フラグを指定すると、自動的にメッセージを pull して確認応答が行われます。

## 手動で確認応答する

### 新しいメッセージを送信する

次のコマンドを使って新しいメッセージを送信します。

```bash
gcloud pubsub \
    topics publish my-topic --message thanks
```

### メッセージを再度 pull する

次のコマンドを使ってメッセージを pull します。

```bash
gcloud pubsub subscriptions \
    pull my-sub
```

これにより、メッセージ `thanks`、`MESSAGE_ID`、`ACK_ID` が表示されます。`ACK_ID` は、メッセージの確認応答に使用できるもう 1 つの ID です。

### メッセージの確認応答をする

メッセージを pull したら、**確認応答期限**が経過する前にメッセージの確認応答を行う必要があります。たとえば、サブスクリプションに構成されている**確認応答期限**が 60 秒の場合、メッセージを pull してから 60 秒以内にメッセージの確認応答を行う必要があります。そうしない場合、Cloud Pub/Sub によってメッセージが再送信されます。

メッセージの確認応答を行うには、次のコマンドを使用します（コピーして貼り付けし、`ACK_ID` を実際の ID に置き換えてください）。

```bash
gcloud pubsub subscriptions ack \
    my-sub --ack-ids ACK_ID
```

## Pub/Sub UI でトピックとサブスクリプションを表示する

以上で `gcloud` コマンドラインのチュートリアルは終了ですが、その前に Google Cloud Console の UI を見ておきましょう。

Pub/Sub セクションでトピックとサブスクリプションを確認することもできます。

### Pub/Sub セクションに移動する

コンソールの左側にある[メニュー][spotlight-console-menu]を開きます。

**Pub/Sub** セクションを選択します。

<walkthrough-menu-navigation sectionid="CLOUDPUBSUB_SECTION"></walkthrough-menu-navigation>

UI を使って、トピックおよびサブスクリプションを作成し、管理することもできます。

### トピックを削除する

作成したトピックの横のチェックボックスをオンにし、[[削除] ボタン][spotlight-delete-button]をクリックしてトピックを完全に削除します。

## まとめ

これで完了です。

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

`gcloud` コマンドライン ツールを使って Cloud Pub/Sub の基本的な概念を説明しました。また、Cloud Pub/Sub の UI を確認しました。次はいよいよアプリケーションの作成です。詳しくは、[Pub/Sub のドキュメント][pubsub-docs]をご覧ください。

次にできる操作:

[コードのサンプルを見る](https://cloud.google.com/pubsub/docs/quickstart-client-libraries)

[pubsub-docs]: https://cloud.google.com/pubsub/docs/
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-delete-button]: walkthrough://spotlight-pointer?cssSelector=.p6n-icon-delete
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
