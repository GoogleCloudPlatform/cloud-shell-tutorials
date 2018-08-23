# Pengantar Cloud IoT Core

<walkthrough-tutorial-url url="https://cloud.google.com/iot/docs/quickstart"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="https://github.com/GoogleCloudPlatform/nodejs-docs-samples.git" key="repo-url"></walkthrough-watcher-constant>

## Pengantar

Google Cloud Internet of Things (IoT) Core adalah layanan terkelola sepenuhnya untuk menghubungkan dan mengelola perangkat IoT dengan aman, dari beberapa hingga jutaan perangkat. Tutorial ini menunjukkan cara menggunakan fitur command-line `gcloud` untuk membuat registry perangkat Cloud IoT Core dan menambahkan perangkat. Tutorial ini juga menunjukkan cara menjalankan sampel MQTT untuk menghubungkan perangkat dan memublikasikan peristiwa telemetri perangkat.

Tutorial ini akan memandu Anda untuk:

  *  Membuat topik Cloud Pub/Sub
  *  Membuat registry perangkat
  *  Menambahkan perangkat ke registry
  *  Menyiapkan kredensial pada perangkat
  *  Membuat langganan ke topik Pub/Sub untuk mengirim dan menerima pesan
  *  Menghubungkan perangkat virtual dan melihat data telemetri

## Penyiapan project

Google Cloud Platform mengatur resource ke dalam sejumlah project. Dengan begitu, Anda dapat mengumpulkan semua resource terkait untuk sebuah aplikasi di 1 tempat.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## Menggunakan Google Cloud Shell

Dalam tutorial ini, Anda akan melakukan semua pekerjaan di Cloud Shell.

### Membuka Google Cloud Shell

Buka Cloud Shell dengan mengklik <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[ikon][spotlight-open-devshell] di menu navigasi di bagian atas konsol.

### Mengaktifkan Google Cloud API

Ini akan mengaktifkan Cloud IoT Core API.

<walkthrough-enable-apis apis="cloudiot.googleapis.com"></walkthrough-enable-apis>

## Membuat topik pertama Anda

Topik adalah resource bernama yang menjadi tujuan pengiriman pesan perangkat. Buat topik pertama dengan perintah berikut:

```bash
gcloud pubsub topics create my-topic
```

Anda akan mengirimkan beberapa pesan ke topik ini nanti.

## Membuat clone file sampel Node.js Cloud IoT Core dari GitHub

Anda akan menggunakan sampel MQTT untuk mengirim pesan ke Cloud IoT Core.

Catatan: Jika direktori sudah ada, hapus file sebelumnya sebelum meng-clone:

```bash
rm -rf nodejs-docs-samples
```

Buat clone program sampel dengan perintah berikut:

```bash
git clone {{repo-url}}
```

## Memberikan izin ke akun layanan Cloud IoT Core

Dengan menggunakan skrip helper di folder `/iot/scripts`, tambahkan akun layanan `cloud-iot@system.gserviceaccount.com` ke topik Cloud Pub/Sub dengan peran Publisher.

### Membuka direktori iot:

```bash
cd nodejs-docs-samples/iot
```

### Menginstal dependensi:

```bash
npm --prefix ./scripts install
```

### Menjalankan skrip helper:

```bash
node scripts/iam.js my-topic
```

Skrip ini memberikan izin ke akun layanan Cloud IoT Core pada topik `my-topic`.

## Membuat registry perangkat

Registry perangkat memuat perangkat dan menentukan properti yang digunakan bersama oleh semua perangkat yang ada. Buat registry perangkat dengan perintah berikut:

```bash
gcloud iot registries create my-registry \
    --project={{project-id}} \
    --region=us-central1 \
    --event-notification-config=topic=projects/{{project-id}}/topics/my-topic
```

## Membuat kunci penandatanganan

Untuk mengautentikasi ke Cloud IoT Core, perangkat memerlukan kunci pribadi dan kunci publik. Buatlah kunci penandatanganan dengan menjalankan perintah berikut:

```bash
./scripts/generate_keys.sh
```

Skrip ini membuat kunci RS256 dan ES256 dalam format PEM, tetapi Anda hanya memerlukan kunci RS256 untuk tutorial ini. Kunci pribadi harus disimpan dengan aman pada perangkat dan digunakan untuk menandatangani JWT autentikasi ([Token Web JSON][web-token-docs]). Kunci publik disimpan dalam registry perangkat.

