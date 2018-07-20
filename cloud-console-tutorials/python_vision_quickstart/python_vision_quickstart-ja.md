# Cloud Vision API

<walkthrough-test-start-page url="/start?tutorial=python_vision_quickstart_v2"></walkthrough-test-start-page>

<walkthrough-tutorial-url url="https://cloud.google.com/vision/docs/label-tutorial"></walkthrough-tutorial-url>

<walkthrough-watcher-constant value="https://github.com/GoogleCloudPlatform/python-docs-samples.git" key="repo-url"></walkthrough-watcher-constant>

<walkthrough-watcher-constant value="python-docs-samples" key="repo-name"></walkthrough-watcher-constant>

<walkthrough-devshell-precreate></walkthrough-devshell-precreate>

## はじめに

このチュートリアルでは、`LABEL_DETECTION` リクエストを使用する基本的な Vision API
アプリケーションの作成を順を追って説明します。`LABEL_DETECTION`
リクエストは、画像にラベル（タグともいいます）でアノテーションを付けるものですが、このラベルは画像の内容に基づいて選択されます。たとえば、納屋の写真からは「納屋」、「農場」などのアノテーションが生成されます。

手順は次のとおりです。

*   **ラベル検出アプリを実行する** ブラウザで Google Cloud Shell を使用してアプリを実行する方法について説明します。
*   **アプリの作業が終了したら... ** アプリが完成したら、テストできるようになります。また、アプリを削除して最初から作成することもできます。

[「Python」および Python のロゴは、Python Software Foundation
の商標または登録商標です。](walkthrough://footnote)

# プロジェクトのセットアップ

プロジェクトを通じて Cloud Vision API を有効にする必要があります。

Google Cloud Platform がリソースを整理してプロジェクトに格納します。これによって、1 つのアプリケーションの関連リソースすべてを 1
か所にまとめることができます。

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## Vision API の有効化

リクエストを受け入れるには、プロジェクトで Vision API を有効にする必要があります。

### API Manager に移動する

API Manager ではプロジェクトで有効にする API を設定できます。

コンソール左側の
[メニュー](walkthrough://spotlight-pointer?spotlightId=console-nav-menu) を開きます。

次に、[**API とサービス**] セクションを選択します。

<walkthrough-menu-navigation sectionid="API_SECTION"></walkthrough-menu-navigation>

### 使用可能な API を表示する

API を有効にするには、
[[API を有効にする](walkthrough://spotlight-pointer?cssSelector=.p6n-action-bar-button)
ボタンをクリックします。

### Vision API を選択する

[Vision API](walkthrough://spotlight-pointer?spotlightId=api-vision.googleapis.com) リンクをクリックします。

### Vision API を有効にする

Vision API を有効にするには、[[有効にする](walkthrough://spotlight-pointer?spotlightId=api-enable-vision.googleapis.com)]
ボタンをクリックします。このチュートリアルの後半で、プロジェクトの認証情報を作成します。

## Google Cloud Shell の使用

Cloud Shell はコンソールに組み込まれたコマンドライン ツールです。ここでは、Cloud Shell を使用してアプリを実行します。

### Google Cloud Shell を開く

コンソールの上部にあるナビゲーション
バーの<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>
[アイコン](walkthrough://spotlight-pointer?spotlightId=devshell-activate-button)
をクリックして、Cloud
Shell を開きます。

### サンプルコードのクローンを作成する

Cloud Shell を使ってクローンし、「Hello World」コードに移動します。プロジェクトのレポジトリから Cloud Shell
にサンプルコードのクローンが作成されます。

注: ディレクトリがすでに存在する場合は、クローン作成の前に以前のファイルを削除します。

```bash
rm -rf {{repo-name}}
```

サンプル レポジトリのクローンを作成する:

```bash
git clone {{repo-url}}
```

次に、チュートリアル ディレクトリに切り替えます。

```bash
cd {{repo-name}}/vision/cloud-client/quickstart
```

## デプロイの設定

現時点のディレクトリはサンプルコードのメイン ディレクトリです。ここでは、アプリケーションの設定ファイルを確認します。

### アプリケーションを確認する

次のコマンドを入力して、アプリケーション コードを表示します。

```bash
cat quickstart.py
```

`quickstart.py`
ファイルは、リクエストの種類やコンテンツなどのリクエスト情報をフォーマットします。以下の各セクションを展開して詳細を確認してください。

Vision API に対するリクエストは、JSON オブジェクトとして作成します。このようなリクエストの具体的な構造の詳しい情報については、[Vision
API リファレンス][vision-request-doc]をご覧ください。JSON リクエストは `execute`
を呼び出した場合にのみ送信されます。このパターンを利用すると、このようなリクエストを順に渡して `execute` を必要なときに呼び出すことができます。

## アプリケーションのテスト

この API を使用するには、認証情報を設定する必要があります。Cloud API
を使用するには、アプリケーションに適した[認証情報][auth-doc]の設定が必要になります。これにより、アプリケーションはサービスに対してアプリケーション自体の
ID を認証し、タスクを実行するための承認を取得できるようになります。その後、サンプル画像を使用して API をテストします。

### サービス アカウントを作成する

API リクエストを認証するには、サービス アカウントを作成する必要があります。サービス アカウントをすでに作成している場合は、それが再利用されます。

```bash
gcloud iam service-accounts create vision-quickstart
```

### 認証情報を作成する

次に、サービス アカウント キーを作成し、それをデフォルトの認証情報として設定します。

```bash
gcloud iam service-accounts keys create key.json --iam-account    vision-quickstart@{{project-id}}.iam.gserviceaccount.com
```

```bash
export GOOGLE_APPLICATION_CREDENTIALS=key.json
```

<walkthrough-test-code-output text="created key"></walkthrough-test-code-output>

### アプリをテストする

サンプル画像を使用してアプリをテストするには、次のように入力します。

```bash
python quickstart.py
```

画像リソース `resources/wakeupcat.jpg` がソースで指定されています（[画像を表示][cat-picture]）。

## まとめ

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Cloud Vision API を使用する準備ができました。

次にできる操作:

*   [顔検出][face-tutorial]のチュートリアルを参照する。
*   [ドキュメント テキスト][document-text-tutorial]のチュートリアルを試す。
*   [サンプル アプリケーション][vision-samples]を確認する。
*   [Google Cloud SDK][get-cloud-sdk] をダウンロードしてローカルマシンで実行する。

[auth-doc]: https://cloud.google.com/vision/docs/auth
[cat-picture]: https://raw.githubusercontent.com/GoogleCloudPlatform/python-docs-samples/master/vision/cloud-client/quickstart/resources/wakeupcat.jpg
[document-text-tutorial]: https://cloud.google.com/vision/docs/fulltext-annotations
[face-tutorial]: https://cloud.google.com/vision/docs/face-tutorial
[get-cloud-sdk]: https://cloud.google.com/sdk/
[vision-request-doc]: https://cloud.google.com/vision/reference/rest
[vision-samples]: https://cloud.google.com/vision/docs/samples
