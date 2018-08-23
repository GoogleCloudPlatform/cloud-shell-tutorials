# Cloud IoT Core'a Giriş

<walkthrough-tutorial-url url="https://cloud.google.com/iot/docs/quickstart"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="https://github.com/GoogleCloudPlatform/nodejs-docs-samples.git" key="repo-url"></walkthrough-watcher-constant>

## Giriş

Google Cloud Internet of Things (IoT) Core, ister birkaç ister milyonlarca IoT cihazını güvenle bağlayıp yönetmenizi sağlayan, tümüyle yönetilen bir hizmettir. Bu eğitici, bir Cloud IoT Core cihaz kayıt defteri oluşturmak ve cihaz eklemek için `gcloud` komut satırı aracını nasıl kullanacağınızı gösterir. Ayrıca, bir cihazı bağlamak ve cihaz telemetri etkinliklerini yayınlamak için MQTT örneğinin nasıl çalıştırılacağını da buradan öğrenebilirsiniz.

Bu eğitici size şu konularda rehberlik sunacak:

  *  Cloud Pub/Sub konusu oluşturma
  *  Cihaz kaydı oluşturma
  *  Kayıt defterine cihaz ekleme
  *  Cihazda kimlik bilgilerini belirleme
  *  Mesaj gönderip almak için bir Pub/Sub konusuna abonelik oluşturma
  *  Sanal makineye bağlanma ve telemetri verilerini görüntüleme

## Proje hazırlama

Google Cloud Platform, kaynakları projeler halinde düzenler. Bu sayede, tek bir uygulamayla ilgili tüm kaynakları tek bir yerde toplayabilirsiniz.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## Google Cloud Shell'i Kullanma

Bu eğiticide, tüm işlemlerinizi Cloud Shell'de yapacaksınız.

### Google Cloud Shell'i açın

Konsolun üstündeki gezinme çubuğunda yer alan <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[simgeyi][spotlight-open-devshell] tıklayarak Cloud Shell'i açın.

### Google Cloud API'lerini açın

Bu işlem, Cloud IoT Core API'yi etkinleştirecek.

<walkthrough-enable-apis apis="cloudiot.googleapis.com"></walkthrough-enable-apis>

## İlk konunuzu oluşturun

Konu, cihazların mesaj gönderdiği bir adlandırılmış kaynaktır. Aşağıdaki komutla ilk konunuzu oluşturun:

```bash
gcloud pubsub topics create my-topic
```

Bu konuya daha sonra birçok mesaj göndereceksiniz.

## GitHub'dan, Cloud IoT Core Node.js örnek dosyalarını klonlayın

Cloud IoT Core'a mesaj göndermek için MQTT örneğini kullanacaksınız.

Not: Dizin zaten mevcutsa klonlama işleminden önce eski dosyaları kaldırın:

```bash
rm -rf nodejs-docs-samples
```

Şu komutla, örnek programı klonlayın:

```bash
git clone {{repo-url}}
```

## Cloud IoT Core hizmet hesabına izin verin

`/iot/scripts` klasöründeki yardımcı komut dosyasını kullanarak, `cloud-iot@system.gserviceaccount.com` hizmet hesabını Yayıncı rolüyle Cloud Pub/Sub konusuna ekleyin.

### iot dizinine gidin:

```bash
cd nodejs-docs-samples/iot
```

### Bağımlılıkları yükleyin:

```bash
npm --prefix ./scripts install
```

### Yardımcı komut dosyasını çalıştırın:

```bash
node scripts/iam.js my-topic
```

Komut, `my-topic` konusunda Cloud IoT Core hizmet hesabına izin verir.

## Cihaz kayıt defteri oluşturun

Cihaz kayıt defteri, cihazları içerir ve kapsanan tüm cihazlar tarafından paylaşılan özellikleri tanımlar. Aşağıdaki komutu kullanarak cihazınızın kayıt defterini oluşturun:

```bash
gcloud iot registries create my-registry \
    --project={{project-id}} \
    --region=us-central1 \
    --event-notification-config=topic=projects/{{project-id}}/topics/my-topic
```

## İmza anahtarlarınızı oluşturun

Cloud IoT Core'da kimlik doğrulaması için cihazın özel anahtar ve genel anahtarı olması gerekir. Aşağıdaki komutu çalıştırarak imza anahtarlarınızı oluşturun:

```bash
./scripts/generate_keys.sh
```

Komut dosyası, PEM biçiminde RS256 ve ES256 anahtarları oluşturur ancak bu eğitici için yalnızca RS256 anahtarları gereklidir. Cihazda güvenle depolanması gereken özel anahtar, kimlik doğrulaması JWT'sini ([JSON Web Token][web-token-docs]) imzalamak için kullanılır. Genel anahtar, cihaz kayıt defterinde depolanır.

