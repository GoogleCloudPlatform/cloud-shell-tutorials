# Mengaktifkan IAP untuk GCE/GKE

Identity-Aware Proxy (IAP) hanya mengamankan traffic yang melewati load balancer. Ikuti langkah-langkah di bawah untuk melindungi aplikasi Anda dari serangan yang tidak sah.

[Pelajari lebih lanjut](https://cloud.google.com/iap/docs/)

## Berikut ini langkah-langkah yang perlu Anda selesaikan:

### Tinjau konfigurasi jaringan

Jika IP load balancer, `130.211.0.0/22` dan `35.191.0.0/16`, tidak dapat mencapai backend, IAP **tidak akan berfungsi**.

Jika ada IP lain yang dapat mengakses backend, traffic tersebut akan mengabaikan kebijakan akses IAP Anda. Dalam kasus tertentu, hal ini dapat berguna, seperti mengizinkan sistem pemantauan untuk terhubung ke backend.

### Pantau konfigurasi jaringan Anda

Jika konfigurasi berubah setelah IAP diaktifkan, konfigurasi Anda dapat menjadi tidak aman.
Terapkan [Forseti Security][forseti-security], sebuah program open source yang dikelola oleh Google untuk terus memantau konfigurasi project dan mengirim notifikasi.

### Terapkan pemeriksaan header bertanda tangan

[Pelajari cara](https://cloud.google.com/iap/docs/signed-headers-howto) melindungi aplikasi dari pengabaian kebijakan akses IAP, seperti:

  *  Admin project tidak sengaja menonaktifkan IAP
  *  Error konfigurasi jaringan
  *  Seorang pengguna login ke VM dan terhubung ke server web melalui hosting lokal

### Konfirmasi konfigurasi

Setujui bahwa Anda telah membaca dan mengonfigurasi resource GCE/GKE sesuai dengan dokumentasi.

[Tunjukkan caranya][spotlight-config-reviewed]

[forseti-security]: https://opensource.google.com/projects/forseti-security
[spotlight-config-reviewed]: walkthrough://spotlight-pointer?spotlightId=iap-network-config-reviewed
