# Cloud Console 둘러보기

<walkthrough-tutorial-duration duration="5"></walkthrough-tutorial-duration>

## 소개

이 가이드에서는 Google Cloud Platform에서 애플리케이션을 만들고 관리할 준비를 할 수 있도록 Cloud Console의 핵심 기능을 다룹니다.

여기에서 알아볼 개념은 다음과 같습니다.

  *  GCP 프로젝트 및 리소스
  *  간략한 리소스 개요 및 활동 로그
  *  콘솔 탐색 및 검색
  *  사용자 및 권한 관리
  *  기술 지원
  *  GCP의 브라우저 기반 명령줄

지금 시작해 보세요.

## GCP 리소스 사용

GCP 리소스는 모든 Google Cloud 서비스를 구성하는 기본 요소입니다. 리소스는 계층구조로 구성되며 GCP에서 작업을 구성하는 데 도움이 됩니다.

프로젝트는 리소스 계층의 첫 번째 수준이며 Cloud Storage 버킷, Compute Engine 인스턴스와 같은 다른 낮은 수준의 리소스를 포함합니다.

[GCP 리소스 자세히 알아보기][gcp-resources]

### 프로젝트 탐색

Cloud Console의 [범위 선택도구][spotlight-project-select]를 사용하면 GCP 프로젝트를 간편하게 탐색할 수 있습니다. 프로젝트를 전환하면 해당 프로젝트와 모든 하위 프로젝트에 맞게 보기가 변경됩니다.

<walkthrough-project-setup></walkthrough-project-setup>

## Google Cloud 서비스 탐색

### 서비스 탐색

Google Cloud 서비스는 [왼쪽 탐색 메뉴][spotlight-console-menu]에서 액세스할 수 있으며 빅데이터, 컴퓨팅, 네트워킹 등의 제품 영역별로 정리되어 있습니다.

### 섹션 고정

정기적으로 이용하는 서비스의 경우 섹션 항목에 마우스를 가져가 고정 아이콘을 클릭하여 탐색 메뉴 상단에 섹션을 고정합니다.

탐색 메뉴를 열고 **홈**을 선택하여 계속 진행합니다.

<walkthrough-menu-navigation sectionid="HOME_SECTION"></walkthrough-menu-navigation>

## 대략적인 프로젝트 개요 보기

### 홈 대시보드

홈 대시보드는 선택한 GCP 프로젝트의 간략한 개요를 표시하며 주요 측정항목, 결제, 기타 유용한 정보를 강조표시합니다.

### 맞춤설정

[맞춤설정][spotlight-customize-dashboard]을 클릭하여 대시보드를 커스텀할 수 있습니다.
페이지에서 카드를 숨기거나 표시하고 순서를 변경할 수 있습니다. 또한 카드에 마우스를 가져가면 더보기 메뉴에서 액세스할 수 있는 맞춤설정 옵션이 표시됩니다.

## GCP 리소스의 전반적인 활동 보기

[활동 스트림][spotlight-activity-stream]을 통해 GCP 리소스 전반에서 진행되는 모든 활동을 한곳에서 파악할 수 있습니다.

팀원들이 프로젝트에서 무슨 작업을 하고 있는지 확인하면서 문제를 찾고 감사를 진행하세요. 간편하게 피드를 필터링하여 필요한 항목을 정확히 찾을 수 있습니다.

## Cloud Console에서 검색

Cloud Console의 [검색창][spotlight-search-bar]을 사용하면 Google Cloud 제품 및 GCP의 리소스에 신속하게 액세스할 수 있습니다.

**App Engine**이나 프로젝트 이름으로 검색해 보세요.

## 연중무휴 지원 받기

문제가 생겼거나 GCP를 이용하는 데 도움이 필요한 경우 Google 지원팀에서 도와드립니다.

[지원 자세히 알아보기](http://cloud.google.com/support)

탐색 메뉴에서 지원을 문의하세요.

<walkthrough-menu-navigation sectionid="SUPPORT_SECTION"></walkthrough-menu-navigation>

## 사용자 및 권한 관리

Google Cloud IAM(ID 및 액세스 관리)을 사용하면 GCP 리소스에 대한 권한을 만들고 관리할 수 있습니다.

[IAM 자세히 알아보기](https://cloud.google.com/iam/docs/)

팀이 계속 성장함에 따라 'IAM 및 관리자' 섹션에서 Cloud IAM을 사용해 팀원에게 액세스 권한을 부여할 수 있습니다.

사용자, 그룹, 서비스 계정을 추가하고 원하는 개수만큼 역할을 할당하여 필요한 권한을 부여해 보세요.

<walkthrough-menu-navigation sectionid="IAM_ADMIN_SECTION"></walkthrough-menu-navigation>

## 브라우저에서 명령줄 액세스

Google Cloud Shell을 사용하면 브라우저에서 직접 명령줄을 통해 클라우드 리소스에 액세스할 수 있습니다. Google Cloud SDK 또는 기타 도구를 시스템에 설치하지 않고도 프로젝트와 리소스를 쉽게 관리할 수 있습니다.

<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[Cloud Shell][spotlight-open-devshell]을 사용하면 Cloud SDK gcloud 명령줄 도구 및 그 밖의 필요한 유틸리티를 필요할 때마다 항상 최신 및 인증된 상태로 사용할 수 있습니다.

[Cloud Shell 자세히 알아보기](https://cloud.google.com/shell/)

## GCP 계속 알아보기

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

이제 새로운 서비스와 제품을 탐색하기 위한 단단한 기초를 갖추었으므로 Cloud Console을 수월하게 탐색할 수 있습니다.

또한 [자세한 문서](https://cloud.google.com/docs/)에서 제품 개요부터 퀵스타트 가이드 및 API 참조에 이르기까지 풍부한 정보를 볼 수 있습니다.

가이드를 더 보려면 시작하기 페이지로 돌아가세요.
<walkthrough-menu-navigation sectionid="ONBOARDING_SECTION"></walkthrough-menu-navigation>

[gcp-resources]: https://cloud.google.com/resource-manager/docs/cloud-platform-resource-hierarchy
[spotlight-activity-stream]: walkthrough://spotlight-pointer?cssSelector=.mat-tab-link:nth-of-type(2)
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-customize-dashboard]: walkthrough://spotlight-pointer?cssSelector=.cfc-customize-button
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-project-select]: walkthrough://spotlight-pointer?spotlightId=purview-switcher
[spotlight-search-bar]: walkthrough://spotlight-pointer?cssSelector=.p6n-search-bar,.pcc-platform-bar-search-bar
