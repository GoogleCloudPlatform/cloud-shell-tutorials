# Compute Engine Hızlı Başlangıç

## MongoDB ile yapılacaklar uygulaması oluşturun

<walkthrough-tutorial-duration duration="15"></walkthrough-tutorial-duration>

Bu hızlı başlangıç belgesinde iki katmanlı bir uygulama oluşturmak için Compute
Engine'i kullanacaksınız. Ön uç sanal makinesi Node.js yapılacaklar listesi web
uygulamasını çalıştırırken, arka uç sanal makinesi MongoDB'yi çalıştırır.

Bu eğitici size şu konularda rehberlik sunacak:

*   İki sanal makine oluşturma ve yapılandırma
*   Güvenlik duvarı kuralları ayarlama
*   Sanal makinelerinizde paket yüklemek için SSH kullanma

## Proje ayarlama

Google Cloud Platform, kaynakları projeler halinde düzenler. Bu sayede, tek bir
uygulamayla ilgili tüm kaynakları tek bir yerde toplayabilirsiniz.

<walkthrough-project-billing-setup permissions="compute.instances.create"></walkthrough-project-billing-setup>

## Compute Engine'e gidin

Konsolun sol tarafındaki [menüyü][spotlight-console-menu] açın.

Ardından **Compute Engine** bölümünü seçin.

<walkthrough-menu-navigation sectionid="COMPUTE_SECTION"></walkthrough-menu-navigation>

## Örnek oluşturun

Uygulama için arka uç ve ön uç sunucusu olmak üzere 2 örnek oluşturacaksınız.

### Arka uç örneğini oluşturun

Önce MongoDB çalıştıran arka uç örneğini oluşturun. Bu sunucu, yapılacaklar
listesi öğelerini depolar.

[Örnek oluştur][spotlight-create-instance] düğmesini tıklayın.

*   Bu örnek için [ad][spotlight-instance-name] ve
    [alt bölge][spotlight-instance-zone] seçin.

*   [f1-micro][spotlight-machine-type] seçeneğini belirleyin. Bu sayede daha az
    ücretlendirilirsiniz.

    *   [Fiyatlandırma hakkında daha fazla bilgi][pricing]

*   Bu eğitici için önyükleme diski görüntünüz olarak
    [Ubuntu 14.04 LTS][spotlight-boot-disk]'yi seçin.

*   [Güvenlik Duvarı seçicide][spotlight-firewall] **HTTP trafiğine izin ver**
    seçeneğini belirleyin. Bu, uygulamaya erişmek için 80 numaralı bağlantı
    noktasını (HTTP) açar.

*   Örneği oluşturmak için [Oluştur][spotlight-submit-create] düğmesini
    tıklayın.

Not: Örnek oluşturulduktan sonra faturalandırma hesabınız GCE fiyatlandırmasına
göre ücretlendirilmeye başlar. Ekstra ücretlerden kaçınmak için daha sonra
örneği kaldırabilirsiniz.

### Ön uç örneğini oluşturun

Arka uç sanal makinesi dönerken, Node.js yapılacaklar listesi uygulamasını
çalıştıran ön uç sanal makinesini oluşturun. Arka uç örneğiyle aynı
yapılandırmayı kullanın.

## Kurulum

Verilerinizi kaydetmek için arka uç örneğine bir MongoDB veritabanı kurarsınız.

Tablodaki [SSH düğmeleri][spotlight-ssh-buttons], örneğinize ayrı bir pencerede
bir SSH oturumu açar.

Bu eğiticide Cloud Shell kullanarak bağlanacaksınız. Cloud Shell, konsol için
dahili bir komut satırı aracıdır.

### Cloud Shell'i açın

Konsolun üstündeki gezinme çubuğunda yer alan
<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[simgeyi][spotlight-open-devshell]
tıklayarak Cloud Shell'i açın.

### Örnek oluşturma işleminin bitmesini bekleyin

Eğiticinin devam edebilmesi için örnek oluşturma işleminin bitmesi gerekir.
İşlem, üstteki gezinme çubuğunda yer alan
[bildirim menüsünü][spotlight-notification-menu] tıklayarak izlenebilir.

## Arka uç örneğinize bağlanın

### Örneğe bağlanın

Sanal makine içine SSH uygulamak için aşağıdaki komutu girin. İlk kez Cloud
Shell'den SSH kullanıyorsanız bir özel anahtar oluşturmanız gerekir.
Oluşturduğunuz örneğin alt bölgesini ve adını girin.

```bash
gcloud compute --project "{{project-id}}" ssh --zone <backend-zone> <backend-name>
```

### Arka uç veritabanını yükleyin

Artık arka uç örneğine bir SSH bağlantınız olduğuna göre aşağıdaki komutları
kullanarak arka uç veritabanını kurabilirsiniz:

Paketleri günceller ve MongoDB'yi yükler. Devam etmek isteyip istemediğiniz
sorulduğunda `Y` yazın.

```bash
sudo apt-get update
```

```bash
sudo apt-get install mongodb
```

### Veritabanını çalıştırın

