# App Engine のクイックスタート

<walkthrough-tutorial-url url="https://cloud.google.com/appengine/docs/python/quickstart"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="https://github.com/GoogleCloudPlatform/python-docs-samples" key="repo-url"></walkthrough-watcher-constant>
<walkthrough-watcher-constant value="python-docs-samples/appengine/standard/hello_world" key="repo-dir"></walkthrough-watcher-constant>

## はじめに

このチュートリアルでは、`gcloud` コマンドを使用してサンプルの [Python](https://python.org/) アプリケーションを Google App Engine にデプロイする方法を紹介します。

手順は次のとおりです。

  *  **プロジェクトの作成**

     プロジェクトによりコード、VM、その他のリソースが 1 つにまとめられるため、開発とモニタリングが簡単になります。

  *  **「Hello, world!」アプリのビルドと実行**

     ブラウザで Google Cloud Shell を使用してアプリを実行する方法について説明します。最後に `gcloud` コマンドを使用してアプリをウェブにデプロイします。

  *  **チュートリアルの後**

     アプリが完成したら、デプロイ後に使用できるようになります。また、アプリを削除して最初から作成することもできます。

[「Python」および Python のロゴは、Python Software Foundation の商標または登録商標です。](walkthrough://footnote)

## プロジェクトのセットアップ

アプリケーションをデプロイするには、最初にプロジェクトを作成する必要があります。

Google Cloud Platform がリソースを整理してプロジェクトに格納します。これによって、1 つのアプリケーションの関連リソースすべてを 1 か所にまとめることができます。

<walkthrough-devshell-precreate></walkthrough-devshell-precreate>

<walkthrough-project-setup></walkthrough-project-setup>

## Google Cloud Shell の使用

Cloud Shell はコンソールに組み込まれたコマンドライン ツールです。Cloud Shell を使用してアプリをデプロイします。

### Google Cloud Shell を開く

コンソールの上部にあるナビゲーション バーの<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[アイコン][spotlight-open-devshell]をクリックして、Cloud Shell を開きます。

### サンプルコードのクローンを作成する

Cloud Shell を使ってクローンし、「Hello World」コードに移動します。プロジェクトのレポジトリから Cloud Shell にサンプルコードのクローンが作成されます。

注: ディレクトリがすでに存在する場合は、クローン作成の前に以前のファイルを削除します。

Cloud Shell で、次のように入力します。

```bash
git clone {{repo-url}}
```

次に、チュートリアル ディレクトリに切り替えます。

```bash
cd {{repo-dir}}
```

## デプロイの構成

現時点のディレクトリはサンプルコードのメイン ディレクトリです。ここでは、アプリケーションの構成ファイルを確認します。

### アプリケーションを確認する

次のコマンドを入力して、アプリケーション コードを表示します。

```bash
cat main.py
```

このアプリケーションは、[webapp2](https://webapp2.readthedocs.io/) ウェブ フレームワークを使用するシンプルな Python アプリケーションです。この Python スクリプトはリクエストに対して、HTTP ヘッダーとメッセージ `Hello, World!` で応答します。

### 構成の確認

Google App Engine は YAML ファイルを使用してデプロイの構成を指定します。
`app.yaml` ファイルには、ランタイム環境や URL ハンドラなど、アプリケーションに関する情報が含まれています。

次のコマンドを入力して、構成ファイルを表示してください。

```bash
cat app.yaml
```

この構成ファイルでは、上から下の順に、アプリケーションに関する次の情報が記述されています。

  *  このコードは `python` ランタイム環境で実行されます。
  *  このアプリケーションは `threadsafe` です。そのため、1 つのインスタンスで複数のリクエストを同時に処理できます。スレッドセーフは先進的な機能であるため、アプリケーションがスレッドセーフに対応するよう適切に設計されていない場合、動作にエラーが生じることがあります。
  *  パスが正規表現 `/.*`（すべての URL）に合致する場合、その URL に対するリクエストはすべて、`main` Python モジュールの app オブジェクトで処理されます。

このファイルの構文は [YAML](http://www.yaml.org) です。構成オプションの全リストについては、[`app.yaml リファレンス`][app-yaml-reference]をご覧ください。

## アプリをテストする

### Cloud Shell でアプリをテストする

Cloud Shell では、ローカルマシンのデバッグと同じように、アプリが意図しているとおりに動作しているか確認するため、デプロイ前にテストできます。

アプリをテストするには、次のように入力します。

```bash
dev_appserver.py $PWD
```

### 「ウェブでプレビュー」でアプリをプレビューする

アプリは現在 Cloud Shell 上で実行されています。[[ウェブでプレビュー][spotlight-web-preview]] <walkthrough-web-preview-icon></walkthrough-web-preview-icon>を使用してポート 8080 に接続することでアプリにアクセスできます。

### プレビュー インスタンスの終了

Cloud Shell で `Ctrl+C` キーを押して、アプリケーションのインスタンスを終了します。

## Google App Engine へのデプロイ

### アプリケーションの作成

アプリをデプロイするには、リージョン内にアプリを作成する必要があります。

```bash
gcloud app create
```

注: すでにアプリを作成している場合は、この手順をスキップできます。

### Cloud Shell を使ってデプロイする

Cloud Shell を使用してアプリをデプロイできます。アプリをデプロイするには、次のように入力します。

```bash
gcloud app deploy app.yaml --project {{project-id}}
```

### アプリにアクセスする

これで、アプリがデプロイされました。アプリのデフォルト URL は [{{project-gae-url}}](http://{{project-gae-url}}) です。URL をクリックしてアプリにアクセスしてください。

### アプリのステータスを表示する

アプリのステータスは、App Engine のダッシュボードで確認できます。

コンソールの左側にある[メニュー][spotlight-console-menu]を開きます。

次に、[**App Engine**] セクションを選択します。

<walkthrough-menu-navigation sectionid="APPENGINE_SECTION"></walkthrough-menu-navigation>

## まとめ

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

App Engine アプリケーションが正常にデプロイされました。

次に進めるステップをいくつかご紹介します。

**Google Cloud SDK のダウンロードとローカルでの開発**

ローカルマシンに [Google Cloud SDK][cloud-sdk-installer] をインストールします。

**次のアプリケーションのビルド**

他の Google Cloud Platform プロダクトで App Engine を使用する方法について学びます。

<walkthrough-tutorial-card label="django" url="python/django/appengine" icon="APPENGINE_SECTION">
  **Django の実行**
  App Engine で動作する Django アプリを開発します。
</walkthrough-tutorial-card>

<walkthrough-tutorial-card label="datastore" url="appengine/docs/python/datastore/" icon="DATASTORE_SECTION">
  **Cloud Datastore の使用について学ぶ**
  Cloud Datastore はアプリケーション向けのスケーラビリティの高い NoSQL データベースです。
</walkthrough-tutorial-card>

[app-yaml-reference]: https://cloud.google.com/appengine/docs/standard/python/config/appref
[cloud-sdk-installer]: https://cloud.google.com/sdk/downloads#interactive
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-web-preview]: walkthrough://spotlight-pointer?spotlightId=devshell-web-preview-button
