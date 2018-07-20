# Cloud Vision API

<walkthrough-test-start-page url="/start?tutorial=python_vision_quickstart_v2"></walkthrough-test-start-page>

<walkthrough-tutorial-url url="https://cloud.google.com/vision/docs/label-tutorial"></walkthrough-tutorial-url>

<walkthrough-watcher-constant value="https://github.com/GoogleCloudPlatform/python-docs-samples.git" key="repo-url"></walkthrough-watcher-constant>

<walkthrough-watcher-constant value="python-docs-samples" key="repo-name"></walkthrough-watcher-constant>

<walkthrough-devshell-precreate></walkthrough-devshell-precreate>

## Giriş

Bu eğitici, `LABEL_DETECTION` isteği kullanan temel bir Vision API uygulamasında
size rehberlik eder. `LABEL_DETECTION` isteği, görüntü içeriğine göre seçilen
bir etiketle bir görüntüye not ekler. Örneğin, bir ambar resmi "ambar" veya
"çiftlik" etiketi ya da başka benzer notlar üretebilir.

Uygulayacağınız adımlar şu şekildedir:

*   **Etiket algılama uygulamanızı çalıştırın** Doğrudan tarayıcınızda Google
    Cloud Shell'i kullanarak uygulamanızı nasıl çalıştıracağınızı
    öğreneceksiniz.
*   **Uygulamadan sonra...** Uygulamanız hayata geçecek ve uygulamanız ile
    denemeler yapabileceksiniz. Dilerseniz uygulamayı kaldırıp baştan
    başlayabilirsiniz.

