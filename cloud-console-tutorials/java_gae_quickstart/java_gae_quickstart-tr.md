# App Engine Hızlı Başlangıç

<walkthrough-test-start-page url="/getting-started?tutorial=java_gae_quickstart_2"/>

<walkthrough-tutorial-url url="https://cloud.google.com/appengine/docs/java/quickstart"/>

<walkthrough-watcher-constant key="repo-url" value="https://github.com/GoogleCloudPlatform/appengine-try-java" />

<walkthrough-watcher-constant key="repo-name" value="appengine-try-java"/>

## Giriş

Bu eğiticide, App Engine Maven eklentisini kullanarak örnek bir [Java][java]
uygulamasının Google App Engine'e nasıl dağıtılacağı gösterilmiştir.

Uygulayacağınız adımları aşağıda bulabilirsiniz.

*   **"Hello, world!" uygulamanızı derleyip çalıştırın**

    Google Cloud Shell'i kullanarak uygulamanızı tarayıcınızda nasıl
    çalıştıracağınızı öğreneceksiniz. Son olarak, App Engine Maven eklentisini
    kullanarak uygulamanızı internete dağıtacaksınız.

*   **Uygulamadan sonra...**

    Oluşturduğunuz uygulamayı dağıttıktan sonra uygulamayla denemeler
    yapabileceksiniz. İsterseniz uygulamayı kaldırıp sürece baştan da
    başlayabilirsiniz.

