# Cloud Pub/Sub'a Giriş

<walkthrough-tutorial-url url="https://cloud.google.com/pubsub/quickstart-console"></walkthrough-tutorial-url></walkthrough-test-start-page>

<walkthrough-devshell-precreate></walkthrough-devshell-precreate>

## Giriş

Cloud Pub/Sub, bağımsız uygulamalar arasında mesaj göndermenizi ve almanızı sağlayan tamamen yönetilen gerçek zamanlı bir mesajlaşma hizmetidir. Bu öğretici, `gcloud` komutunu kullanarak Cloud Pub/Sub komut satırı arayüzüne kısa bir giriş niteliğindedir.

## Proje Ayarları

Google Cloud Platform, kaynakları projeler halinde düzenler. Bu sayede, tek bir uygulamayla ilgili tüm kaynakları tek bir yerde toplayabilirsiniz.

Cloud Pub/Sub, mesajları ayarlamak için bir projeye ihtiyaç duyar.

<walkthrough-project-setup></walkthrough-project-setup>

## İlk konunuzu oluşturma

### Google Cloud Shell'i açma

Cloud Shell, konsol için dahili bir komut satırı aracıdır. Cloud Pub/Sub'ı kurmak için Cloud Shell'i kullanacaksınız.

Konsolun üstündeki gezinme çubuğunda yer alan <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[simgeyi][spotlight-open-devshell] tıklayarak Cloud Shell'i açın.

### Konu oluşturma

Konu, mesajları göndereceğiniz adlandırılmış bir kaynaktır. Aşağıdaki komutla ilk konunuzu oluşturun:

```bash
gcloud pubsub topics create my-topic
```

## Abonelik ekleme

Mesajlar almak için abonelikler oluşturmanız gerekir. Bir aboneliğin ilgili konuya sahip olması gerekir. Aşağıdaki komutla ilk aboneliğinizi oluşturun:

```bash
gcloud pubsub subscriptions \
    create my-sub --topic my-topic \
    --ack-deadline=60
```

Bu komut, `my-topic` konusuna bağlı `my-sub` adında bir abonelik oluşturur. `my-topic` konusunda yayınlanan tüm mesajlar bu aboneliğe gönderilecektir.

`--ack-deadline=60` seçeneğini görebilirsiniz. `ack-deadline`, 
`Acknowledgement deadline`'ın kısaltmasıdır. Bu yeni abonelikte 60 saniyelik `Acknowledgement deadline` vardır. Daha sonra bunu biraz daha açıklayacağız.

## Konuları ve abonelikleri listeleme

İlk mesajınızı göndermeden önce, konu ve aboneliğin başarıyla oluşturulup oluşturulmadığını kontrol edin. Aşağıdaki komutu kullanarak konu ve aboneliğinizi listeleyin:

```bash
gcloud pubsub topics list
```

```bash
gcloud pubsub subscriptions list
```

## Konu için mesaj yayınlama

Aşağıdaki komutları kullanarak iki mesaj gönderin:

```bash
gcloud pubsub topics publish my-topic --message hello
```

```bash
gcloud pubsub topics publish my-topic --message goodbye
```

Bu komutların her biri bir mesaj gönderir. İlk mesaj `hello` ve ikinci mesaj `goodbye`'dır. Bir mesajı başarıyla yayınladığınızda, sunucudan döndürülen mesajKimliği'ni görmeniz gerekir. Bu, her mesaja sunucu tarafından otomatik olarak atanan benzersiz bir kimliktir.

## Abonelikten mesajları alma

### Mesajları alma

Şimdi de mesajları aşağıdaki komutla alın:

```bash
gcloud pubsub subscriptions \
    pull --auto-ack --limit=2 my-sub
```

Büyük olasılıkla yeni yayınladığınız iki mesajı gördünüz. Mesajlar, `hello` ve `goodbye` verileri ile `MESSAGE_ID` değerini içerir. `MESSAGE_ID` sunucu tarafından atanır ve mesajın benzersiz bir kimliğidir.

