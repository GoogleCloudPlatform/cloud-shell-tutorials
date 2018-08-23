# Cloud IoT Core 소개

<walkthrough-tutorial-url url="https://cloud.google.com/iot/docs/quickstart"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="https://github.com/GoogleCloudPlatform/nodejs-docs-samples.git" key="repo-url"></walkthrough-watcher-constant>

## 소개

Google Cloud IoT(Internet of Things) Core는 최대 수백만 개의 IoT 기기를 안전하게 연결하고 관리해 주는 완전 관리형 서비스입니다. 이 가이드에서는 `gcloud` 명령줄 도구를 사용해 Cloud IoT Core 기기 레지스트리를 만들고 기기를 추가하는 방법에 대해 다룹니다. 또한 MQTT 샘플을 실행하여 기기를 연결하고 기기의 텔레메트리 이벤트를 게시하는 방법도 보여줍니다.

이 가이드에서 설명하는 내용은 다음과 같습니다.

  *  Cloud Pub/Sub 주제 생성
  *  기기 레지스트리 생성
  *  레지스트리에 기기 추가
  *  기기에 사용자 인증 정보 설정
  *  메시지를 주고받기 위한 Pub/Sub 주제 구독 생성
  *  가상 기기 연결 및 텔레메트리 데이터 보기

## 프로젝트 설정

Google Cloud Platform은 리소스를 프로젝트별로 정리하므로 하나의 애플리케이션과 관련된 모든 리소스를 한곳에 모을 수 있습니다.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## Google Cloud Shell 사용

이 가이드의 모든 작업은 Cloud Shell에서 이루어집니다.

### Google Cloud Shell 열기

콘솔 상단 탐색 메뉴에서 
<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>
[아이콘][spotlight-open-devshell]을 클릭하여 Cloud Shell을 엽니다.

### Google Cloud API 사용 설정

Cloud IoT Core API가 사용 설정됩니다.

<walkthrough-enable-apis apis="cloudiot.googleapis.com"></walkthrough-enable-apis>

## 첫 번째 주제 만들기

주제는 이름이 지정된 리소스로, 기기에서 이곳으로 메시지를 보내게 됩니다. 다음 명령어로 첫 번째 주제를 만드세요.

```bash
gcloud pubsub topics create my-topic
```

이후 단계에서 이 주제로 메시지를 여러 개 보냅니다.

## GitHub에서 Cloud IoT Core Node.js 샘플 파일 복제하기

MQTT 샘플을 사용해 Cloud IoT Core로 메시지를 보냅니다.

참고: 디렉토리가 이미 존재하는 경우 복제하기 전에 이전 파일을 삭제하세요.

```bash
rm -rf nodejs-docs-samples
```

다음 명령어로 샘플 프로그램을 복제합니다.

```bash
git clone {{repo-url}}
```

## Cloud IoT Core 서비스 계정에 권한 부여

`/iot/scripts` 폴더의 helper 스크립트를 사용해 `cloud-iot@system.gserviceaccount.com` 서비스 계정을 게시자 역할로 Cloud Pub/Sub 주제에 추가합니다.

### iot 디렉토리로 이동:

```bash
cd nodejs-docs-samples/iot
```

### 종속 항목 설치:

```bash
npm --prefix ./scripts install
```

### helper 스크립트 실행:

```bash
node scripts/iam.js my-topic
```

이 스크립트로 Cloud IoT Core 서비스 계정에 `my-topic` 주제에 대한 권한을 부여합니다.

## 기기 레지스트리 만들기

기기 레지스트리에는 기기가 포함되며 이를 통해 포함된 모든 기기가 공유하는 속성을 정의합니다. 다음 명령어로 기기 레지스트리를 만드세요.

```bash
gcloud iot registries create my-registry \
    --project={{project-id}} \
    --region=us-central1 \
    --event-notification-config=topic=projects/{{project-id}}/topics/my-topic
```

## 서명 키 생성

Cloud IoT Core에서 인증을 받으려면 기기에 비공개 키와 공개 키가 있어야 합니다. 다음 명령어를 실행해 서명 키를 생성하세요.

```bash
./scripts/generate_keys.sh
```

이 스크립트로 PEM 형식의 RS256 및 ES256 키가 생성되지만 이 가이드에서는 RS256 키만 있으면 됩니다. 비공개 키를 기기에 안전하게 저장해야 하며 이를 사용해 인증 JWT([JSON 웹 토큰][web-token-docs])에 서명합니다. 공개 키는 기기 레지스트리에 저장됩니다.

