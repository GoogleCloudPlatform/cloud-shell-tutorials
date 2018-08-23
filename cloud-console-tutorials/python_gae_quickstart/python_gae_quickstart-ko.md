# App Engine 퀵스타트

<walkthrough-tutorial-url url="https://cloud.google.com/appengine/docs/python/quickstart"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="https://github.com/GoogleCloudPlatform/python-docs-samples" key="repo-url"></walkthrough-watcher-constant>
<walkthrough-watcher-constant value="python-docs-samples/appengine/standard/hello_world" key="repo-dir"></walkthrough-watcher-constant>

## 소개

이 가이드에서는 `gcloud` 명령어를 사용하여 샘플 [Python](https://python.org/) 애플리케이션을 Google App Engine에 배포하는 방법을 보여줍니다.

수행할 단계는 다음과 같습니다.

  *  **프로젝트 만들기**

     프로젝트는 코드, VM, 기타 리소스를 함께 모으므로 개발과 모니터링이 더 용이합니다.

  *  **'Hello, World!' 앱 빌드 및 실행**

     브라우저에서 바로 Google Cloud Shell을 사용하여 앱을 실행하는 방법에 대해 알아봅니다. 마지막에는 `gcloud` 명령어를 사용하여 앱을 웹에 배포합니다.

  *  **가이드 진행 후**

     앱이 실제로 배포되므로 배포 후에 앱으로 실험하거나 앱을 삭제한 후 처음부터 다시 시작할 수 있습니다.

['Python' 및 Python 로고는 Python Software Foundation의 상표 또는 등록 상표입니다.](walkthrough://footnote)

## 프로젝트 설정

애플리케이션을 배포하려면 먼저 프로젝트를 만들어야 합니다.

Google Cloud Platform은 리소스를 프로젝트별로 정리하므로 한 애플리케이션과 관련된 모든 리소스를 한곳에 모을 수 있습니다.

<walkthrough-devshell-precreate></walkthrough-devshell-precreate>

<walkthrough-project-setup></walkthrough-project-setup>

## Google Cloud Shell 사용

Cloud Shell은 콘솔용으로 내장된 명령줄 도구입니다. 이 가이드에서는 Cloud Shell을 사용해 앱을 배포합니다.

### Google Cloud Shell 열기

콘솔 상단 탐색 메뉴에서
<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>
[아이콘][spotlight-open-devshell]을 클릭하여 Cloud Shell을 엽니다.

### 샘플 코드 복제

Cloud Shell을 사용하여 'Hello World' 코드를 복제하고 이 코드로 이동합니다. 샘플 코드가 프로젝트 저장소에서 Cloud Shell로 복제됩니다.

참고: 디렉토리가 이미 존재하는 경우 복제하기 전에 이전 파일을 삭제하세요.

Cloud Shell에서 다음을 입력하세요.

```bash
git clone {{repo-url}}
```

그런 다음 가이드 디렉토리로 전환합니다.

```bash
cd {{repo-dir}}
```

## 배포 구성

현재 샘플 코드의 기본 디렉토리에 있습니다. 애플리케이션을 구성하는 파일을 살펴보겠습니다.

### 애플리케이션 살펴보기

다음 명령을 입력하여 애플리케이션 코드를 확인하세요.

```bash
cat main.py
```

이 애플리케이션은 [webapp2](https://webapp2.readthedocs.io/) 웹 프레임워크를 사용하는 간단한 Python 애플리케이션입니다. 이 Python 스크립트는 HTTP 헤더 및 `Hello, World!` 메시지를 사용하여 요청에 응답합니다.

### 구성 살펴보기

Google App Engine은 YAML 파일을 사용하여 배포 구성을 지정합니다.
`app.yaml` 파일에는 런타임 환경, URL 핸들러 등과 같은 애플리케이션 정보가 포함됩니다.

다음 명령어를 입력하여 구성 파일을 확인하세요.

```bash
cat app.yaml
```

맨 위부터 순서대로 이 구성 파일이 애플리케이션에 대해 말하고 있는 정보는 다음과 같습니다.

  *  이 코드는 `python` 런타임 환경에서 실행됩니다.
  *  이 애플리케이션은 `threadsafe`이므로 동일 인스턴스가 여러 개의 동시 요청을 처리할 수 있습니다. threadsafe는 고급 기능이며, threadsafe를 위해 특별히 설계되지 않은 애플리케이션에서는 불안정한 동작이 발생할 수 있습니다.
  *  경로가 정규 표현식 `/.*`(모든 URL)와 일치하는 URL에 대한 모든 요청은 `main` Python 모듈에 있는 앱 객체에서 처리해야 합니다.

이 파일의 구문은 [YAML](http://www.yaml.org)입니다. 전체 구성 옵션 목록은 [`app.yaml`][app-yaml-reference] 참조 자료를 확인하세요.

## 앱 테스트

### Cloud Shell에서 앱 테스트

로컬 머신에서 디버깅하는 것과 마찬가지로 배포하기 전에 Cloud Shell에서 앱을 테스트하여 올바르게 실행되는지 확인할 수 있습니다.

앱을 테스트하려면 다음을 입력하세요.

```bash
dev_appserver.py $PWD
```

### '웹 미리보기'로 앱 미리보기

앱이 이제 Cloud Shell에서 실행됩니다. [웹 미리보기][spotlight-web-preview]<walkthrough-web-preview-icon></walkthrough-web-preview-icon>로 포트 8080에 연결하여 앱에 액세스할 수 있습니다.

### 미리보기 인스턴스 종료

Cloud Shell에서 `Ctrl+C`를 눌러 애플리케이션의 인스턴스를 종료합니다.

## Google App Engine에 배포

### 애플리케이션 만들기

앱을 배포하기 위해서는 한 지역에서 앱을 만들어야 합니다.

```bash
gcloud app create
```

참고: 앱을 이미 만든 경우 이 단계를 건너뛸 수 있습니다.

### Cloud Shell로 배포

Cloud Shell을 사용하여 앱을 배포할 수 있습니다. 앱을 배포하려면 다음을 입력하세요.

```bash
gcloud app deploy app.yaml --project {{project-id}}
```

### 앱 방문

축하합니다. 앱이 배포되었습니다. 앱의 기본 URL은 [{{project-gae-url}}](http://{{project-gae-url}})입니다. URL을 클릭해서 방문하세요.

### 앱 상태 보기

App Engine 대시보드에서 상태를 모니터링하여 앱을 확인할 수 있습니다.

콘솔 왼쪽에서 [메뉴][spotlight-console-menu]를 엽니다.

그런 다음 **App Engine** 섹션을 선택합니다.

<walkthrough-menu-navigation sectionid="APPENGINE_SECTION"></walkthrough-menu-navigation>

## 마무리

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

App Engine 애플리케이션을 배포했습니다.

이제 다음 작업을 수행할 수 있습니다.

**Google Cloud SDK 다운로드 및 로컬에서 개발**

로컬 머신에 [Google Cloud SDK][cloud-sdk-installer]를 설치합니다.

**다음 애플리케이션 빌드**

다른 Google Cloud Platform 제품에서 App Engine을 사용하는 방법을 알아봅니다.

<walkthrough-tutorial-card label="django" url="python/django/appengine" icon="APPENGINE_SECTION">
  **Django 실행**
App Engine에서 실행되는 Django 앱을 개발합니다.
</walkthrough-tutorial-card>

<walkthrough-tutorial-card label="datastore" url="appengine/docs/python/datastore/" icon="DATASTORE_SECTION">
  **Cloud Datastore 사용 방법 알아보기**
Cloud Datastore는 확장성이 뛰어난 애플리케이션용 NoSQL 데이터베이스입니다.
</walkthrough-tutorial-card>

[app-yaml-reference]: https://cloud.google.com/appengine/docs/standard/python/config/appref
[cloud-sdk-installer]: https://cloud.google.com/sdk/downloads#interactive
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-web-preview]: walkthrough://spotlight-pointer?spotlightId=devshell-web-preview-button
