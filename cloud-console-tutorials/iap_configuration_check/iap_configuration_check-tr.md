# GCE/GKE için IAP'yi açma

Kimliğe Duyarlı Proxy (IAP), yalnızca yük dengeleyiciden geçen trafiği güvenceye alır. Uygulamanızı yetkisiz saldırılardan korumak için aşağıdaki adımları uygulayın.

[Daha fazla bilgi](https://cloud.google.com/iap/docs/)

## Uygulayacağınız adımlar şunlardır:

### Ağ yapılandırmasını inceleyin

Yük dengeleyici IP'leri olan `130.211.0.0/22` ve `35.191.0.0/16`, arka uçlarınıza erişemezse IAP **çalışmaz**.

Başka IP'ler arka uçlarınıza erişebiliyorsa bu trafik IAP erişim politikanızı atlar. Bazı durumlarda bu faydalı olabilir (ör. izleme sistemlerinin arka uçlara bağlanmasına izin vermek gibi).

### Ağ yapılandırmanızı izleyin

IAP etkinleştirildikten sonra yapılandırmanız değişirse güvensiz hale gelebilir.
Proje yapılandırmasını sürekli olarak izlemek ve bildirimler göndermek için Google tarafından yönetilen açık kaynaklı bir araç olan [Forseti Security][forseti-security]'yi dağıtın.

### İmzalanmış başlık kontrolü uygulayın

Uygulamanızı aşağıdakiler gibi IAP erişim politikası atlamalarına karşı korumayı [öğrenin](https://cloud.google.com/iap/docs/signed-headers-howto):

  *  Bir proje yöneticisinin IAP'yi yanlışlıkla devre dışı bırakması
  *  Ağ yapılandırma hataları
  *  Sanal makinede oturum açan ve localhost aracılığıyla web sunucusuna bağlanan bir kullanıcı

### Yapılandırmayı doğrulayın

GCE/GKE kaynağını okuduğunuzu ve belgelere göre yapılandırdığınızı kabul edin.

[Nasıl yapıldığını göster][spotlight-config-reviewed]

[forseti-security]: https://opensource.google.com/projects/forseti-security
[spotlight-config-reviewed]: walkthrough://spotlight-pointer?spotlightId=iap-network-config-reviewed
