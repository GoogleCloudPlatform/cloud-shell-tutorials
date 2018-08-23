# Tur Cloud Console

<walkthrough-tutorial-duration duration="5"></walkthrough-tutorial-duration>

## Pengantar

Tutorial ini mencakup sejumlah fitur inti Cloud Console yang akan membantu Anda membuat dan mengelola aplikasi di Google Cloud Platform.

Anda akan mempelajari konsep berikut:

  *  Project dan resource GCP
  *  Ringkasan resource level tinggi dan log aktivitas
  *  Navigasi konsol dan penelusuran
  *  Pengelolaan pengguna dan izin
  *  Dukungan teknis
  *  Command-line berbasis browser GCP

Mari kita mulai.

## Menggunakan Resource GCP

Resource GCP adalah komponen dasar yang menyusun semua layanan Google Cloud. Resource ditata secara hierarkis dan memudahkan pengorganisasian tugas Anda di GCP.

Project merupakan hierarki resource level pertama dan terdiri dari sejumlah resource level rendah, seperti bucket Cloud Storage dan instance Compute Engine.

[Pelajari resource GCP lebih lanjut][gcp-resources]

### Navigasi project

Gunakan [pemilih cakupan][spotlight-project-select] di Cloud Console untuk berpindah-pindah antara project GCP dengan mudah. Saat Anda beralih project, tampilan akan disesuaikan dengan project tersebut dan semua resource turunannya.

<walkthrough-project-setup></walkthrough-project-setup>

## Berpindah-pindah antara Layanan Google Cloud

### Navigasi layanan

Layanan Google Cloud dapat diakses di [menu navigasi sebelah kiri][spotlight-console-menu] yang diatur berdasarkan area produk, termasuk Big Data, Compute, Networking, dll.

### Memasang pin ke bagian

Untuk layanan yang Anda kunjungi secara teratur, pasang pin ke bagian tersebut ke atas menu navigasi dengan mengarahkan kursor ke atas item bagian dan mengklik ikon pin.

Buka menu navigasi dan pilih **Beranda** untuk melanjutkan.

<walkthrough-menu-navigation sectionid="HOME_SECTION"></walkthrough-menu-navigation>

## Melihat ringkasan level tinggi dari setiap project

### Dasbor Beranda

Dasbor Beranda menyajikan ringkasan level tinggi untuk project GCP yang dipilih, dengan menyoroti metrik utama, penagihan, dan informasi berguna lainnya.

### Penyesuaian

Anda dapat menyesuaikan dasbor dengan mengklik [Sesuaikan][spotlight-customize-dashboard].
Setiap kartu dapat disembunyikan, ditampilkan, dan disusun ulang pada halaman ini. Setiap kartu juga memiliki opsi kustom yang dapat diakses dari menu tambahan saat kursor diarahkan ke atas kartu tersebut.

## Melihat aktivitas di seluruh resource GCP

Dengan [Arus Aktivitas][spotlight-activity-stream], Anda akan dapat memahami semua aktivitas yang terjadi di seluruh resource GCP dari 1 tempat.

Lihat apa yang diperbarui oleh anggota tim Anda dalam suatu proyek untuk melacak masalah dan mengaudit akses. Filter feed dengan mudah untuk menemukan resource yang Anda perlukan dengan tepat.

## Melakukan penelusuran di seluruh Cloud Console

Dengan [kotak penelusuran][spotlight-search-bar] di Cloud Console, Anda dapat mengakses produk Google Cloud dan semua resource di seluruh GCP dengan cepat.

Coba jalankan penelusuran untuk **App Engine** atau nama salah satu project Anda.

## Mendapatkan dukungan kapan saja

Jika Anda mengalami kebuntuan atau memerlukan bantuan dalam menjelajahi dunia GCP, tim dukungan kami siap membantu.

[Pelajari Dukungan lebih lanjut](http://cloud.google.com/support)

Akses dukungan dari menu navigasi.

<walkthrough-menu-navigation sectionid="SUPPORT_SECTION"></walkthrough-menu-navigation>

## Mengelola pengguna dan izin

Dengan Google Cloud Identity and Access Management (Cloud IAM), Anda dapat mengelola dan membuat izin untuk resource GCP Anda.

[Pelajari IAM lebih lanjut](https://cloud.google.com/iam/docs/)

Seiring pertumbuhan tim, Anda dapat memberikan akses ke anggota tim menggunakan Cloud IAM di bagian "IAM & Admin".

Tambahkan pengguna, grup, atau akun layanan, lalu tetapkan sejumlah peran untuk memberikan izin yang mereka perlukan.

<walkthrough-menu-navigation sectionid="IAM_ADMIN_SECTION"></walkthrough-menu-navigation>

## Mengakses command-line dari browser

Google Cloud Shell menyediakan akses command-line ke resource cloud langsung dari browser. Anda dapat mengelola project dan resource dengan mudah, tanpa perlu menginstal Google Cloud SDK atau fitur lainnya di sistem Anda.

Dengan <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[Cloud Shell][spotlight-open-devshell], fitur command-line gcloud Cloud SDK dan utilitas lain yang Anda perlukan selalu tersedia, terkini, dan terautentikasi sepenuhnya setiap kali Anda memerlukannya.

[Pelajari Cloud Shell lebih lanjut](https://cloud.google.com/shell/)

## Melanjutkan perjalanan GCP Anda

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Sekarang Anda tentu telah memahami cara menavigasi Cloud Console dengan dasar yang mantap untuk menjelajahi layanan dan produk baru.

[Dokumentasi terperinci](https://cloud.google.com/docs/) kami juga menyediakan banyak informasi, dari ringkasan produk hingga panduan mulai cepat serta referensi API.

Kembali ke halaman Mulai untuk mempelajari tutorial lainnya.
<walkthrough-menu-navigation sectionid="ONBOARDING_SECTION"></walkthrough-menu-navigation>

[gcp-resources]: https://cloud.google.com/resource-manager/docs/cloud-platform-resource-hierarchy
[spotlight-activity-stream]: walkthrough://spotlight-pointer?cssSelector=.mat-tab-link:nth-of-type(2)
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-customize-dashboard]: walkthrough://spotlight-pointer?cssSelector=.cfc-customize-button
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-project-select]: walkthrough://spotlight-pointer?spotlightId=purview-switcher
[spotlight-search-bar]: walkthrough://spotlight-pointer?cssSelector=.p6n-search-bar,.pcc-platform-bar-search-bar
