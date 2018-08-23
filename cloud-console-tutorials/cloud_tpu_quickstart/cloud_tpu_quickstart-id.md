# Panduan Memulai Menggunakan TPU

<walkthrough-tutorial-url url="https://cloud.google.com/tpu/docs/quickstart"></walkthrough-tutorial-url>

## Pengantar

Anda dapat menggunakan [Tensor Processing Unit][tpu-docs] (TPU) untuk mempercepat beban kerja machine learning [TensorFlow][tensor-flow] tertentu. Tutorial ini menjelaskan cara membuat Cloud TPU dan menggunakannya untuk menjalankan model TensorFlow dasar.

## Penyiapan project

Google Cloud Platform mengatur resource ke dalam sejumlah project. Dengan begitu, Anda dapat mengumpulkan semua resource terkait untuk sebuah aplikasi di 1 tempat.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## Mengonfigurasi Cloud SDK

### Membuka Cloud Shell

Cloud Shell adalah fitur command-line bawaan untuk konsol yang dapat digunakan agar terhubung ke TPU.

Buka Cloud Shell dengan mengklik <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[ikon][spotlight-open-devshell] di menu navigasi di bagian atas konsol.

### Menentukan zona

Gunakan perintah berikut untuk menentukan zona tempat Anda ingin membuat resource TPU:

```bash
gcloud config set compute/zone us-central1-c
```

Untuk contoh ini, gunakan zona `us-central1-c`.

Untuk melihat zona yang tersedia, buka situs dokumentasi Cloud TPU:

[Zona dan region Cloud TPU][tpu-regions]

## Membuat resource

Panduan memulai ini memerlukan instance mesin virtual Compute Engine. Gambar mencakup fitur command-line `gcloud beta` serta kandidat rilis TensorFlow yang diperlukan untuk menjalankan TensorFlow pada resource Cloud TPU.

### Membuat VM Compute Engine

Gunakan fitur command-line `gcloud` untuk membuat instance VM.

```bash
gcloud compute instances create tpu-demo-vm \
  --machine-type=n1-standard-4 \
  --boot-disk-size=500GB \
  --image-project=ml-images \
  --image-family=tf-1-8 \
  --scopes=cloud-platform
```

### Mengaktifkan TPU API

Aktifkan TPU API jika Anda belum melakukannya.

<walkthrough-enable-apis apis="tpu.googleapis.com"></walkthrough-enable-apis>

### Membuat resource TPU

Gunakan perintah `gcloud beta compute tpus create` untuk membuat resource Cloud TPU baru. Untuk contoh ini, tetapkan tanda `--range` ke `10.240.1.0/29`.

```bash
gcloud beta compute tpus create demo-tpu \
  --range=10.240.1.0/29 --version=1.8
```

## Menjalankan contoh TensorFlow

Hubungkan ke instance dan buat program TensorFlow dengan panggilan prosedur jarak jauh (RPC) yang mengarah ke endpoint jaringan TPU Anda.

### Menghubungkan ke instance

Masukkan perintah berikut ke SSH di dalam VM. Jika ini pertama kalinya Anda menggunakan SSH dari Cloud Shell, Anda harus membuat kunci pribadi:

```bash
gcloud compute ssh tpu-demo-vm
```

### Memberi nama TPU Anda

Pada instance, tetapkan variabel lingkungan dengan nama yang Anda pilih untuk TPU. Untuk contoh ini, gunakan "demo-tpu".

```bash
export TPU_NAME="demo-tpu"
```

### Membuat aplikasi

Buat aplikasi Python yang mengarah ke endpoint Cloud TPU dan menjalankan penghitungan sederhana.

```bash
nano cloud-tpu.py
```

Copy-paste isi file ini:

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

### Menjalankan aplikasi

Jalankan program TensorFlow.

```bash
python cloud-tpu.py
```

Jangan ragu untuk membuat dan menjalankan program TensorFlow tambahan yang menggunakan perangkat TPU.

Jika sudah selesai bereksperimen, keluar dari instance.

```bash
exit
```

## Menghapus resource

Agar tidak menimbulkan biaya pada akun Google Cloud Platform Anda untuk resource yang digunakan dalam panduan memulai ini:

### Menghapus resource TPU dan instance VM

Gunakan fitur command-line gcloud untuk menghapus resource Cloud TPU.

```bash
gcloud beta compute tpus delete demo-tpu
```

Gunakan fitur command-line `gcloud` untuk menghapus instance Compute Engine.

```bash
gcloud compute instances delete tpu-demo-vm
```

### Menghapus jaringan VPC

Buka bagian Jaringan VPC di Google Cloud Platform Console.

<walkthrough-menu-navigation sectionid="VIRTUAL_NETWORK_SECTION"></walkthrough-menu-navigation>

Buka bagian [peering jaringan VPC][spotlight-network-peering] dan pilih jaringan VPC yang otomatis dibuat oleh Google sebagai bagian dari penyiapan Cloud TPU. Entri peering dimulai dengan `cp-to-tp-peering` di ID-nya.

Di bagian atas halaman, klik **Hapus**.

### Menghapus rute VPC

Buka bagian [Rute][spotlight-routes-list] dan pilih rute yang otomatis dibuat oleh Google sebagai bagian dari penyiapan Cloud TPU. Entri peering dimulai dengan `peering-route` di ID-nya.

Di bagian atas halaman, klik **Hapus**.

## Kesimpulan

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Selamat!

Anda telah membuat aplikasi yang menggunakan Cloud TPU.

Untuk mempelajari lebih lanjut, kunjungi situs dokumentasi Cloud TPU:

[https://cloud.google.com/tpu/][tpu-docs]

[request-tpu-quota]: https://services.google.com/fb/forms/cloud-tpu-beta-request/
[spotlight-network-peering]: walkthrough://spotlight-pointer?cssSelector=#cfctest-section-nav-item-peering_list
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-routes-list]: walkthrough://spotlight-pointer?cssSelector=#cfctest-section-nav-item-routes_list
[tensor-flow]: https://www.tensorflow.org/
[tpu-docs]: https://cloud.google.com/tpu/docs/
[tpu-regions]: https://cloud.google.com/tpu/docs/regions
