# App Engine クイックスタート

<walkthrough-test-start-page url="/getting-started?tutorial=java_gae_quickstart_2"/>

<walkthrough-tutorial-url url="https://cloud.google.com/appengine/docs/java/quickstart"/>

<walkthrough-watcher-constant key="repo-url" value="https://github.com/GoogleCloudPlatform/appengine-try-java" />

<walkthrough-watcher-constant key="repo-name" value="appengine-try-java"/>

## はじめに

このチュートリアルでは、Maven App Engine Plugin を使用して、サンプルの [Java][java] アプリケーションを Google
App Engine にデプロイする方法を紹介します。

手順は次のとおりです。

*   **「Hello, world!」アプリケーションをビルドし、実行する**

    ブラウザで Google Cloud Shell を使用してアプリケーションを実行する方法を学習します。 最後に、Maven App Engine
    Plugin を使用してアプリケーションをウェブにデプロイします。

*   **アプリケーションをデプロイした後**

    このアプリケーションは実際に動作するので、デプロイした後でテストに使用できます。このアプリケーションを削除して、ゼロから始めても構いません。

[Java is a registered trademark of Oracle and/or its affiliates.](walkthrough://footnote)

<walkthrough-devshell-precreate/>

## プロジェクトの設定

アプリケーションをデプロイするには、まずプロジェクトを作成します。

Google Cloud Platform では、プロジェクトを使ってリソースがをプロジェクトとして整理します。 これにより、すべての関連リソースを 1
つのアプリケーションにまとめることができます。

<walkthrough-project-setup/>

## Google Cloud Shell の使用

Cloud Shell はコンソール用の組み込みコマンドライン ツールです。 Cloud Shell を使用して、アプリケーションをデプロイします。

## Google Cloud Shell を開く

コンソール上部のナビゲーション バーで <walkthrough-cloud-shell-icon/>
[icon](walkthrough://spotlight-pointer?spotlightId=devshell-activate-button)
の順にクリックして、Cloud Shell を開きます。

### サンプルコードのクローンを作成する

Cloud Shell を使用して「Hello World」コードのクローンを作成し、このクローンに移動します。 サンプルコードのクローンは、プロジェクト
レポジトリから Cloud Shell に作成されます。

注: ディレクトリがすでに存在する場合は、クローンを作成する前に以前のファイルを削除します。

```bash
rm -rf {{repo-name}}
```

Cloud Shell で次のように入力します。

```bash
git clone {{repo-url}}
```

その後、チュートリアルのディレクトリに移動します。

```bash
cd {{repo-name}}
```

## デプロイの設定

現在、サンプルコードのメイン ディレクトリにいます。 アプリケーションを構成するファイルを見てみます。

### アプリケーションのコードを確認する

次のコマンドを入力してアプリケーション コードを表示します。

```bash
cat src/main/java/myapp/DemoServlet.java
```

このサーブレットは、「`Hello, world!」というメッセージを含むレスポンスを送信することで、リクエストに応答します。

### 構成を確認する

Java の場合、Google App Engineは XML ファイルを使用してデプロイの構成を指定します。

次のコマンドを入力して構成ファイルを表示します。

```bash
cat pom.xml
```

`「helloworld」` アプリケーションは Maven を使用します。つまり、プロジェクトをビルドするために Maven によってが使用するプロジェクト
オブジェクト モデル（POM）を指定する必要があります。POM にはプロジェクトと構成の詳細情報が含まれます。

## アプリケーションのテスト

### Cloud Shell でアプリケーションをテストする

Cloud Shell
を使用すると、ローカルマシンでデバッグを行うのと同じように、アプリケーションをデプロイする前にテストして、意図したとおりに動作するか確認できます。

アプリケーションをテストするには次のコマンドを入力します。

```bash
mvn appengine:run
```

<walkthrough-test-code-output
  text="module .* running at|Dev App Server is now running" />

### [ウェブでプレビュー] でアプリケーションをプレビューする

現在、アプリケーションは Cloud Shell 上で動作しています。 [ウェブでプレビュー] <walkthrough-web-preview-icon/>
を使用してポート 8080 に接続することで、アプリケーションにアクセスできます。
[手順を見る](walkthrough://spotlight-pointer?spotlightId=devshell-web-preview-button)

### 以前のインスタンスを終了する

Cloud Shell で `Ctrl+C キーを押して、アプリケーションのインスタンスを終了します。

## Google App Engine へのデプロイ

### アプリケーションを作成する

アプリケーションをデプロイするには、リージョン内にアプリケーションを作成する必要があります。

```bash
gcloud app create
```

注: すでにアプリケーションを作成してある場合は、この手順をスキップできます。

### Cloud Shell でデプロイする

Cloud Shell を使用してアプリケーションをデプロイする準備が整いました。

まず、使用するプロジェクトを設定します。

```bash
gcloud config set project {{project-id}}
```

次に、アプリケーションをデプロイします。

```bash
 mvn appengine:deploy
```

<walkthrough-test-code-output text="Deployed (module|service)" />

### アプリケーションにアクセスする

アプリケーションがデプロイされました。 アプリケーションのデフォルトの URL
は、[{{project-gae-url}}](（http://{{project-gae-url}}) です。この URL をクリックしてアクセスします。

### アプリケーションのステータスを表示する

App Engine ダッシュボードでアプリケーションのステータスをモニタリングすることで、アプリケーションの状態を確認できます。 コンソール左側の
[メニュー](walkthrough://spotlight-pointer?spotlightId=console-nav-menu) を開きます。

次に、[**App Engine**] セクションを選択します。

<walkthrough-menu-navigation sectionId="APPENGINE_SECTION"/>

## まとめ

<walkthrough-conclusion-trophy/>

これで完了です。 App Engine アプリケーションが正常にデプロイされました。 次の手順は以下のとおりです。

**Google Cloud SDK をダウンロードし、ローカルで開発する**

[Google Cloud SDK][cloud-sdk-installer]

**次のアプリケーションをビルドする**

他の Google Cloud Platform プロダクトで App Engine を使用する方法をご確認ください。

<walkthrough-tutorial-card
  url="appengine/docs/java/datastore/"
  icon="DATASTORE_SECTION"
  label="datastore">
**Cloud Datastore の使用方法**
Cloud Datastore はアプリケーション向けの拡張性の高い NoSQL データベースです。
</walkthrough-tutorial-card>

<walkthrough-tutorial-card
  url="appengine/docs/java/googlecloudstorageclient/setting-up-cloud-storage/"
  icon="STORAGE_SECTION"
  label="cloudStorage">
**Cloud Storage の使用方法**
Cloud Storage は強力かつシンプルなオブジェクト ストレージ サービスです。
</walkthrough-tutorial-card>

[java]: https://java.com/
[cloud-sdk-installer]: https://cloud.google.com/sdk/downloads#interactive
