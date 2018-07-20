# Cloud Vision API

<walkthrough-test-start-page url="/start?tutorial=python_vision_quickstart_v2"></walkthrough-test-start-page>

<walkthrough-tutorial-url url="https://cloud.google.com/vision/docs/label-tutorial"></walkthrough-tutorial-url>

<walkthrough-watcher-constant value="https://github.com/GoogleCloudPlatform/python-docs-samples.git" key="repo-url"></walkthrough-watcher-constant>

<walkthrough-watcher-constant value="python-docs-samples" key="repo-name"></walkthrough-watcher-constant>

<walkthrough-devshell-precreate></walkthrough-devshell-precreate>

## Pengantar

Tutorial ini membahas tentang aplikasi Vision API dasar, dengan menggunakan
permintaan `LABEL_DETECTION`. Permintaan `LABEL_DETECTION` menganotasi gambar
dengan tabel (atau "tag") yang dipilih berdasarkan konten gambar. Misalnya,
gambar lumbung dapat menghasilkan label "lumbung", "pertanian", atau beberapa
anotasi serupa lainnya.

Berikut ini langkah-langkah yang harus Anda lakukan:

*   **Jalankan aplikasi deteksi label** Anda akan mempelajari cara menjalankan
    aplikasi menggunakan Google Cloud Shell, langsung di browser.
*   **Setelah itu aplikasi...** Aplikasi Anda akan menjadi nyata dan Anda akan
    dapat mencobanya, atau menghapusnya dan memulai yang baru.

["Python" dan logo Python adalah merek dagang atau merek dagang terdaftar dari
Python Software Foundation.](walkthrough://footnote)

# Penyiapan Project

Anda harus mengaktifkan Cloud Vision API melalui project.

Google Cloud Platform mengatur resource ke dalam sejumlah project. Dengan
begitu, Anda dapat mengumpulkan semua resource terkait untuk sebuah aplikasi di
1 tempat.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## Mengaktifkan Vision API

Project Anda harus mengaktifkan Vision API untuk menerima permintaan.

### Membuka Pengelola API

Pengelola API menentukan API mana yang diaktifkan untuk project Anda.

Buka [menu](walkthrough://spotlight-pointer?spotlightId=console-nav-menu) di
bagian kiri konsol.

Kemudian, pilih bagian **API & Layanan**.

<walkthrough-menu-navigation sectionid="API_SECTION"></walkthrough-menu-navigation>

### Melihat API yang Tersedia

Untuk mengaktifkan API, klik tombol
[Aktifkan API](walkthrough://spotlight-pointer?cssSelector=.p6n-action-bar-button).

### Memilih Vision API

Klik link [Vision API](walkthrough://spotlight-pointer?spotlightId=api-vision.googleapis.com).

### Mengaktifkan Vision API

Untuk mengaktifkan Vision API, klik tombol [Aktifkan](walkthrough://spotlight-pointer?spotlightId=api-enable-vision.googleapis.com).
Anda akan membuat kredensial untuk project Anda nanti dalam tutorial ini.

## Menggunakan Google Cloud Shell

Cloud Shell adalah fitur command-line bawaan untuk konsol. Anda akan menggunakan
Cloud Shell untuk menjalankan aplikasi.

### Membuka Google Cloud Shell

Buka Cloud Shell dengan mengklik
<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>
[ikon](walkthrough://spotlight-pointer?spotlightId=devshell-activate-button)
di menu navigasi di bagian atas konsol.

### Meng-clone kode sampel

Gunakan Cloud Shell untuk meng-clone dan membuka kode "Hello World". Kode sampel
di-clone dari repositori project Anda ke Cloud Shell.

Catatan: Jika direktori sudah ada, hapus file sebelumnya sebelum meng-clone:

```bash
rm -rf {{repo-name}}
```

Clone repositori sampel:

```bash
git clone {{repo-url}}
```

Kemudian, beralih ke direktori tutorial:

```bash
cd {{repo-name}}/vision/cloud-client/quickstart
```

## Mengonfigurasi penerapan Anda

Kini Anda berada di direktori utama untuk kode sampel. Anda akan melihat file
yang mengonfigurasi aplikasi.

### Mempelajari aplikasi

Masukkan perintah berikut untuk melihat kode aplikasi Anda:

```bash
cat quickstart.py
```

File `quickstart.py` memformat informasi permintaan Anda, seperti jenis dan
konten permintaan. Perluas setiap bagian di bawah ini untuk mempelajari
detailnya.

Permintaan ke Vision API diberikan sebagai objek JSON. Lihat [Referensi Vision
API][vision-request-doc] untuk mengetahui informasi lengkap mengenai struktur
spesifik permintaan semacam itu. Permintaan JSON hanya akan dikirim jika
`execute` dipanggil. Dengan pola ini, Anda dapat meneruskan permintaan semacam
itu dan memanggil `execute` jika diperlukan.

## Menguji aplikasi

Untuk menggunakan API, Anda harus menyiapkan kredensial. Untuk menggunakan Cloud
API, Anda harus menyiapkan [kredensial][auth-doc] yang sesuai untuk aplikasi
Anda. Kredensial ini akan mengaktifkan aplikasi Anda untuk mengautentikasi
identitasnya pada layanan, dan mendapatkan otorisasi untuk melakukan tugas.
Kemudian, Anda akan menguji API dengan gambar sampel.

### Membuat akun layanan

Anda perlu membuat akun layanan untuk mengautentikasi permintaan API. Jika Anda
sudah membuat akun layanan, akun tersebut akan digunakan kembali.

```bash
gcloud iam service-accounts create vision-quickstart
```

### Membuat kredensial

Berikutnya, buat kunci akun layanan dan tetapkan sebagai kredensial default
Anda.

```bash
gcloud iam service-accounts keys create key.json --iam-account    vision-quickstart@{{project-id}}.iam.gserviceaccount.com
```

```bash
export GOOGLE_APPLICATION_CREDENTIALS=key.json
```

<walkthrough-test-code-output text="created key"></walkthrough-test-code-output>

### Menguji aplikasi Anda

Untuk menguji aplikasi Anda dengan gambar sampel, masukkan:

```bash
python quickstart.py
```

Resource gambar, `resources/wakeupcat.jpg`, ditentukan di sumber. ([Lihat
Gambar][cat-picture])

## Kesimpulan

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Selamat! Anda siap menggunakan Cloud Vision API.

Inilah yang dapat Anda lakukan selanjutnya:

*   Menyimak tutorial [Deteksi Wajah][face-tutorial].
*   Mencoba tutorial [Teks Dokumen][document-text-tutorial].
*   Melihat [Aplikasi Sampel][vision-samples].
*   Mendownload [Google Cloud SDK][get-cloud-sdk] untuk dijalankan di komputer
    lokal Anda.

[auth-doc]: https://cloud.google.com/vision/docs/auth
[cat-picture]: https://raw.githubusercontent.com/GoogleCloudPlatform/python-docs-samples/master/vision/cloud-client/quickstart/resources/wakeupcat.jpg
[document-text-tutorial]: https://cloud.google.com/vision/docs/fulltext-annotations
[face-tutorial]: https://cloud.google.com/vision/docs/face-tutorial
[get-cloud-sdk]: https://cloud.google.com/sdk/
[vision-request-doc]: https://cloud.google.com/vision/reference/rest
[vision-samples]: https://cloud.google.com/vision/docs/samples
