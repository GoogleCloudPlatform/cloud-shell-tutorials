# Dataflow Kelime Sayımı Eğiticisi

<walkthrough-tutorial-url url="https://cloud.google.com/dataflow/docs/quickstarts/quickstart-python"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="dataflow-intro" key="directory"></walkthrough-watcher-constant>
<walkthrough-watcher-constant value="dataflow-intro" key="job-name"></walkthrough-watcher-constant>

## Giriş

Bu eğiticide, Python'dan yararlanarak basit bir örnek ardışık düzen çalıştırarak Cloud Dataflow hizmetiyle ilgili temel bilgiler edineceksiniz.

Dataflow ardışık düzenleri, *toplu* (bir dosya veya veritabanı tablosu gibi sınırlı girişi işleme) veya *akışlı* (Cloud Pub/Sub gibi bir kaynaktan gelen sınırı olmayan girişi işleme) olabilir. Bu eğiticideki örnek, Shakespeare eserlerinden oluşan bir koleksiyonda kelimeleri sayan bir toplu ardışık düzendir.

Başlamadan önce, Cloud Platform projenizdeki ön koşulları kontrol etmeniz ve ilk kurulumu yapmanız gerekir.

## Proje ayarlama

Google Cloud Platform, kaynakları projeler halinde düzenler. Bu sayede, tek bir uygulamayla ilgili tüm kaynakları tek bir yerde toplayabilirsiniz.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>
<walkthrough-project-permissions permissions="dataflow.jobs.create"></walkthrough-project-permissions>

## Cloud Dataflow'u kurun

Dataflow'u kullanmak için Cloud Dataflow API'lerini etkinleştirin ve Cloud Shell'i açın.

### Google Cloud API'lerini açın

<walkthrough-enable-apis apis="compute.googleapis.com,dataflow,cloudresourcemanager.googleapis.com,logging,storage_component,storage_api,bigquery,pubsub">
</walkthrough-enable-apis>

### Cloud Shell'i açın

Cloud Shell, konsol için dahili bir komut satırı aracıdır. Uygulamanızı dağıtmak için Cloud Shell'i kullanacaksınız.

Konsolun üstündeki gezinme çubuğunda yer alan <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[simgeyi][spotlight-open-devshell] tıklayarak Cloud Shell'i açın.

## Cloud Shell'de Cloud Dataflow Örneklerini Yükleyin

Cloud Dataflow'un Python sürümü Python, Google Cloud SDK ve Python için Cloud Dataflow SDK'ya sahip bir geliştirme ortamı gerektirir.
Buna ek olarak Cloud Dataflow, SDK bağımlılıklarını yönetmek için Python'ın paket yöneticisi olan pip'i kullanır.

Bu eğitici, Python ve pip yüklenmiş bir Cloud Shell kullanır. Dilerseniz bu eğiticiyi [yerel makinenizde][dataflow-python-tutorial] uygulayabilirsiniz.

### Pip komutunu kullanarak Python için örnekleri ve Cloud Dataflow SDK'yı indirin

Bu komutu çalıştırdığınızda pip, Cloud Dataflow SDK'nın uygun sürümünü indirir ve yükler.

```bash
pip install --user google-cloud-dataflow
```

Cloud Shell'de pip komutunu çalıştırın.

## Cloud Storage paketi kurun

Cloud Dataflow, çıkış verilerini depolamak ve ardışık düzen kodunuzu önbelleğe almak için Cloud Storage paketlerini kullanır.

### gsutil mb'yi çalıştırın

Cloud Shell'de, Cloud Storage paketi oluşturmak için `gsutil mb` komutunu kullanın.

```bash
gsutil mb gs://{{project-id-no-domain}}
```

`gsutil` aracı hakkında daha fazla bilgi edinmek için [belgeleri][gsutil-docs] inceleyin.

## Bir ardışık düzen oluşturun ve başlatın

Cloud Dataflow'da, veri işleme işi *ardışık düzenle* temsil edilir. Bir ardışık düzen giriş verilerini okur, bu veriler üzerinde değişiklikler yapar ve ardından çıkış verisi üretir. Ardışık düzendeki değişiklikler; filtreleme, gruplama, karşılaştırma veya verileri birleştirme işlemlerini kapsayabilir.

### Dataflow Hizmetinizde ardışık düzeninizi oluşturun

Python kullanarak Cloud Dataflow Hizmetinizde ardışık düzeninizi oluşturun. Çalışan ardışık düzen *iş* olarak adlandırılır.

```bash
python -m apache_beam.examples.wordcount \
  --project {{project-id}} \
  --runner DataflowRunner \
  --temp_location gs://{{project-id-no-domain}}/temp \
  --output gs://{{project-id-no-domain}}/results/output \
  --job_name {{job-name}}
```

  *  `output`, WordCount örneği tarafından bu işin sonuçlarının depolanması için kullanılan pakettir.

