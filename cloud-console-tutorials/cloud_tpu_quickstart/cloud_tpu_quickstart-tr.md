# TPU Kullanmaya Hızlı Başlangıç

<walkthrough-tutorial-url url="https://cloud.google.com/tpu/docs/quickstart"></walkthrough-tutorial-url>

## Giriş

Belirli [TensorFlow][tensor-flow] makine öğrenimi iş yüklerini hızlandırmak için bir [Tensor İşleme Birimi][tpu-docs] (TPU) kullanabilirsiniz. Bu eğiticide, Cloud TPU'yu nasıl oluşturacağınız ve bunu temel bir TensorFlow modeli çalıştırmak için nasıl kullanacağınız anlatılmaktadır.

## Proje hazırlama

Google Cloud Platform, kaynakları projeler halinde düzenler. Bu sayede, tek bir uygulamayla ilgili tüm kaynakları tek bir yerde toplayabilirsiniz.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## Google Cloud SDK'yı Yapılandırma

### Cloud Shell'i açın

Cloud Shell, TPU'nuza bağlanırken kullanabileceğiniz, konsol için dahili bir komut satırı aracıdır.

Konsolun üstündeki gezinme çubuğunda yer alan <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[simgeyi][spotlight-open-devshell] tıklayarak Cloud Shell'i açın.

### Bir alt bölge belirtin

TPU kaynağınızı oluşturmayı planladığınız alt bölgeyi belirtmek için aşağıdaki komutu kullanın:

```bash
gcloud config set compute/zone us-central1-c
```

Bu örnek için `us-central1-c` alt bölgesini kullanın.

Mevcut alt bölgeleri görmek için Cloud TPU belgelerinin yer aldığı siteyi ziyaret edin:

[Cloud TPU bölgeleri ve alt bölgeleri][tpu-regions]

## Kaynak oluşturun

Bu hızlı başlangıç, bir Compute Engine sanal makine örneği gerektirir. Görüntü, `gcloud beta` komut satırı aracının yanı sıra Cloud TPU kaynakları üzerinde TensorFlow çalıştırmak için gerekli olan TensorFlow aday sürümünü de içerir.

### Compute Engine sanal makinesi oluşturun

Sanal makine örneği oluşturmak için `gcloud` komut satırı aracını kullanın.

```bash
gcloud compute instances create tpu-demo-vm \
  --machine-type=n1-standard-4 \
  --boot-disk-size=500GB \
  --image-project=ml-images \
  --image-family=tf-1-8 \
  --scopes=cloud-platform
```

### TPU API'yi etkinleştirin

Henüz yapmadıysanız TPU API'yi etkinleştirin.

<walkthrough-enable-apis apis="tpu.googleapis.com"></walkthrough-enable-apis>

### TPU kaynağı oluşturun

Yeni bir Cloud TPU kaynağı oluşturmak için `gcloud beta compute tpus create` komutunu kullanın. Bu örnek için `--range` işaretini `10.240.1.0/29` olarak ayarlayın.

```bash
gcloud beta compute tpus create demo-tpu \
  --range=10.240.1.0/29 --version=1.8
```

## TensorFlow örneği çalıştırın

Örneğinize bağlanın ve TPU'nuzun ağ uç noktasına işaret eden bir uzak prosedür çağrısı (RPC) ile bir TensorFlow programı oluşturun.

### Örneğinize bağlanın

Sanal makine içine SSH uygulamak amacıyla aşağıdaki komutu girin. İlk kez Cloud Shell'den SSH kullanıyorsanız bir gizli anahtar oluşturmanız gerekir:

```bash
gcloud compute ssh tpu-demo-vm
```

### TPU'nuzu adlandırın

Örnek üzerinde, TPU'nuz için seçtiğiniz bir adla birlikte ortam değişkeni belirleyin. Bu örnek için "demo-tpu" adını kullanın.

```bash
export TPU_NAME="demo-tpu"
```

### Uygulamayı oluşturun

Cloud TPU uç noktanıza işaret eden ve basit bir hesaplama yürüten bir Python uygulaması oluşturun.

```bash
nano cloud-tpu.py
```

Şu dosya içeriklerini kopyalayıp yapıştırın:

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

### Uygulamayı çalıştırın

TensorFlow programını çalıştırın.

```bash
python cloud-tpu.py
```

TPU cihazını kullanan ek TensorFlow programları oluşturabilir ve çalıştırabilirsiniz.

Denemeyi tamamladığınızda örnekten çıkın.

```bash
exit
```

## Kaynakları silin

Bu hızlı başlangıçta kullanılan kaynaklar için Google Cloud Platform hesabınızın ücretlendirilmesini önlemek amacıyla:

### TPU kaynağını ve sanal makine örneğini silin

Cloud TPU kaynağınızı silmek için gcloud komut satırı aracını kullanın.

```bash
gcloud beta compute tpus delete demo-tpu
```

Compute Engine kaynağınızı silmek için `gcloud` komut satırı aracını kullanın.

```bash
gcloud compute instances delete tpu-demo-vm
```

### VPC ağını silin

Google Cloud Platform Console'da VPC ağı bölümüne gidin.

<walkthrough-menu-navigation sectionid="VIRTUAL_NETWORK_SECTION"></walkthrough-menu-navigation>

[VPC ağ eşleme][spotlight-network-peering] bölümüne gidin ve Google'ın Cloud TPU kurulumunda otomatik olarak oluşturduğu VPC ağını seçin. Eşleme girişi, kimlik bölümünde `cp-to-tp-peering` ile başlar.

Sayfanın üst kısmından **Sil**'i tıklayın.

### VPC rotasını silin

[Rotalar][spotlight-routes-list] bölümüne gidin ve Google'ın Cloud TPU kurulumunda otomatik olarak oluşturduğu rotayı seçin. Eşleme girişi, kimlik bölümünde `peering-route` ile başlar.

Sayfanın üst kısmından **Sil**'i tıklayın.

## Sonuç

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Tebrikler!

Cloud TPU kullanan bir uygulama oluşturdunuz.

Daha fazla bilgi edinmek için Cloud TPU belgelerinin yer aldığı siteyi ziyaret edin:

[https://cloud.google.com/tpu/][tpu-docs]

[request-tpu-quota]: https://services.google.com/fb/forms/cloud-tpu-beta-request/
[spotlight-network-peering]: walkthrough://spotlight-pointer?cssSelector=#cfctest-section-nav-item-peering_list
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-routes-list]: walkthrough://spotlight-pointer?cssSelector=#cfctest-section-nav-item-routes_list
[tensor-flow]: https://www.tensorflow.org/
[tpu-docs]: https://cloud.google.com/tpu/docs/
[tpu-regions]: https://cloud.google.com/tpu/docs/regions
