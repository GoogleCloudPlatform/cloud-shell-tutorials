# Tutorial Word Count Dataflow

<walkthrough-tutorial-url url="https://cloud.google.com/dataflow/docs/quickstarts/quickstart-java-maven"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="dataflow-intro" key="directory"></walkthrough-watcher-constant>
<walkthrough-watcher-constant value="dataflow-intro" key="job-name"></walkthrough-watcher-constant>

## Pengantar

Dalam tutorial ini, Anda akan mempelajari dasar-dasar layanan Cloud Dataflow dengan menjalankan contoh pipeline sederhana menggunakan Java.

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

Untuk menggunakan Cloud Dataflow SDK untuk Java, lingkungan pengembangan Anda akan memerlukan Java, Google Cloud SDK, Cloud Dataflow SDK untuk Java, dan Apache Maven untuk mengelola dependensi SDK. Tutorial ini menggunakan Cloud Shell yang telah menginstal Java, Google Cloud SDK, dan Maven.

Selain itu, Anda dapat menjalankan tutorial ini [di komputer lokal][dataflow-java-tutorial].

### Mendownload sampel dan Cloud Dataflow SDK untuk Java menggunakan perintah Maven

Saat Anda menjalankan perintah ini, Maven akan membuat struktur project dan file konfigurasi yang akan digunakan untuk mendownload versi Cloud Dataflow SDK yang sesuai.

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

  *  `archetypeArtifactId` dan `archetypeGroupId` digunakan untuk menentukan struktur project contoh.
  *  `groupId` adalah awalan nama paket Java organisasi Anda; misalnya, `com.mycompany`
  *  `artifactId` menetapkan nama file jar yang dibuat. Gunakan nilai default (`{{directory}}`) untuk keperluan tutorial ini.

Jalankan perintah Maven di Cloud Shell.

### Mengubah direktori

Ubah direktori kerja Anda menjadi `{{directory}}`.

```bash
cd {{directory}}
```

Jika ingin melihat kode untuk contoh ini, Anda dapat menemukannya di subdirektori `src` dalam direktori `{{directory}}`.

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

Jika ingin melihat kode untuk contoh ini, Anda dapat menemukannya di subdirektori `src` dalam direktori `{{directory}}`.

### Meluncurkan pipeline pada Layanan Dataflow

Gunakan perintah `mvn exec` dari Apache Maven untuk meluncurkan pipeline di layanan.
Pipeline yang sedang berjalan disebut *job* (tugas).

```bash
mvn compile exec:java \
  -Dexec.mainClass=com.example.WordCount \
  -Dexec.args="--project={{project-id}} \
  --stagingLocation=gs://{{project-id-no-domain}}/staging/ \
  --output=gs://{{project-id-no-domain}}/output \
  --runner=DataflowRunner \
  --jobName={{job-name}}"
```

  *  `stagingLocation` adalah bucket penyimpanan yang akan digunakan Cloud Dataflow untuk menyimpan data biner dan data lainnya guna menjalankan pipeline. Lokasi ini dapat dibagikan di beberapa tugas.
  *  `output` adalah bucket yang digunakan oleh contoh WordCount untuk menyimpan hasil tugas.

### Tugas Anda sedang berjalan

Selamat! Biner Anda kini siap dimasukkan ke bucket penyimpanan yang Anda buat sebelumnya, dan instance Compute Engine sedang dibuat. Cloud Dataflow akan membagi file input agar dapat diproses secara paralel di beberapa mesin.

Catatan: Jika melihat pesan "Job finished", Anda dapat menutup Cloud Shell.

Jika Anda ingin membersihkan jejak project Maven yang Anda hasilkan, jalankan `cd .. && rm -R {{directory}}` di Cloud Shell untuk menghapus direktori.

## Memantau tugas Anda

Periksa progres pipeline Anda di halaman UI Cloud Dataflow Monitoring.

### Membuka halaman Cloud Dataflow

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

Lalu, pilih bagian **Penyimpanan**.

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
  *  [Pelajari model pemrograman Cloud Dataflow][df-model]
  *  [Pelajari Cloud Dataflow SDK di GitHub][df-sdk]

Menyiapkan lingkungan lokal Anda:

  *  [Gunakan Eclipse untuk menjalankan Dataflow][df-eclipse]
  *  [Gunakan Python untuk menjalankan Dataflow][df-python]

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
