# Stackdriver Error Reporting

## Wstęp

Stackdriver Error Reporting gromadzi i wyświetla błędy generowane przez usługi chmurowe.

W tym samouczku przedstawiamy interfejs internetowy usługi Error Reporting. Dowiesz się, jak wyświetlić listę błędów aplikacji, zapoznać się ze szczegółami tych błędów i podjąć odpowiednie działania.

## Konfiguracja projektu

<walkthrough-project-setup></walkthrough-project-setup>

## Generowanie błędów

Zanim przejdziesz dalej, musisz zgłosić sztucznie wygenerowane błędy. Użyjesz do tego celu polecenia `gcloud`.

W rzeczywistości błędy te byłyby zgłaszane bezpośrednio z uruchomionej aplikacji. Po zakończeniu tego samouczka możesz zapoznać się z dodatkowymi informacjami na temat konfigurowania usługi Error Reporting.

### Otwieranie Google Cloud Shell

Kliknij [ikonę][spotlight-open-devshell] <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon> na pasku nawigacyjnym u góry konsoli, aby otworzyć Cloud Shell.

### Zgłaszanie przykładowych błędów

Kliknij przycisk **Kopiuj do schowka** w prawym górnym rogu poniższego skryptu i uruchom go w Cloud Shell, aby wygenerować przykładowe błędy.

```bash
COUNTER=0
while [  $COUNTER -lt 11 ]; do
    gcloud beta error-reporting events report --service tutorial --service-version v$((COUNTER/10+1)) \
        --message "java.lang.RuntimeException: Error rendering template $COUNTER
          at com.example.TestClass.test(TestClass.java:51)
          at com.example.AnotherClass(AnotherClass.java:25)
          at javax.servlet.http.HttpServlet.service (HttpServlet.java:617)
          at javax.servlet.http.HttpServlet.service (HttpServlet.java:717)"
    if [ $COUNTER -lt 3 ]; then
      gcloud beta error-reporting events report --service tutorial --service-version v1 \
          --message "java.lang.ArrayIndexOutOfBoundsException: $COUNTER
            at com.example.AppController.createUser(AppController.java:42)
            at com.example.User(User.java:31)
            at javax.servlet.http.HttpServlet.service (HttpServlet.java:617)
            at javax.servlet.http.HttpServlet.service (HttpServlet.java:717)"
    fi
    if [ $COUNTER -eq 10 ]; then
      echo "All artificial errors reported."
    fi
    let COUNTER=COUNTER+1
done
```

### Zamknięcie Cloud Shell

Zamknij Cloud Shell, a potem kliknij *Dalej*.

## Wyświetlanie listy błędów aplikacji

Za pomocą usługi Stackdriver Error Reporting zobaczysz zgłoszone błędy.

### Otwieranie usługi Error Reporting

Otwórz [menu][spotlight-console-menu] po lewej stronie konsoli.

Następnie przewiń stronę do kategorii **Stackdriver** i wybierz **Error Reporting**.

<walkthrough-menu-navigation sectionid="CRASH_SECTION"></walkthrough-menu-navigation>

### Sortowanie według *pierwszego zarejestrowanego*

Błędy występujące w aplikacji są grupowane, a duplikaty usuwane na podstawie analizy zrzutów stosu. Każdy wpis na tej liście zawiera podsumowanie, które pomaga określić, kiedy aplikacja zaczęła generować błąd, jak często ten błąd występował i kiedy pojawił się ostatni raz.

Domyślnie błędy są sortowane według liczby *wystąpień*. Kliknij nagłówek kolumny *Pierwszy zarejestrowany*, aby wyświetlić błędy, które zaczęły pojawiać się ostatnio.

### Opcja otrzymywania powiadomień o nowych błędach

Po pojawieniu się nowych błędów w projekcie możesz otrzymywać e-maile i powiadomienia push na komórkę. Aby otrzymywać te powiadomienia, kliknij *Włącz powiadomienia*.

Na koniec kliknij *Dalej*.

## Poznawanie szczegółów błędu

### Otwarcie raportu o błędach

Kliknij błąd z tej listy, aby zobaczyć szczegóły.

### Powiązanie problemu z wybranym błędem

Zbadaj na tej stronie informacje dotyczące konkretnego błędu i zapoznaj się z jego historią.

Gdy zauważasz nowy błąd, zwykle następnym krokiem jest zgłoszenie go w narzędziu do śledzenia problemów używanym przez Twój zespół. Wpis w tym narzędziu możesz połączyć z błędem w usłudze Stackdriver Error Reporting.

Aby to zrobić:

  *  Kliknij *Powiąż z problemem* u góry (aby wyświetlić ten link, może być konieczne otwarcie menu **Więcej działań**).
  *  W wyświetlonym oknie wpisz adres `http://example.com/issues/1234`.
  *  Kliknij *Zapisz*.

### Badanie zrzutów stosów

Aby ułatwić Ci skoncentrowanie się na kodzie, ukrywamy ramki zrzutu stosu, które nie pochodzą z kodu Twojej aplikacji.

Kliknij *Pokaż wszystko* w przykładowym błędzie, aby wyświetlić ramki stosów platformy.

## Podsumowanie

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Gratulacje! Masz już za sobą samouczek dotyczący usługi Stackdriver Error Reporting.

Oto, co możesz teraz zrobić:

### Skonfiguruj usługę Error Reporting dla swojego projektu

Dowiedz się z [dokumentacji konfiguracji][errors-setup], jak skonfigurować usługę Error Reporting dla swoich działających usług.

### Zapoznaj się z innymi samouczkami poświęconymi usłudze Stackdriver

Dowiedz się, jak debugować aplikację produkcyjną – przeczytaj krótkie wprowadzenie do usługi [Stackdriver Debugger][debug-quickstart].

Zapoznaj się z przyczynami opóźnień w działaniu aplikacji dzięki krótkiemu wprowadzeniu do usługi [Stackdriver Trace][trace-quickstart].

[debug-quickstart]: https://cloud.google.com/debugger/docs/quickstart
[errors-setup]: https://cloud.google.com/error-reporting/docs/how-to
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[trace-quickstart]: https://cloud.google.com/trace/docs/quickstart
