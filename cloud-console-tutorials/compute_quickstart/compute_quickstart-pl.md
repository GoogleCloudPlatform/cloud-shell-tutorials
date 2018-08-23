# Compute Engine – szybki start

## Tworzenie aplikacji z listą zadań korzystającą z MongoDB

<walkthrough-tutorial-duration duration="15"></walkthrough-tutorial-duration>

W ramach tego krótkiego wprowadzenia wykorzystasz Compute Engine, aby utworzyć
dwupoziomową aplikację. Na maszynie wirtualnej frontendu będzie działać
aplikacja internetowa z listą zadań oparta na Node.js, a na maszynie wirtualnej
backendu uruchomimy MongoDB.

W tym samouczku omawiamy:

*   tworzenie i konfigurowanie dwóch maszyn wirtualnych,
*   konfigurowanie reguł zapory sieciowej,
*   używanie protokołu SSH przy instalowaniu pakietów na maszynach wirtualnych.

## Konfiguracja projektu

Google Cloud Platform organizuje zasoby w projekty. Dzięki temu wszystkie zasoby
powiązane z jedną aplikacją są przechowywane w jednym miejscu.

<walkthrough-project-billing-setup permissions="compute.instances.create"></walkthrough-project-billing-setup>

## Przechodzenie do Compute Engine

Otwórz [menu][spotlight-console-menu] po lewej stronie konsoli.

Wybierz sekcję **Compute Engine**.

<walkthrough-menu-navigation sectionid="COMPUTE_SECTION"></walkthrough-menu-navigation>

## Tworzenie instancji

Utworzysz dwie instancje, które będą serwerem backendu i frontendu dla
aplikacji.

### Tworzenie instancji backendowej

Zacznij od utworzenia instancji backendowej z MongoDB. Będzie ona służyć jako
serwer przechowujący elementy listy zadań.

Kliknij przycisk [Utwórz instancję][spotlight-create-instance].

*   Wybierz [nazwę][spotlight-instance-name] i [strefę][spotlight-instance-zone]
    instancji.

*   Wybierz [f1-micro][spotlight-machine-type]. Spowoduje to naliczenie
    mniejszych opłat.

    *   [Więcej informacji o cenach][pricing]

*   Wybierz [Ubuntu 14.04 LTS][spotlight-boot-disk] jako obraz dysku
    rozruchowego na potrzeby tego samouczka.

*   W [selektorze zapory sieciowej][spotlight-firewall] wybierz **Zezwalaj na
    ruch HTTP**. Otworzy się port 80 (HTTP) umożliwiający dostęp do aplikacji.

*   Kliknij przycisk [Utwórz][spotlight-submit-create], aby utworzyć instancję.

Uwaga: gdy instancja zostanie utworzona, zaczniemy obciążać Twoje konto
rozliczeniowe zgodnie z cennikiem usług GCE. Później usuniesz tę instancję, aby
uniknąć dodatkowych opłat.

### Tworzenie instancji frontendowej

W czasie, gdy maszyna wirtualna backendu startuje, utwórz instancję frontendową,
na której będzie działać aplikacja typu „lista zadań” na Node.js. Użyj tej samej
konfiguracji co w przypadku instancji backendowej.

## Konfiguracja

Zainstalujesz bazę danych MongoDB w instancji backendowej, aby zapisywać dane.

[Przyciski SSH][spotlight-ssh-buttons] w tabeli otworzą w osobnym oknie sesję
SSH połączoną z Twoją instancją.

W tym samouczku będziesz się łączyć za pomocą Cloud Shell. Cloud Shell to
wbudowane narzędzie wiersza poleceń konsoli.

### Otwarcie Cloud Shell

Kliknij
[ikonę][spotlight-open-devshell] <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>
na pasku nawigacyjnym u góry konsoli, aby otworzyć Cloud Shell.

### Kończenie tworzenia instancji

Aby można było kontynuować samouczek, proces tworzenia instancji musi dobiec
końca. Jeżeli chcesz sprawdzić postępy tego procesu, kliknij
[menu powiadomień][spotlight-notification-menu] na górnym pasku nawigacyjnym.

## Łączenie z instancją backendową

### Nawiązywanie połączenia z instancją

