# Cloud Pub/Sub 소개

<walkthrough-tutorial-url url="https://cloud.google.com/pubsub/quickstart-console"></walkthrough-tutorial-url></walkthrough-test-start-page>

<walkthrough-devshell-precreate></walkthrough-devshell-precreate>

## 소개

Cloud Pub/Sub은 독립적인 애플리케이션 간에 메시지를 주고받을 수 있는 완전 관리형 실시간 메시지 서비스입니다. 이 가이드에서는 `gcloud` 명령을 사용하는 Cloud Pub/Sub의 명령줄 인터페이스에 대해 간단히 소개합니다.

## 프로젝트 설정

Google Cloud Platform은 리소스를 프로젝트별로 정리하므로 한 애플리케이션과 관련된 모든 리소스를 한곳에 모을 수 있습니다.

Cloud Pub/Sub에서 메시지를 설정하려면 프로젝트가 필요합니다.

<walkthrough-project-setup></walkthrough-project-setup>

## 첫 번째 주제 만들기

### Google Cloud Shell 열기

Cloud Shell은 콘솔용으로 내장된 명령줄 도구입니다. Cloud Shell을 사용하여 Cloud Pub/Sub을 설정합니다.

콘솔 상단 탐색 메뉴에서
<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>
[아이콘][spotlight-open-devshell]을 클릭하여 Cloud Shell을 엽니다.

### 주제 만들기

주제는 메시지를 보낼 이름이 지정된 리소스입니다. 다음 명령어로 첫 번째 주제를 만드세요.

```bash
gcloud pubsub topics create my-topic
```

## 구독 추가

메시지를 받으려면 구독을 만들어야 합니다. 구독에는 해당 주제가 있어야 합니다. 다음 명령어를 사용하여 첫 번째 구독을 만드세요.

```bash
gcloud pubsub subscriptions \
    create my-sub --topic my-topic \
    --ack-deadline=60
```

이 명령어는 `my-topic` 주제에 연결된 `my-sub`라는 이름의 구독을 만듭니다. `my-topic`에 게시되는 모든 메시지는 이 구독으로 전달됩니다.

여기에서는 `--ack-deadline=60` 옵션을 확인할 수 있습니다. `ack-deadline`은 `Acknowledgement deadline`(확인 시한)을 나타냅니다. 이 새로운 구독의 `Acknowledgement deadline`은 60초입니다. 이에 대해서는 잠시 후에 설명하겠습니다.

## 주제 및 구독 표시

첫 번째 메시지를 보내기 전에 주제 및 구독이 성공적으로 생성되었는지 확인합니다. 다음 명령어를 사용하여 주제와 구독을 나열합니다.

```bash
gcloud pubsub topics list
```

```bash
gcloud pubsub subscriptions list
```

## 주제에 메시지 게시

다음 명령어로 메시지 2개를 보냅니다.

```bash
gcloud pubsub topics publish my-topic --message hello
```

```bash
gcloud pubsub topics publish my-topic --message goodbye
```

이러한 각 명령어는 메시지를 보냅니다. 첫 번째 메시지는 `hello`이고 두 번째 메시지는 `goodbye`입니다. 메시지를 성공적으로 게시하면 서버에서 반환된 messageId가 표시됩니다. 이 ID는 서버가 각 메시지에 자동으로 할당한 고유 ID입니다.

## 구독에서 메시지 가져오기

### 메시지 가져오기

이제 다음 명령어를 사용하여 메시지를 가져옵니다.

```bash
gcloud pubsub subscriptions \
    pull --auto-ack --limit=2 my-sub
```

바로 전에 게시한 2개 메시지가 확인되었을 것입니다. 이 메시지에는 `hello` 및 `goodbye` 데이터뿐만 아니라 `MESSAGE_ID`도 포함됩니다. `MESSAGE_ID`는 서버가 할당한 메시지의 고유 ID입니다.

참고: Cloud Pub/Sub에서는 메시지 순서가 보장되지 않습니다. 또한 메시지가 하나만 표시되었을 수도 있습니다. 이 경우 다른 메시지가 표시될 때까지 같은 명령어를 여러 번 실행해 보세요.

### 확인 및 확인 시한

메시지를 가져와서 올바르게 처리한 후에는 메시지가 성공적으로 수신되었음을 Cloud Pub/Sub에 알려야 합니다. 이러한 작업을 **확인**이라고 부릅니다.

위에서는 `--auto-ack` 플래그가 `pull` 명령어와 함께 전달된 것을 볼 수 있습니다.
`--auto-ack` 플래그는 메시지를 가져와서 확인하는 작업을 자동으로 수행합니다.

## 직접 확인

### 새 메시지 보내기

다음 명령어로 새 메시지를 보냅니다.

```bash
gcloud pubsub \
    topics publish my-topic --message thanks
```

### 메시지 다시 가져오기

다음 명령어로 메시지를 가져옵니다.

```bash
gcloud pubsub subscriptions \
    pull my-sub
```

그러면 `MESSAGE_ID` 및 `ACK_ID`와 함께 `thanks` 메시지가 표시됩니다.
`ACK_ID`는 메시지 확인을 위해 사용할 수 있는 또 다른 ID입니다.

### 메시지 확인

메시지를 가져온 후에는 **확인 시한**이 지나가기 전에 메시지를 확인해야 합니다. 예를 들어 이 가이드처럼 구독의 **확인 시한**이 60초로 구성된 경우 메시지를 가져오고 나서 60초 내에 메시지를 확인해야 합니다. 그렇지 않으면 Cloud Pub/Sub이 메시지를 다시 보냅니다.

다음 명령어를 사용하여 메시지를 확인합니다(복사/붙여넣기로 `ACK_ID`를 실제 항목으로 바꿈).

```bash
gcloud pubsub subscriptions ack \
    my-sub --ack-ids ACK_ID
```

## Pub/Sub UI에서 주제 및 구독 보기

이것으로 `gcloud` 명령줄 가이드를 마칩니다. 하지만 이 가이드를 마치기 전에 Google Cloud Console에서 UI를 살펴보겠습니다.

Pub/Sub 섹션에서 주제 및 구독을 확인할 수도 있습니다.

### Pub/Sub 섹션으로 이동

콘솔 왼쪽에서 [메뉴][spotlight-console-menu]를 엽니다.

그런 다음 **Pub/Sub** 섹션을 선택합니다.

<walkthrough-menu-navigation sectionid="CLOUDPUBSUB_SECTION"></walkthrough-menu-navigation>

또한 UI를 통해 주제와 구독을 만들고 관리할 수 있습니다.

### 주제 삭제

여기서 만든 주제 옆에 있는 체크박스를 선택하고 [삭제 버튼][spotlight-delete-button]을 클릭하여 주제를 영구적으로 삭제합니다.

## 마무리

축하합니다.

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

`gcloud` 명령줄 도구를 사용하여 Cloud Pub/Sub의 기본 개념을 살펴보고 Cloud Pub/Sub UI를 확인했습니다. 다음 단계는 직접 애플리케이션을 만들어 보는 것입니다. 자세한 내용은 [Pub/Sub 문서][pubsub-docs]를 참조하세요.

다음으로 할 수 있는 작업은 아래와 같습니다.

[코드 샘플 보기](https://cloud.google.com/pubsub/docs/quickstart-client-libraries)

[pubsub-docs]: https://cloud.google.com/pubsub/docs/
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-delete-button]: walkthrough://spotlight-pointer?cssSelector=.p6n-icon-delete
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
