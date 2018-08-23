# Cloud Storage'a Hızlı Başlangıç

## Google Cloud Storage'a hoş geldiniz!

<walkthrough-tutorial-url url="https://cloud.google.com/storage/docs/quickstart-console"></walkthrough-tutorial-url>

Google Cloud Storage, yapılandırılmamış nesneler için güçlü ve uygun maliyetli bir depolama çözümüdür. Canlı web içerikleri barındırmaktan analiz için veri saklamaya, arşiv ve yedeklemeye kadar birçok konuda mükemmeldir.

Bu eğiticide, Cloud Storage'da nesne saklamanın ne kadar kolay olduğunu size göstereceğiz. Yapacaklarınız:

  *  **Paket oluşturun**

     Paketler, Cloud Storage'da saklamak istediğiniz nesneleri (herhangi bir dosya türü) barındırır.

  *  **Nesneler yükleyin ve paylaşın**

     Bir nesne yükleyip bunu genel kullanıma açık hale getirerek paketinizi kullanmaya başlayın.

  *  **Temizleyin**

     Son adım olarak, bu eğiticide oluşturduğunuz paketi ve nesneyi silin.

Son adımda paketinizi ve nesnenizi sileceğinizden, bu eğiticiyi denediğiniz için ücretlendirilme konusunda endişelenmeyin.

## Proje Hazırlama

Cloud Storage, kaynak oluşturmak için bir projeye ihtiyaç duyar.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## Paket oluşturun

Cloud Storage'de nesneleri paketlerde depolarsınız. Bir paket oluşturmak için Cloud Storage tarayıcısına gitmeniz gerekir.

Konsolun sol tarafındaki [menüyü][spotlight-menu] açın.

Ardından, **Storage** bölümünü seçin.

<walkthrough-menu-navigation sectionid="STORAGE_SECTION"></walkthrough-menu-navigation>

## Paket oluşturun

Nesne yüklemeye başlamadan önce, nesneleri içinde saklayacağınız bir "paket" oluşturmanız gerekir. Paketler nesnelerinizi düzenlemenize ve bunlara erişimi kontrol etmenize yardımcı olur.

  1. [Paket oluştur](walkthrough://spotlight-pointer?cssSelector=#p6ntest-cloudstorage-create-first-bucket-button)'u tıklayın.

  1. Paket oluşturma sayfasında, paketin özelliklerini belirtin. Göz önünde bulundurulması gereken birkaç nokta aşağıda verilmiştir:

     *  **Ad:** Benzersiz bir ad düşünün. Cloud Storage'da bulunan başka bir paketin adıyla aynı olan bir ad girerseniz bir hata mesajı görürsünüz.
     *  **Varsayılan depolama sınıfı:** Bu, varsayılan olarak paketinizin nesnelerine atanan depolama sınıfıdır. Tercihiniz büyük ölçüde nesnelere ne sıklıkla erişilmesini beklediğinize ve verileri dünya çapında hizmete sunup sunmayacağınıza bağlıdır. Depolama sınıfı, maliyetinizi etkiler.
     *  **Konum:** Verilerinizi uygulamalara ve buna erişen kullanıcılara yakın tutmak istersiniz. Mevcut tercihler, depolama sınıfı seçiminize bağlıdır.

Paket son adımda silineceğinden bu deneme işlemi için herhangi bir depolama sınıfı ve konum kullanılabilir.

  1. [Oluştur][spotlight-create-button]'u tıklayın

## Bir nesne yükleyip

Artık bir paketiniz olduğuna göre, nesne yüklemeye başlayabilirsiniz.

  1. Sayfanın üst kısmından, [Dosya yükle][spotlight-upload-file]'yi tıklayın.

  1. Yüklenecek dosyayı seçin. Herhangi bir dosya türünü yükleyebilirsiniz.

     Dosyanız yok mu? [Örnek bir dosya oluşturun][create-sample-file] ve bunu paketinizde görmek için ekranın üst kısmında [Paketi Yenile][spotlight-refresh-bucket]'yi tıklayın. (İpucu: Nesneleri paket adınızın altındaki boşluğa sürükleyip bırakarak da yükleyebilirsiniz.)

## Paketi silin

Şimdi az önce oluşturduğunuz paketi silelim. Paket silindiğinde, içindekiler de silinir.

  1. Paketler listesine dönmek için tablonun üstünden [Paketler][spotlight-buckets-link]'i tıklayın.

  1. Paketinizin yanındaki kutuyu işaretleyin. Bu projede başka paketler varsa ve kendi paketinizi bulma konusunda yardıma ihtiyacınız varsa paketler listesini filtrelemek için arama çubuğunu kullanın.

  1. Sayfanın üstünden [Sil][spotlight-delete-buckets]'i tıklayarak silme işlemini onaylayın.

## Sonuç

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Tebrikler!

Artık Cloud Storage'da nesne depolamaya nasıl başlayacağınızı bildiğinize göre
 [statik bir web sitesi barındırarak](https://cloud.google.com/storage/docs/hosting-static-website) bunları gerçek hayatta kullanıma koymak hakkında bilgi edinmek isteyebilirsiniz.

Cloud Storage'ı [gsutil komut satırı aracıyla](https://cloud.google.com/storage/docs/quickstart-gsutil) kullanmayı da öğrenebilirsiniz.

Cloud Storage ve diğer GCP hizmetlerini [ücretsiz](https://cloud.google.com/free) olarak nasıl kullanmaya başlayabileceğinizi öğrenin.

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
