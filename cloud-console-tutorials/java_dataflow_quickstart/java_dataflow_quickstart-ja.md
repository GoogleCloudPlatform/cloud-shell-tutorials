# Dataflow 単語数カウント チュートリアル

<walkthrough-tutorial-url url="https://cloud.google.com/dataflow/docs/quickstarts/quickstart-java-maven"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="dataflow-intro" key="directory"></walkthrough-watcher-constant>
<walkthrough-watcher-constant value="dataflow-intro" key="job-name"></walkthrough-watcher-constant>

## はじめに

このチュートリアルでは、Java を使用して簡単なサンプル パイプラインを実行し、Cloud Dataflow サービスの基本を学習します。

Dataflow のパイプラインは、**バッチ（ファイルやデータベース テーブルのような境界のある入力の処理）または**ストリーミング（Cloud Pub/Sub のようなソースからの境界のない入力の処理）のいずれかです。このチュートリアルの例は、シェイクスピアの作品集の中の単語数を数えるバッチ パイプラインです。

開始する前に、Cloud Platform プロジェクトの前提条件を確認し、初期設定を行う必要があります。

## プロジェクトのセットアップ

Google Cloud Platform がリソースを整理してプロジェクトに格納します。これによって、1 つのアプリケーションの関連リソースすべてを 1 か所にまとめることができます。

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>
<walkthrough-project-permissions permissions="dataflow.jobs.create"></walkthrough-project-permissions>

## Cloud Dataflow を設定する

Dataflow を使用するには、Cloud Dataflow API を有効にして、Cloud Shell を開きます。

### Google Cloud API を有効にする

<walkthrough-enable-apis apis="compute.googleapis.com,dataflow,cloudresourcemanager.googleapis.com,logging,storage_component,storage_api,bigquery,pubsub">
</walkthrough-enable-apis>

### Cloud Shell を開く

Cloud Shell はコンソールに組み込まれたコマンドライン ツールです。ここでは、Cloud Shell を使用してアプリをデプロイします。

コンソールの上部にあるナビゲーション バーの<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[アイコン][spotlight-open-devshell]をクリックして、Cloud Shell を開きます。

## Cloud Dataflow のサンプルを Cloud Shell にインストールする

Cloud Dataflow SDK for Java を使用するには、開発環境に Java、Google Cloud SDK、Cloud Dataflow SDK for Java、Apache Maven をインストールして、SDK の依存関係を管理する必要があります。このチュートリアルでは、Java、Google Cloud SDK、Maven がすでにインストールされている Cloud Shell を使用します。

または、[ローカルマシン][dataflow-java-tutorial]でこのチュートリアルを実行することもできます。

### Maven コマンドを使用して、サンプルと Cloud Dataflow SDK for Java をダウンロードする

このコマンドを実行すると、Maven によって、適切なバージョンの Cloud Dataflow SDK をダウンロードするためのプロジェクト構造と構成ファイルが作成されます。

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

  *  `archetypeArtifactId` と `archetypeGroupId` は、サンプル プロジェクト構造を定義するために使用されます。
  *  `groupId` は、組織の Java パッケージ名接頭辞です（例: `com.mycompany`）。
  *  `artifactId` は、作成された jar ファイルの名前を設定します。このチュートリアルでは、デフォルト値（`{{directory}}`）を使用します。

Cloud Shell で Maven コマンドを実行します。

### ディレクトリの移動

作業ディレクトリを `{{directory}}` に変更します。

```bash
cd {{directory}}
```

この例のコードを確認したい場合は、`{{directory}}` ディレクトリの `src` サブディレクトリにあります。

## Cloud Storage バケットを設定する

Cloud Dataflow は、Cloud Storage バケットを使用して出力データを格納し、パイプライン コードをキャッシュします。

### gsutil mb を実行する

Cloud Shell で、コマンド `gsutil mb` を使用して Cloud Storage バケットを作成します。

```bash
gsutil mb gs://{{project-id-no-domain}}
```

`gsutil` ツールの詳細については、[ドキュメント][gsutil-docs]をご覧ください。

## パイプラインを作成し、起動する

