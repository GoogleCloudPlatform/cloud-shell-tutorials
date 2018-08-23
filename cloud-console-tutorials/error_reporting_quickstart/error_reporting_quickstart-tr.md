# Stackdriver Error Reporting

## Giriş

Stackdriver Error Reporting, bulut hizmetleri tarafından üretilen hataları toplayıp gösterir.

Bu eğitici, Error Reporting web arayüzünde sizi yönlendirir. Uygulama hatalarınızı nasıl listeleyeceğinizi, bunlarla ilgili diğer ayrıntıları nasıl göreceğinizi ve nasıl harekete geçeceğinizi öğreneceksiniz.

## Proje Hazırlama

<walkthrough-project-setup></walkthrough-project-setup>

## Hata oluşturun

Devam etmeden önce yapay hataları bildirmeniz gerekir. Bunun için bir `gcloud` komutu kullanacaksınız.

Gerçek bir senaryoda bu hatalar doğrudan çalışan uygulamanızdan bildirilir. Bu eğiticiden sonra Error Reporting'i nasıl kuracağınız hakkında daha fazla bilgi edinebilirsiniz.

### Google Cloud Shell'i açın

Konsolun üstündeki gezinme çubuğunda yer alan <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[simgeyi][spotlight-open-devshell] tıklayarak Cloud Shell'i açın.

### Birkaç hata bildirin

Aşağıdaki komut dosyasının sağ üst tarafındaki **Panoya kopyala** düğmesini tıklayın ve örnek hatalar oluşturmak için bunu Cloud Shell'de çalıştırın.

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

### Cloud Shell'i kapatın

İşleminiz tamamlandığında Cloud Shell'i kapatın ve *Devam*'ı tıklayın.

## Uygulama hatalarınızı listeleyin

Bildirilen hataları tek bakışta görmek için Stackdriver Error Reporting'i kullanacaksınız.

### Error Reporting'i açın

Konsolun sol tarafındaki [menüyü][spotlight-console-menu] açın.

Ardından **Stackdriver** kategorisine gidin ve **Error Reporting**'i seçin.

<walkthrough-menu-navigation sectionid="CRASH_SECTION"></walkthrough-menu-navigation>

### *İlk görülme zamanına* göre sıralayın

Uygulamanızda meydana gelen hatalar gruplanır ve yığın izleri analiz edilerek kopyaları silinir. Bu listedeki her giriş, uygulamanın hatayı ne zaman üretmeye başladığını, hatanın ne sıklıkta ve ne kadar süre önce oluştuğunu belirlemenize yardımcı olan bir özet sunar.

Varsayılan sıralama, *Karşılaşılma Sayısıdır*. Yakın zamanda oluşmaya başlayan hataları görmek için *İlk görülme zamanı* sütun başlığını tıklayın.

### Yeni hatalarda bildirim almayı seçin

Projede yeni görülen bir hata meydana geldiğinde bir e-posta ve mobil push bildirimi gönderilebilir. Bu bildirimleri etkinleştirmek için *Bildirimleri aç*'ı tıklayın.

İşleminiz tamamlandığında *Devam*'ı tıklayın.

## Bir hatanın ayrıntılarını anlama

### Bir hata raporunu açın

Ayrıntılarını görmek için bu listeden bir hatayı tıklayın.

### Bir sorunu bu hataya bağlayın

Belirli bir hatanın bilgilerini ve geçmişini incelemek için bu sayfayı kullanın.

Yeni bir hataya baktıktan sonraki adım, ekibinizin sorun takipçisine bir sorun girmektir. Sorun takipçisi girişiniz, Strackdriver Error Reporting'deki hataya geri bağlanabilir.

Bunu yapmak için:

  *  Üstteki *Soruna bağla*'yı tıklayın (Bu bağlantıyı görmek için **diğer işlemler** menüsünü açmanız gerekebilir).
  *  İletişim kutusuna `http://example.com/issues/1234` adresini girin.
  *  *Kaydet*'i tıklayın.

### Yığın izlerini keşfedin

Kodunuza odaklanmanıza yardımcı olmak için uygulamanızın kodundan olmayan yığın izi kareleri gizlenir.

Çerçeve yığın karelerini göstermek için bir hata örneğinde *Tümünü göster*'i tıklayın.

## Sonuç

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Tebrikler! Stackdriver Error Reporting eğiticisini başarıyla tamamladınız.

Şimdi şunları yapabilirsiniz:

### Projeniz için Error Reporting'i Ayarlama

[Kurulum belgelerinden][errors-setup] çalışan hizmetleriniz için Error Reporting'i nasıl kuracağınızı öğrenin.

### Diğer Stackdriver eğitimlerini keşfedin

[Stackdriver Debugger][debug-quickstart] hızlı başlangıç belgesiyle bir üretim uygulamasının hatalarını ayıklayın.

[Stackdriver Trace][trace-quickstart] hızlı başlangıç belgesiyle uygulama gecikmenizi anlayın.

[debug-quickstart]: https://cloud.google.com/debugger/docs/quickstart
[errors-setup]: https://cloud.google.com/error-reporting/docs/how-to
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[trace-quickstart]: https://cloud.google.com/trace/docs/quickstart
