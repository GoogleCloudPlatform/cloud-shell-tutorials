# Dataflow 단어 수 가이드

<walkthrough-tutorial-url url="https://cloud.google.com/dataflow/docs/quickstarts/quickstart-java-maven"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="dataflow-intro" key="directory"></walkthrough-watcher-constant>
<walkthrough-watcher-constant value="dataflow-intro" key="job-name"></walkthrough-watcher-constant>

## 소개

이 가이드에서는 자바를 이용한 간단한 예제 파이프라인을 실행하여 Cloud Dataflow 서비스의 기본사항을 알아봅니다.

Dataflow 파이프라인의 유형으로는 *일괄*(파일이나 데이터베이스 테이블과 같은 제한된 입력 처리) 및 *스트리밍*(Cloud Pub/Sub과 같은 소스의 제한 없는 입력 처리)이 있습니다. 이 가이드에서는 셰익스피어 작품 속 단어 수를 세는 일괄 파이프라인을 예시로 들고 있습니다.

시작하기 전에 Cloud Platform 프로젝트의 필수 조건을 확인하고 초기 설정을 수행해야 합니다.

## 프로젝트 설정

Google Cloud Platform은 리소스를 프로젝트별로 정리하므로 한 애플리케이션과 관련된 모든 리소스를 한곳에 모을 수 있습니다.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>
<walkthrough-project-permissions permissions="dataflow.jobs.create"></walkthrough-project-permissions>

## Cloud Dataflow 설정

Dataflow를 사용하려면 Cloud Dataflow API를 사용 설정하고 Cloud Shell을 엽니다.

### Google Cloud API 사용 설정

<walkthrough-enable-apis apis="compute.googleapis.com,dataflow,cloudresourcemanager.googleapis.com,logging,storage_component,storage_api,bigquery,pubsub">
</walkthrough-enable-apis>

### Cloud Shell 열기

Cloud Shell은 콘솔용으로 내장된 명령줄 도구입니다. 이 가이드에서는 Cloud Shell을 사용해 앱을 배포합니다.

콘솔 상단 탐색 메뉴에서
<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>
[아이콘][spotlight-open-devshell]을 클릭하여 Cloud Shell을 엽니다.

## Cloud Shell에서 Cloud Dataflow 샘플 설치

자바용 Cloud Dataflow SDK를 사용하려면 자바, Google Cloud SDK, 자바용 Cloud Dataflow SDK와 SDK 종속 항목 관리를 위한 Apache Maven이 설치된 개발 환경이 필요합니다. 이 가이드에서는 Java, Google Cloud SDK, Maven이 이미 설치된 Cloud Shell을 사용합니다.

이 가이드를 [로컬 머신에서][dataflow-java-tutorial] 진행할 수도 있습니다.

### Maven 명령어로 샘플 및 자바용 Cloud Dataflow SDK 다운로드

이 명령어를 실행하면 Maven에서 Cloud Dataflow SDK의 적절한 버전을 다운로드하기 위해 프로젝트 구조 및 구성 파일을 만듭니다.

```bash
mvn archetype:generate \
    -DarchetypeArtifactId=google-cloud-dataflow-java-archetypes-examples \
    -DarchetypeGroupId=com.google.cloud.dataflow \
    -DarchetypeVersion=2.1.0 \
    -DgroupId=com.example \
    -DartifactId={{directory}} \
    -Dversion="0.1" \
    -DinteractiveMode=false \
    -Dpackage=com.example
```

  *  `archetypeArtifactId`와 `archetypeGroupId`는 예제 프로젝트 구조를 정의하는 데 사용됩니다.
  *  `groupId`는 조직의 자바 패키지 이름 프리픽스(예: `com.mycompany`)입니다.
  *  `artifactId`는 생성된 jar 파일의 이름을 설정합니다. 이 가이드에서는 기본값(`{{directory}}`)을 사용합니다.

Cloud Shell에서 Maven 명령어를 실행합니다.

### 디렉토리 변경

작업 디렉토리를 `{{directory}}`로 변경합니다.

```bash
cd {{directory}}
```

이 예제의 코드를 보려면 `{{directory}}` 디렉토리의 `src` 하위 디렉토리를 확인하세요.

## Cloud Storage 버킷 설정

Cloud Dataflow는 Cloud Storage 버킷을 사용하여 출력 데이터를 저장하고 파이프라인 코드를 캐시합니다.

### gsutil mb 실행

Cloud Shell에서 `gsutil mb` 명령어를 사용하여 Cloud Storage 버킷을 만듭니다.

```bash
gsutil mb gs://{{project-id-no-domain}}
```

`gsutil` 도구에 관한 자세한 내용은 [문서][gsutil-docs]를 참조하세요.

## 파이프라인 만들기 및 실행

Cloud Dataflow에서는 데이터 처리 작업이 *파이프라인*으로 표현됩니다. 파이프라인은 입력 데이터를 읽고 변환한 후 출력 데이터를 생성합니다. 파이프라인의 변환에는 데이터 필터링, 그룹화, 비교, 결합이 포함될 수 있습니다.

이 예제의 코드를 보려면 `{{directory}}` 디렉토리의 `src` 하위 디렉토리를 확인하세요.

### Dataflow 서비스에서 파이프라인 실행

