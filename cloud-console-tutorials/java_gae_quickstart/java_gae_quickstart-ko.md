# App Engine 빠른 시작

<walkthrough-test-start-page url="/getting-started?tutorial=java_gae_quickstart_2"/>

<walkthrough-tutorial-url url="https://cloud.google.com/appengine/docs/java/quickstart"/>

<walkthrough-watcher-constant key="repo-url" value="https://github.com/GoogleCloudPlatform/appengine-try-java" />

<walkthrough-watcher-constant key="repo-name" value="appengine-try-java"/>

## 소개

이 가이드에서는 App Engine Maven 플러그인을 사용하여 샘플 [자바][java] 애플리케이션을 Google App Engine에
배포하는 방법을 보여줍니다.

진행할 단계는 다음과 같습니다.

*   **’Hello, world!’ 앱 빌드 및 실행**

    Google Cloud Shell을 사용하여 브라우저에서 바로 앱을 실행하는 방법을 알아봅니다. 마지막 단계에서 App Engine
    Maven 플러그인을 사용하여 앱을 웹에 배포합니다.

*   **앱 배포 후...**

    앱의 서비스가 실제로 시작되며 배포 후에 앱으로 실험하거나 앱을 삭제한 후 처음부터 다시 시작할 수 있습니다.

[Java is a registered trademark of Oracle and/or its affiliates.](walkthrough://footnote)

<walkthrough-devshell-precreate/>

## 프로젝트 설정

애플리케이션을 배포하려면 먼저 프로젝트를 만들어야 합니다. Google Cloud Platform은 리소스를 프로젝트별로 정리합니다. 이 방식을
통해 애플리케이션 1개와 관련된 모든 리소스를 한곳에 모을 수 있습니다.

<walkthrough-project-setup/>

## Google Cloud Shell 사용

Cloud Shell은 콘솔용으로 내장된 명령줄 도구입니다. Cloud Shell을 사용하여 앱을 배포해 보겠습니다.

### Google Cloud Shell 열기

콘솔 상단의 탐색 메뉴에 있는 <walkthrough-cloud-shell-icon/>
[icon](walkthrough://spotlight-pointer?spotlightId=devshell-activate-button) 버튼을
클릭하여 Cloud Shell을 엽니다.

### 샘플 코드 복제

Cloud Shell을 사용하여 'Hello World’ 코드를 복제하고 이 코드로 이동합니다. 샘플 코드가 프로젝트 저장소에서 Cloud
Shell로 복제됩니다.

참고: 디렉토리가 이미 있다면 복제하기 전에 이전 파일을 삭제합니다.

```bash
rm -rf {{repo-name}}
```

Cloud Shell에 다음을 입력합니다.

```bash
git clone {{repo-url}}
```

그런 다음 가이드 디렉토리로 전환합니다.

```bash
cd {{repo-name}}
```

## 배포 구성

지금 보시는 것은 샘플 코드의 기본 디렉토리입니다. 애플리케이션을 구성하는 파일을 살펴보겠습니다.

### 애플리케이션 살펴보기

다음 명령어를 입력하여 애플리케이션 코드를 확인합니다.

```bash
cat src/main/java/myapp/DemoServlet.java
```

서블릿이 `Hello, world!` 메시지가 포함된 응답을 전송하여 모든 요청에 응답합니다.

### 구성 살펴보기

자바의 경우 Google App Engine에서 XML 파일을 사용하여 배포 구성을 지정합니다.

다음 명령어를 입력하여 구성 파일을 확인합니다.

```bash
cat pom.xml
```

`helloworld` 앱은 Maven을 사용하므로 Maven에서 프로젝트 빌드에 사용하는 프로젝트 관련 정보와 구성 세부정보가 포함된
POM(Project Object Model)을 지정해야 합니다.

## 앱 테스트

### Cloud Shell에서 앱 테스트

Cloud Shell을 사용하면 로컬 머신에서 디버깅하는 것과 마찬가지로 배포하기 전에 앱을 테스트하여 의도한 대로 실행되는지 확인할 수
있습니다.

앱을 테스트하려면 다음을 입력합니다.

```bash
mvn appengine:run
```

<walkthrough-test-code-output
  text="module .* running at|Dev App Server is now running" />

### ‘웹 미리보기’로 앱 미리보기

이제 앱이 Cloud Shell에서 실행되고 있습니다. ‘웹 미리보기’ <walkthrough-web-preview-icon/>를 사용하여 포트
8080에 연결하면 앱에 액세스할 수 있습니다.
[방법 확인하기](walkthrough://spotlight-pointer?spotlightId=devshell-web-preview-button)

### 미리보기 인스턴스 종료

Cloud Shell에서 `Ctrl+C`를 눌러 애플리케이션의 인스턴스를 종료합니다.

## Google App Engine에 배포

### 애플리케이션 만들기

앱을 배포하려면 지역에서 앱을 만들어야 합니다.

```bash
gcloud app create
```

참고: 이미 앱을 만들었다면 이 단계를 건너뛸 수 있습니다.

### Cloud Shell로 배포

이제 Cloud Shell을 사용하여 앱을 배포할 수 있습니다.

먼저 사용할 프로젝트를 설정합니다.

```bash
gcloud config set project {{project-id}}
```

그런 다음 앱을 배포합니다.

```bash
mvn appengine:deploy
```

<walkthrough-test-code-output text="Deployed (module|service)" />

### 앱으로 이동

앱이 배포되었습니다. 앱의 기본 URL은 [{{project-gae-url}}](http://{{project-gae-url}})입니다. 앱으로
이동하려면 URL을 클릭하세요.

### 앱 상태 보기

App Engine 대시보드에서 상태를 모니터링하여 앱 상태를 확인할 수 있습니다.

콘솔 왼쪽에서 [menu](walkthrough://spotlight-pointer?spotlightId=console-nav-menu) 메뉴를
엽니다.

그런 다음 **App Engine** 섹션을 선택합니다.

<walkthrough-menu-navigation sectionId="APPENGINE_SECTION"/>

## 마무리

<walkthrough-conclusion-trophy/>

수고 많으셨습니다. App Engine 애플리케이션을 배포했습니다. 이후 단계는 다음과 같습니다.

**Google Cloud SDK를 다운로드하고 로컬에서 개발**

[Google Cloud SDK][cloud-sdk-installer]

**다음 애플리케이션 빌드**

다른 Google Cloud Platform 제품과 함께 App Engine을 사용하는 방법을 알아보세요.

<walkthrough-tutorial-card
  url="appengine/docs/java/datastore/"
  icon="DATASTORE_SECTION"
  label="datastore">
**Cloud Datastore 사용 방법 알아보기**
Cloud Datastore는 애플리케이션을 위한 확장성이 높은 NoSQL 데이터베이스입니다.
</walkthrough-tutorial-card>

<walkthrough-tutorial-card
  url="appengine/docs/java/googlecloudstorageclient/setting-up-cloud-storage/"
  icon="STORAGE_SECTION"
  label="cloudStorage">
**Cloud Storage 사용 방법 알아보기**
Cloud Storage는 강력하면서도 간단한 개체 저장소 서비스입니다.
</walkthrough-tutorial-card>

[java]: https://java.com/
[cloud-sdk-installer]: https://cloud.google.com/sdk/downloads#interactive