## Cihaz oluşturup kayıt defterine ekleyin

Cihaz oluşturup kayıt defterine eklemek için şu komutu çalıştırın:

```bash
gcloud iot devices create my-node-device \
    --project={{project-id}} \
    --region=us-central1 \
    --registry=my-registry \
    --public-key path=rsa_cert.pem,type=rs256
```

## Cihazınızı bağlayıp telemetri verilerini görüntüleyin

Bu adımda, sanal cihazdan Pub/Sub'a mesaj göndereceksiniz. Ardından, mesajları alıp görüntüleyeceksiniz.

### MQTT örnek dizinine gidin:

```bash
cd mqtt_example
```

### Node.js bağımlılıklarını yükleyin:

```bash
npm install
```

### MQTT köprüsünü kullanarak bir sanal cihazı Cloud IoT Core'a bağlamak için aşağıdaki komutu çalıştırın:

```bash
node cloudiot_mqtt_example_nodejs.js \
    --projectId={{project-id}} \
    --registryId=my-registry \
    --deviceId=my-node-device \
    --privateKeyFile=../rsa_private.pem \
    --numMessages=25 \
    --algorithm=RS256 \
    --mqttBridgePort=443
```

Çıktıda sanal cihazın, telemetri konusunda mesaj yayınladığı gösterilir. Yirmi beş mesaj yayınlandı.

## Cihaz konusuna abonelik oluşturun

Abonelik oluşturmak ve böylece cihazınız tarafından yayınlanan mesajları görüntülemek için şu komutu çalıştırın:

```bash
gcloud pubsub subscriptions create \
    projects/{{project-id}}/subscriptions/my-subscription \
    --topic=my-topic
```

## Yayınlanan mesajları alın

Şu komutla, cihaz tarafından yayınlanan mesajları alın:

```bash
gcloud pubsub subscriptions pull --auto-ack \
    projects/{{project-id}}/subscriptions/my-subscription
```

Bu komut çalıştırıldığında, cihaz tarafından yayınlanan mesajlar döndürülür. Mesajlarda, cihazla ilgili bilgilerden oluşan bir `ATTRIBUTES` listesinin yanı sıra şu veriler yer alır: `my-registry/my-node-device-payload-&lt;INTEGER&gt;`, `MESSAGE_ID`. `MESSAGE_ID`, sunucu tarafından atanan benzersiz bir kimliktir.

Not: Cloud Pub/Sub, mesajların sırasını garanti etmez. Cloud Shell'de sadece bir mesaj görme ihtimaliniz de vardır. Bu durumda, diğer mesajları görene kadar aynı komutu birkaç kez çalıştırmayı deneyin.

## Kaynakları Google Cloud Platform Console'da görüntüleyin

Bu adımla birlikte `gcloud` komut satırı eğiticisi sona eriyor. Ancak yakın zamanda oluşturduğunuz kaynakları görüntülemek için GCP Console'u da kullanabilirsiniz.

Konsolun sol tarafındaki [menüyü][spotlight-console-menu] açın.

Ardından **IoT Core**'u seçin.

<walkthrough-menu-navigation sectionid="IOT_SECTION"></walkthrough-menu-navigation>

Ayrıca kullanıcı arayüzünden, cihaz kayıtları ve cihazlar oluşturup yönetebilirsiniz.

## Sonuç

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Tebrikler! `gcloud` komut satırı aracını kullanarak Cloud IoT Core'un temel kavramlarını öğrendiniz. Bunun yanı sıra Cloud IoT Core kaynaklarını görüntülemek için GCP Console'u kullandınız. Bir sonraki adım, mükemmel uygulamalar oluşturmak! Daha fazla bilgi için [IoT Core belgelerini](https://cloud.google.com/iot/docs/) inceleyin.

### Şimdi şunları yapabilirsiniz:

GitHub'da diğer Cloud IoT Core örneklerini görüntüleyin:

  *  [C](https://github.com/GoogleCloudPlatform/cpp-docs-samples/tree/master/iot/mqtt-ciotc)
  *  [Java](https://github.com/GoogleCloudPlatform/java-docs-samples/tree/master/iot/api-client)
  *  [Node.js](https://github.com/GoogleCloudPlatform/nodejs-docs-samples/tree/master/iot)
  *  [Python](https://github.com/GoogleCloudPlatform/python-docs-samples/tree/master/iot/api-client)

[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[web-token-docs]: https://cloud.google.com/iot/docs/how-tos/credentials/jwts
