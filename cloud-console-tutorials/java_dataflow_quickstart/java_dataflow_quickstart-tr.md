# Dataflow Kelime Sayısı Eğiticisi

<walkthrough-tutorial-url url="https://cloud.google.com/dataflow/docs/quickstarts/quickstart-java-maven"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="dataflow-intro" key="directory"></walkthrough-watcher-constant>
<walkthrough-watcher-constant value="dataflow-intro" key="job-name"></walkthrough-watcher-constant>

## Giriş

Bu eğiticide, Java yardımıyla basit bir örnek ardışık düzen çalıştırarak Cloud Dataflow hizmetinin temellerini öğreneceksiniz.

Dataflow ardışık düzenleri, *toplu* (bir dosya veya veritabanı tablosu gibi sınırlı girişi işleme) ya da *akış tabanlı* (Cloud Pub/Sub gibi bir kaynaktan gelen sınırı olmayan girişi işleme) olabilir. Bu eğiticideki örnek, Shakespeare'in eserlerindeki kelimeleri sayan bir toplu ardışık düzendir.

Başlamadan önce, Cloud Platform projenizdeki ön koşulları kontrol etmeniz ve ilk kurulumu yapmanız gerekir.

## Proje hazırlayın

Google Cloud Platform, kaynakları projeler halinde düzenler. Bu sayede, tek bir uygulamayla ilgili tüm kaynakları tek bir yerde toplayabilirsiniz.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>
<walkthrough-project-permissions permissions="dataflow.jobs.create"></walkthrough-project-permissions>

## Cloud Dataflow'u hazırlayın

Dataflow'u kullanmak için Cloud Dataflow API'lerini etkinleştirin ve Cloud Shell'i açın.

### Google Cloud API'lerini açın

<walkthrough-enable-apis apis="compute.googleapis.com,dataflow,cloudresourcemanager.googleapis.com,logging,storage_component,storage_api,bigquery,pubsub">
</walkthrough-enable-apis>

### Cloud Shell'i açın

Cloud Shell, konsol için dahili bir komut satırı aracıdır. Uygulamanızı dağıtmak için Cloud Shell'i kullanacaksınız.

Konsolun üstündeki gezinme çubuğunda yer alan <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[simgeyi][spotlight-open-devshell] tıklayarak Cloud Shell'i açın.

## Cloud Shell'de Cloud Dataflow Örneklerini Yükleyin

Java için Cloud Dataflow SDK'yı kullanmak üzere geliştirme ortamınızda Java, Google Cloud SDK, Java için Cloud Dataflow SDK ve ayrıca SDK bağımlılıklarını yönetmek amacıyla Apache Maven olması gerekir. Bu eğitici; Java, Google Cloud SDK ve Maven yüklenmiş bir Cloud Shell kullanır.

Alternatif olarak, bu eğiticiyi [yerel makinenizde uygulayabilirsiniz.][dataflow-java-tutorial]

### Maven komutunu kullanarak örnekleri ve Java için Cloud Dataflow SDK'yı indirin

Bu komutu çalıştırdığınızda Maven bir proje yapısı ayarlar ve Cloud Dataflow SDK'nın uygun sürümünü indirmek için kullanılacak bir yapılandırma dosyası oluşturur.

```bash
mvn archetype:generate \
    -DarchetypeArtifactId=google-cloud-dataflow-java-archetypes-examples \
    -DarchetypeGroupId=com.google.cloud.dataflow \
    -DarchetypeVersion=2.1.0 \
    -DgroupId=com.example \
    -DartifactId={{directory}} \
    -Dversion="0.1" \
    -DinteractiveMode=false \
    -Dpackage=com.example
```

  *  `archtypeArtifactId` ve `archetypeGroupId`, örnek proje yapısını tanımlamak için kullanılır.
  *  `groupID`, kuruluşunuzun java paketi adı ön ekidir, ör. `com.sirketim`
  *  `artifactId`, oluşturulan jar dosyasının adını belirler. Bu eğiticinin amacı doğrultusunda varsayılan değeri (`{{directory}}`) kullanın.

Cloud Shell'de Maven komutunu çalıştırın.

### Dizini değiştirin

Çalışma dizininizi `{{directory}}` olarak değiştirin.

```bash
cd {{directory}}
```

Bu örnek için belirlenen kodu görmek isterseniz `{{directory}}` dizinindeki `src` alt dizinine bakmanız yeterlidir.

## Cloud Storage paketi hazırlayın

Cloud Dataflow, Cloud Storage paketlerini çıkış verilerini depolamak ve ardışık düzen kodunuzu önbelleğe almak için kullanır.

### gsutil mb'yi çalıştırın

Cloud Shell'de, Cloud Storage paketi oluşturmak için `gsutil mb` komutunu kullanın.

```bash
gsutil mb gs://{{project-id-no-domain}}
```

`gsutil` aracı hakkında daha fazla bilgi edinmek için [belgeleri][gsutil-docs] inceleyin.

## Bir ardışık düzen oluşturun ve başlatın

Cloud Dataflow'da, veri işleme işi bir *ardışık düzen* ile temsil edilir. Bir ardışık düzen giriş verilerini okur, bu verilerde değişimler gerçekleştirir ve ardından çıkış verilerini üretir. Bir ardışık düzenin değişimleri; filtreleme, gruplama, karşılaştırma veya verileri birleştirme işlemlerini içerebilir.

Bu örnek için belirlenen kodu görmek isterseniz `{{directory}}` dizinindeki `src` alt dizinine bakmanız yeterlidir.