## 기기 생성 및 레지스트리에 추가

다음 명령어를 실행해 기기를 만들고 레지스트리에 추가합니다.

```bash
gcloud iot devices create my-node-device \
    --project={{project-id}} \
    --region=us-central1 \
    --registry=my-registry \
    --public-key path=rsa_cert.pem,type=rs256
```

## 기기 연결 및 텔레메트리 데이터 보기

이 단계에서는 가상 기기에서 Pub/Sub으로 메시지를 보냈다가 다시 가져와 확인합니다.

### MQTT 샘플 디렉토리로 이동:

```bash
cd mqtt_example
```

### Node.js 종속 항목 설치:

```bash
npm install
```

### 다음 명령어를 실행해 MQTT 브리지로 가상 기기를 Cloud IoT Core에 연결하세요.

```bash
node cloudiot_mqtt_example_nodejs.js \
    --projectId={{project-id}} \
    --registryId=my-registry \
    --deviceId=my-node-device \
    --privateKeyFile=../rsa_private.pem \
    --numMessages=25 \
    --algorithm=RS256 \
    --mqttBridgePort=443
```

출력에 가상 기기가 텔레메트리 주제로 메시지를 게시하고 있다고 표시됩니다. 메시지 25개가 게시됩니다.

## 기기 주제에 대한 구독 만들기

기기에서 게시한 메시지를 볼 수 있도록 다음 명령어를 실행해 구독을 만드세요.

```bash
gcloud pubsub subscriptions create \
    projects/{{project-id}}/subscriptions/my-subscription \
    --topic=my-topic
```

## 게시된 메시지 가져오기

다음 명령어로 기기에서 게시한 메시지를 가져오세요.

```bash
gcloud pubsub subscriptions pull --auto-ack \
    projects/{{project-id}}/subscriptions/my-subscription
```

이 명령어를 실행하면 기기에서 게시한 메시지가 반환됩니다. 메시지에는 기기에 대한 `my-registry/my-node-device-payload-&lt;INTEGER&gt;`, `MESSAGE_ID`, `ATTRIBUTES` 정보 목록이 포함됩니다. `MESSAGE_ID`는 서버가 할당한 고유한 ID입니다.

참고: Cloud Pub/Sub에서는 메시지의 순서를 보장하지 않습니다. Cloud Shell에 메시지가 1개만 표시될 수도 있습니다. 이 경우 다른 메시지가 표시될 때까지 동일한 명령어를 여러 번 실행해 보세요.

## Google Cloud Platform 콘솔에서 리소스 보기

`gcloud` 명령줄 가이드는 여기까지이며, GCP 콘솔을 사용하면 방금 만든 리소스를 볼 수 있습니다.

콘솔 왼쪽의 [메뉴][spotlight-console-menu]를 엽니다.

그런 다음 **IoT Core**를 선택합니다.

<walkthrough-menu-navigation sectionid="IOT_SECTION"></walkthrough-menu-navigation>

UI를 통해 기기 레지스트리 및 기기를 만들고 관리할 수도 있습니다.

## 마무리

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

축하합니다. `gcloud` 명령줄 도구를 사용하여 Cloud IoT Core의 기본 개념을 살펴보고 GCP 콘솔을 사용해 Cloud IoT Core 리소스를 살펴봤습니다. 다음 단계는 직접 애플리케이션을 만들어 보는 것입니다. 자세한 내용은 [IoT Core 문서](https://cloud.google.com/iot/docs/)를 참조하세요.

### 다음으로 할 수 있는 작업은 아래와 같습니다.

GitHub에서 Cloud IoT Core 샘플 더 보기:

  *  [C](https://github.com/GoogleCloudPlatform/cpp-docs-samples/tree/master/iot/mqtt-ciotc)
  *  [자바](https://github.com/GoogleCloudPlatform/java-docs-samples/tree/master/iot/api-client)
  *  [Node.js](https://github.com/GoogleCloudPlatform/nodejs-docs-samples/tree/master/iot)
  *  [Python](https://github.com/GoogleCloudPlatform/python-docs-samples/tree/master/iot/api-client)

[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[web-token-docs]: https://cloud.google.com/iot/docs/how-tos/credentials/jwts
