# Cloud Vision API

<walkthrough-test-start-page url="/start?tutorial=python_vision_quickstart_v2"></walkthrough-test-start-page>

<walkthrough-tutorial-url url="https://cloud.google.com/vision/docs/label-tutorial"></walkthrough-tutorial-url>

<walkthrough-watcher-constant value="https://github.com/GoogleCloudPlatform/python-docs-samples.git" key="repo-url"></walkthrough-watcher-constant>

<walkthrough-watcher-constant value="python-docs-samples" key="repo-name"></walkthrough-watcher-constant>

<walkthrough-devshell-precreate></walkthrough-devshell-precreate>

## 소개

이 가이드에서는 `LABEL_DETECTION` 요청을 사용해 기본 Vision API 애플리케이션에 대해 안내합니다.
`LABEL_DETECTION` 요청은 이미지 콘텐츠를 기준으로 선정된 라벨 또는 '태그'로 이미지에 주석을 추가합니다. 예를 들어 헛간 사진의
경우 '헛간', '농장' 또는 기타 유사한 주석의 라벨이 생성될 수 있습니다.

수행할 단계는 다음과 같습니다.

*   **라벨 감지 앱 실행**: 브라우저에서 바로 Google Cloud Shell을 사용하여 앱을 실행하는 방법을 알아봅니다.
*   **앱 배포 후...** 앱이 실제로 배포되므로 앱으로 실험하거나 앱을 삭제한 후 처음부터 다시 시작할 수 있습니다.

['Python' 및 Python 로고는 Python Software Foundation의 상표 또는 등록
상표입니다.](walkthrough://footnote)

# 프로젝트 설정

프로젝트를 통해 Cloud Vision API를 사용 설정해야 합니다.

Google Cloud Platform은 리소스를 프로젝트별로 정리하므로 애플리케이션 1개와 관련된 모든 리소스를 한곳에 모을 수 있습니다.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## Vision API 사용 설정

프로젝트에서 Vision API를 사용 설정해야 요청을 허용할 수 있습니다.

### API 관리자로 이동

API 관리자에서 프로젝트에 사용 설정된 API를 설정합니다.

콘솔 왼쪽에서 [menu](walkthrough://spotlight-pointer?spotlightId=console-nav-menu) 메뉴를
엽니다.

그런 다음 **API 및 서비스** 섹션을 선택합니다.

<walkthrough-menu-navigation sectionid="API_SECTION"></walkthrough-menu-navigation>

### 사용 가능한 API 보기

API를 사용하려면
[API 사용 설정](walkthrough://spotlight-pointer?cssSelector=.p6n-action-bar-button)
버튼을 클릭하세요.

### Vision API 선택

[Vision API](walkthrough://spotlight-pointer?spotlightId=api-vision.googleapis.com) 링크를 클릭하세요.

### Vision API 사용 설정

Vision API를 사용하려면 [사용 설정](walkthrough://spotlight-pointer?spotlightId=api-enable-vision.googleapis.com)버튼을 클릭하세요. 이 가이드에서 나중에 프로젝트에
사용할 사용자 인증 정보가 생성됩니다.

## Google Cloud Shell 사용

Cloud Shell은 콘솔용으로 내장된 명령줄 도구입니다. 이 가이드에서는 Cloud Shell을 사용해 앱을 실행합니다.

### Google Cloud Shell 열기

콘솔 상단 탐색 메뉴에서<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>
[아이콘](walkthrough://spotlight-pointer?spotlightId=devshell-activate-button)
을 클릭하여 Cloud Shell을 엽니다.

### 샘플 코드 복제

Cloud Shell을 사용하여 'Hello World' 코드를 복제하고 이 코드로 이동합니다. 샘플 코드가 프로젝트 저장소에서 Cloud
Shell로 복제됩니다.

참고: 디렉토리가 이미 존재하는 경우 복제하기 전에 이전 파일을 삭제하세요.

```bash
rm -rf {{repo-name}}
```

샘플 저장소를 복제합니다.

```bash
git clone {{repo-url}}
```

그런 다음 가이드 디렉토리로 전환합니다.

```bash
cd {{repo-name}}/vision/cloud-client/quickstart
```

## 배포 구성

현재 샘플 코드의 기본 디렉토리에 있습니다. 애플리케이션을 구성하는 파일을 살펴보겠습니다.

### 애플리케이션 살펴보기

다음 명령을 입력하여 애플리케이션 코드를 확인하세요.

```bash
cat quickstart.py
```

`quickstart.py` 파일은 요청 유형 및 콘텐츠와 같은 요청 정보의 형식을 지정합니다. 자세히 알아보려면 아래의 각 섹션을 펼치세요.

Vision API에 대한 요청은 JSON 객체로 제공됩니다. 이러한 요청의 자세한 구조 정보는 [}Vision API
참조][vision-request-doc]를 참조하세요. 여기에서는 `execute`를 호출할 때만 JSON 요청을 전송합니다. 이 패턴을
사용하면 이러한 요청을 자유롭게 전달하면서 필요할 때 `execute`를 호출할 수 있습니다.

## 애플리케이션 테스트

API를 사용하기 위해서는 사용자 인증 정보를 설정해야 합니다. Cloud API를 사용하려면 애플리케이션에 해당하는 적절한 [사용자 인증
정보][auth-doc]를 설정해야 합니다. 그러면 애플리케이션에서 서비스에 자신을 인증하여 작업을 수행할 권한을 획득할 수 있습니다. 그런
다음 샘플 이미지로 API를 테스트해 보겠습니다.

### 서비스 계정 만들기

API 요청을 인증하려면 서비스 계정을 만들어야 합니다. 이전에 만든 서비스 계정이 있으면 기존 계정이 다시 사용됩니다.

```bash
gcloud iam service-accounts create vision-quickstart
```

### 사용자 인증 정보 만들기

서비스 계정 키를 만들고 기본 사용자 인증 정보로 설정합니다.

```bash
gcloud iam service-accounts keys create key.json --iam-account    vision-quickstart@{{project-id}}.iam.gserviceaccount.com
```

```bash
export GOOGLE_APPLICATION_CREDENTIALS=key.json
```

<walkthrough-test-code-output text="created key"></walkthrough-test-code-output>

### 앱 테스트

샘플 이미지로 앱을 테스트하려면 다음을 입력하세요.

```bash
python quickstart.py
```

이미지 리소스, `resources/wakeupcat.jpg`가 소스에 지정되어 있습니다. ([이미지 보기][cat-picture])

## 마무리

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

축하합니다. Cloud Vision API를 사용할 준비가 되었습니다.

다음으로 수행할 작업은 아래와 같습니다.

*   [얼굴 감지][face-tutorial] 가이드 진행
*   [문서 텍스트][document-text-tutorial] 가이드 진행
*   [샘플 애플리케이션][vision-samples] 보기
*   로컬 머신에서 실행할 [Google Cloud SDK][get-cloud-sdk] 다운로드

[auth-doc]: https://cloud.google.com/vision/docs/auth
[cat-picture]: https://raw.githubusercontent.com/GoogleCloudPlatform/python-docs-samples/master/vision/cloud-client/quickstart/resources/wakeupcat.jpg
[document-text-tutorial]: https://cloud.google.com/vision/docs/fulltext-annotations
[face-tutorial]: https://cloud.google.com/vision/docs/face-tutorial
[get-cloud-sdk]: https://cloud.google.com/sdk/
[vision-request-doc]: https://cloud.google.com/vision/reference/rest
[vision-samples]: https://cloud.google.com/vision/docs/samples
