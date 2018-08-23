# App Engine'e Hızlı Başlangıç

<walkthrough-tutorial-url url="https://cloud.google.com/appengine/docs/python/quickstart"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="https://github.com/GoogleCloudPlatform/python-docs-samples" key="repo-url"></walkthrough-watcher-constant>
<walkthrough-watcher-constant value="python-docs-samples/appengine/standard/hello_world" key="repo-dir"></walkthrough-watcher-constant>

## Giriş

Bu eğiticide, `gcloud` komutu kullanılarak örnek bir [Python](https://python.org/) uygulamasının Google App Engine'e nasıl dağıtılacağı gösterilmektedir.

Uygulayacağınız adımlar şu şekildedir:

  *  **Proje oluşturun**

     Projeler; kodları, sanal makineleri ve diğer kaynakları paket haline getirerek daha kolay geliştirme ve izleme imkanı sunar.

  *  **Kendi "Hello, world!" uygulamanızı derleyip çalıştırın**

     Doğrudan tarayıcınız üzerinden Google Cloud Shell'i kullanarak uygulamanızı nasıl çalıştıracağınızı öğreneceksiniz. Son olarak `gcloud` komutuyla uygulamanızı internete dağıtacaksınız.

  *  **Eğiticiden sonra...**

     Uygulamanız hayata geçecek ve uygulamanız ile denemeler yapabileceksiniz. Dilerseniz uygulamayı kaldırıp baştan başlayabilirsiniz.

["Python" ve Python logoları, Python Software Foundation'ın ticari markaları veya tescilli ticari markalarıdır.](walkthrough://footnote)

## Proje hazırlama

Bir uygulamayı dağıtmak için önce proje oluşturmanız gerekir.

Google Cloud Platform, kaynakları projeler halinde düzenler. Bu sayede, tek bir uygulamayla ilgili tüm kaynakları tek bir yerde toplayabilirsiniz.

<walkthrough-devshell-precreate></walkthrough-devshell-precreate>

<walkthrough-project-setup></walkthrough-project-setup>

## Google Cloud Shell'i Kullanma

Cloud Shell, konsol için dahili bir komut satırı aracıdır. Uygulamamızı dağıtmak için Cloud Shell'i kullanacağız.

### Google Cloud Shell'i açın

Konsolun üstündeki gezinme çubuğunda yer alan <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[simgeyi][spotlight-open-devshell] tıklayarak Cloud Shell'i açın.

### Örnek kodu kopyalayın

Klonlamak ve "Hello World" koduna gitmek için Cloud Shell'i kullanın. Örnek kod, projenizin kod deposundan Cloud Shell'e klonlanır.

Not: Dizin zaten mevcutsa klonlama işleminden önce eski dosyaları kaldırın.

Cloud Shell'de şunu girin:

```bash
git clone {{repo-url}}
```

Ardından, eğitici dizinine geçin:

```bash
cd {{repo-dir}}
```

## Dağıtımınızı yapılandırma

Şu anda örnek kodun ana dizinindesiniz. Uygulamanızı yapılandıran dosyalara bakacağız.

### Uygulamayı keşfetme

Uygulamanızın kodunu görmek için şu komutu girin:

```bash
cat main.py
```

Uygulama, [webapp2](https://webapp2.readthedocs.io/) web çerçevesini kullanan basit bir Python uygulamasıdır. Bu Python komut dosyası, isteklere bir HTTP üst bilgisi ve
 `Hello, World!` mesajıyla yanıt verir.

### Yapılandırmanızı keşfetme

Google App Engine, bir dağıtımın yapılandırmasını belirtmek amacıyla YAML dosyalarını kullanır.
`app.yaml` dosyaları, uygulamanız hakkında çalışma zamanı ortamı, URL işleyicileri vb. bilgiler içerir.

Yapılandırma dosyanızı görmek için şu komutu girin:

```bash
cat app.yaml
```

Bu yapılandırma dosyası, bu uygulama hakkında baştan sona şunları belirtmektedir:

  *  Bu kod `python` çalışma zamanı ortamında çalıştırılır.
  *  Bu uygulama `threadsafe` olduğundan aynı örnek çeşitli eş zamanlı istekleri işleyebilir. Threadsafe gelişmiş bir özelliktir ve uygulamanız özellikle threadsafe olacak şekilde tasarlanmamışsa istikrarsız davranışlara neden olabilir.
  *  Yolu `/.*` normal ifadesiyle eşleşen bir URL'ye (tüm URL'ler) yapılan tüm istekler `main` Python modülündeki uygulama nesnesi tarafından işlenmelidir.

Bu dosyanın söz dizimi [YAML](http://www.yaml.org) biçimindedir. Yapılandırma seçeneklerinin tam listesi için [`app.yaml`][app-yaml-reference] referansına bakın.

## Uygulamanızı test etme

### Cloud Shell'de uygulamanızı test edin

Cloud Shell, uygulamanızın beklendiği gibi çalıştığından emin olmak için dağıtmadan önce yerel makinenizde hata ayıklar gibi test etmenizi sağlar.

Uygulamanızı test etmek için şunu girin:

```bash
dev_appserver.py $PWD
```

### "Web önizlemesi" ile uygulamanızı önizleyin

Uygulamanız şu anda Cloud Shell'de çalışıyor. 8080 bağlantı noktasına bağlanmak için uygulamaya [Web
önizlemesi][spotlight-web-preview]<walkthrough-web-preview-icon></walkthrough-web-preview-icon> kullanarak erişebilirsiniz.

### Önizleme örneğini sonlandırma

Cloud  Shell'de `Ctrl+C` tuşlarına basarak uygulamanın örneğini sonlandırın.

## Google App Engine'e Dağıtma

### Uygulama oluşturun

Uygulamanızı dağıtmak için uygulamayı bir bölgede oluşturmanız gerekir:

```bash
gcloud app create
```

Not: Uygulamanızı zaten oluşturduysanız bu adımı atlayabilirsiniz.

### Cloud Shell ile Dağıtım

Uygulamanızı dağıtmak için Cloud Shell'i kullanabilirsiniz. Uygulamanızı dağıtmak için şu komutu girin:

```bash
gcloud app deploy app.yaml --project {{project-id}}
```

### Uygulamanızı ziyaret edin

Tebrikler! Uygulamanız dağıtıldı. Uygulamanız için varsayılan URL [{{project-gae-url}}](http://{{project-gae-url}}) şeklindedir. Uygulamanıza gitmek için URL'yi tıklayın.

### Uygulamanızın durumunu görüntüleyin

Uygulamanızı, App Engine kontrol panelinde durumunu izleyerek kontrol edebilirsiniz.

Konsolun sol tarafındaki [menüyü][spotlight-console-menu] açın.

Ardından **App Engine** bölümünü seçin.

<walkthrough-menu-navigation sectionid="APPENGINE_SECTION"></walkthrough-menu-navigation>

## Sonuç

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

App Engine uygulamasını başarıyla dağıttınız!

Sonraki adımlardan bazıları şunlardır:

**Google Cloud SDK'yı indirin ve yerel olarak geliştirin**

Yerel makinenize [Google Cloud SDK][cloud-sdk-installer]'yı yükleyin.

**Sonraki uygulamanızı oluşturun**

App Engine'i diğer Google Cloud Platform ürünleriyle nasıl kullanacağınızı öğrenin:

<walkthrough-tutorial-card label="django" url="python/django/appengine" icon="APPENGINE_SECTION">
  **Django'yu çalıştırın**
  App Engine'de çalışan Django uygulamaları geliştirin.
</walkthrough-tutorial-card>

<walkthrough-tutorial-card label="datastore" url="appengine/docs/python/datastore/" icon="DATASTORE_SECTION">
  **Cloud Datastore'u nasıl kullanacağınızı öğrenin**
  Cloud Datastore, uygulamalarınız için yüksek düzeyde ölçeklendirilebilen bir NoSQL veritabanıdır.
</walkthrough-tutorial-card>

[app-yaml-reference]: https://cloud.google.com/appengine/docs/standard/python/config/appref
[cloud-sdk-installer]: https://cloud.google.com/sdk/downloads#interactive
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-web-preview]: walkthrough://spotlight-pointer?spotlightId=devshell-web-preview-button
