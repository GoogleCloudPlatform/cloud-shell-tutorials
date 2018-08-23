# Stackdriver Error Reporting

## Pengantar

Stackdriver Error Reporting menggabungkan dan menampilkan error yang ditimbulkan oleh layanan cloud.

Tutorial ini akan memandu Anda mengenal antarmuka web Error Reporting. Anda akan mempelajari cara menampilkan error aplikasi, melihat detail lainnya mengenai error, dan mengambil tindakan.

## Penyiapan Project

<walkthrough-project-setup></walkthrough-project-setup>

## Membuat error

Sebelum melanjutkan, Anda harus melaporkan error buatan. Anda akan menggunakan perintah `gcloud` untuk melakukannya.

Dalam skenario yang sebenarnya, error ini akan dilaporkan langsung dari aplikasi yang sedang berjalan. Setelah menyelesaikan tutorial ini, Anda dapat mempelajari cara menyiapkan Error Reporting lebih lanjut.

### Membuka Google Cloud Shell

Buka Cloud Shell dengan mengklik <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[ikon][spotlight-open-devshell] di menu navigasi di bagian atas konsol.

### Melaporkan beberapa error

Klik tombol **Salin ke clipboard** di kanan atas skrip berikut, kemudian jalankan skrip dalam Cloud Shell untuk membuat error contoh.

```bash
COUNTER=0
while [  $COUNTER -lt 11 ]; do
    gcloud beta error-reporting events report --service tutorial --service-version v$((COUNTER/10+1)) \
        --message "java.lang.RuntimeException: Error rendering template $COUNTER
          at com.example.TestClass.test(TestClass.java:51)
          at com.example.AnotherClass(AnotherClass.java:25)
          at javax.servlet.http.HttpServlet.service (HttpServlet.java:617)
          at javax.servlet.http.HttpServlet.service (HttpServlet.java:717)"
    if [ $COUNTER -lt 3 ]; then
      gcloud beta error-reporting events report --service tutorial --service-version v1 \
          --message "java.lang.ArrayIndexOutOfBoundsException: $COUNTER
            at com.example.AppController.createUser(AppController.java:42)
            at com.example.User(User.java:31)
            at javax.servlet.http.HttpServlet.service (HttpServlet.java:617)
            at javax.servlet.http.HttpServlet.service (HttpServlet.java:717)"
    fi
    if [ $COUNTER -eq 10 ]; then
      echo "All artificial errors reported."
    fi
    let COUNTER=COUNTER+1
done
```

### Menutup Cloud Shell

Tutup Cloud Shell dan klik *Lanjutkan* setelah selesai.

## Membuat daftar error aplikasi

Kita akan menggunakan Stackdriver Error Reporting untuk melihat sekilas error yang dilaporkan.

### Membuka Error Reporting

Buka [menu][spotlight-console-menu] di sisi kiri konsol.

Lalu, scroll ke kategori **Stackdriver** dan pilih **Error Reporting**.

<walkthrough-menu-navigation sectionid="CRASH_SECTION"></walkthrough-menu-navigation>

### Mengurutkan berdasarkan *Pertama dilihat*

Error yang terjadi dalam aplikasi Anda dikelompokkan dan dihilangkan duplikasinya dengan menganalisis pelacakan stack error tersebut. Setiap entri dalam daftar ini menyediakan rangkuman yang membantu Anda menentukan kapan aplikasi mulai memunculkan error, seberapa sering terjadinya, dan seberapa baru error ini terjadi.

Pengurutan defaultnya adalah *Kekerapan*. Klik judul kolom *Pertama dilihat* untuk melihat error yang baru-baru ini mulai terjadi.

### Memilih untuk diberi tahu jika ada error baru

Email dan notifikasi push seluler dapat dikirimkan jika terjadi error yang baru dilihat dalam project. Untuk memilih notifikasi ini, klik *Aktifkan notifikasi*.

Klik *Lanjutkan* setelah selesai.

## Memahami detail error

### Membuka laporan error

Klik salah satu error dari daftar untuk melihat detailnya.

### Menautkan masalah ke error ini

Gunakan halaman ini untuk memeriksa informasi dan histori error tertentu.

Setelah melihat error yang baru, langkah umum berikutnya adalah melaporkan masalah dalam pelacak masalah tim Anda. Entri pelacak masalah Anda dapat ditautkan kembali ke error di Stackdriver Error Reporting.

Untuk melakukannya:

  *  Klik *Tautkan ke masalah* di bagian atas (Anda mungkin perlu membuka menu **tindakan lainnya** untuk melihat link ini).
  *  Ketik `http://example.com/issues/1234` dalam dialog.
  *  Klik *Simpan*.

### Mempelajari pelacakan stack

Untuk membantu Anda berfokus pada kode, kami menyembunyikan frame pelacakan stack yang tidak berasal dari kode aplikasi Anda.

Klik *Tampilkan semua* dalam contoh error untuk menampilkan frame stack framework.

## Kesimpulan

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Selamat! Anda berhasil menyelesaikan tutorial Stackdriver Error Reporting.

Inilah yang dapat Anda lakukan selanjutnya:

### Menyiapkan Error Reporting untuk project Anda

Pelajari cara menyiapkan Error Reporting untuk layanan yang sedang berjalan dalam [dokumentasi penyiapan][errors-setup].

### Mempelajari tutorial Stackdriver lainnya

Lakukan proses debug pada aplikasi produksi dengan panduan memulai [Stackdriver Debugger][debug-quickstart].

Pahami latensi aplikasi Anda dengan panduan memulai [Stackdriver Trace][trace-quickstart].

[debug-quickstart]: https://cloud.google.com/debugger/docs/quickstart
[errors-setup]: https://cloud.google.com/error-reporting/docs/how-to
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[trace-quickstart]: https://cloud.google.com/trace/docs/quickstart