Not: Cloud Pub/Sub, mesajların sırasını garanti etmez. Yalnızca bir mesaj da görmüş olabilirsiniz. Bu durumda, diğer mesajı görene kadar aynı komutu birkaç kez çalıştırmayı deneyin.

### Onay ve onay bitiş süresi

Bir mesajı aldıktan ve düzgün şekilde işledikten sonra mesajı başarıyla aldığınız konusunda Cloud Pub/Sub'ı bilgilendirmeniz gerekir. Bu işlem, **onay** olarak adlandırılır.

`--auto-ack` işaretinin `pull` komutu ile geçirildiğini fark etmişsinizdir.
`--auto-ack` işareti otomatik olarak mesajı alır ve onaylar.

## Manuel onay

### Yeni mesaj gönderme

Aşağıdaki komutla yeni bir mesaj gönderin:

```bash
gcloud pubsub \
    topics publish my-topic --message thanks
```

### Mesajları yeniden alma

Şu komutla mesajları alın:

```bash
gcloud pubsub subscriptions \
    pull my-sub
```

Bu işlemle, `thanks` mesajının yanı sıra `MESSAGE_ID` ve `ACK_ID` öğesini görürsünüz.
`ACK_ID`, mesajı onaylamak için kullanabileceğiniz başka bir kimliktir.

### Mesajı onaylama

Bir mesaj aldıktan sonra **onay bitiş süresi** geçmeden mesajı onaylamanız gerekir. Örneğin, bir abonelik bu öğreticide yaptığımız gibi 60 saniye **onay bitiş süresi** için yapılandırıldıysa mesajı aldıktan sonra mesajı 60 saniye içinde onaylamanız gerekir. Aksi halde, Cloud Pub/Sub mesajı yeniden gönderir.

Mesajı aşağıdaki komutla onaylayın (`ACK_ID` öğesini kopyalayıp yapıştırarak gerçeğiyle değiştirin):

```bash
gcloud pubsub subscriptions ack \
    my-sub --ack-ids ACK_ID
```

## Pub/Sub kullanıcı arayüzünde konuya ve aboneliğe bakın

`gcloud` komut satırı eğiticisi burada bitiyor ancak bu öğreticiyi bitirmeden önce Google Cloud Console'daki kullanıcı arayüzüne bakalım.

Pub/Sub kısmındaki konu ve aboneliklere de bakabilirsiniz.

### Pub/Sub bölümüne gitme

Konsolun sol tarafındaki [menüyü][spotlight-console-menu] açın.

Ardından **Pub/Sub** bölümünü seçin.

<walkthrough-menu-navigation sectionid="CLOUDPUBSUB_SECTION"></walkthrough-menu-navigation>

Kullanıcı arayüzü, konu ve abonelikler oluşturmanızı ve yönetmenizi de sağlar.

### Konuyu silme

Oluşturduğunuz konunun yanındaki onay kutusunu işaretleyin ve konuyu kalıcı olarak silmek için [Sil düğmesini][spotlight-delete-button] tıklayın.

## Sonuç

Tebrikler!

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

`gcloud` komut satırı aracını kullanarak Cloud Pub/Sub'ın temel kavramlarını gördünüz ve Cloud Pub/Sub kullanıcı arayüzüne göz attınız. Sonraki adım mükemmel uygulamalarınızı oluşturmak! Daha fazla bilgi edinmek için [Pub/Sub belgelerine][pubsub-docs] göz atın.

Şimdi şunları yapabilirsiniz:

[Kod örneklerini gör](https://cloud.google.com/pubsub/docs/quickstart-client-libraries)

[pubsub-docs]: https://cloud.google.com/pubsub/docs/
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-delete-button]: walkthrough://spotlight-pointer?cssSelector=.p6n-icon-delete
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