["Python" ve Python logoları, Python Software Foundation'ın ticari markaları
veya tescilli ticari markalarıdır.](walkthrough://footnote)

# Proje Ayarları

Bir proje üzerinden Cloud Vision API'yi etkinleştirmeniz gerekir.

Google Cloud Platform, kaynakları projeler halinde düzenler. Bu sayede, tek bir
uygulamayla ilgili tüm kaynakları tek bir yerde toplayabilirsiniz.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## Vision API'yi etkinleştirin

İstekleri kabul etmek için projenizde Vision API'nin etkinleştirilmesi gerekir.

### API Yöneticisi'ne gidin

API yöneticisi, projenizde hangi API'lerin etkinleştirildiğini ayarlar.

Konsolun sol tarafında
[menu](walkthrough://spotlight-pointer?spotlightId=console-nav-menu) bölümünü
açın.

Ardından, **API'ler ve Hizmetler** bölümünü seçin.

<walkthrough-menu-navigation sectionid="API_SECTION"></walkthrough-menu-navigation>

### Kullanılabilir API'leri görüntüleyin

API'leri etkinleştirmek için
[API'yi Etkinleştir](walkthrough://spotlight-pointer?cssSelector=.p6n-action-bar-button)
düğmesini tıklayın.

### Vision API'yi seçin

[Vision API](walkthrough://spotlight-pointer?spotlightId=api-vision.googleapis.com) bağlantısını tıklayın.

### Vision API'yi etkinleştirin

Vision API'yi etkinleştirmek için [Etkinleştir](walkthrough://spotlight-pointer?spotlightId=api-enable-vision.googleapis.com) düğmesini
tıklayın. Bu eğiticide daha sonra projeniz için kimlik bilgileri oluşturacağız.

## Google Cloud Shell'i Kullanma

Cloud Shell, konsol için dahili bir komut satırı aracıdır. Uygulamanızı
çalıştırmak için Cloud Shell'i kullanacaksınız.

### Google Cloud Shell'i açın

Konsolun üst kısmındaki gezinme çubuğunda yer alan
<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>
[simgeyi](walkthrough://spotlight-pointer?spotlightId=devshell-activate-button)
tıklayarak Cloud Shell'i açın.

### Örnek kodu kopyalayın

Klonlamak ve "Hello World" koduna gitmek için Cloud Shell'i kullanın. Örnek kod,
projenizin kod deposundan Cloud Shell'e klonlanır.

Not: Dizin zaten mevcutsa klonlama işleminden önce eski dosyaları kaldırın:

```bash
rm -rf {{repo-name}}
```

Örnek kod deposunu klonlama:

```bash
git clone {{repo-url}}
```

Ardından, eğitici dizinine geçin:

```bash
cd {{repo-name}}/vision/cloud-client/quickstart
```

## Dağıtımınızı yapılandırma

Şu anda örnek kodun ana dizinindesiniz. Uygulamanızı yapılandıran dosyalara
bakın.

### Uygulamayı keşfetme

Uygulamanızın kodunu görmek için şu komutu girin:

```bash
cat quickstart.py
```

`quickstart.py` dosyası, istek türü ve içerik gibi istek bilgilerinizi
biçimlendirir. Ayrıntılar hakkında bilgi edinmek için aşağıdaki her bölümü
genişletin.

Vision API'ye yapılan istekler JSON nesneleri olarak sunulur. Böyle bir isteğin
yapısı hakkında kapsamlı bilgi edinmek için [Vision API
Referansı][vision-request-doc]'na bakın. JSON isteğiniz yalnızca `execute`
çağrısı yaptığınızda gönderilir. Bu kalıp, böyle istekleri yönetmenize ve
gerektiğinde `execute` çağrısı yapmanıza olanak tanır.

## Uygulamayı test etme

API'yi kullanmak için kimlik bilgileri belirlemeniz gerekir. Cloud API kullanmak
üzere uygulamanız için uygun [kimlik bilgileri][auth-doc] belirlemeniz gerekir.
Bu sayede uygulamanız, hizmete kendi kimliğini doğrulayabilir ve görev
gerçekleştirme yetkisi elde eder. Ardından, örnek görüntülerle API'yi test
edersiniz.

### Hizmet hesabı oluşturun

API isteklerinizin kimliğini doğrulamak için bir hizmet hesabı oluşturmanız
gerekir. Zaten bir hizmet hesabı oluşturduysanız bu hesabı tekrar
kullanabilirsiniz.

```bash
gcloud iam service-accounts create vision-quickstart
```

### Kimlik bilgileri oluşturun

Şimdi bir hizmet hesabı anahtarı oluşturun ve bu anahtarı varsayılan kimlik
bilgileriniz olarak ayarlayın.

```bash
gcloud iam service-accounts keys create key.json --iam-account    vision-quickstart@{{project-id}}.iam.gserviceaccount.com
```

```bash
export GOOGLE_APPLICATION_CREDENTIALS=key.json
```

<walkthrough-test-code-output text="created key"></walkthrough-test-code-output>

### Uygulamanızı test edin

Örnek görüntü ile uygulamanızı test etmek için şunu girin:

```bash
python quickstart.py
```

Görüntü kaynağı `resources/wakeupcat.jpg`, kaynakta belirtilmiştir. ([Görüntüyü
göster][cat-picture])

## Sonuç

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Tebrikler! Cloud Vision API'yi kullanmaya hazırsınız.

Şimdi şunları yapabilirsiniz:

*   [Yüz Algılama][face-tutorial] eğiticisinde ilerleyin.
*   [Belge Metni][document-text-tutorial] eğiticisini deneyin.
*   [Örnek Uygulamalara][vision-samples] bakın.
*   Yerel makinenizde çalıştırmak için [Google Cloud SDK][get-cloud-sdk]'yı
    indirin.

[auth-doc]: https://cloud.google.com/vision/docs/auth
[cat-picture]: https://raw.githubusercontent.com/GoogleCloudPlatform/python-docs-samples/master/vision/cloud-client/quickstart/resources/wakeupcat.jpg
[document-text-tutorial]: https://cloud.google.com/vision/docs/fulltext-annotations
[face-tutorial]: https://cloud.google.com/vision/docs/face-tutorial
[get-cloud-sdk]: https://cloud.google.com/sdk/
[vision-request-doc]: https://cloud.google.com/vision/reference/rest
[vision-samples]: https://cloud.google.com/vision/docs/samples