## Membuat perangkat dan menambahkannya ke registry

Jalankan perintah berikut untuk membuat perangkat dan menambahkannya ke registry:

```bash
gcloud iot devices create my-node-device \
    --project={{project-id}} \
    --region=us-central1 \
    --registry=my-registry \
    --public-key path=rsa_cert.pem,type=rs256
```

## Menghubungkan perangkat dan melihat data telemetri

Pada langkah ini, Anda akan mengirim pesan dari perangkat virtual ke Pub/Sub. Selanjutnya, Anda akan menarik pesan itu dan melihatnya.

### Membuka direktori sampel MQTT:

```bash
cd mqtt_example
```

### Menginstal dependensi Node.js:

```bash
npm install
```

### Menjalankan perintah berikut untuk menghubungkan perangkat virtual ke Cloud IoT Core menggunakan perantara MQTT:

```bash
node cloudiot_mqtt_example_nodejs.js \
    --projectId={{project-id}} \
    --registryId=my-registry \
    --deviceId=my-node-device \
    --privateKeyFile=../rsa_private.pem \
    --numMessages=25 \
    --algorithm=RS256 \
    --mqttBridgePort=443
```

Output menunjukkan bahwa perangkat virtual memublikasikan pesan ke topik telemetri. Ada 25 pesan yang dipublikasikan.

## Membuat langganan ke topik perangkat

Jalankan perintah berikut untuk membuat langganan agar dapat melihat pesan yang dipublikasikan oleh perangkat Anda:

```bash
gcloud pubsub subscriptions create \
    projects/{{project-id}}/subscriptions/my-subscription \
    --topic=my-topic
```

## Menarik pesan yang dipublikasikan

Tarik pesan yang dipublikasikan oleh perangkat dengan menjalankan perintah berikut:

```bash
gcloud pubsub subscriptions pull --auto-ack \
    projects/{{project-id}}/subscriptions/my-subscription
```

Menjalankan perintah ini akan menampilkan pesan yang dipublikasikan oleh perangkat. Pesan tersebut memiliki data berikut, `my-registry/my-node-device-payload-&lt;INTEGER&gt;`, `MESSAGE_ID`, dan daftar `ATTRIBUTES` informasi tentang perangkat. `MESSAGE_ID` adalah ID unik yang ditetapkan oleh server.

Catatan: Cloud Pub/Sub tidak menjamin urutan pesan. Mungkin saja Anda hanya akan melihat 1 pesan di Cloud Shell. Dalam hal ini, coba jalankan perintah yang sama beberapa kali sampai Anda melihat pesan lainnya.

## Melihat resource di Google Cloud Platform Console

Langkah ini mengakhiri tutorial command-line `gcloud`, tetapi Anda juga dapat menggunakan GCP Console untuk melihat resource yang baru saja Anda buat.

Buka [menu][spotlight-console-menu] di sisi kiri konsol.

Lalu, pilih **IoT Core**.

<walkthrough-menu-navigation sectionid="IOT_SECTION"></walkthrough-menu-navigation>

UI ini juga memungkinkan Anda membuat dan mengelola registry perangkat dan perangkat.

## Kesimpulan

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Selamat! Anda baru saja mempelajari berbagai konsep dasar Cloud IoT Core menggunakan fitur command-line `gcloud`, dan menggunakan GCP Console untuk melihat resource Cloud IoT Core. Langkah berikutnya adalah membuat aplikasi yang hebat. Untuk informasi lebih lanjut, baca [dokumentasi IoT Core](https://cloud.google.com/iot/docs/).

### Inilah yang dapat Anda lakukan selanjutnya

Lihat sampel Cloud IoT Core lainnya di GitHub:

  *  [C](https://github.com/GoogleCloudPlatform/cpp-docs-samples/tree/master/iot/mqtt-ciotc)
  *  [Java](https://github.com/GoogleCloudPlatform/java-docs-samples/tree/master/iot/api-client)
  *  [Node.js](https://github.com/GoogleCloudPlatform/nodejs-docs-samples/tree/master/iot)
  *  [Python](https://github.com/GoogleCloudPlatform/python-docs-samples/tree/master/iot/api-client)

[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[web-token-docs]: https://cloud.google.com/iot/docs/how-tos/credentials/jwts
