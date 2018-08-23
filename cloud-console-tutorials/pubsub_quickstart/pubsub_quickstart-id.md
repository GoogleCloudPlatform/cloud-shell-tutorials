# Pengantar Cloud Pub/Sub

<walkthrough-tutorial-url url="https://cloud.google.com/pubsub/quickstart-console"></walkthrough-tutorial-url></walkthrough-test-start-page>

<walkthrough-devshell-precreate></walkthrough-devshell-precreate>

## Pengantar

Cloud Pub/Sub adalah layanan messaging real-time terkelola sepenuhnya yang dapat Anda gunakan untuk mengirim dan menerima pesan antar-aplikasi secara independen. Tutorial ini memberikan pengantar singkat mengenai antarmuka command-line Cloud Pub/Sub menggunakan perintah `gcloud`.

## Penyiapan Project

Google Cloud Platform mengatur resource ke dalam sejumlah project. Dengan begitu, Anda dapat mengumpulkan semua resource terkait untuk sebuah aplikasi di 1 tempat.

Cloud Pub/Sub membutuhkan project untuk menyiapkan pesan.

<walkthrough-project-setup></walkthrough-project-setup>

## Membuat topik pertama Anda

### Membuka Google Cloud Shell

Cloud Shell adalah fitur command-line bawaan untuk konsol. Anda memerlukan Cloud Shell untuk menyiapkan Cloud Pub/Sub.

Buka Cloud Shell dengan mengklik <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[ikon][spotlight-open-devshell] di menu navigasi di bagian atas konsol.

### Membuat topik

Topik adalah resource bernama yang menjadi tujuan pengiriman pesan. Buat topik pertama Anda dengan perintah berikut:

```bash
gcloud pubsub topics create my-topic
```

## Menambahkan langganan

Agar dapat menerima pesan, Anda harus membuat langganan. Langganan harus memiliki topik yang terkait. Buat langganan pertama dengan perintah berikut:

```bash
gcloud pubsub subscriptions \
    create my-sub --topic my-topic \
    --ack-deadline=60
```

Perintah ini menghasilkan langganan bernama `my-sub` yang terpasang ke topik `my-topic`. Semua pesan yang dipublikasikan ke `my-topic` akan dikirim ke langganan ini.

Anda mungkin melihat opsi `--ack-deadline=60`. `ack-deadline` adalah singkatan dari `Acknowledgement deadline`. Langganan baru ini memiliki `Acknowledgement deadline` 60 detik. Kami akan menjelaskan sepintas tentang hal ini nanti.

## Membuat daftar topik dan langganan

Sebelum mengirim pesan pertama Anda, pastikan topik dan langganan sudah berhasil dibuat. Buat daftar topik dan langganan menggunakan perintah berikut:

```bash
gcloud pubsub topics list
```

```bash
gcloud pubsub subscriptions list
```

## Memublikasikan pesan ke topik

Kirim 2 pesan dengan perintah berikut:

```bash
gcloud pubsub topics publish my-topic --message hello
```

```bash
gcloud pubsub topics publish my-topic --message goodbye
```

Setiap perintah ini mengirim sebuah pesan. Pesan pertama adalah `hello` dan pesan kedua adalah `goodbye`. Setelah berhasil memublikasikan pesan, Anda akan melihat ID pesan yang ditampilkan dari server. Ini adalah ID unik yang otomatis ditetapkan oleh server pada setiap pesan.

## Menarik pesan dari langganan

### Menarik pesan

Sekarang, tarik pesan dengan perintah berikut:

```bash
gcloud pubsub subscriptions \
    pull --auto-ack --limit=2 my-sub
```

Anda mungkin melihat 2 pesan yang baru saja dipublikasikan. Pesan tersebut memiliki data, `hello` dan `goodbye`, serta `MESSAGE_ID`. `MESSAGE_ID` adalah ID unik dari pesan yang ditetapkan server.

Catatan: Cloud Pub/Sub tidak menjamin urutan pesan. Mungkin juga Anda hanya akan melihat 1 pesan. Dalam hal ini, coba jalankan perintah yang sama beberapa kali sampai Anda melihat pesan lainnya.

### Menyatakan penerimaan dan tenggat pernyataan

Setelah menarik pesan dan memprosesnya dengan benar, Anda harus memberi tahu Cloud Pub/Sub bahwa Anda berhasil menerima pesan. Tindakan ini disebut **acknowledge** (menyatakan penerimaan).

Anda mungkin melihat tanda `--auto-ack` diteruskan bersama dengan perintah `pull`.
Tanda `--auto-ack` otomatis menarik pesan dan menyatakan penerimaannya.

## Pernyataan penerimaan manual

### Mengirim pesan baru

Kirim pesan baru dengan perintah berikut:

```bash
gcloud pubsub \
    topics publish my-topic --message thanks
```

### Menarik pesan lagi

Tarik pesan dengan:

```bash
gcloud pubsub subscriptions \
    pull my-sub
```

Ini akan menampilkan pesan `thanks`, serta `MESSAGE_ID`, dan `ACK_ID`. `ACK_ID` adalah ID lain yang bisa Anda gunakan untuk menyatakan penerimaan pesan.

### Menyatakan penerimaan pesan

Setelah menarik pesan, Anda harus menyatakan penerimaan sebelum **tenggat penerimaan pesan** berlalu. Misalnya, jika langganan dikonfigurasi agar memiliki **tenggat penerimaan pesan** 60 detik, seperti dalam tutorial ini, Anda harus menyatakan penerimaan dalam waktu 60 detik setelah menarik pesan tersebut. Jika tidak, Cloud Pub/Sub akan mengirim ulang pesan.

Nyatakan penerimaan pesan dengan perintah berikut (ganti `ACK_ID` dengan ID asli melalui copy/paste)

```bash
gcloud pubsub subscriptions ack \
    my-sub --ack-ids ACK_ID
```

## Melihat topik dan langganan di UI Pub/Sub

Tindakan ini mengakhiri tutorial command-line `gcloud`. Namun, mari kita lihat UI di Google Cloud Console sebelum menyelesaikan tutorial.

Anda juga dapat melihat topik dan langganan di bagian Pub/Sub.

### Membuka bagian Pub/Sub

Buka [menu][spotlight-console-menu] di sisi kiri konsol.

Lalu, pilih bagian **Pub/Sub**.

<walkthrough-menu-navigation sectionid="CLOUDPUBSUB_SECTION"></walkthrough-menu-navigation>

UI juga dapat Anda gunakan untuk membuat dan mengelola topik serta langganan.

### Menghapus topik

Centang kotak di samping topik yang Anda buat, lalu klik tombol [Hapus][spotlight-delete-button] untuk menghapus permanen topik.

## Kesimpulan

Selamat!

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Anda telah mempelajari berbagai konsep dasar Cloud Pub/Sub menggunakan fitur command-line `gcloud`. Anda juga sudah melihat sekilas UI Cloud Pub/Sub. Langkah selanjutnya adalah membuat aplikasi yang mengagumkan. Untuk informasi lebih lanjut, baca [dokumentasi Pub/Sub][pubsub-docs].

Inilah yang dapat Anda lakukan selanjutnya:

[Lihat contoh kode](https://cloud.google.com/pubsub/docs/quickstart-client-libraries)

[pubsub-docs]: https://cloud.google.com/pubsub/docs/
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-delete-button]: walkthrough://spotlight-pointer?cssSelector=.p6n-icon-delete
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