Apache Maven의 `mvn exec` 명령어를 사용하여 서비스에서 파이프라인을 실행합니다.
실행 중인 파이프라인을 *작업*이라고 합니다.

```bash
mvn compile exec:java \
  -Dexec.mainClass=com.example.WordCount \
  -Dexec.args="--project={{project-id}} \
  --stagingLocation=gs://{{project-id-no-domain}}/staging/ \
  --output=gs://{{project-id-no-domain}}/output \
  --runner=DataflowRunner \
  --jobName={{job-name}}"
```

  *  `stagingLocation`은 Cloud Dataflow에서 파이프라인을 실행하는 데 필요한 바이너리 및 기타 데이터를 저장하는 데 사용하는 저장소 버킷입니다. 여러 작업에서 이 위치를 공유할 수 있습니다.
  *  `output`은 WordCount 예제에서 작업 결과를 저장하는 데 사용하는 버킷입니다.

### 작업 실행 중

수고 많으셨습니다. 앞서 만든 저장소 버킷에 바이너리가 준비되었으며 Compute Engine 인스턴스가 생성되고 있습니다. Cloud Dataflow가 여러 머신에서 동시에 처리할 수 있도록 입력 파일을 분할합니다.

참고: '작업 완료' 메시지가 표시되면 Cloud Shell을 닫아도 무방합니다.

생성한 Maven 프로젝트를 삭제하려면 Cloud Shell에서 `cd .. && rm -R {{directory}}`를 실행하여 디렉토리를 삭제하세요.

## 작업 모니터링

Cloud Dataflow Monitoring UI 페이지에서 파이프라인의 진행률을 확인합니다.

### Cloud Dataflow 페이지로 이동

콘솔 왼쪽의 [메뉴][spotlight-console-menu]를 엽니다.

그런 다음 **Dataflow** 섹션을 선택합니다.

<walkthrough-menu-navigation sectionid="DATAFLOW_SECTION"></walkthrough-menu-navigation>

### 작업 선택

작업을 클릭하여 세부정보를 확인합니다.

### 파이프라인 세부정보 및 측정항목 살펴보기

왼쪽의 파이프라인과 오른쪽의 작업 정보를 살펴봅니다. 자세한 작업 상태를 보려면 [로그][spotlight-job-logs]를 클릭합니다. 파이프라인의 단계를 클릭하여 측정항목을 확인해 봅니다.

작업이 완료되면 작업 상태가 변경되고 작업에 사용되는 Compute Engine 인스턴스가 자동으로 중지됩니다.

## 출력 보기

이제 작업이 실행되었으므로 Cloud Storage의 출력 파일을 살펴볼 수 있습니다.

### Cloud Storage 페이지로 이동

콘솔 왼쪽의 [메뉴][spotlight-console-menu]를 엽니다.

그런 다음 **Storage** 섹션을 선택합니다.

<walkthrough-menu-navigation sectionid="STORAGE_SECTION"></walkthrough-menu-navigation>

### 저장소 버킷으로 이동

버킷 목록에서 앞서 만든 버킷을 선택합니다. 추천 이름을 사용한 경우 이름이 `{{project-id}}`입니다.

이 버킷에는 준비 폴더와 출력 폴더가 포함되어 있습니다. Dataflow는 출력을 분할하여 저장하므로 버킷에 여러 출력 파일이 포함됩니다.

## 삭제

Cloud Storage 사용 비용이 청구되지 않도록 이 가이드에서 만든 버킷을 삭제합니다.

### 버킷 브라우저로 돌아가기

[버킷][spotlight-buckets-link] 링크를 클릭합니다.

### 버킷 선택

이 가이드에서 만든 버킷 옆의 체크박스를 선택합니다.

### 버킷 삭제

[삭제][spotlight-delete-bucket]를 클릭하고 삭제를 확인합니다.

## 마무리

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

다음으로 할 수 있는 작업은 아래와 같습니다.

  *  [단어 세기 예제 자세히 알아보기][wordcount]
  *  [Cloud Dataflow 프로그래밍 모델에 대해 자세히 알아보기][df-model]
  *  [Github에서 Cloud Dataflow SDK 살펴보기][df-sdk]

로컬 환경 설정

  *  [Eclipse로 Dataflow 실행][df-eclipse]
  *  [Python으로 Dataflow 실행][df-python]

[dataflow-java-tutorial]: https://cloud.google.com/dataflow/docs/quickstarts/quickstart-java-maven
[df-eclipse]: https://cloud.google.com/dataflow/docs/quickstarts/quickstart-java-eclipse
[df-model]: https://cloud.google.com/dataflow/model/programming-model-beam
[df-python]: https://cloud.google.com/dataflow/docs/quickstarts/quickstart-python
[df-sdk]: https://github.com/apache/beam/tree/master/sdks/java
[gsutil-docs]: https://cloud.google.com/storage/docs/gsutil
[spotlight-buckets-link]: walkthrough://spotlight-pointer?cssSelector=.p6n-cloudstorage-path-link
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-delete-bucket]: walkthrough://spotlight-pointer?cssSelector=#p6n-cloudstorage-delete-buckets
[spotlight-job-logs]: walkthrough://spotlight-pointer?cssSelector=#p6n-dax-job-logs-toggle
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[wordcount]: https://beam.apache.org/get-started/wordcount-example/
