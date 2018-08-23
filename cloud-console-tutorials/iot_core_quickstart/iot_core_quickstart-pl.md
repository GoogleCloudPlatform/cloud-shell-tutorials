# Wprowadzenie do Cloud IoT Core

<walkthrough-tutorial-url url="https://cloud.google.com/iot/docs/quickstart"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="https://github.com/GoogleCloudPlatform/nodejs-docs-samples.git" key="repo-url"></walkthrough-watcher-constant>

## Wstęp

Google Cloud Internet of Things (IoT) Core to w pełni zarządzana usługa pozwalająca na bezpieczne łączenie urządzeń w ramach internetu rzeczy i na zarządzanie nimi, niezależnie od tego czy tych urządzeń jest kilka, czy kilka milionów. Z tego samouczka dowiesz się, jak za pomocą narzędzia wiersza poleceń `gcloud` utworzyć w Cloud IoT Core rejestr urządzeń i jak dodać do niego urządzenie. Zobaczysz także, jak uruchomić przykładową aplikację MQTT, aby podłączyć urządzenie i opublikować pochodzące z niego zdarzenia telemetryczne.

W tym samouczku omawiamy:

  *  tworzenie tematu Cloud Pub/Sub;
  *  tworzenie rejestru urządzeń;
  *  dodawanie urządzenia do rejestru;
  *  konfigurowanie danych logowania urządzenia;
  *  tworzenie subskrypcji tematu Pub/Sub, do którego będą wysyłane i z którego będą odbierane wiadomości;
  *  podłączanie urządzenia wirtualnego i wyświetlanie danych telemetrycznych.

## Konfiguracja projektu

Google Cloud Platform organizuje zasoby w projekty. Dzięki temu wszystkie zasoby powiązane z jedną aplikacją są przechowywane w jednym miejscu.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## Korzystanie z Google Cloud Shell

Wszystkie zadania w ramach tego samouczka wykonasz w Cloud Shell.

### Otwarcie Google Cloud Shell

Kliknij [ikonę][spotlight-open-devshell] <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon> na pasku nawigacyjnym u góry konsoli, aby otworzyć Cloud Shell.

### Włączenie interfejsów API Google Cloud

Włączenie tych interfejsów włączy też interfejs Cloud IoT Core API.

<walkthrough-enable-apis apis="cloudiot.googleapis.com"></walkthrough-enable-apis>

## Tworzenie pierwszego tematu

Temat to nazwany zasób, do którego urządzenia wysyłają wiadomości. Utwórz pierwszy temat przy pomocy tego polecenia:

```bash
gcloud pubsub topics create my-topic
```

Później wyślesz do niego kilka wiadomości.

## Klonowanie z GitHuba przykładowych plików Node.js dla Cloud IoT Core

Przykładowej aplikacji MQTT użyjesz do wysłania wiadomości do Cloud IoT Core.

Uwaga: jeżeli katalog już istnieje, przed kopiowaniem usuń wcześniejsze pliki:

```bash
rm -rf nodejs-docs-samples
```

Skopiuj przykładowy program za pomocą następującego polecenia:

```bash
git clone {{repo-url}}
```

## Przyznawanie uprawnień kontu usługi Cloud IoT Core

Za pomocą skryptu pomocniczego z folderu `/iot/scripts` dodaj do tematu Cloud Pub/Sub konto usługi `cloud-iot@system.gserviceaccount.com` i przydziel mu rolę publikującego.

### Przejdź do katalogu iot:

```bash
cd nodejs-docs-samples/iot
```

### Zainstaluj zależności:

```bash
npm --prefix ./scripts install
```

### Uruchom skrypt pomocniczy:

```bash
node scripts/iam.js my-topic
```

Skrypt ten przyznaje uprawnienia kontu usługi Cloud IoT Core w temacie `my-topic`.

## Tworzenie rejestru urządzeń

W rejestrze urządzeń znajdują się urządzenia oraz określone są właściwości wspólne dla wszystkich zawartych w nim urządzeń. Utwórz własny rejestr urządzeń za pomocą tego polecenia:

```bash
gcloud iot registries create my-registry \
    --project={{identyfikator-projektu}} \
    --region=us-central1 \
    --event-notification-config=topic=projects/{{identyfikator-projektu}}/topics/my-topic
```

## Generowanie kluczy podpisywania

Aby uwierzytelnić się w Cloud IoT core, urządzenie potrzebuje klucza prywatnego i klucza publicznego. Wygeneruj klucze podpisywania, uruchamiając następujące polecenie:

```bash
./scripts/generate_keys.sh
```

