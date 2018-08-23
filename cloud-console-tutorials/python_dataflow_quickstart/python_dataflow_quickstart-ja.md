# Dataflow 単語数カウント チュートリアル

<walkthrough-tutorial-url url="https://cloud.google.com/dataflow/docs/quickstarts/quickstart-python"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="dataflow-intro" key="directory"></walkthrough-watcher-constant>
<walkthrough-watcher-constant value="dataflow-intro" key="job-name"></walkthrough-watcher-constant>

## はじめに

このチュートリアルでは、Python を使用した簡単なサンプル パイプラインを実行することにより、Cloud Dataflow サービスの基礎を学びます。

Dataflow のパイプラインは、バッチ**（ファイルやデータベース テーブルのような制限付きの入力の処理）またはストリーミング**（Cloud Pub/Sub のようなソースからの制限なしの入力の処理）です。このチュートリアルの例は、シェイクスピアの一連の作品の単語数を数えるバッチ パイプラインです。

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

Python バージョンの Cloud Dataflow を使用するには、Python、Google Cloud SDK、Cloud Dataflow SDK for Python がインストールされている開発環境が必要です。また、Cloud Dataflow は、Python のパッケージ マネージャである pip を使用して、SDK の依存関係を管理します。

このチュートリアルでは、Python と pip がすでにインストールされている Cloud Shell を使用します。必要に応じて、このチュートリアルを[ローカルマシン上で][dataflow-python-tutorial]行うこともできます。

### pip コマンドを使用してサンプルと Cloud Dataflow SDK for Python をダウンロードする

このコマンドを実行すると、適切なバージョンの Cloud Dataflow SDK がダウンロードされて、インストールされます。

```bash
pip install --user google-cloud-dataflow```

Cloud Shell で pip コマンドを実行します。

## Cloud Storage バケットを設定する

Cloud Dataflow は、Cloud Storage バケットを使用して出力データを格納し、パイプライン コードをキャッシュに保存します。

### gsutil mb を実行する

Cloud Shell で、コマンド `gsutil mb` を使用して Cloud Storage バケットを作成します。

```bash
gsutil mb gs://{{project-id-no-domain}}```

`gsutil` ツールの詳細については、[ドキュメント][gsutil-docs]をご覧ください。

## パイプラインを作成し、起動する

Cloud Dataflow では、データ処理作業はパイプラインで**表されます。パイプラインは入力データを読み込み、そのデータを変換してから、出力データを生成します。パイプラインによる変換には、データのフィルタリング、グループ化、比較、結合などがあります。

### Dataflow サービスでパイプラインを起動する

Python を使用して、Cloud Dataflow サービスでパイプラインを起動します。実行中のパイプラインはジョブと呼ばれます。**

```bash
python -m apache_beam.examples.wordcount \
  --project {{project-id}} \
  --runner DataflowRunner \
  --temp_location gs://{{project-id-no-domain}}/temp \
  --output gs://{{project-id-no-domain}}/results/output \
  --job_name {{job-name}}
```

  *  `output` は、ジョブ結果を格納するために WordCount の例で使用されるバケットです。

### ジョブを実行する

これで、以前に作成したストレージ バケットにバイナリがステージングされ、Compute Engine インスタンスが作成されました。Cloud Dataflow によって入力ファイルが分割され、複数のマシンでデータを並列に処理できるようになります。

注: 「JOB_STATE_DONE」というメッセージが表示されたら、Cloud Shell を閉じることができます。

## ジョブをモニタリングする

Cloud Dataflow ページでパイプラインの進行状況を確認します。

### Cloud Dataflow Monitoring UI ページに移動する

まだ移動していない場合は、Cloud Dataflow Monitoring UI ページに移動します。

コンソールの左側にある[メニュー][spotlight-console-menu]を開きます。

次に、[**Dataflow**] セクションを選択します。

<walkthrough-menu-navigation sectionid="DATAFLOW_SECTION"></walkthrough-menu-navigation>

### ジョブを選択する

ジョブをクリックして、詳細を表示します。

### パイプラインの詳細と指標を詳しく見る

左側のパイプラインと右側のジョブ情報を詳しく見てみましょう。詳しいジョブ ステータスを表示するには、[[ログ][spotlight-job-logs]] をクリックします。パイプライン内のステップをクリックして、指標を表示してください。

ジョブが完了すると、ジョブ ステータスが変化し、このジョブで使用される Compute Engine インスタンスが自動的に停止します。

## 出力の表示

ジョブを実行したので、Cloud Storage 内の出力ファイルを確認できます。

### Cloud Storage ページに移動

コンソールの左側にある[メニュー][spotlight-console-menu]を開きます。

次に、[**Compute Engine**] セクションを選択します。

<walkthrough-menu-navigation sectionid="STORAGE_SECTION"></walkthrough-menu-navigation>

### Storage バケットに移動

バケットのリストで、前に作成したバケットを選択します。推奨された名前を使用した場合は、`{{project-id}}` という名前になります。

このバケットにはステージング フォルダと出力フォルダが含まれています。Dataflow は出力を分割して保存するため、バケットには複数の出力ファイルが含まれます。

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
  *  [Cloud Dataflow プログラミング モデルについて学習する][df-pipelines]
  *  [GitHub で Apache Beam SDK を探す][beam-sdk]

ローカル環境の設定:

  *  [Java と Eclipse を使用して Dataflow を実行する][df-eclipse]
  *  [Java と Maven を使用して Dataflow を実行する][df-maven]

[beam-sdk]: https://github.com/apache/beam/tree/master/sdks/python
[dataflow-python-tutorial]: https://cloud.google.com/dataflow/docs/quickstarts/quickstart-python
[df-eclipse]: https://cloud.google.com/dataflow/docs/quickstarts/quickstart-java-eclipse
[df-maven]: https://cloud.google.com/dataflow/docs/quickstarts/quickstart-java-maven
[df-pipelines]: https://cloud.google.com/dataflow/model/programming-model-beam
[gsutil-docs]: https://cloud.google.com/storage/docs/gsutil
[spotlight-buckets-link]: walkthrough://spotlight-pointer?cssSelector=.p6n-cloudstorage-path-link
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-delete-bucket]: walkthrough://spotlight-pointer?cssSelector=#p6n-cloudstorage-delete-buckets
[spotlight-job-logs]: walkthrough://spotlight-pointer?cssSelector=#p6n-dax-job-logs-toggle
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[wordcount]: https://beam.apache.org/get-started/wordcount-example/
