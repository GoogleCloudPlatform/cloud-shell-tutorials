# Cloud Console Turu

<walkthrough-tutorial-duration duration="5"></walkthrough-tutorial-duration>

## Giriş

Bu eğitici, sizi Google Cloud Platform'da uygulamalarınızı oluşturmaya ve yönetmeye hazırlamak için Cloud Console'un temel özelliklerini ele alır.

Aşağıdaki kavramları öğreneceksiniz:

  *  GCP projeleri ve kaynakları
  *  Yüksek düzeydeki kaynaklara genel bakış ve etkinlik günlükleri
  *  Konsolda gezinme ve arama
  *  Kullanıcı ve izin yönetimi
  *  Teknik destek
  *  GCP'nin tarayıcı tabanlı komut satırı

Haydi başlayalım!

## GCP Kaynaklarını Kullanma

GCP kaynakları, tüm Google Cloud hizmetlerini oluşturan temel bileşenlerdir. Kaynaklar hiyerarşik olarak düzenlenir ve GCP'deki işlerinizi organize etmenize yardımcı olur.

Kaynak hiyerarşisinde ilk düzey olan projeler, Cloud Storage paketleri ve Compute Engine örnekleri gibi diğer alt düzey kaynakları içerir.

[GCP kaynakları hakkında daha fazla bilgi][gcp-resources]

### Projelerde gezinme

Cloud Console'daki [kapsam seçiciyi][spotlight-project-select] kullanarak GCP projeleriniz arasında kolayca gezinin. Proje değiştirildiğinde, görünüm ilgili proje ve tüm alt kaynakları gösterilecek şekilde uyarlanır.

<walkthrough-project-setup></walkthrough-project-setup>

## Google Cloud Hizmetlerinde Gezinme

### Hizmetlerde gezinme

Büyük Veri, İşlem ve Ağ İletişimi gibi ürün alanlarına göre düzenlenmiş Google Cloud hizmetlerine [soldaki gezinme menüsünden][spotlight-console-menu] erişebilirsiniz.

### Bölüm sabitleme

Düzenli olarak ziyaret ettiğiniz hizmetlere kolayca ulaşmak için fareyle bölüm öğesinin üzerine gelip iğne simgesini tıklayarak bölümü gezinme menüsünün üst kısmına sabitleyin.

Devam etmek için gezinme menüsünü açıp **Ana Sayfa**'yı seçin.

<walkthrough-menu-navigation sectionid="HOME_SECTION"></walkthrough-menu-navigation>

## Projelere Genel Bakış

### Ana sayfa kontrol paneli

Ana Sayfa kontrol paneli; temel metrikler, faturalandırma ve diğer faydalı bilgileri öne çıkararak seçili GCP projesine dair genel bakış sağlar.

### Özelleştirme

[Özelleştir][spotlight-customize-dashboard]'i tıklayarak kontrol panelinizi özelleştirebilirsiniz.
Kartlardan herhangi biri sayfada gizlenebilir, gösterilebilir ve yeniden düzenlenebilir. Ayrıca her kart, fareyle üzerine gelindiğinde açılan menüden erişilen özel seçeneklere sahiptir.

## GCP kaynaklarınız genelindeki etkinliği görüntüleme

[Etkinlik Akışı][spotlight-activity-stream] ile GCP kaynaklarınızda gerçekleşen tüm etkinlikleri tek bir noktadan takip edebilirsiniz.

Sorunları izlemek ve erişimi denetlemek için ekip arkadaşlarınızın herhangi bir projede neleri güncellediğini görün. Tam aradığınız öğeyi bulmak için özet akışı içinde kolayca filtreleme yapın.

## Cloud Console genelinde arama

Cloud Console'daki [arama çubuğunu][spotlight-search-bar] kullanarak, Google Cloud ürünlerine ve GCP genelindeki kaynaklarınıza hızlıca erişebilirsiniz.

**App Engine** veya projelerinizden birinin adıyla arama yapmayı deneyin.

## Her zaman destek

Sorun yaşamanız veya GCP dünyasında gezinirken yardıma ihtiyacınız olması durumunda destek ekibimiz size yardımcı olmak için hazırdır.

[Destek hakkında daha fazla bilgi](http://cloud.google.com/support)

Gezinme menüsünden destek bölümüne erişin.

<walkthrough-menu-navigation sectionid="SUPPORT_SECTION"></walkthrough-menu-navigation>

## Kullanıcıları ve izinleri yönetme

Google Cloud Identity ve Access Management (Cloud IAM), GCP kaynaklarınız için izinler oluşturmanızı ve yönetmenizi sağlar.

[IAM hakkında daha fazla bilgi](https://cloud.google.com/iam/docs/)

Ekibiniz büyümeye devam ederken, Cloud IAM kullanan ekip arkadaşlarınıza "IAM ve Yönetici" bölümünden erişim izni verebilirsiniz.

Kullanıcılar, gruplar veya hizmet hesapları ekleyin ve ihtiyaç duydukları izinleri vermek için onlara istediğiniz sayıda rol atayın.

<walkthrough-menu-navigation sectionid="IAM_ADMIN_SECTION"></walkthrough-menu-navigation>

## Tarayıcınızdan komut satırına erişme

Google Cloud Shell, bulut kaynaklarınız için doğrudan tarayıcınızdan komut satırı erişimi sağlar. Sisteminize Google Cloud SDK veya başka araçlar yüklemenize gerek kalmadan projeleriniz ve kaynaklarınızı kolayca yönetebilirsiniz.

<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[Cloud Shell][spotlight-open-devshell] sayesinde, Google Cloud SDK gcloud komut satırı aracı ve ihtiyacınız olan diğer yardımcı uygulamalar her an kullanılabilir. Ayrıca bunlar güncel ve kimlikleri tamamen doğrulanmış durumda olur.

[Cloud Shell hakkında daha fazla bilgi](https://cloud.google.com/shell/)

## GCP yolculuğunuza devam edin

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Artık sağlam bir temele sahip olduğunuza göre Cloud Console'da rahatça gezinerek yeni hizmetler ve ürünleri keşfedebilirsiniz.

[Ayrıntılı belgelerimiz](https://cloud.google.com/docs/) de ürün incelemelerinden hızlı başlangıç kılavuzları ve API referanslarına kadar birçok bilgi içermektedir.

Daha fazla eğitici için Başlarken sayfasına dönün.
<walkthrough-menu-navigation sectionid="ONBOARDING_SECTION"></walkthrough-menu-navigation>

[gcp-resources]: https://cloud.google.com/resource-manager/docs/cloud-platform-resource-hierarchy
[spotlight-activity-stream]: walkthrough://spotlight-pointer?cssSelector=.mat-tab-link:nth-of-type(2)
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-customize-dashboard]: walkthrough://spotlight-pointer?cssSelector=.cfc-customize-button
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-project-select]: walkthrough://spotlight-pointer?spotlightId=purview-switcher
[spotlight-search-bar]: walkthrough://spotlight-pointer?cssSelector=.p6n-search-bar,.pcc-platform-bar-search-bar
