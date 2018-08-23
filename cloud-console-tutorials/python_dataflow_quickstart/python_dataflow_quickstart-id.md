# Tutorial Word Count Dataflow

<walkthrough-tutorial-url url="https://cloud.google.com/dataflow/docs/quickstarts/quickstart-python"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="dataflow-intro" key="directory"></walkthrough-watcher-constant>
<walkthrough-watcher-constant value="dataflow-intro" key="job-name"></walkthrough-watcher-constant>

## Pengantar

Dalam tutorial ini, Anda akan mempelajari dasar-dasar layanan Cloud Dataflow dengan menjalankan contoh pipeline sederhana menggunakan Python.

Pipeline Dataflow adalah *batch* (memproses input terikat seperti file atau tabel database) atau *streaming* (memproses input tak terikat dari sumber seperti Cloud Pub/Sub). Contoh dalam tutorial ini adalah pipeline batch yang menghitung jumlah kata dalam koleksi karya Shakespeare.

Sebelum memulai, Anda harus memeriksa prasyarat di project Cloud Platform Anda dan menjalankan persiapan awal.

## Penyiapan project

Google Cloud Platform mengatur resource ke dalam sejumlah project. Dengan begitu, Anda dapat mengumpulkan semua resource terkait untuk sebuah aplikasi di 1 tempat.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>
<walkthrough-project-permissions permissions="dataflow.jobs.create"></walkthrough-project-permissions>

## Menyiapkan Cloud Dataflow

Untuk menggunakan Dataflow, aktifkan Cloud Dataflow API dan buka Cloud Shell.

### Mengaktifkan Google Cloud API

<walkthrough-enable-apis apis="compute.googleapis.com,dataflow,cloudresourcemanager.googleapis.com,logging,storage_component,storage_api,bigquery,pubsub">
</walkthrough-enable-apis>

### Membuka Cloud Shell

Cloud Shell adalah fitur command-line bawaan untuk konsol. Anda akan menggunakan Cloud Shell untuk menerapkan aplikasi.

Buka Cloud Shell dengan mengklik <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[ikon][spotlight-open-devshell] di menu navigasi di bagian atas konsol.

## Menginstal sampel Cloud Dataflow di Cloud Shell

Versi Python dari Cloud Dataflow memerlukan lingkungan pengembangan yang memiliki Python, Google Cloud SDK, dan Cloud Dataflow SDK untuk Python.
Selain itu, Cloud Dataflow menggunakan pip, pengelola paket Python, untuk mengelola dependensi SDK.

Tutorial ini menggunakan Cloud Shell yang telah menginstal Python dan pip. Jika ingin, Anda dapat menjalankan tutorial ini [di komputer lokal][dataflow-python-tutorial].

### Mendownload sampel dan Cloud Dataflow SDK untuk Python menggunakan perintah pip

Ketika Anda menjalankan perintah ini, pip akan mendownload dan menginstal versi Cloud Dataflow SDK yang sesuai.

```bash
pip install --user google-cloud-dataflow
```

Jalankan perintah pip di Cloud Shell.

## Menyiapkan bucket Cloud Storage

Cloud Dataflow menggunakan bucket Cloud Storage untuk menyimpan data output dan meng-cache kode pipeline Anda.

### Menjalankan gsutil mb

Di Cloud Shell, gunakan perintah `gsutil mb` untuk membuat bucket Cloud Storage.

```bash
gsutil mb gs://{{project-id-no-domain}}
```

Untuk informasi lebih lanjut tentang fitur `gsutil`, lihat [dokumentasi][gsutil-docs].

## Membuat dan meluncurkan pipeline

Di Cloud Dataflow, tugas pemrosesan data direpresentasikan oleh *pipeline*. Pipeline membaca data input, menjalankan transformasi pada data tersebut, lalu menghasilkan data output. Transformasi pipeline dapat mencakup pemfilteran, pengelompokan, pembandingan, atau penggabungan data.

### Meluncurkan pipeline pada Layanan Dataflow

Gunakan Python untuk meluncurkan pipeline di layanan Cloud Dataflow. Pipeline yang sedang berjalan disebut *job*.

```bash
python -m apache_beam.examples.wordcount \
  --project {{project-id}} \
  --runner DataflowRunner \
  --temp_location gs://{{project-id-no-domain}}/temp \
  --output gs://{{project-id-no-domain}}/results/output \
  --job_name {{job-name}}
```

  *  `output` adalah bucket yang digunakan oleh contoh WordCount untuk menyimpan hasil tugas.

### Tugas Anda sedang berjalan

Selamat! Biner Anda kini siap dimasukkan ke bucket penyimpanan yang Anda buat sebelumnya, dan instance Compute Engine sedang dibuat. Cloud Dataflow akan memecah file input sedemikian rupa sehingga data dapat diproses oleh beberapa mesin secara paralel.

Catatan: Jika melihat pesan "JOB_STATE_DONE", Anda dapat menutup Cloud Shell.

## Memantau tugas Anda

Periksa progres pipeline Anda di halaman Cloud Dataflow.

### Membuka halaman UI Cloud Dataflow Monitoring

Jika belum dilakukan, buka halaman UI Cloud Dataflow Monitoring.

Buka [menu][spotlight-console-menu] di sisi kiri konsol.

Lalu, pilih bagian **Dataflow**.

<walkthrough-menu-navigation sectionid="DATAFLOW_SECTION"></walkthrough-menu-navigation>

### Memilih tugas Anda

Klik tugas Anda untuk melihat detailnya.

### Mempelajari detail dan metrik pipeline

Pelajari pipeline di sebelah kiri dan informasi tugas di sebelah kanan. Untuk melihat detail status tugas, klik [Log][spotlight-job-logs]. Coba klik salah satu langkah pada pipeline untuk melihat metriknya.

Setelah tugas selesai, Anda akan melihat perubahan status tugas, dan instance Compute Engine yang digunakan oleh tugas akan otomatis berhenti.

## Melihat output Anda

Setelah tugas berjalan, Anda dapat mempelajari file output di Cloud Storage.

### Membuka halaman Cloud Storage

Buka [menu][spotlight-console-menu] di sisi kiri konsol.

Kemudian, pilih bagian **Compute Engine**.

<walkthrough-menu-navigation sectionid="STORAGE_SECTION"></walkthrough-menu-navigation>

### Membuka bucket penyimpanan

Pada daftar bucket, pilih bucket yang Anda buat sebelumnya. Jika Anda menggunakan nama yang disarankan, bucket tersebut akan dinamai `{{project-id}}`.

Bucket berisi folder staging dan folder output. Dataflow menyimpan output dalam file terpisah-pisah, sehingga bucket Anda akan memuat beberapa file output.

## Pembersihan

Untuk menghindari biaya penggunaan Cloud Storage, hapus bucket yang Anda buat.

### Kembali ke browser bucket

Klik link [Bucket][spotlight-buckets-link].

### Memilih bucket

Centang kotak di sebelah bucket yang dibuat.

### Menghapus bucket

Klik [Hapus][spotlight-delete-bucket] dan konfirmasikan penghapusan.

## Kesimpulan

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Inilah yang dapat Anda lakukan selanjutnya:

  *  [Baca lebih lanjut contoh Word Count][wordcount]
  *  [Pelajari model pemrograman Cloud Dataflow][df-pipelines]
  *  [Pelajari Apache Beam SDK di GitHub][beam-sdk]

Menyiapkan lingkungan lokal Anda:

  *  [Gunakan Java dan Eclipse untuk menjalankan Dataflow][df-eclipse]
  *  [Gunakan Java dan Maven untuk menjalankan Dataflow][df-maven]

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