Cloud Dataflow では、データ処理作業は**パイプラインで表されます。パイプラインは入力データを読み込み、そのデータを変換してから、出力データを生成します。パイプラインによる変換には、データのフィルタリング、グループ化、比較、結合などがあります。

この例のコードを確認したい場合は、`{{directory}}` ディレクトリの `src` サブディレクトリにあります。

### Dataflow サービスでパイプラインを起動する

Apache Maven の `mvn exec` コマンドを使用して、サービス上でパイプラインを起動します。実行中のパイプラインは**ジョブと呼ばれます。

```bash
mvn compile exec:java \
  -Dexec.mainClass=com.example.WordCount \
  -Dexec.args="--project={{project-id}} \
  --stagingLocation=gs://{{project-id-no-domain}}/staging/ \
  --output=gs://{{project-id-no-domain}}/output \
  --runner=DataflowRunner \
  --jobName={{job-name}}"
```

  *  `stagingLocation` は、Cloud Dataflow がパイプラインを実行するためのバイナリやその他のデータに使用するストレージ バケットです。この場所は複数のジョブで共有できます。
  *  `output` は、ジョブ結果を格納するために WordCount の例で使用されるバケットです。

### ジョブを実行する

これで終了です。バイナリは作成したストレージ バケットにステージングされ、Compute Engine インスタンスが作成されています。Cloud Dataflow は入力ファイルを分割し、データを複数のマシンで並列処理できるようにします。

注: 「ジョブが完了しました」というメッセージが表示されたら、Cloud Shell を閉じることができます。

生成した Maven プロジェクトをクリーンアップする場合は、Cloud Shell で `cd .. && rm -R {{directory}}` を実行してディレクトリを削除します。

## ジョブをモニタリングする

Cloud Dataflow Monitoring UI ページでパイプラインの進行状況を確認します。

### Cloud Dataflow ページを開く

コンソールの左側にある[メニュー][spotlight-console-menu]を開きます。

次に、[**Dataflow**] セクションを選択します。

<walkthrough-menu-navigation sectionid="DATAFLOW_SECTION"></walkthrough-menu-navigation>

### ジョブを選択する

ジョブをクリックして、詳細を表示します。

### パイプラインの詳細と指標を詳しく見る

左側のパイプラインと右側のジョブ情報を詳しく見てみましょう。詳しいジョブ ステータスを表示するには、[ログ][spotlight-job-logs]をクリックします。パイプライン内のステップをクリックして、指標を表示してください。

ジョブが完了すると、ジョブ ステータスが変化し、このジョブで使用される Compute Engine インスタンスが自動的に停止します。

## 出力の表示

ジョブを実行したので、Cloud Storage 内の出力ファイルを確認できます。

### Cloud Storage ページに移動

コンソールの左側にある[メニュー][spotlight-console-menu]を開きます。

次に、[**Storage**] セクションを選択します。

<walkthrough-menu-navigation sectionid="STORAGE_SECTION"></walkthrough-menu-navigation>

### Storage バケットに移動

バケットのリストで、前に作成したバケットを選択します。推奨された名前を使用した場合は、`{{project-id}}` という名前になります。

このバケットには、ステージング フォルダと出力フォルダが含まれています。Dataflow は出力を分割して保存するため、バケットには複数の出力ファイルが含まれます。

## クリーンアップ

Cloud Storage の使用に対して課金されないようにするために、作成したバケットは削除してください。

### バケット ブラウザに戻る

[[バケット][spotlight-buckets-link]] リンクをクリックします。

### バケットを選択する

作成したバケットの横にあるボックスをオンにします。

### バケットを削除する

[[削除][spotlight-delete-bucket]] をクリックして、削除を確認します。

## まとめ

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

次にできる操作:

  *  [単語数カウントの例の詳細を確認する][wordcount]
  *  [Cloud Dataflow プログラミング モデルについて学習する][df-model]
  *  [GitHub で Cloud Dataflow SDK を見る][df-sdk]

ローカル環境の設定:

  *  [Eclipse を使用して Dataflow を実行する][df-eclipse]
  *  [Python を使用して Dataflow を実行する][df-python]

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
