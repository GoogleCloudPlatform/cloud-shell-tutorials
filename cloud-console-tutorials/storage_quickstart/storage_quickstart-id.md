# Panduan Memulai Cloud Storage

## Selamat datang di Google Cloud Storage!

<walkthrough-tutorial-url url="https://cloud.google.com/storage/docs/quickstart-console"></walkthrough-tutorial-url>

Google Cloud Storage adalah solusi penyimpanan andal dan hemat biaya untuk objek yang tidak terstruktur. Solusi ini juga cocok untuk segala keperluan, mulai hosting konten web live, penyimpanan data untuk analisis, hingga pengarsipan dan backup.

Dalam tutorial ini, kami akan menunjukkan betapa mudahnya memulai penyimpanan objek di Cloud Storage. Berikut ini hal-hal yang perlu Anda lakukan:

  *  **Membuat bucket**

     Bucket menampung objek (semua jenis file) yang ingin Anda simpan di Cloud Storage.

  *  **Mengupload dan membagikan objek**

     Mulai gunakan bucket Anda dengan mengupload objek dan menyediakannya untuk publik.

  *  **Membersihkan**

     Sebagai langkah terakhir, hapus bucket dan objek yang Anda buat untuk tutorial ini.

Karena bucket dan objek akan dihapus di akhir tutorial, Anda tidak perlu khawatir akan dikenakan biaya karena mencoba tutorial ini.

## Penyiapan Project

Cloud Storage membutuhkan project untuk membuat resource.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## Membuat bucket

Di Cloud Storage, Anda menyimpan objek ke dalam bucket. Untuk membuat bucket, Anda harus membuka browser Cloud Storage.

Buka [menu][spotlight-menu] di sisi kiri konsol.

Lalu, pilih bagian **Storage**.

<walkthrough-menu-navigation sectionid="STORAGE_SECTION"></walkthrough-menu-navigation>

## Membuat bucket

Agar dapat mengupload objek, Anda harus membuat "bucket" untuk menyimpan objek tersebut. Bucket membantu Anda mengatur objek dan mengontrol aksesnya.

  1. Klik [Buat bucket](walkthrough://spotlight-pointer?cssSelector=#p6ntest-cloudstorage-create-first-bucket-button,)

  1. Pada halaman pembuatan bucket, tentukan properti bucket. Berikut ini beberapa hal yang perlu diperhatikan:

     *  **Nama:** Pikirkan nama yang unik. Error akan muncul jika Anda memasukkan nama yang sama dengan nama bucket lain di Cloud Storage.
     *  **Class penyimpanan default:** Ini adalah class penyimpanan yang secara default ditetapkan ke objek bucket Anda. Pilihan Anda bergantung terutama pada perkiraan Anda tentang seberapa sering objek diakses dan apakah Anda menyajikan data ke seluruh dunia atau tidak. Class penyimpanan akan memengaruhi biaya.
     *  **Lokasi:** Sebaiknya simpan data Anda dekat dengan aplikasi dan pengguna yang mengaksesnya. Pilihan yang tersedia bergantung pada pilihan class penyimpanan Anda.

Untuk uji coba ini, semua class penyimpanan dan lokasi dapat digunakan, karena pada akhirnya bucket ini akan dihapus.

  1. Klik [Buat][spotlight-create-button]

## Mengupload objek

Setelah memiliki bucket, Anda dapat mulai mengupload objek.

  1. Di bagian atas halaman, klik [Upload file][spotlight-upload-file]

  1. Pilih file yang akan diupload. Anda dapat mengupload semua jenis file.

     Tidak punya file? [Buat file contoh][create-sample-file], lalu klik [Refresh Bucket][spotlight-refresh-bucket] di bagian atas halaman untuk melihatnya di bucket Anda. (Tips: Anda juga dapat mengupload objek dengan menarik lalu melepaskannya ke ruang di bawah nama bucket.)

## Menghapus bucket

Sekarang mari kita hapus bucket yang tadi dibuat. Menghapus bucket juga akan menghapus isinya.

  1. Di bagian atas tabel, klik [Bucket][spotlight-buckets-link] untuk kembali ke daftar bucket.

  1. Centang kotak di samping bucket Anda. Jika ada bucket lain dalam project ini, dan Anda memerlukan bantuan untuk menemukan bucket Anda, gunakan kotak penelusuran untuk memfilter daftar bucket.

  1. Di bagian atas halaman, klik [Hapus][spotlight-delete-buckets] dan konfirmasikan penghapusan.

## Kesimpulan

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Selamat!

Setelah mengetahui cara menyimpan objek di Cloud Storage, Anda mungkin ingin belajar menggunakannya di dunia nyata dengan [menghosting situs statis](https://cloud.google.com/storage/docs/hosting-static-website).

Atau belajar menggunakan Cloud Storage dengan [fitur command-line gsutil](https://cloud.google.com/storage/docs/quickstart-gsutil).

Pelajari cara mulai menggunakan Cloud Storage dan layanan GCP lainnya [gratis](https://cloud.google.com/free).

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