MongoDB hizmeti, siz hizmeti yüklediğinizde başlatıldı. Hizmetin çalışma şeklini
değiştirebilmeniz için hizmeti durdurmanız gerekir.

```bash
sudo service mongodb stop
```

MongoDB için bir dizin oluşturur ve MongoDB hizmetini arka planda 80 numaralı
bağlantı noktası üzerinde çalıştırır.

```bash
sudo mkdir $HOME/db
```

```bash
sudo mongod --dbpath $HOME/db --port 80 --fork --logpath /var/tmp/mongodb
```

Sonra, `exit` komutunu kullanarak SSH oturumundan çıkın:

```bash
exit
```

## Ön uç örneğinize bağlanın

### Web uygulamasını ön uç sanal makinenizde yükleyin ve çalıştırın

Arka uç sunucusu çalışıyor, artık ön uç web uygulamasını yükleyebilirsiniz.

### Örneğe bağlanın

Sanal makine içine SSH uygulamak amacıyla aşağıdaki komutu girin. Oluşturduğunuz
örneğin alt bölgesini ve adını girin.

```bash
gcloud compute --project "{{project-id}}" ssh --zone <frontend-zone> <frontend-name>
```

### Bağımlılıkları yükleyin

Ön uç örneğinize bağlandığınıza göre paketleri güncelleyin ve git, Node.js ve
npm'yi yükleyin. Devam etmek isteyip istemediğiniz sorulduğunda `Y` yazın.

```bash
sudo apt-get update
```

```bash
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
```

```bash
sudo apt-get install git nodejs
```

### Ön uç web uygulamasını kurun ve çalıştırın

Örnek uygulamayı klonlayın ve uygulama bağımlılıklarını yükleyin.

```bash
git clone https://github.com/GoogleCloudPlatform/todomvc-mongodb.git
```

```bash
cd todomvc-mongodb; npm install
```

```bash
sed -i -e 's/8080/80/g' server.js
```

Oluşturduğunuz örnekler için [dahili ip adreslerini][spotlight-internal-ip]
girerek yapılacaklar listesi web uygulamasını aşağıdaki komutla başlatın:

```bash
sudo nohup nodejs server.js --be_ip <backend-internal-ip> --fe_ip <frontend-internal-ip> &
```

Sonra, `exit` komutunu kullanarak SSH oturumundan çıkın:

```bash
exit
```

### Uygulamanızı ziyaret edin

Web sunucunuzu [Harici IP][spotlight-external-ip] sütununda listelenen IP
adresinde ziyaret edin.

## Temizleme

Örneğinizi kaldırmak için örneğinizin adının yanındaki
[onay kutusunu][spotlight-instance-checkbox] seçin ve
[Sil düğmesini][spotlight-delete-button] tıklayın.

## Sonuç

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Hepsi bu kadar!

Şimdi şunları yapabilirsiniz:

*   [GitHub'da](http://googlecloudplatform.github.io/) Google Cloud Platform
    örneklerini bulun.

*   [Yük Dengelemeyi](https://cloud.google.com/compute/docs/load-balancing/)
    nasıl kuracağınızı öğrenin.

*   [Dosyaları Sanal Makinenize nasıl aktaracağınızı](https://cloud.google.com/compute/docs/instances/transfer-files/)
    öğrenin.

*   [Kapsayıcıları nasıl çalıştıracağınızı](https://cloud.google.com/compute/docs/containers)
    öğrenin.

[pricing]: https://cloud.google.com/compute/#compute-engine-pricing
[spotlight-boot-disk]: walkthrough://spotlight-pointer?cssSelector=vm-set-boot-disk
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-control-panel]: walkthrough://spotlight-pointer?cssSelector=#p6n-action-bar-container-main
[spotlight-create-instance]: walkthrough://spotlight-pointer?spotlightId=gce-zero-new-vm,gce-vm-list-new
[spotlight-delete-button]: walkthrough://spotlight-pointer?cssSelector=.p6n-icon-delete
[spotlight-external-ip]: walkthrough://spotlight-pointer?cssSelector=.p6n-external-link
[spotlight-firewall]: walkthrough://spotlight-pointer?spotlightId=gce-vm-add-firewall
[spotlight-instance-checkbox]: walkthrough://spotlight-pointer?cssSelector=.p6n-checkbox-form-label
[spotlight-instance-name]: walkthrough://spotlight-pointer?spotlightId=gce-vm-add-name
[spotlight-instance-zone]: walkthrough://spotlight-pointer?spotlightId=gce-vm-add-zone-select
[spotlight-internal-ip]: walkthrough://spotlight-pointer?cssSelector=gce-internal-ip
[spotlight-machine-type]: walkthrough://spotlight-pointer?spotlightId=gce-add-machine-type-select
[spotlight-notification-menu]: walkthrough://spotlight-pointer?cssSelector=.p6n-notification-dropdown,.cfc-icon-notifications
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-ssh-buttons]: walkthrough://spotlight-pointer?cssSelector=gce-connect-to-instance
[spotlight-submit-create]: walkthrough://spotlight-pointer?spotlightId=gce-submit
[spotlight-vm-list]: walkthrough://spotlight-pointer?cssSelector=vm2-instance-list%20.p6n-checkboxed-table
