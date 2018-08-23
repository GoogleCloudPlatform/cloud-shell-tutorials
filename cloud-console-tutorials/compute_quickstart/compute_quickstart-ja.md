# Compute Engine のクイックスタート

## MongoDB を使用した ToDo アプリの構築

<walkthrough-tutorial-duration duration="15"></walkthrough-tutorial-duration>

このクイックスタートでは、Compute Engine を使用して 2 層アプリケーションを作成します。フロントエンド VM で Node.js の Todo
ウェブアプリを実行し、バックエンド VM で MongoDB を実行します。

このチュートリアルの内容:

*   2 つの VM を作成して構成する。
*   ファイアウォール ルールを設定する。
*   SSH を使用して VM にパッケージをインストールする。

## プロジェクトのセットアップ

Google Cloud Platform がリソースを整理してプロジェクトに格納します。これによって、1 つのアプリケーションの関連リソースすべてを 1
か所にまとめることができます。

<walkthrough-project-billing-setup permissions="compute.instances.create"></walkthrough-project-billing-setup>

## Compute Engine への移動

コンソールの左側にある[メニュー][spotlight-console-menu]を開きます。

次に、[**Compute Engine**] セクションを選択します。

<walkthrough-menu-navigation sectionid="COMPUTE_SECTION"></walkthrough-menu-navigation>

## インスタンスの作成

2 つのインスタンスを作成し、アプリケーションのバックエンド サーバーとフロントエンド サーバーとして使用します。

### バックエンド インスタンスを作成する

まず、MongoDB を実行するバックエンド インスタンスを作成します。このサーバーには、ToDo アイテムが格納されます。

[[インスタンスを作成][spotlight-create-instance]] ボタンをクリックします。

*   このインスタンスの[名前][spotlight-instance-name]と[ゾーン][spotlight-instance-zone]を選択します。

*   [f1-micro][spotlight-machine-type] を選択します。これによって課金額が軽減されます。

    *   [料金の詳細を確認する。][pricing]

*   このチュートリアルでは、ブートディスク イメージに [Ubuntu 14.04 LTS][spotlight-boot-disk] を選択します。

*   [ファイアウォール セレクタ][spotlight-firewall]で [**HTTP トラフィックを許可する**]
    を選択します。これにより、アプリケーションにアクセスするためのポート 80（HTTP）が開きます。

*   [[作成][spotlight-submit-create]] ボタンをクリックしてインスタンスを作成します。

注: インスタンスが作成されたら、GCE 価格設定に従って請求先アカウントへの課金が開始します。余分に課金されることがないよう、後でインスタンスを削除します。

### フロントエンド インスタンスを作成する

バックエンド VM の起動中に、Node.js の ToDo アプリケーションを実行するフロントエンド VM を作成します。バックエンド
インスタンスと同じ構成を使用します。

## 設定

データを保存するには、MongoDB データベースをバックエンド インスタンスにインストールします。

テーブル内の [SSH ボタン][spotlight-ssh-buttons]をクリックすると、インスタンスへの SSH セッションが別のウィンドウで開きます。

このチュートリアルでは、Cloud Shell を使用して接続します。Cloud Shell はコンソールに組み込まれたコマンドライン ツールです。

### Cloud Shell を開く

コンソールの上部にあるナビゲーション
バーの<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[アイコン][spotlight-open-devshell]をクリックして、Cloud
Shell を開きます。

### インスタンスの作成が完了するまで待機する

チュートリアルを進める前に、インスタンスの作成が完了している必要があります。上部のナビゲーション
バーから[通知メニュー][spotlight-notification-menu]をクリックすると進捗状況を確認できます。

## バックエンド インスタンスへの接続

### インスタンスに接続する

次のコマンドを入力して、VM に SSH 接続します。Cloud Shell で SSH
を初めて使用する場合は、秘密鍵を作成する必要があります。作成するインスタンスのゾーンと名前を入力します。

```bash
gcloud compute --project "{{project-id}}" ssh --zone <backend-zone> <backend-name>
```

### バックエンド データベースをインストールする

バックエンド インスタンスに SSH 接続されたので、次のコマンドを使用してバックエンド データベースをインストールします。

パッケージを更新して MongoDB をインストールします。続行するかどうかの確認メッセージが表示されたら、「`Y`」と入力します。

```bash
sudo apt-get update
```

```bash
sudo apt-get install mongodb
```

### データベースを実行する

MongoDB サービスは、インストールしたときに開始されました。実行方法を変更するには、停止する必要があります。

```bash
sudo service mongodb stop
```

