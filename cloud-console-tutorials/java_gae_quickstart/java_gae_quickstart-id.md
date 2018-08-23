# Panduan Memulai App Engine

<walkthrough-test-start-page url="/getting-started?tutorial=java_gae_quickstart_2"/>

<walkthrough-tutorial-url url="https://cloud.google.com/appengine/docs/java/quickstart"/>

<walkthrough-watcher-constant key="repo-url" value="https://github.com/GoogleCloudPlatform/appengine-try-java" />

<walkthrough-watcher-constant key="repo-name" value="appengine-try-java"/>

## Pengantar

Tutorial ini menunjukkan cara menerapkan contoh aplikasi [Java][java] ke Google
App Engine menggunakan plugin App Engine Maven.

Berikut langkah-langkah yang perlu Anda lakukan.

*   **Membangun dan menjalankan aplikasi "Hello, world!" Anda**

    Anda akan mempelajari cara menjalankan aplikasi menggunakan Google Cloud
    Shell di browser yang digunakan. Di bagian akhir, Anda akan menerapkan
    aplikasi tersebut ke web menggunakan plugin App Engine Maven.

*   **Setelah aplikasi...**

    Aplikasi Anda akan siap digunakan, dan Anda dapat bereksperimen dengan
    aplikasi tersebut setelah menerapkannya, atau Anda bisa menghapusnya dan
    memulai lagi dari awal.

[Java is a registered trademark of Oracle and/or its affiliates.](walkthrough://footnote)

<walkthrough-devshell-precreate/>

## Penyiapan project

Untuk menerapkan aplikasi, pertama-tama Anda perlu membuat sebuah project.

Google Cloud Platform mengatur resource ke dalam project. Dengan demikian, Anda
dapat mengumpulkan semua resource terkait untuk sebuah aplikasi di satu tempat.

<walkthrough-project-setup/>

## Menggunakan Google Cloud Shell

Cloud Shell adalah fitur command line terpasang untuk konsol. Kita akan
menggunakan Cloud Shell untuk menerapkan aplikasi.

### Membuka Google Cloud Shell

Buka Cloud Shell dengan mengklik <walkthrough-cloud-shell-icon/>
[icon](walkthrough://spotlight-pointer?spotlightId=devshell-activate-button) di
menu navigasi di bagian atas konsol.

### Membuat clone kode contoh

Gunakan Cloud Shell untuk membuat clone dan membuka kode "Hello World". Kode
contoh dikloning dari repositori project Anda ke Cloud Shell.

Catatan: Jika direktori sudah ada, hapus file sebelumnya sebelum melakukan
kloning:

```bash
rm -rf {{repo-name}}
```

Di Cloud Shell, masukkan:

```bash
git clone {{repo-url}}
```

Kemudian, beralihlah ke direktori tutorial:

```bash
cd {{repo-name}}
```

## Mengonfigurasi penerapan Anda

Sekarang Anda berada di direktori utama untuk kode contoh. Kita akan melihat
file yang mengonfigurasi aplikasi Anda.

### Menjelajahi aplikasi

Masukkan perintah berikut untuk melihat kode aplikasi Anda:

```bash
cat src/main/java/myapp/DemoServlet.java
```

Servlet ini akan menanggapi setiap permintaan dengan mengirimkan respons yang
berisi pesan `Hello, world!`.

### Menjelajahi konfigurasi Anda

Untuk Java, Google App Engine menggunakan file XML untuk menentukan konfigurasi
penerapan Anda.

Masukkan perintah berikut untuk melihat file konfigurasi Anda:

```bash
cat pom.xml
```

Aplikasi `helloworld` menggunakan Maven, yang berarti Anda harus menentukan
Project Object Model, atau POM, yang berisi informasi tentang detail project dan
konfigurasi yang digunakan Maven untuk membangun project tersebut.

## Menguji aplikasi Anda

### Menguji aplikasi Anda di Cloud Shell

Dengan Cloud Shell, Anda dapat menguji aplikasi sebelum diterapkan untuk
memastikan aplikasi tersebut berfungsi sebagaimana mestinya, seperti melakukan
debug di komputer Anda.

Untuk menguji aplikasi Anda, masukkan:

```bash
mvn appengine:run
```

<walkthrough-test-code-output
  text="module .* running at|Dev App Server is now running" />

### Melihat pratinjau aplikasi Anda dengan "Pratinjau web"

Aplikasi Anda sekarang berjalan di Cloud Shell. Anda dapat mengakses aplikasi
menggunakan "Pratinjau web" <walkthrough-web-preview-icon/> untuk terhubung ke
port 8080. [Tunjukan
caranya](walkthrough://spotlight-pointer?spotlightId=devshell-web-preview-button)

### Menghentikan instance pratinjau

Hentikan instance aplikasi dengan menekan `Ctrl+C` di Cloud Shell.

## Menerapkan aplikasi ke Google App Engine

### Membuat aplikasi

Untuk menerapkan aplikasi, kita perlu membuat aplikasi di sebuah region:

```bash
gcloud app create
```

Catatan: Jika sudah membuat aplikasi, Anda dapat melewati langkah ini.

### Menerapkan aplikasi dengan Cloud Shell

Sekarang Anda dapat menggunakan Cloud Shell untuk menerapkan aplikasi.

Pertama-tama, tentukan project yang akan digunakan:

```bash
gcloud config set project {{project-id}}
```

Kemudian, terapkan aplikasi Anda:

```bash
mvn appengine:deploy
```

<walkthrough-test-code-output text="Deployed (module|service)" />

### Mengunjungi aplikasi Anda

Aplikasi Anda telah diterapkan. URL default aplikasi Anda adalah
[{{project-gae-url}}](http://{{project-gae-url}}) Klik URL tersebut untuk
mengunjunginya.

### Melihat status aplikasi Anda

Anda dapat memeriksa aplikasi dengan memantau statusnya di dasbor App Engine.

Buka [menu](walkthrough://spotlight-pointer?spotlightId=console-nav-menu) di
bagian kiri konsol.

Kemudian, pilih bagian **App Engine**.

<walkthrough-menu-navigation sectionId="APPENGINE_SECTION"/>

## Kesimpulan

<walkthrough-conclusion-trophy/>

Selamat! Anda telah berhasil menerapkan aplikasi App Engine. Berikut beberapa
langkah selanjutnya yang perlu dilakukan:

**Download Google Cloud SDK dan kembangkan secara lokal**

[Google Cloud SDK][cloud-sdk-installer]

**Bangun aplikasi Anda selanjutnya**

Pelajari cara menggunakan App Engine dengan produk Google Cloud Platform
lainnya:

<walkthrough-tutorial-card
  url="appengine/docs/java/datastore/"
  icon="DATASTORE_SECTION"
  label="datastore">
**Pelajari cara menggunakan Cloud Datastore**
Cloud Datastore adalah basis data NoSQL yang sangat skalabel untuk aplikasi Anda.
</walkthrough-tutorial-card>

<walkthrough-tutorial-card
  url="appengine/docs/java/googlecloudstorageclient/setting-up-cloud-storage/"
  icon="STORAGE_SECTION"
  label="cloudStorage">
**Pelajari cara menggunakan Cloud Storage**
Cloud Storage adalah layanan penyimpanan objek yang hebat dan sederhana.
</walkthrough-tutorial-card>

[java]: https://java.com/
[cloud-sdk-installer]: https://cloud.google.com/sdk/downloads#interactive
