# Panduan App Engine

<walkthrough-tutorial-url url="https://cloud.google.com/appengine/docs/python/quickstart"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="https://github.com/GoogleCloudPlatform/python-docs-samples" key="repo-url"></walkthrough-watcher-constant>
<walkthrough-watcher-constant value="python-docs-samples/appengine/standard/hello_world" key="repo-dir"></walkthrough-watcher-constant>

## Pengantar

Tutorial ini menunjukkan cara menerapkan sampel aplikasi [Python](https://python.org/) di Google App Engine menggunakan perintah `gcloud`.

Berikut adalah langkah-langkah yang harus Anda ambil.

  *  **Buat project**

     Project menggabungkan kode, VM, dan resource lain untuk memudahkan pengembangan dan pemantauan.

  *  **Buat dan jalankan aplikasi "Hello, world!" **

     Anda akan mempelajari cara menjalankan aplikasi menggunakan Google Cloud Shell langsung di browser. Di bagian akhir, Anda akan menerapkan aplikasi Anda ke web menggunakan perintah `gcloud`.

  *  **Setelah tutorial...**

     Aplikasi Anda akan menjadi nyata dan Anda akan dapat bereksperimen dengannya setelah aplikasi diterapkan, atau Anda dapat menghapusnya dan mulai dari awal.

["Python" dan logo Python adalah merek dagang atau merek dagang terdaftar dari Python Software Foundation.](walkthrough://footnote)

## Penyiapan project

Untuk menerapkan aplikasi, Anda harus membuat project terlebih dahulu.

Google Cloud Platform mengatur resource ke dalam sejumlah project. Dengan begitu, Anda dapat mengumpulkan semua resource terkait untuk sebuah aplikasi di 1 tempat.

<walkthrough-devshell-precreate></walkthrough-devshell-precreate>

<walkthrough-project-setup></walkthrough-project-setup>

## Menggunakan Google Cloud Shell

Cloud Shell adalah fitur command-line bawaan untuk konsol. Kita akan menggunakan Cloud Shell untuk menerapkan aplikasi.

### Membuka Google Cloud Shell

Buka Cloud Shell dengan mengklik <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[ikon][spotlight-open-devshell] di menu navigasi di bagian atas konsol.

### Meng-clone kode sampel

Gunakan Cloud Shell untuk meng-clone dan membuka kode "Hello World". Kode sampel di-clone dari repositori project Anda ke Cloud Shell.

Catatan: Jika direktori sudah ada, hapus file sebelumnya sebelum meng-clone.

Dalam Cloud Shell, masukkan:

```bash
git clone {{repo-url}}
```

Kemudian, beralih ke direktori tutorial:

```bash
cd {{repo-dir}}
```

## Mengonfigurasi penerapan Anda

Kini Anda berada di direktori utama untuk kode sampel. Kita akan melihat file yang mengonfigurasi aplikasi Anda.

### Mempelajari aplikasi

Masukkan perintah berikut untuk melihat kode aplikasi Anda:

```bash
cat main.py
```

Aplikasi ini adalah aplikasi Python sederhana yang menggunakan framework web [webapp2](https://webapp2.readthedocs.io/). Skrip Python ini merespons permintaan dengan header HTTP dan pesan `Hello, World!`.

### Mempelajari konfigurasi anda

Google App Engine menggunakan file YAML untuk menentukan konfigurasi penerapan.
File `app.yaml` berisi informasi tentang aplikasi Anda, seperti lingkungan runtime, penangan URL, dan lainnya.

Masukkan perintah berikut untuk melihat file konfigurasi Anda:

```bash
cat app.yaml
```

Dari atas ke bawah, file konfigurasi ini menyatakan hal berikut mengenai aplikasi ini:

  *  Kode ini berjalan di lingkungan runtime `python`.
  *  Aplikasi ini adalah `threadsafe`, jadi instance yang sama dapat menangani beberapa permintaan bersamaan. Threadsafe adalah fitur lanjutan dan dapat menyebabkan perilaku tidak menentu jika aplikasi Anda tidak dirancang khusus untuk menangani threadsafe.
  *  Setiap permintaan ke URL yang lokasinya cocok dengan ekspresi reguler `/.*` (semua URL) harus ditangani oleh objek aplikasi dalam modul Python `main`.

Sintaks file ini adalah [YAML](http://www.yaml.org). Untuk mengetahui daftar lengkap opsi konfigurasi, lihat referensi [`app.yaml`][app-yaml-reference].

## Menguji aplikasi Anda

### Menguji aplikasi Anda pada Cloud Shell

Cloud Shell dapat digunakan untuk menguji aplikasi sebelum diterapkan, sehingga aplikasi dapat dipastikan berjalan sebagaimana diinginkan. Prosesnya sama seperti debugging pada mesin lokal Anda.

Untuk menguji aplikasi, masukkan:

```bash
dev_appserver.py $PWD
```

### Melihat pratinjau aplikasi menggunakan fitur "Pratinjau web"

Aplikasi Anda kini berjalan di Cloud Shell. Anda dapat mengakses aplikasi menggunakan fitur [Pratinjau web][spotlight-web-preview]<walkthrough-web-preview-icon></walkthrough-web-preview-icon> untuk membuat hubungan ke port 8080.

### Mengakhiri instance pratinjau

Hentikan instance aplikasi dengan menekan `Ctrl+C` di Cloud Shell.

## Menerapkan di Google App Engine

### Membuat aplikasi

Agar dapat menerapkan aplikasi, Anda harus membuat aplikasi di sebuah region:

```bash
gcloud app create
```

Catatan: Jika aplikasi sudah dibuat, Anda dapat melewati langkah ini.

### Menerapkan dengan Cloud Shell

Anda dapat menggunakan Cloud Shell untuk menerapkan aplikasi. Untuk menerapkan aplikasi, masukkan:

```bash
gcloud app deploy app.yaml --project {{project-id}}
```

### Mengunjungi aplikasi Anda

Selamat! Aplikasi Anda telah diterapkan. URL default aplikasi Anda adalah [{{project-gae-url}}](http://{{project-gae-url}}). Klik URL ini untuk mengunjunginya.

### Melihat status aplikasi Anda

Anda dapat memeriksa aplikasi dengan memantau statusnya di dasbor App Engine.

Buka [menu][spotlight-console-menu] di sisi kiri konsol.

Lalu pilih bagian **App Engine**.

<walkthrough-menu-navigation sectionid="APPENGINE_SECTION"></walkthrough-menu-navigation>

## Kesimpulan

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Anda berhasil menerapkan aplikasi App Engine.

Berikut adalah beberapa langkah selanjutnya:

**Download Google Cloud SDK dan kembangkan secara lokal**

Instal [Google Cloud SDK][cloud-sdk-installer] di mesin lokal Anda.

**Buat aplikasi Anda berikutnya**

Pelajari cara menggunakan App Engine dengan produk Cloud Platform lainnya:

<walkthrough-tutorial-card label="django" url="python/django/appengine" icon="APPENGINE_SECTION">
  **Jalankan Django**
  Kembangkan aplikasi Django yang berjalan di App Engine.
</walkthrough-tutorial-card>

<walkthrough-tutorial-card label="datastore" url="appengine/docs/python/datastore/" icon="DATASTORE_SECTION">
  **Pelajari cara menggunakan Cloud Datastore**
  Cloud Datastore adalah database NoSQL yang sangat skalabel untuk aplikasi Anda.
</walkthrough-tutorial-card>

[app-yaml-reference]: https://cloud.google.com/appengine/docs/standard/python/config/appref
[cloud-sdk-installer]: https://cloud.google.com/sdk/downloads#interactive
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-web-preview]: walkthrough://spotlight-pointer?spotlightId=devshell-web-preview-button