MongoDB のディレクトリを作成し、ポート 80 で MongoDB サービスをバックグラウンドで実行します。

```bash
sudo mkdir $HOME/db
```

```bash
sudo mongod --dbpath $HOME/db --port 80 --fork --logpath /var/tmp/mongodb
```

その後、`exit` コマンドを使用して SSH セッションを終了します。

```bash
exit
```

## フロントエンド インスタンスへの接続

### フロントエンド VM にウェブアプリをインストールして実行

バックエンド サーバーが実行されている状態で、フロントエンドのウェブ アプリケーションをインストールします。

### インスタンスに接続する

次のコマンドを入力して、VM に SSH 接続します。作成するインスタンスのゾーンと名前を入力します。

```bash
gcloud compute --project "{{project-id}}" ssh --zone <frontend-zone> <frontend-name>
```

### 依存関係をインストールする

フロントエンド インスタンスに接続されたので、パッケージを更新して、git、Node.js、npm
をインストールします。続行を確認するメッセージが表示されたら、「`Y`」と入力します。

```bash
sudo apt-get update
```

```bash
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
```

```bash
sudo apt-get install git nodejs
```

### フロントエンド ウェブアプリをインストールして実行する

サンプル アプリケーションのクローンを作成し、アプリケーションの依存関係をインストールします。

```bash
git clone https://github.com/GoogleCloudPlatform/todomvc-mongodb.git
```

```bash
cd todomvc-mongodb; npm install
```

```bash
sed -i -e 's/8080/80/g' server.js
```

次のコマンドを使用して ToDo ウェブ
アプリケーションを起動し、作成したインスタンスの[内部 IP アドレス][spotlight-internal-ip]を入力します。

```bash
sudo nohup nodejs server.js --be_ip <backend-internal-ip> --fe_ip <frontend-internal-ip> &
```

その後、`exit` コマンドを使用して SSH セッションを終了します。

```bash
exit
```

### アプリケーションの確認

フロントエンド インスタンスの横にある [[外部 IP][spotlight-external-ip]] 列に表示された IP
アドレスでウェブサーバーにアクセスします。

## クリーンアップ

インスタンスを削除するには、インスタンス名の横にある[チェックボックス][spotlight-instance-checkbox]をオンにし、[[削除][spotlight-delete-button]]
ボタンをクリックします。

## まとめ

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

これで手順は完了です。

次にできること:

*   GitHub で Google Cloud Platform
    の[サンプル](http://googlecloudplatform.github.io/)を参照します。

*   [負荷分散](https://cloud.google.com/compute/docs/load-balancing/)の設定方法を学びます。

*   [](https://cloud.google.com/compute/docs/instances/transfer-files/)仮想マシンにファイルを転送する方法を学びます。

*   [コンテナを実行する](https://cloud.google.com/compute/docs/containers)方法を学びます。

[pricing]: https://cloud.google.com/compute/#compute-engine-pricing
[spotlight-boot-disk]: walkthrough://spotlight-pointer?cssSelector=vm-set-boot-disk
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-control-panel]: walkthrough://spotlight-pointer?cssSelector=#p6n-action-bar-container-main
[spotlight-create-instance]: walkthrough://spotlight-pointer?spotlightId=gce-zero-new-vm,gce-vm-list-new
[spotlight-delete-button]: walkthrough://spotlight-pointer?cssSelector=.p6n-icon-delete
[spotlight-external-ip]: walkthrough://spotlight-pointer?cssSelector=.p6n-external-link
[spotlight-firewall]: walkthrough://spotlight-pointer?spotlightId=gce-vm-add-firewall
[spotlight-instance-checkbox]: walkthrough://spotlight-pointer?cssSelector=.p6n-checkbox-form-label
[spotlight-instance-name]: walkthrough://spotlight-pointer?spotlightId=gce-vm-add-name
[spotlight-instance-zone]: walkthrough://spotlight-pointer?spotlightId=gce-vm-add-zone-select
[spotlight-internal-ip]: walkthrough://spotlight-pointer?cssSelector=gce-internal-ip
[spotlight-machine-type]: walkthrough://spotlight-pointer?spotlightId=gce-add-machine-type-select
[spotlight-notification-menu]: walkthrough://spotlight-pointer?cssSelector=.p6n-notification-dropdown,.cfc-icon-notifications
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-ssh-buttons]: walkthrough://spotlight-pointer?cssSelector=gce-connect-to-instance
[spotlight-submit-create]: walkthrough://spotlight-pointer?spotlightId=gce-submit
[spotlight-vm-list]: walkthrough://spotlight-pointer?cssSelector=vm2-instance-list%20.p6n-checkboxed-table
