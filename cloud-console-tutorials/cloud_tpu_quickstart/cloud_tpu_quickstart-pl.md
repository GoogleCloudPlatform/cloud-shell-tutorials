# Krótkie wprowadzenie do korzystania z TPU

<walkthrough-tutorial-url url="https://cloud.google.com/tpu/docs/quickstart"></walkthrough-tutorial-url>

## Wstęp

[Tensor Processing Unit][tpu-docs] (TPU) może posłużyć do przyspieszenia określonych zadań systemów uczących się, które wykorzystują [TensorFlow][tensor-flow]. Z tego samouczka dowiesz się, jak utworzyć jednostkę Cloud TPU i użyć jej do uruchomienia podstawowego modelu w TensorFlow.

## Konfiguracja projektu

Google Cloud Platform organizuje zasoby w projekty. Dzięki temu wszystkie zasoby powiązane z jedną aplikacją są przechowywane w jednym miejscu.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## Konfigurowanie Cloud SDK

### Otwieranie Cloud Shell

Cloud Shell to wbudowane narzędzie wiersza poleceń konsoli, które może posłużyć do połączenia z TPU.

Kliknij [ikonę][spotlight-open-devshell] <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon> na pasku nawigacyjnym u góry konsoli, aby otworzyć Cloud Shell.

### Określanie strefy

Aby określić strefę, w której planujesz stworzyć zasób TPU, skorzystaj z następującego polecenia:

```bash
gcloud config set compute/zone us-central1-c
```

W tym przykładzie użyj strefy `us-central1-c`.

Aby sprawdzić dostępne strefy, odwiedź stronę z dokumentacją Cloud TPU:

[Regiony i strefy Cloud TPU][tpu-regions]

## Tworzenie zasobów

To krótkie wprowadzenie wymaga utworzenia maszyny wirtualnej Compute Engine. Obraz zawiera narzędzie wiersza poleceń `gcloud beta`, a także wersję TensorFlow do publikacji, która pozwala uruchomić TensorFlow w zasobach Cloud TPU.

### Tworzenie maszyny wirtualnej Compute Engine

Skorzystaj z narzędzia wiersza poleceń `gcloud`, by utworzyć maszynę wirtualną.

```bash
gcloud compute instances create tpu-demo-vm \
  --machine-type=n1-standard-4 \
  --boot-disk-size=500GB \
  --image-project=ml-images \
  --image-family=tf-1-8 \
  --scopes=cloud-platform
```

### Włączanie TPU API

Jeśli interfejs TPU API nie został jeszcze aktywowany, zrób to teraz.

<walkthrough-enable-apis apis="tpu.googleapis.com"></walkthrough-enable-apis>

### Tworzenie zasobu TPU

Za pomocą polecenia `gcloud beta compute tpus create` utwórz nowy zasób Cloud TPU. W tym przykładzie ustaw dla flagi {`--range` wartość `10.240.1.0/29`.

```bash
gcloud beta compute tpus create demo-tpu \
  --range=10.240.1.0/29 --version=1.8
```

## Uruchamianie przykładowego programu w TensorFlow

Połącz się z instancją i utwórz program w TensorFlow ze zdalnym wywoływaniem procedury (RPC), który wskazuje na punkt końcowy sieci Twojego TPU.

### Nawiązywanie połączenia z instancją

Wpisz następujące polecenie, by połączyć się przez SSH z maszyną wirtualną. Jeśli po raz pierwszy używasz SSH w Cloud Shell, musisz utworzyć klucz prywatny:

```bash
gcloud compute ssh tpu-demo-vm
```

### Określanie nazwy TPU

Ustaw zmienną środowiskową dla instancji zawierającą wybraną przez Ciebie nazwę TPU. W tym przykładzie użyj „demo-tpu”.

```bash
export TPU_NAME="demo-tpu"
```

### Tworzenie aplikacji

Utwórz aplikację w Pythonie, która wskazuje punkt końcowy Cloud TPU i uruchamia proste obliczenia.

```bash
nano cloud-tpu.py
```

Skopiuj i wklej tę zawartość pliku:

```python
import os
import tensorflow as tf
from tensorflow.contrib import tpu
from tensorflow.contrib.cluster_resolver import TPUClusterResolver

def axy_computation(a, x, y):
  return a * x + y

inputs = [
    3.0,
    tf.ones([3, 3], tf.float32),
    tf.ones([3, 3], tf.float32),
]

tpu_computation = tpu.rewrite(axy_computation, inputs)

tpu_grpc_url = TPUClusterResolver(
    tpu=[os.environ['TPU_NAME']]).get_master()

with tf.Session(tpu_grpc_url) as sess:
  sess.run(tpu.initialize_system())
  sess.run(tf.global_variables_initializer())
  output = sess.run(tpu_computation)
  print(output)
  sess.run(tpu.shutdown_system())

print('Done!')
```

### Uruchamianie aplikacji

Uruchom program w TensorFlow.

```bash
python cloud-tpu.py
```

Jeśli chcesz, możesz tworzyć i uruchamiać dodatkowe programy w TensorFlow, które wykorzystują TPU.

Po zakończeniu eksperymentów wyjdź z instancji.

```bash
exit
```

## Usuwanie zasobów

Oto kroki, które musisz wykonać, aby uniknąć obciążenia konta Google Cloud Platform opłatami za zasoby zużyte podczas krótkiego wprowadzenia.

### Usuwanie zasobu TPU i maszyny wirtualnej

Skorzystaj z narzędzia wiersza poleceń gcloud, by usunąć zasób Cloud TPU.

```bash
gcloud beta compute tpus delete demo-tpu
```

Skorzystaj z narzędzia wiersza poleceń `gcloud`, by usunąć instancję Compute Engine.

```bash
gcloud compute instances delete tpu-demo-vm
```

### Usuwanie sieci VPC

Otwórz sekcję Sieć VPC w konsoli Google Cloud Platform.

<walkthrough-menu-navigation sectionid="VIRTUAL_NETWORK_SECTION"></walkthrough-menu-navigation>

Przejdź do sekcji [Połączenia sieci równorzędnych VPC][spotlight-network-peering] i wybierz sieć VPC utworzoną automatycznie przez Google podczas konfigurowania Cloud TPU. We wpisie dotyczącym połączenia równorzędnego identyfikator zaczyna się od `cp-to-tp-peering`.

U góry strony kliknij **Usuń**.

### Usuwanie trasy VPC

Przejdź do sekcji [Trasy][spotlight-routes-list] i wybierz trasę utworzoną automatycznie przez Google podczas konfiguracji Cloud TPU. We wpisie dotyczącym połączenia równorzędnego identyfikator zaczyna się od `peering-route`.

U góry strony kliknij **Usuń**.

## Podsumowanie

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Gratulacje!

Udało Ci się stworzyć aplikację wykorzystującą Cloud TPU.

Aby dowiedzieć się więcej, odwiedź stronę z dokumentacją Cloud TPU:

[https://cloud.google.com/tpu/][tpu-docs]

[request-tpu-quota]: https://services.google.com/fb/forms/cloud-tpu-beta-request/
[spotlight-network-peering]: walkthrough://spotlight-pointer?cssSelector=#cfctest-section-nav-item-peering_list
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-routes-list]: walkthrough://spotlight-pointer?cssSelector=#cfctest-section-nav-item-routes_list
[tensor-flow]: https://www.tensorflow.org/
[tpu-docs]: https://cloud.google.com/tpu/docs/
[tpu-regions]: https://cloud.google.com/tpu/docs/regions
