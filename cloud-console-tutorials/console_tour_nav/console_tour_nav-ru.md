# Краткий обзор Cloud Console

<walkthrough-tutorial-duration duration="5"></walkthrough-tutorial-duration>

## Введение

В этом руководстве рассказывается об основных функциях Cloud Console, с помощью которых вы сможете создавать приложения в Google Cloud Platform и управлять ими.

Мы рассмотрим следующие темы:

  *  проекты и ресурсы GCP;
  *  обзор ресурсов проекта и журналы активности;
  *  навигация и поиск в консоли;
  *  управление пользователями и правами доступа;
  *  техническая поддержка;
  *  командная строка GCP в браузере.

Давайте начнем.

## Использование ресурсов GCP

Ресурсы GCP – это базовые компоненты в составе всех сервисов Google Cloud. Они имеют иерархическую структуру и позволяют упорядочить работу в GCP.

Проекты – это ресурсы первого уровня, которые содержат другие низкоуровневые ресурсы, например сегменты Cloud Storage и экземпляры Compute Engine.

[Подробнее о ресурсах GCP…][gcp-resources]

### Навигация по проектам

Чтобы просмотреть информацию о проекте GCP и его дочерних ресурсах, выберите нужный проект в окне [Выбор области действия][spotlight-project-select] в Cloud Console.

<walkthrough-project-setup></walkthrough-project-setup>

## Выбор сервиса Google Cloud

### Навигация по сервисам

Выбрать нужный сервис Google Cloud можно в [меню навигации в левой части страницы][spotlight-console-menu]. Сервисы упорядочены по разделам: "Большие данные", "Ресурсы", "Сеть" и т. д.

### Закрепление разделов

Сервисы, которыми вы пользуетесь чаще всего, можно закрепить в начале меню. Для этого наведите курсор на название сервиса и нажмите на значок "Закрепить".

Чтобы продолжить, откройте меню навигации и выберите **Главная страница**.

<walkthrough-menu-navigation sectionid="HOME_SECTION"></walkthrough-menu-navigation>

## Обзор проекта

### Главная страница

На главной странице можно просмотреть основную информацию о проекте GCP, в том числе ключевые показатели и данные о платежах.

### Настройка

Чтобы изменить расположение виджетов на панели управления, нажмите кнопку [Настроить][spotlight-customize-dashboard].
Чтобы скрыть ненужные виджеты или настроить дополнительные параметры, наведите курсор на виджет и нажмите на значок меню.

## Просмотр действий с ресурсами GCP

В [ленте активности][spotlight-activity-stream] отображается список действий с вашими ресурсами GCP.

В нем можно просмотреть все операции, которые вы и ваши коллеги выполняете в проекте. Список можно фильтровать по разным параметрам.

## Поиск в Cloud Console

Чтобы быстро найти нужный продукт Google Cloud или ресурс GCP, воспользуйтесь [строкой поиска][spotlight-search-bar] в Cloud Console.

Введите в строку поиска название сервиса (например, **App Engine**) или одного из своих проектов.

## Круглосуточная поддержка

Если вам потребуется помощь, вы можете обратиться в службу поддержки GCP.

[Подробнее о поддержке…](http://cloud.google.com/support)

В меню навигации выберите "Поддержка".

<walkthrough-menu-navigation sectionid="SUPPORT_SECTION"></walkthrough-menu-navigation>

## Управление пользователями и правами доступа

Сервис Google Cloud IAM позволяет управлять доступом к ресурсам GCP.

[Подробнее об IAM…](https://cloud.google.com/iam/docs/)

Чтобы предоставить новым участникам проекта доступ к его ресурсам, перейдите в раздел "IAM и администрирование".

Здесь вы можете добавить пользователей, группы и сервисные аккаунты и назначить для них роли с нужными правами доступа.

<walkthrough-menu-navigation sectionid="IAM_ADMIN_SECTION"></walkthrough-menu-navigation>

## Доступ к командной строке в браузере

Google Cloud Shell – это интерфейс командной строки, с помощью которого вы можете управлять проектами и ресурсами прямо в браузере. Ни Google Cloud SDK, ни другие локальные приложения для этого не нужны.

В <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[Cloud Shell][spotlight-open-devshell] доступны последние версии интерфейса командной строки gcloud и других утилит Cloud SDK.

[Подробнее о Cloud Shell…](https://cloud.google.com/shell/)

## Дальнейшие действия в GCP

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Вы познакомились с интерфейсом Cloud Console. Теперь вы можете подробнее изучить другие сервисы и продукты.

Обзоры продуктов, краткие руководства и документация по API доступны [здесь](https://cloud.google.com/docs/).

Чтобы изучить другие полезные руководства, вернитесь на начальную страницу.
<walkthrough-menu-navigation sectionid="ONBOARDING_SECTION"></walkthrough-menu-navigation>

[gcp-resources]: https://cloud.google.com/resource-manager/docs/cloud-platform-resource-hierarchy
[spotlight-activity-stream]: walkthrough://spotlight-pointer?cssSelector=.mat-tab-link:nth-of-type(2)
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-customize-dashboard]: walkthrough://spotlight-pointer?cssSelector=.cfc-customize-button
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-project-select]: walkthrough://spotlight-pointer?spotlightId=purview-switcher
[spotlight-search-bar]: walkthrough://spotlight-pointer?cssSelector=.p6n-search-bar,.pcc-platform-bar-search-bar