Wpisz następujące polecenie, by połączyć się przez SSH z maszyną wirtualną.
Jeśli po raz pierwszy używasz SSH w Cloud Shell, musisz utworzyć klucz prywatny.
Wpisz nazwę i strefę utworzonej przez siebie instancji.

```bash
gcloud compute --project "{{identyfikator projektu}}" ssh --zone <strefa-backendu> <nazwa-backendu>
```

### Instalowanie bazy danych backendu

Po nawiązaniu połączenia SSH z instancją backendową zainstaluj bazę danych
backendu za pomocą tych poleceń:

Zaktualizuj pakiety i zainstaluj MongoDB. Na pytanie, czy chcesz kontynuować,
wpisz w odpowiedzi `Y`.

```bash
sudo apt-get update
```

```bash
sudo apt-get install mongodb
```

### Uruchamianie bazy danych

Usługa MongoDB uruchomiła się po zainstalowaniu. Musisz ją zatrzymać, aby
zmienić sposób jej działania.

```bash
sudo service mongodb stop
```

Utwórz katalog dla MongoDB, a następnie uruchom usługę MongoDB w tle na
porcie 80.

```bash
sudo mkdir $HOME/db
```

```bash
sudo mongod --dbpath $HOME/db --port 80 --fork --logpath /var/tmp/mongodb
```

Potem zakończ sesję SSH za pomocą polecenia `exit`:

```bash
exit
```

## Łączenie z instancją frontendową

### Instalacja i uruchomienie aplikacji internetowej w maszynie wirtualnej frontendu

Serwer backendu już działa, więc pora zainstalować frontendową aplikację
internetową.

### Nawiązywanie połączenia z instancją

Wpisz następujące polecenie, by połączyć się przez SSH z maszyną wirtualną.
Wpisz nazwę i strefę utworzonej instancji.

```bash
gcloud compute --project "{{identyfikator-projektu}}" ssh --zone <strefa-frontendu> <nazwa-frontendu>
```

### Instalowanie zależności

Po nawiązaniu połączenia z instancją frontendową zaktualizuj pakiety i
zainstaluj git, Node.js oraz npm. Na pytanie, czy chcesz kontynuować, wpisz w
odpowiedzi `Y`:

```bash
sudo apt-get update
```

```bash
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
```

```bash
sudo apt-get install git nodejs
```

### Instalacja i uruchomienie frontendowej aplikacji internetowej

Skopiuj przykładową aplikację i zainstaluj jej zależności.

```bash
git clone https://github.com/GoogleCloudPlatform/todomvc-mongodb.git
```

```bash
cd todomvc-mongodb; npm install
```

```bash
sed -i -e 's/8080/80/g' server.js
```

Uruchom aplikację internetową typu „lista zadań” za pomocą poniższego polecenia
i podaj [wewnętrzne adresy IP][spotlight-internal-ip] utworzonych przez siebie
instancji.

```bash
sudo nohup nodejs server.js --be_ip <wewnętrzny-ip-backendu> --fe_ip <wewnętrzny-ip-frontendu> &
```

Potem zakończ sesję SSH za pomocą polecenia `exit`:

```bash
exit
```

### Przejście do aplikacji

Przejdź do serwera WWW, który znajduje się pod adresem IP wyświetlonym w
kolumnie [Zewnętrzny adres IP][spotlight-external-ip] obok instancji
frontendowej.

## Czyszczenie

Aby usunąć instancje, zaznacz [pole wyboru][spotlight-instance-checkbox] przy
ich nazwach i kliknij przycisk [Usuń][spotlight-delete-button].

## Podsumowanie

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

To już wszystko.

Oto co możesz teraz zrobić:

*   Znajdź [na GitHubie przykłady kodu](http://googlecloudplatform.github.io/)
    dla Google Cloud Platform.

*   Dowiedz się, jak skonfigurować
    [równoważenie obciążenia](https://cloud.google.com/compute/docs/load-balancing/).

*   Dowiedz się, jak
    [przenieść pliki do maszyny wirtualnej](https://cloud.google.com/compute/docs/instances/transfer-files/).

*   Dowiedz się, jak
    [używać kontenerów](https://cloud.google.com/compute/docs/containers).

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
