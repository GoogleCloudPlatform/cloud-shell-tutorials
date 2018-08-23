# Poznaj Cloud Console

<walkthrough-tutorial-duration duration="5"></walkthrough-tutorial-duration>

## Wstęp

Ten samouczek przybliża kluczowe funkcje Cloud Console, by przygotować Cię do tworzenia aplikacji w Google Cloud Platform i zarządzania nimi w tej usłudze.

Omawiamy w nim:

  *  projekty i zasoby GCP,
  *  informacje o zasobach wysokiego poziomu i logi aktywności,
  *  poruszanie się po Cloud Console i wyszukiwanie zasobów,
  *  zarządzanie użytkownikami i uprawnieniami,
  *  pomoc techniczną,
  *  wiersz poleceń GCP w przeglądarce.

Zaczynajmy!

## Używanie zasobów GCP

Zasoby GCP to podstawowe elementy, z których składają się wszystkie usługi Google Cloud. Zasoby są ułożone hierarchicznie i pomagają w organizacji pracy w GCP.

Projekty to pierwszy poziom hierarchii zasobów. Projekty zawierają inne zasoby niskiego poziomu, takie jak zasobniki Cloud Storage i instancje Compute Engine.

[Dowiedz się więcej o zasobach GCP][gcp-resources]

### Poruszanie się po projektach

Poruszanie się po projektach w GCP ułatwia [selektor zakresu][spotlight-project-select] w Cloud Console. Przełączenie się między projektami powoduje dostosowanie widoku do danego projektu i wszystkich jego zasobów podrzędnych.

<walkthrough-project-setup></walkthrough-project-setup>

## Poruszanie się po usługach Google Cloud

### Przechodzenie pomiędzy usługami

Usługi Google Cloud są dostępne w [menu nawigacyjnym po lewej stronie][spotlight-console-menu] i są ułożone według grup usług takich jak Big Data, Compute, Sieci itd.

### Przypinanie sekcji

Dowolną sekcję, z której często korzystasz, możesz przypiąć na górze menu nawigacyjnego. Aby to zrobić, najedź kursorem na element z sekcji i kliknij ikonę pinezki.

Aby przejść dalej, otwórz menu nawigacyjne i wybierz **Strona główna**.

<walkthrough-menu-navigation sectionid="HOME_SECTION"></walkthrough-menu-navigation>

## Wyświetlanie ogólnych informacji o dowolnym projekcie

### Panel główny

W panelu głównym znajdziesz ogólny przegląd wybranego projektu w GCP zawierający kluczowe wskaźniki, informacje o płatnościach i inne przydatne dane.

### Dostosowywanie

Aby dostosować panel, kliknij [Dostosuj][spotlight-customize-dashboard].
Każdą kartę można ukryć, wyświetlić i przesunąć w inne miejsce na stronie. Każda karta ma również opcje niestandardowe dostępne z rozszerzonego menu, które pojawia się po najechaniu jej kursorem.

## Wyświetlanie aktywności we wszystkich zasobach GCP

Dzięki [strumieniowi aktywności][spotlight-activity-stream] możesz w jednym miejscu poznać wszystkie działania prowadzone w Twoich zasobach GCP.

Zobacz, co Twój zespół zmienia w dowolnym projekcie, by dojść do źródeł problemów lub zweryfikować uprawnienia. Listę możesz łatwo filtrować, by znaleźć dokładnie to, czego potrzebujesz.

## Wyszukiwanie w Cloud Console

[Pasek wyszukiwania][spotlight-search-bar] w Cloud Console pozwala uzyskać szybki dostęp do usług Google Cloud i dowolnego zasobu w GCP.

Spróbuj wyszukać **App Engine** lub nazwę jednego ze swoich projektów.

## Pomoc w dowolnym momencie

Jeżeli kiedykolwiek napotkasz problem lub będziesz potrzebować wskazówek na temat korzystania z usług GCP, możesz liczyć na nasz zespół pomocy.

[Dowiedz się więcej o opcjach pomocy](http://cloud.google.com/support)

Z pomocy możesz skorzystać w menu nawigacyjnym.

<walkthrough-menu-navigation sectionid="SUPPORT_SECTION"></walkthrough-menu-navigation>

## Zarządzanie użytkownikami i uprawnieniami

Zarządzanie tożsamościami i dostępem w Google Cloud (Cloud IAM) pozwala tworzyć uprawnienia do Twoich zasobów GCP i zarządzać tymi uprawnieniami.

[Dowiedz się więcej o uprawnieniach](https://cloud.google.com/iam/docs/)

Wraz ze wzrostem liczebności swojego zespołu możesz przydzielać jego uczestnikom dostęp za pomocą funkcji Cloud IAM w sekcji „Administracja”.

Dodawaj konta użytkowników, grup lub usług i przypisuj im dowolną liczbę ról, by przekazać im potrzebne uprawnienia.

<walkthrough-menu-navigation sectionid="IAM_ADMIN_SECTION"></walkthrough-menu-navigation>

## Korzystanie z wiersza poleceń w przeglądarce

Wiersz poleceń Google Cloud Shell daje Ci dostęp do zasobów w chmurze bezpośrednio z przeglądarki. Możesz łatwo zarządzać projektami i zasobami bez potrzeby instalowania w swoim systemie pakietu SDK Google Cloud lub innych narzędzi.

<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>Dzięki [Cloud Shell][spotlight-open-devshell] narzędzie wiersza poleceń gcloud z pakietu SDK Cloud, a także inne potrzebne narzędzia, są zawsze dostępne, aktualne i w pełni uwierzytelnione.

[Dowiedz się więcej o Cloud Shell](https://cloud.google.com/shell/)

## Więcej zastosowań GCP

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Już wiesz, jak poruszać się po Cloud Console, i masz solidne podstawy, by poznawać nowe narzędzia i usługi.

W naszej [szczegółowej dokumentacji](https://cloud.google.com/docs/) znajdziesz wiele pomocnych informacji w formie przewodników po usługach, krótkich instrukcji czy dokumentacji interfejsów API.

Aby znaleźć więcej samouczków, wróć na stronę Pierwsze kroki.
<walkthrough-menu-navigation sectionid="ONBOARDING_SECTION"></walkthrough-menu-navigation>

[gcp-resources]: https://cloud.google.com/resource-manager/docs/cloud-platform-resource-hierarchy
[spotlight-activity-stream]: walkthrough://spotlight-pointer?cssSelector=.mat-tab-link:nth-of-type(2)
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-customize-dashboard]: walkthrough://spotlight-pointer?cssSelector=.cfc-customize-button
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-project-select]: walkthrough://spotlight-pointer?spotlightId=purview-switcher
[spotlight-search-bar]: walkthrough://spotlight-pointer?cssSelector=.p6n-search-bar,.pcc-platform-bar-search-bar