[Java is a registered trademark of Oracle and/or its affiliates.](walkthrough://footnote)

<walkthrough-devshell-precreate/>

## Proje hazırlanması

Uygulama dağıtmak için önce proje oluşturmanız gerekir.

Google Cloud Platform, kaynakları projelere yerleştirir. Bu sayede, tek bir
uygulamanın ilgili tüm kaynaklarını tek bir yerde toplayabilirsiniz.

<walkthrough-project-setup/>

## Google Cloud Shell'i kullanma

Cloud Shell, konsol için yerleşik bir komut satırı aracıdır. Uygulamamızı
dağıtmak için Cloud Shell'i kullanacağız.

### Google Cloud Shell'i açın

Konsolun üst kısmındaki gezinme çubuğunda yer alan
<walkthrough-cloud-shell-icon/>
[icon](walkthrough://spotlight-pointer?spotlightId=devshell-activate-button)
simgesini tıklayarak Cloud Shell'i açın.

### Örnek kodu klonlayın

Cloud Shell'i kullanarak klonlama işlemini gerçekleştirin ve "Hello World"
koduna gidin. Örnek kod, proje kod deponuzdan Cloud Shell'e klonlanır.

Not: Dizin zaten mevcutsa klonlamayı gerçekleştirmeden, önceki dosyaları
kaldırın:

```bash
rm -rf {{repo-name}}
```

Cloud Shell'de şunu girin:

```bash
git clone {{repo-url}}
```

Ardından eğitici dizinine geçin:

```bash
cd {{repo-name}}
```

## Dağıtımınızın yapılandırılması

Şu an örnek kodun ana dizinindesiniz. Uygulamanızı yapılandıran dosyalara
bakacağız.

### Uygulamayı keşfetme

Uygulama kodunuzu görüntülemek için aşağıdaki komutu girin:

```bash
cat src/main/java/myapp/DemoServlet.java
```

Bu servlet, tüm isteklere `Hello, world!` mesajını içeren bir yanıt göndererek
cevap verir.

### Yapılandırmanızı keşfetme

Google App Engine, Java'da bir dağıtımın yapılandırmasını belirtmek amacıyla XML
dosyalarını kullanır.

Yapılandırma dosyanızı görüntülemek için aşağıdaki komutu girin:

```bash
cat pom.xml
```

`helloworld` uygulaması Maven kullanır. Bu nedenle, proje hakkındaki bilgileri
ve Maven tarafından projeyi oluşturmak için kullanılan yapılandırma
ayrıntılarını içeren bir Proje Nesne Modeli (POM) belirtmeniz gerekir.

## Uygulamanızı test etme

### Uygulamanızı Cloud Shell'de test edin

Cloud Shell, beklendiği gibi çalıştığından emin olmak için uygulamanızı
dağıtmadan önce test etmenizi sağlar (yerel makinenizde hata ayıklar gibi).

Uygulamanızı test etmek için şunu girin:

```bash
mvn appengine:run
```

<walkthrough-test-code-output
  text="module .* running at|Dev App Server is now running" />

### "Web önizlemesi" ile uygulamanızı önizleyin

Uygulamanız artık Cloud Shell'de çalışıyor. 8080 bağlantı noktasına bağlanmak
için uygulamaya "Web önizlemesi" <walkthrough-web-preview-icon/> kullanarak
erişebilirsiniz. [Nasıl yapıldığını
göster](walkthrough://spotlight-pointer?spotlightId=devshell-web-preview-button)

### Önizleme örneğini sonlandırma

Cloud Shell'de `Ctrl+C` tuşlarına basarak uygulamanın örneğini sonlandırın.

## Google App Engine'e dağıtma

### Uygulama oluşturun

Uygulamamızı dağıtmak için bir bölgede uygulama oluşturmamız gerekir:

```bash
gcloud app create
```

Not: Zaten uygulama oluşturduysanız bu adımı atlayabilirsiniz.

### Cloud Shell ile dağıtma

Artık uygulamanızı dağıtmak için Cloud Shell'i kullanabilirsiniz.

Öncelikle hangi projenin kullanılacağını ayarlayın:

```bash
gcloud config set project {{project-id}}
```

Ardından uygulamanızı dağıtın:

```bash
mvn appengine:deploy
```

<walkthrough-test-code-output text="Deployed (module|service)" />

### Uygulamanızı ziyaret edin

Uygulamanız dağıtıldı! Uygulamanızın varsayılan URL'si
[{{project-gae-url}}](http://{{project-gae-url}}). Ziyaret etmek için URL'yi
tıklayın.

### Uygulamanızın durumunu görüntüleyin

App Engine kontrol panelinde durumunu izleyerek uygulamanızı kontrol
edebilirsiniz.

Konsolun sol tarafında
[menu](walkthrough://spotlight-pointer?spotlightId=console-nav-menu) bölümünü
açın.

Ardından **App Engine** bölümünü seçin.

<walkthrough-menu-navigation sectionId="APPENGINE_SECTION"/>

## Sonuç

<walkthrough-conclusion-trophy/>

Tebrikler! App Engine uygulamasını başarıyla dağıttınız! Sonraki adımların
bazıları şunlardır:

**Google Cloud SDK'yı indirin ve yerel olarak geliştirin**

[Google Cloud SDK][cloud-sdk-installer]

**Sonraki uygulamanızı geliştirin** App Engine'i diğer Cloud Platform
ürünleriyle birlikte nasıl kullanacağınızı öğrenin:

<walkthrough-tutorial-card
  url="appengine/docs/java/datastore/"
  icon="DATASTORE_SECTION"
  label="datastore">
**Cloud Datastore'u nasıl kullanacağınızı öğrenin**
Cloud Datastore, uygulamalarınız için yüksek oranda ölçeklendirilebilen bir NoSQL veritabanıdır.
</walkthrough-tutorial-card>

<walkthrough-tutorial-card
  url="appengine/docs/java/googlecloudstorageclient/setting-up-cloud-storage/"
  icon="STORAGE_SECTION"
  label="cloudStorage">
**Cloud Storage'ı kullanmayı öğrenin**
Cloud Storage, güçlü ve basit bir nesne depolama hizmetidir.
</walkthrough-tutorial-card>

[java]: https://java.com/
[cloud-sdk-installer]: https://cloud.google.com/sdk/downloads#interactive