### Dataflow Hizmetinde ardışık düzeninizi başlatın

Hizmette ardışık düzeninizi başlatmak için Apache Maven'in `mvn exec` komutunu kullanın.
Çalışan ardışık düzene bir *iş* adı verilir.

```bash
mvn compile exec:java \
  -Dexec.mainClass=com.example.WordCount \
  -Dexec.args="--project={{project-id}} \
  --stagingLocation=gs://{{project-id-no-domain}}/staging/ \
  --output=gs://{{project-id-no-domain}}/output \
  --runner=DataflowRunner \
  --jobName={{job-name}}"
```

  *  `stagingLocation`, Cloud Dataflow'un ardışık düzeni çalıştırmak için ikili programları ve diğer verileri depolayacağı konumdur. Bu konum, işler arasında paylaşılabilir.
  *  `output`, WordCount örneği tarafından bu işin sonuçlarının saklanması için kullanılan pakettir.

### İşiniz çalışıyor

Tebrikler! İkili programınız şimdi daha önce oluşturduğunuz depolama paketine yükseltildi ve Compute Engine örnekleri oluşturuluyor. Cloud Dataflow, giriş dosyanızı ayırarak verilerinizin birçok makinede paralel işlenebilmesini sağlayacak.

Not: "İş tamamlandı" mesajını gördüğünüzde Cloud Shell'i kapatabilirsiniz.

Oluşturduğunuz Maven projesini temizlemek isterseniz dizini silmek için Cloud Shell'de `cd .. && rm -R {{directory}}` kodunu çalıştırın.

## İşinizi izleyin

Cloud Dataflow İzleme Kullanıcı Arayüzü sayfasında ardışık düzeninizin ilerlemesini kontrol edin.

### Cloud Dataflow sayfasına gidin

Konsolun sol tarafındaki [menüyü][spotlight-console-menu] açın.

Ardından **Dataflow** bölümünü seçin.

<walkthrough-menu-navigation sectionid="DATAFLOW_SECTION"></walkthrough-menu-navigation>

### İşinizi seçin

Ayrıntılarını görüntülemek için işinizi tıklayın.

### Ardışık düzen ayrıntılarını ve metriklerini keşfedin

Solda ardışık düzeni, sağda da iş bilgilerini keşfedin. İş durumunu ayrıntılı olarak görmek için [Günlükler][spotlight-job-logs]'i tıklayın. Ardışık düzendeki bir adımı tıklayarak metriklerini görüntüleyebilirsiniz.

İşiniz bittiğinde iş durumunun değiştiğini görürsünüz. Ayrıca iş tarafından kullanılan Compute Engine örnekleri otomatik olarak durur.

## Çıkışınızı görüntüleyin

İşiniz çalıştırıldıktan sonra Cloud Storage'daki çıkış dosyalarını keşfedebilirsiniz.

### Cloud Storage sayfasına gidin

Konsolun sol tarafındaki [menüyü][spotlight-console-menu] açın.

Ardından, **Storage** bölümünü seçin.

<walkthrough-menu-navigation sectionid="STORAGE_SECTION"></walkthrough-menu-navigation>

### Depolama paketine gidin

Paketler listesinden, daha önce oluşturduğunuz paketi seçin. Önerilen adı kullandıysanız paket `{{project-id}}` olarak adlandırılmıştır.

Pakette aşama klasörü ve çıkış klasörleri bulunur. Dataflow çıkışı parçalar olarak kaydettiği için pakette birkaç çıkış dosyası vardır.

## Temizleyin

Cloud Storage kullanımı nedeniyle ücret alınmasını önlemek için oluşturduğunuz paketi silin.

### Paketler tarayıcısına geri gidin

[Paketler][spotlight-buckets-link] bağlantısını tıklayın.

### Paketi seçin

Oluşturduğunuz paketin yanındaki kutuyu işaretleyin.

### Paketi silin

[Sil][spotlight-delete-bucket]'i tıklayın ve silme işlemini onaylayın.

## Sonuç

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Şimdi şunları yapabilirsiniz:

  *  [Kelime Sayısı örneği hakkında daha fazla bilgi edinin][wordcount]
  *  [Cloud Dataflow programlama modeli hakkında bilgi edinin][df-model]
  *  [GitHub'da Cloud Dataflow SDK'yı keşfedin][df-sdk]

Yerel ortamınızı ayarlayın:

  *  [Dataflow'u çalıştırmak için Eclipse kullanın][df-eclipse]
  *  [Dataflow'u çalıştırmak için Python kullanın][df-python]

[dataflow-java-tutorial]: https://cloud.google.com/dataflow/docs/quickstarts/quickstart-java-maven
[df-eclipse]: https://cloud.google.com/dataflow/docs/quickstarts/quickstart-java-eclipse
[df-model]: https://cloud.google.com/dataflow/model/programming-model-beam
[df-python]: https://cloud.google.com/dataflow/docs/quickstarts/quickstart-python
[df-sdk]: https://github.com/apache/beam/tree/master/sdks/java
[gsutil-docs]: https://cloud.google.com/storage/docs/gsutil
[spotlight-buckets-link]: walkthrough://spotlight-pointer?cssSelector=.p6n-cloudstorage-path-link
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-delete-bucket]: walkthrough://spotlight-pointer?cssSelector=#p6n-cloudstorage-delete-buckets
[spotlight-job-logs]: walkthrough://spotlight-pointer?cssSelector=#p6n-dax-job-logs-toggle
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[wordcount]: https://beam.apache.org/get-started/wordcount-example/