### İşiniz çalışıyor

Tebrikler! Tebrikler! İkili programınız daha önce oluşturduğunuz depolama paketine yükseltildi ve Compute Engine örnekleri oluşturuluyor. Cloud Dataflow, giriş dosyanızı parçalara ayırarak verilerinizin birçok makinede aynı anda işlenebilmesini sağlayacak.

Not: "JOB_STATE_DONE" mesajını gördüğünüzde Cloud Shell'i kapatabilirsiniz.

## İşinizi izleyin

Cloud Dataflow sayfasında ardışık düzeninizin ilerlemesini kontrol edin.

### Cloud Dataflow Monitoring kullanıcı arayüzü sayfasına gidin

Henüz yapmadıysanız Cloud Dataflow İzleme Kullanıcı Arayüzü sayfasına gidin.

Konsolun sol tarafındaki [menüyü][spotlight-console-menu] açın.

Ardından **Dataflow** bölümünü seçin.

<walkthrough-menu-navigation sectionid="DATAFLOW_SECTION"></walkthrough-menu-navigation>

### İşinizi seçin

Ayrıntılarını görüntülemek için işinizi tıklayın.

### Ardışık düzen ayrıntılarını ve metriklerini keşfedin

Sol kısımdaki ardışık düzeni ve sağ kısımdaki iş bilgilerini inceleyin. İş durumuyla ilgili ayrıntılı bilgileri görmek için [Günlükler][spotlight-job-logs]'i tıklayın. Ardışık düzendeki bir adımı tıklayarak söz konusu adımın metriklerini görüntüleyebilirsiniz.

İşiniz bittiğinde iş durumunun değiştiğini görürsünüz. Ayrıca iş tarafından kullanılan Compute Engine örnekleri otomatik olarak durur.

## Çıkışınızı görüntüleyin

İşiniz çalıştırıldıktan sonra Cloud Storage'daki çıkış dosyalarını keşfedebilirsiniz.

### Cloud Storage sayfasına gidin

Konsolun sol tarafındaki [menüyü][spotlight-console-menu] açın.

Ardından **Compute Engine** bölümünü seçin.

<walkthrough-menu-navigation sectionid="STORAGE_SECTION"></walkthrough-menu-navigation>

### Depolama paketine gidin

Paketler listesinden, daha önce oluşturduğunuz paketi seçin. Önerilen adı kullandıysanız paket `{{project-id}}` olarak adlandırılır.

Pakette hazırlama klasörü ve çıkış klasörleri bulunur. Dataflow çıkışı parçalara ayırarak kaydettiğinden, paketinizde birkaç çıkış dosyası bulunur.

## Temizleyin

Cloud Storage kullanımı nedeniyle sizden ücret alınmasının önüne geçmek için oluşturduğunuz paketi silin.

### Paketler tarayıcısına geri gidin

[Paketler][spotlight-buckets-link] bağlantısını tıklayın.

### Paketi seçin

Oluşturduğunuz paketin yanındaki kutuyu işaretleyin.

### Paketi silin

[Sil][spotlight-delete-bucket]'i tıklayın ve silme işleminizi onaylayın.

## Sonuç

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Şimdi şunları yapabilirsiniz:

  *  [Kelime Sayımı örneği hakkında daha fazla bilgi][wordcount]
  *  [Cloud Dataflow programlama modeli hakkında bilgi][df-pipelines]
  *  [GitHub'da Apache Beam SDK'yı keşfet][beam-sdk]

Yerel ortamınızı ayarlayın:

  *  [Dataflow'u çalıştırmak için Java ve Eclipse kullanma][df-eclipse]
  *  [Dataflow'u çalıştırmak için Java ve Maven kullanma][df-maven]

[beam-sdk]: https://github.com/apache/beam/tree/master/sdks/python
[dataflow-python-tutorial]: https://cloud.google.com/dataflow/docs/quickstarts/quickstart-python
[df-eclipse]: https://cloud.google.com/dataflow/docs/quickstarts/quickstart-java-eclipse
[df-maven]: https://cloud.google.com/dataflow/docs/quickstarts/quickstart-java-maven
[df-pipelines]: https://cloud.google.com/dataflow/model/programming-model-beam
[gsutil-docs]: https://cloud.google.com/storage/docs/gsutil
[spotlight-buckets-link]: walkthrough://spotlight-pointer?cssSelector=.p6n-cloudstorage-path-link
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-delete-bucket]: walkthrough://spotlight-pointer?cssSelector=#p6n-cloudstorage-delete-buckets
[spotlight-job-logs]: walkthrough://spotlight-pointer?cssSelector=#p6n-dax-job-logs-toggle
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[wordcount]: https://beam.apache.org/get-started/wordcount-example/
