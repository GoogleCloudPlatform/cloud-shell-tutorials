# Panduan Memulai Compute Engine

## Membuat aplikasi rencana dengan MongoDB

<walkthrough-tutorial-duration duration="15"></walkthrough-tutorial-duration>

Dalam panduan memulai ini, Anda akan menggunakan Compute Engine untuk membuat
aplikasi dua tingkat. VM frontend menjalankan aplikasi web rencana Node.js,
sedangkan VM backend menjalankan MongoDB.

Tutorial ini akan memandu Anda untuk:

*   Membuat dan mengonfigurasi dua VM
*   Menyiapkan aturan firewall
*   Menggunakan SSH untuk menginstal paket pada VM Anda

## Penyiapan project

Google Cloud Platform mengatur resource ke dalam sejumlah project. Dengan
begitu, Anda dapat mengumpulkan semua resource terkait untuk sebuah aplikasi di
satu tempat.

<walkthrough-project-billing-setup permissions="compute.instances.create"></walkthrough-project-billing-setup>

## Membuka Compute Engine

Buka [menu][spotlight-console-menu] di sisi kiri konsol.

Kemudian, pilih bagian **Compute Engine**.

<walkthrough-menu-navigation sectionid="COMPUTE_SECTION"></walkthrough-menu-navigation>

## Membuat instance

Anda akan membuat 2 instance untuk menjadi server backend dan frontend bagi
aplikasi.

### Buat backend instance

Pertama, buat backend instance yang menjalankan MongoDB. Server ini menyimpan
item rencana.

Klik tombol [Buat instance][spotlight-create-instance].

*   Pilih [nama][spotlight-instance-name] dan [zona][spotlight-instance-zone]
    untuk instance ini.

*   Pilih [f1-micro][spotlight-machine-type]. Opsi ini akan menghasilkan biaya
    lebih murah.

    *   [Pelajari penetapan harga lebih lanjut][pricing]

*   Pilih [Ubuntu 14.04 LTS][spotlight-boot-disk] sebagai disk image booting
    untuk tutorial ini.

*   Di [pemilih Firewall][spotlight-firewall], pilih **Izinkan traffic HTTP**.
    Tindakan ini akan membuka port 80 (HTTP) untuk mengakses aplikasi.

*   Klik tombol [Buat][spotlight-submit-create] untuk membuat instance.

Catatan: Setelah instance dibuat, akun penagihan Anda akan mulai ditagih sesuai
dengan harga GCE. Anda harus menghapus instance ini nanti untuk menghindari
tagihan tambahan.

### Buat frontend instance

Sementara VM backend bekerja, buatlah frontend instance yang menjalankan
aplikasi rencana Node.js. Gunakan konfigurasi yang sama dengan backend instance.

## Penyiapan

Anda harus menginstal database MongoDB pada backend instance untuk menyimpan
data.

[Tombol SSH][spotlight-ssh-buttons] dalam tabel akan membuka sesi SSH ke
instance Anda di jendela terpisah.

Untuk tutorial ini, Anda akan terhubung menggunakan Cloud Shell. Cloud Shell
adalah fitur command-line bawaan untuk konsol.

### Buka Cloud Shell

Buka Cloud Shell dengan mengklik
<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[ikon][spotlight-open-devshell]
di menu navigasi di bagian atas konsol.

### Tunggu hingga instance selesai dibuat

Instance harus selesai dibuat sebelum tutorial dapat dilanjutkan. Aktivitas
dapat dilacak dengan mengklik [menu pemberitahuan][spotlight-notification-menu]
dari menu navigasi di bagian atas.

## Menghubungkan ke backend instance

### Hubungkan ke instance

Masukkan perintah berikut ke SSH di dalam VM. Jika ini pertama kalinya Anda
menggunakan SSH dari Cloud Shell, Anda harus membuat kunci pribadi. Masukkan
zona dan nama instance yang Anda buat.

```bash
gcloud compute --project "{{project-id}}" ssh --zone <backend-zone> <backend-name>
```

### Instal database backend

Sekarang setelah Anda memiliki koneksi SSH ke backend instance, gunakan perintah
berikut untuk menginstal database backend:

Update paket dan instal MongoDB. Ketika ditanya apakah Anda ingin melanjutkan,
ketik `Y`:

```bash
sudo apt-get update
```

```bash
sudo apt-get install mongodb
```

### Jalankan database

Layanan MongoDB mulai dijalankan setelah Anda menginstalnya. Anda harus
menghentikannya agar dapat mengubah cara menjalankannya.

```bash
sudo service mongodb stop
```

Buat direktori untuk MongoDB, kemudian jalankan layanan MongoDB di latar
belakang pada port 80.

```bash
sudo mkdir $HOME/db
```

```bash
sudo mongod --dbpath $HOME/db --port 80 --fork --logpath /var/tmp/mongodb
```

Setelah itu, tutup sesi SSH menggunakan perintah `exit`:

```bash
exit
```

## Menghubungkan ke frontend instance

### Instal dan jalankan aplikasi web pada VM frontend

Server backend sudah berjalan, jadi sekarang saatnya menginstal aplikasi web
frontend.

### Hubungkan ke instance

Masukkan perintah berikut ke SSH di dalam VM. Masukkan zona dan nama instance
yang Anda buat.

```bash
gcloud compute --project "{{project-id}}" ssh --zone <frontend-zone> <frontend-name>
```

### Instal dependensi

Sekarang setelah Anda terhubung ke frontend instance, update paket dan instal
git, Node.js, dan npm. Ketika ditanya apakah Anda ingin melanjutkan, ketik `Y`:

```bash
sudo apt-get update
```

```bash
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
```

```bash
sudo apt-get install git nodejs
```

### Instal dan jalankan aplikasi web frontend

Clone aplikasi sampel dan instal dependensi aplikasi.

```bash
git clone https://github.com/GoogleCloudPlatform/todomvc-mongodb.git
```

```bash
cd todomvc-mongodb; npm install
```

```bash
sed -i -e 's/8080/80/g' server.js
```

Mulai aplikasi web rencana dengan perintah berikut, dengan memasukkan
[alamat IP internal][spotlight-internal-ip] untuk instance yang Anda buat.

```bash
sudo nohup nodejs server.js --be_ip <backend-internal-ip> --fe_ip <frontend-internal-ip> &
```

Setelah itu, tutup sesi SSH menggunakan perintah `exit`:

```bash
exit
```

### Buka aplikasi Anda

Buka server web Anda di alamat IP yang tercantum di kolom
[IP Eksternal][spotlight-external-ip], di samping frontend instance Anda.

## Pembersihan

Untuk menghapus instance Anda, pilih
[kotak centang][spotlight-instance-checkbox] di samping nama instance dan klik
[tombol Hapus][spotlight-delete-button].

## Kesimpulan

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Selesai!

Inilah yang dapat Anda lakukan selanjutnya:

*   Cari sampel Google Cloud Platform
    [di GitHub](http://googlecloudplatform.github.io/).

*   Pelajari cara menyiapkan
    [Load Balancing](https://cloud.google.com/compute/docs/load-balancing/).

*   Pelajari cara
    [mentransfer file ke Mesin Virtual Anda](https://cloud.google.com/compute/docs/instances/transfer-files/).

*   Pelajari cara
    [menjalankan container](https://cloud.google.com/compute/docs/containers).

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
