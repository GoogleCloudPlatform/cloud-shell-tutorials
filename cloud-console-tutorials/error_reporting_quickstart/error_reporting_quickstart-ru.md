# Stackdriver Error Reporting

## Введение

В Stackdriver Error Reporting представлена сводная информация об ошибках из сервисов Cloud.

Это руководство познакомит вас с интерфейсом Error Reporting. Вы узнаете, как просматривать списки ошибок и получать дополнительную информацию об ошибках приложений.

## Настройка проекта

<walkthrough-project-setup></walkthrough-project-setup>

## Генерация ошибок

Обычно сведения об ошибках поступают из работающих приложений, но для целей этого руководства мы искусственно создадим ошибки с помощью `gcloud`.

Позднее вы сможете подробнее узнать о том, как настроить Error Reporting.

### Запустите Google Cloud Shell

Откройте Cloud Shell. Для этого нажмите <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[значок][spotlight-open-devshell] на панели навигации в верхней части консоли.

### Регистрация ошибок

Нажмите кнопку **Скопировать в буфер обмена** в правом верхнем углу и запустите следующий код в Cloud Shell, чтобы сгенерировать ошибки.

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
      echo "Все ошибки зарегистрированы."
    fi
    let COUNTER=COUNTER+1
done
```

### Закройте Cloud Shell

Закройте Cloud Shell и нажмите *Продолжить*.

## Просмотрите список ошибок

Прежде всего нужно просмотреть зарегистрированные ошибки.

### Откройте Error Reporting

Откройте [меню][spotlight-console-menu] в левой части консоли.

В разделе **Stackdriver** выберите **Error Reporting**.

<walkthrough-menu-navigation sectionid="CRASH_SECTION"></walkthrough-menu-navigation>

### Сортировка по *первому случаю*

После анализа трассировок стека сервис группирует ошибки и удаляет повторяющиеся записи. Для каждой ошибки приводится информация о времени ее первой и последней регистрации, а также о частоте ее возникновения.

По умолчанию ошибки в списке отсортированы по их *количеству*. Выберите сортировку по *первому случаю*, чтобы просмотреть последние ошибки. Для этого нажмите на заголовок соответствующего столбца.

### Оповещения о новых ошибках

Нажмите кнопку *Включить уведомления*, чтобы получать уведомления о новых ошибках по электронной почте и с помощью push-уведомлений.

Затем нажмите *Продолжить*.

## Подробные сведения об ошибке

### Откройте отчет об ошибке

Выберите ошибку из списка, чтобы просмотреть подробную информацию о ней.

### Свяжите ошибку с проблемой

На этой странице представлены подробные сведения об ошибке.

Если вы зарегистрировали проблему в своей системе отслеживания ошибок, вы можете добавить ссылку на проблему к отчету об ошибке в Stackdriver Error Reporting.

Вот как это сделать:

  *  нажмите *Добавить ссылку* вверху страницы (эта ссылка может находиться в меню **Дополнительные действия**);
  *  введите в диалоговом окне URL проблемы (например, `http://example.com/issues/1234`);
  *  нажмите *Сохранить*.

### Просмотрите трассировки стека

По умолчанию стековые фреймы, не относящиеся к коду приложения, скрыты.

Нажмите *Показать все*, чтобы просмотреть всю трассировку стека.

## Заключение

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Поздравляем! Руководство по Stackdriver Error Reporting завершено.

Вот что можно сделать дальше:

### Настройте Error Reporting для своего проекта

Узнать, как настроить Error Reporting для работающих приложений, можно [здесь][errors-setup].

### Изучите другие руководства по Stackdriver

Руководство по быстрой настройке [Stackdriver Debugger][debug-quickstart].

Руководство по быстрой настройке [Stackdriver Trace][trace-quickstart].

[debug-quickstart]: https://cloud.google.com/debugger/docs/quickstart
[errors-setup]: https://cloud.google.com/error-reporting/docs/how-to
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[trace-quickstart]: https://cloud.google.com/trace/docs/quickstart
