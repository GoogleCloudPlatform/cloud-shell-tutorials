# Cloud Storage クイックスタート

## Google Cloud Storage へようこそ

<walkthrough-tutorial-url url="https://cloud.google.com/storage/docs/quickstart-console"></walkthrough-tutorial-url>

Google Cloud Storage は、非構造化オブジェクトに対する、強力でコスト効果の高いストレージ ソリューションです。ライブ ウェブ コンテンツのホスティングから、分析のためのデータ保管、アーカイブやバックアップまで、あらゆる目的に最適です。

このチュートリアルでは、Cloud Storage にオブジェクトを簡単に保存できることを説明します。手順は次のとおりです。

  *  **バケットの作成**

     バケットには、Cloud Storage に保存するオブジェクト（任意の種類のファイル）が保持されます。

  *  **オブジェクトのアップロードと共有**

     バケットを使用するには、まずオブジェクトをアップロードして一般公開します。

  *  **クリーンアップ**

     最後に、このチュートリアルで作成したバケットとオブジェクトを削除します。

最後にバケットとオブジェクトを削除するため、このチュートリアルを試すことによって課金される心配はありません。

## プロジェクトのセットアップ

Cloud Storage にはリソースを作成するためのプロジェクトが必要です。

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## バケットの作成

Cloud Storage では、オブジェクトをバケットに格納します。バケットを作成するには、Cloud Storage ブラウザに移動する必要があります。

コンソールの左側にある[メニュー][spotlight-menu]を開きます。

次に、[**Storage**] セクションを選択します。

<walkthrough-menu-navigation sectionid="STORAGE_SECTION"></walkthrough-menu-navigation>

## バケットの作成

オブジェクトのアップロードを開始する前に、オブジェクトを格納するための「バケット」を作成する必要があります。バケットは、オブジェクトを整理し、オブジェクトへのアクセスを制御するのに役立ちます。

  1. [[バケットを作成](walkthrough://spotlight-pointer?cssSelector=#p6ntest-cloudstorage-create-first-bucket-button,)] をクリックします。

  1. バケット作成ページで、バケットのプロパティを指定します。次の点に注意してください。

     *  **名前:** 固有の名前を付けてください。Cloud Storage の別のバケット名と同じ名前を入力するとエラーが表示されます。
     *  **デフォルトのストレージ クラス:** これはデフォルトでバケットのオブジェクトに割り当てられるストレージ クラスです。選択肢は、主にオブジェクトへのアクセス頻度とデータを世界各地で処理するかどうかに応じて決まります。ストレージ クラスはコストに影響します。
     *  **ロケーション:** データにアクセスするアプリケーションやユーザーの近くにデータを配置する必要があります。使用可能な選択肢は、ストレージ クラスの選択によって異なります。

このチュートリアルでは、最後にバケットを削除するため、どのストレージ クラスとロケーションでも問題はありません。

  1. [[作成][spotlight-create-button]] をクリックします。

## オブジェクトのアップロード

バケットが作成されたので、オブジェクトをアップロードできます。

  1. ページ上部の [[ファイルをアップロード][spotlight-upload-file]] をクリックします。

  1. アップロードするファイルを選択します。任意の種類のファイルをアップロードできます。

     ファイルがない場合は、[サンプル ファイルを作成し][create-sample-file]、ページ上部の [[バケットを更新][spotlight-refresh-bucket]] をクリックしてバケットに表示します。（ヒント: オブジェクトをバケット名の下のスペースにドラッグ＆ドロップしてアップロードすることもできます）。

## バケットの削除

作成したバケットを削除しましょう。バケットを削除すると、そのコンテンツも削除されます。

  1. テーブルの上部にある [[バケット][spotlight-buckets-link]] をクリックして、バケットのリストに戻ります。

  1. バケットの横にあるチェックボックスをオンにします。このプロジェクトに他のバケットがあり、自分のバケットを検索する必要がある場合は、検索バーを使用してバケットリストをフィルタリングします。

  1. ページの上部にある [[削除][spotlight-delete-buckets]] をクリックし、削除を確認します。

## まとめ

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

これで完了です。

Cloud Storage にオブジェクトを格納する方法について理解しました。[静的なウェブサイトをホスト](https://cloud.google.com/storage/docs/hosting-static-website)して実際の使用に移す方法を学ぶことができます。

または、[gsutil コマンドライン ツール](https://cloud.google.com/storage/docs/quickstart-gsutil)で Cloud Storage を使用する方法を学んでください。

Cloud Storage やその他の GCP サービスを[無料](https://cloud.google.com/free)でご利用いただける方法を紹介します。

[create-sample-file]: walkthrough://create-sample-storage-file
[spotlight-buckets-link]: walkthrough://spotlight-pointer?cssSelector=.p6n-cloudstorage-path-link
[spotlight-create-bucket]: walkthrough://spotlight-pointer?cssSelector=#p6ntest-cloudstorage-create-first-bucket-button,#p6n-cloudstorage-create-bucket
[spotlight-create-button]: walkthrough://spotlight-pointer?cssSelector=#p6ntest-gcs-create-bucket-button
[spotlight-delete-buckets]: walkthrough://spotlight-pointer?spotlightId=gcs-action-bar-delete-bucket
[spotlight-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-public-link]: walkthrough://spotlight-pointer?cssSelector=.p6n-cloudstorage-browser-public-label
[spotlight-refresh-bucket]: walkthrough://spotlight-pointer?spotlightId=gcs-action-bar-refresh-objects
[spotlight-share-public]: walkthrough://spotlight-pointer?cssSelector=.p6n-cloudstorage-browser-public-checkbox
[spotlight-upload-file]: walkthrough://spotlight-pointer?spotlightId=gcs-action-bar-upload-file
