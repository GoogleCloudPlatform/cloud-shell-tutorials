# TPU を使用したクイックスタート

<walkthrough-tutorial-url url="https://cloud.google.com/tpu/docs/quickstart"></walkthrough-tutorial-url>

## はじめに

[Tensor Processing Unit][tpu-docs]（TPU）を使用して、特定の [TensorFlow][tensor-flow] 機械学習ワークロードの処理時間を短縮できます。このチュートリアルでは、Cloud TPU を作成して基本的な TensorFlow モデルを実行する方法について説明します。

## プロジェクトのセットアップ

Google Cloud Platform がリソースを整理してプロジェクトに格納します。これによって、1 つのアプリケーションの関連リソースすべてを 1 か所にまとめることができます。

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## Cloud SDK の構成

### Cloud Shell を開く

Cloud Shell はコンソール用の組み込みコマンドライン ツールで、TPU との接続に使用できます。

コンソールの上部にあるナビゲーション バーの<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[アイコン][spotlight-open-devshell]をクリックして、Cloud Shell を開きます。

### ゾーンの指定

次のコマンドを使用して、TPU リソースを作成するゾーンを指定します。

```bash
gcloud config set compute/zone us-central1-c
```

この例では、`us-central1-c` ゾーンを使用します。

利用可能なゾーンを確認するには、Cloud TPU ドキュメントのサイトをご覧ください。

[Cloud TPU のリージョンとゾーン][tpu-regions]

## リソースの作成

このクイックスタートには、Compute Engine 仮想マシンのインスタンスが必要です。このイメージには、`gcloud beta` コマンドライン ツールと、TensorFlow を Cloud TPU リソースで実行するために必要な TensorFlow リリース候補が含まれています。

### Compute Engine VM の作成

`gcloud` コマンドライン ツールを使用して VM インスタンスを作成します。

```bash
gcloud compute instances create tpu-demo-vm \
  --machine-type=n1-standard-4 \
  --boot-disk-size=500GB \
  --image-project=ml-images \
  --image-family=tf-1-8 \
  --scopes=cloud-platform
```

### TPU API の有効化

TPU API がまだ有効になっていない場合は有効にします。

<walkthrough-enable-apis apis="tpu.googleapis.com"></walkthrough-enable-apis>

### TPU リソースの作成

`gcloud beta compute tpus create` コマンドを使用して、新しい Cloud TPU リソースを作成します。この例では、`--range` フラグを `10.240.1.0/29` に設定します。

```bash
gcloud beta compute tpus create demo-tpu \
  --range=10.240.1.0/29 --version=1.8
```

## TensorFlow サンプルの実行

インスタンスに接続し、TPU のネットワーク エンドポイントを指すリモート プロシージャ コール（RPC）を使用して TensorFlow プログラムを作成します。

### インスタンスへの接続

次のコマンドを入力して、VM に SSH 接続します。Cloud Shell で SSH を初めて使用する場合は、秘密鍵を作成する必要があります。

```bash
gcloud compute ssh tpu-demo-vm
```

### TPU の名前の指定

インスタンス上で、選択した TPU の名前を使って環境変数を設定します。この例では「demo-tpu」を使用します。

```bash
export TPU_NAME="demo-tpu"
```

### アプリケーションの作成

Cloud TPU エンドポイントを指す Python アプリケーションを作成して、単純なコンピューティングを実行します。

```bash
nano cloud-tpu.py
```

次に示すファイルの内容をコピーして貼り付けます。

```python
import os
import tensorflow as tf
from tensorflow.contrib import tpu
from tensorflow.contrib.cluster_resolver import TPUClusterResolver

def axy_computation(a, x, y):
  return a * x + y

inputs = [
    3.0,
    tf.ones([3, 3], tf.float32),
    tf.ones([3, 3], tf.float32),
]

tpu_computation = tpu.rewrite(axy_computation, inputs)

tpu_grpc_url = TPUClusterResolver(
    tpu=[os.environ['TPU_NAME']]).get_master()

with tf.Session(tpu_grpc_url) as sess:
  sess.run(tpu.initialize_system())
  sess.run(tf.global_variables_initializer())
  output = sess.run(tpu_computation)
  print(output)
  sess.run(tpu.shutdown_system())

print('Done!')
```

### アプリケーションの実行

TensorFlow プログラムを実行します。

```bash
python cloud-tpu.py
```

TPU 端末を使用する TensorFlow プログラムを他にも自由に作成し、実行してみてください。

調査が完了したら、インスタンスを終了します。

```bash
exit
```

## リソースの削除

このチュートリアルで使用するリソースで Google Cloud Platform アカウントに課金されないように、リソースを削除します。

### TPU リソースと VM インスタンスの削除

gcloud コマンドライン ツールを使用して、Cloud TPU リソースを削除します。

```bash
gcloud beta compute tpus delete demo-tpu
```

`gcloud` コマンドライン ツールを使用して、Compute Engine インスタンスを削除します。

```bash
gcloud compute instances delete tpu-demo-vm
```

### VPC ネットワークの削除

Google Cloud Platform Console の VPC ネットワーク セクションに移動します。

<walkthrough-menu-navigation sectionid="VIRTUAL_NETWORK_SECTION"></walkthrough-menu-navigation>

[[VPC ネットワーク ピアリング][spotlight-network-peering]] セクションに移動し、Cloud TPU 設定の一部として自動的に作成された VPC ネットワークを選択します。ピアリング エントリの ID は、`cp-to-tp-peering` で始まります。

ページ上部の [**削除**] をクリックします。

### VPC ルートの削除

[[ルート][spotlight-routes-list]] セクションに移動し、Cloud TPU 設定の一部として自動的に作成されたルートを選択します。ピアリング エントリの ID は、`peering-route` で始まります。

ページ上部の [**削除**] をクリックします。

## まとめ

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

これで完了です。

Cloud TPU を使用するアプリケーションを作成しました。

詳しくは、Cloud TPU ドキュメントのサイトをご覧ください。

[https://cloud.google.com/tpu/][tpu-docs]

[request-tpu-quota]: https://services.google.com/fb/forms/cloud-tpu-beta-request/
[spotlight-network-peering]: walkthrough://spotlight-pointer?cssSelector=#cfctest-section-nav-item-peering_list
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-routes-list]: walkthrough://spotlight-pointer?cssSelector=#cfctest-section-nav-item-routes_list
[tensor-flow]: https://www.tensorflow.org/
[tpu-docs]: https://cloud.google.com/tpu/docs/
[tpu-regions]: https://cloud.google.com/tpu/docs/regions
