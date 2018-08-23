# Cloud Storage 퀵스타트

## Google Cloud Storage에 오신 것을 환영합니다.

<walkthrough-tutorial-url url="https://cloud.google.com/storage/docs/quickstart-console"></walkthrough-tutorial-url>

Google Cloud Storage는 비구조화 객체를 위한 강력하고 경제적인 저장소 솔루션으로서 라이브 웹 콘텐츠 호스팅에서 분석용 데이터 저장, 보관처리, 백업 등에 이르기까지 다양한 용도에 적합합니다.

이 가이드에서는 Cloud Storage에서 객체 저장을 시작하기가 얼마나 쉬운지 보여줍니다. 수행할 작업은 아래와 같습니다.

  *  **버킷 만들기**

     버킷은 Cloud Storage에 저장하려는 객체(모든 파일 유형)를 보관합니다.

  *  **객체 업로드 및 공유**

     객체를 업로드하고 공개 액세스를 허용하여 버킷 사용을 시작합니다.

  *  **삭제**

     마지막 단계로, 이 가이드에서 만든 버킷과 객체를 삭제합니다.

마지막에 버킷과 객체를 삭제하므로 이 가이드를 따라 해도 요금은 발생하지 않습니다.

## 프로젝트 설정

리소스를 만들려면 Cloud Storage에 프로젝트가 필요합니다.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## 버킷 만들기

Cloud Storage에서는 객체를 버킷에 저장합니다. 버킷을 만들려면 Cloud Storage 브라우저로 이동해야 합니다.

콘솔 왼쪽에서 [메뉴][spotlight-menu]를 엽니다.

그런 다음 **저장소** 섹션을 선택합니다.

<walkthrough-menu-navigation sectionid="STORAGE_SECTION"></walkthrough-menu-navigation>

## 버킷 만들기

객체 업로드를 시작하기 전에 이를 저장할 '버킷'을 만들어야 합니다. 버킷을 사용하면 객체를 정리하고 이에 대한 액세스를 제어할 수 있습니다.

  1. [버킷 만들기](walkthrough://spotlight-pointer?cssSelector=#p6ntest-cloudstorage-create-first-bucket-button,)를 클릭합니다.

  1. 버킷 만들기 페이지에서 버킷 속성을 지정합니다. 다음과 같은 몇 가지 유의사항이 있습니다.

     *  **이름:** 고유한 이름을 지정하세요. Cloud Storage에 있는 다른 버킷과 동일한 이름을 입력하면 오류가 표시됩니다.
     *  **기본 저장소 등급:** 기본적으로 버킷의 객체에 할당되는 저장소 등급입니다. 주로 객체에 예상되는 액세스 빈도, 전 세계에 데이터를 제공할지 여부에 따라 선택합니다. 저장소 등급은 비용에 영향을 줍니다.
     *  **위치:** 데이터에 액세스하는 애플리케이션 및 사용자와 가까운 곳에 데이터를 두는 것이 좋습니다. 사용 가능한 옵션은 저장소 등급 선택에 따라 달라집니다.

이 가이드에서는 마지막에 버킷을 삭제하므로 저장소 등급 및 위치는 임의로 선택해도 됩니다.

  1. [만들기][spotlight-create-button]를 클릭합니다.

##  객체 업로드 및

버킷을 만들었으므로 이제 객체를 업로드할 수 있습니다.

  1. 페이지 상단에서 [파일 업로드][spotlight-upload-file]를 클릭합니다.

  1. 업로드할 파일을 선택합니다. 모든 유형의 파일을 업로드할 수 있습니다.

     파일이 없으면 [샘플 파일을 만들고][create-sample-file] 페이지 상단에서 [버킷 새로고침][spotlight-refresh-bucket]을 클릭하면 버킷에 표시됩니다. (팁: 버킷 이름 아래 공간으로 드래그 앤 드롭하여 객체를 업로드할 수도 있습니다.)

## 버킷 삭제

이제 방금 만든 버킷을 삭제합니다. 버킷을 삭제하면 해당 내용도 삭제됩니다.

  1. 테이블 상단에서 [버킷][spotlight-buckets-link]을 클릭하여 버킷 목록으로 돌아갑니다.

  1. 버킷 옆의 체크박스를 선택합니다. 이 프로젝트에 다른 버킷이 있어서 찾기 어렵다면 검색창을 사용하여 버킷 목록을 필터링하세요.

  1. 페이지 상단에서 [삭제][spotlight-delete-buckets]를 클릭하고 삭제 확인 메시지를 확인합니다.

## 마무리

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

축하합니다.

이제 Cloud Storage에서 객체를 저장하는 방법을 알게 되었으므로 [정적 웹사이트를 호스팅](https://cloud.google.com/storage/docs/hosting-static-website)하여 실무에 활용하는 방법을 알아보세요.

또는 [gsutil 명령줄 도구](https://cloud.google.com/storage/docs/quickstart-gsutil)로 Cloud Storage를 사용하는 방법을 알아보세요.

Cloud Storage 및 기타 GCP 서비스 사용을 [무료](https://cloud.google.com/free)로 시작하는 방법을 알아보세요.

[create-sample-file]: walkthrough://create-sample-storage-file
[spotlight-buckets-link]: walkthrough://spotlight-pointer?cssSelector=.p6n-cloudstorage-path-link
[spotlight-create-bucket]: walkthrough://spotlight-pointer?cssSelector=#p6ntest-cloudstorage-create-first-bucket-button,#p6n-cloudstorage-create-bucket
[spotlight-create-button]: walkthrough://spotlight-pointer?cssSelector=#p6ntest-gcs-create-bucket-button
[spotlight-delete-buckets]: walkthrough://spotlight-pointer?spotlightId=gcs-action-bar-delete-bucket
[spotlight-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-public-link]: walkthrough://spotlight-pointer?cssSelector=.p6n-cloudstorage-browser-public-label
[spotlight-refresh-bucket]: walkthrough://spotlight-pointer?spotlightId=gcs-action-bar-refresh-objects
[spotlight-share-public]: walkthrough://spotlight-pointer?cssSelector=.p6n-cloudstorage-browser-public-checkbox
[spotlight-upload-file]: walkthrough://spotlight-pointer?spotlightId=gcs-action-bar-upload-file