Skrypt tworzy klucze RS256 i ES256 w formacie PEM, ale w tym samouczku potrzebne będą tylko klucze RS256. Klucz prywatny musi być przechowywany na urządzeniu w bezpieczny sposób – służy on do podpisywania tokena internetowego JSON ([JWT][web-token-docs]) używanego do uwierzytelniania. Klucz publiczny przechowywany jest w rejestrze urządzeń.

## Tworzenie urządzenia i dodawanie go do rejestru

Uruchom następujące polecenie, aby utworzyć urządzenie i dodać je do rejestru:

```bash
gcloud iot devices create my-node-device \
    --project={{identyfikator-projektu}} \
    --region=us-central1 \
    --registry=my-registry \
    --public-key path=rsa_cert.pem,type=rs256
```

## Podłączanie urządzenia i wyświetlanie danych telemetrycznych

Podczas tego kroku wyślesz wiadomości z wirtualnego urządzenia do Pub/Sub. Następnie pobierzesz wiadomości i wyświetlisz je.

### Przejdź do katalogu z przykładową aplikacją MQTT:

```bash
cd mqtt_example
```

### Zainstaluj zależności Node.js:

```bash
npm install
```

### Uruchom polecenie podłączające urządzenie wirtualne do Cloud IoT Core za pomocą mostka MQTT:

```bash
node cloudiot_mqtt_example_nodejs.js \
    --projectId={{identyfikator-projektu}} \
    --registryId=my-registry \
    --deviceId=my-node-device \
    --privateKeyFile=../rsa_private.pem \
    --numMessages=25 \
    --algorithm=RS256 \
    --mqttBridgePort=443
```

Dane wynikowe wskazują, że urządzenie wirtualne publikuje wiadomości w temacie dotyczącym telemetrii. Opublikowanych zostało dwadzieścia pięć wiadomości.

## Tworzenie subskrypcji w temacie urządzenia

Uruchom następujące polecenie, aby utworzyć subskrypcję, co pozwoli Ci wyświetlać wiadomości publikowane przez Twoje urządzenie:

```bash
gcloud pubsub subscriptions create \
    projects/{{identyfikator-projektu}}/subscriptions/my-subscription \
    --topic=my-topic
```

## Pobieranie opublikowanych wiadomości

Pobierz wiadomości opublikowane przez urządzenie, korzystając z następującego polecenia:

```bash
gcloud pubsub subscriptions pull --auto-ack \
    projects/{{identyfikator-projektu}}/subscriptions/my-subscription
```

Po uruchomieniu tego polecenia zwracane są wiadomości opublikowane przez urządzenie. Wiadomości zawierają następujące dane: `my-registry/my-node-device-payload-&lt;INTEGER&gt;`, `MESSAGE_ID` oraz `ATTRIBUTES` (listę informacji o urządzeniu). `MESSAGE_ID` to unikalny identyfikator przyznawany przez serwer.

Uwaga: Cloud Pub/Sub nie gwarantuje zachowania kolejności wiadomości. Może też się zdarzyć, że w Cloud Shell wyświetli Ci się tylko jedna wiadomość. W takiej sytuacji uruchom to samo polecenie kilkakrotnie, aż zaczną pojawiać się pozostałe wiadomości.

## Wyświetlanie zasobów w konsoli Google Cloud Platform

To już koniec samouczka poświęconego narzędziu wiersza poleceń `gcloud`, ale możesz jeszcze wyświetlić utworzone przez siebie zasoby w konsoli GCP.

Otwórz [menu][spotlight-console-menu] po lewej stronie konsoli.

Następnie wybierz **IoT Core**.

<walkthrough-menu-navigation sectionid="IOT_SECTION"></walkthrough-menu-navigation>

Interfejs umożliwia tworzenie urządzeń oraz rejestrów urządzeń, a także zarządzanie nimi.

## Podsumowanie

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Gratulacje! Znasz już podstawy korzystania z Cloud IoT Core za pomocą narzędzia wiersza poleceń `gcloud` i wiesz, jak wyświetlać zasoby Cloud IoT Core w konsoli GCP. Pozostaje Ci już tylko tworzyć aplikacje. Więcej informacji znajdziesz w [dokumentacji IoT Core](https://cloud.google.com/iot/docs/).

### Oto, co możesz teraz zrobić

Znajdź na GitHubie więcej przykładowych programów korzystających z Cloud IoT Core:

  *  [C](https://github.com/GoogleCloudPlatform/cpp-docs-samples/tree/master/iot/mqtt-ciotc)
  *  [Java](https://github.com/GoogleCloudPlatform/java-docs-samples/tree/master/iot/api-client)
  *  [Node.js](https://github.com/GoogleCloudPlatform/nodejs-docs-samples/tree/master/iot)
  *  [Python](https://github.com/GoogleCloudPlatform/python-docs-samples/tree/master/iot/api-client)

[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[web-token-docs]: https://cloud.google.com/iot/docs/how-tos/credentials/jwts
