# Compute Engine 빠른 시작

## MongoDB로 할 일 앱 제작

<walkthrough-tutorial-duration duration="15"></walkthrough-tutorial-duration>

이 빠른 시작에서는 Compute Engine을 사용하여 2단계 애플리케이션을 만들어 봅니다. 프런트엔드 VM에서 Node.js 할 일 웹 앱을
실행하고 백엔드 VM에서는 MongoDB를 실행하는 방식입니다.

이 가이드에서 설명하는 내용은 다음과 같습니다.

*   두 개의 VM 생성 및 구성 중
*   방화벽 규칙 설정
*   SSH를 사용하여 VM에 패키지 설치

## 프로젝트 설정

Google Cloud Platform은 리소스를 프로젝트별로 정리하므로 한 애플리케이션과 관련된 모든 리소스를 한곳에 모을 수 있습니다.

<walkthrough-project-billing-setup permissions="compute.instances.create"></walkthrough-project-billing-setup>

## Compute Engine으로 이동

콘솔 왼쪽의 [메뉴][spotlight-console-menu]를 엽니다.

그런 다음 **Compute Engine** 섹션을 선택합니다.

<walkthrough-menu-navigation sectionid="COMPUTE_SECTION"></walkthrough-menu-navigation>

## 인스턴스 생성

애플리케이션의 백엔드 및 프런트엔드 서버가 될 2개의 인스턴스를 생성합니다.

### 백엔드 인스턴스 생성

우선 MongoDB를 실행할 백엔드 인스턴스를 생성합니다. 이 서버에 할 일 항목이 저장됩니다.

[인스턴스 만들기][spotlight-create-instance] 버튼을 클릭합니다.

*   이 인스턴스의 [이름][spotlight-instance-name] 및 [영역][spotlight-instance-zone]을
    선택합니다.

*   [f1-micro][spotlight-machine-type]를 선택하면 요금이 더 저렴합니다.

    *   [가격 책정에 대해 자세히 알아보기][pricing]

*   이 가이드의 부팅 디스크 이미지로 [Ubuntu 14.04 LTS][spotlight-boot-disk]를 선택합니다.

*   [방화벽 선택기][spotlight-firewall]에서 **Allow HTTP traffic(HTTP 트래픽 허용)**을 선택합니다.
    그러면 포트 80(HTTP)이 열리면서 앱에 액세스합니다.

*   [만들기][spotlight-submit-create] 버튼을 클릭하여 인스턴스를 만듭니다.

참고: 인스턴스가 생성되면 GCE 가격표에 따라 결제 계정에 요금이 부과되기 시작합니다. 불필요한 요금이 발생하지 않도록 나중에 이 인스턴스를
삭제할 것입니다.

### 프런트엔드 인스턴스 생성

백엔드 VM이 가동되는 동안 Node.js 할 일 애플리케이션을 실행할 프런트엔드 VM을 생성합니다. 백엔드 인스턴스와 동일한 구성을
사용합니다.

## 설정

데이터를 저장하기 위해 백엔드 인스턴스에 MongoDB 데이터베이스를 설치하게 됩니다.

테이블의 [SSH 버튼][spotlight-ssh-buttons]을 클릭하면 별도의 창에 인스턴스에 대한 SSH 세션이 열립니다.

이 가이드에서는 Cloud Shell을 통해 연결하게 됩니다. Cloud Shell은 콘솔용으로 내장된 명령줄 도구입니다.

### Cloud Shell 열기

콘솔 상단 탐색 메뉴에서 <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>
[아이콘][spotlight-open-devshell]을 클릭하여 Cloud Shell을 엽니다.

### 인스턴스 생성이 완료될 때까지 대기

인스턴스 생성이 완료되어야 가이드를 계속 진행할 수 있습니다. 상단 탐색 메뉴에서
[알림 메뉴][spotlight-notification-menu]를 클릭하면 활동을 추적할 수 있습니다.

## 백엔드 인스턴스에 연결

### 인스턴스에 연결

다음 명령어를 입력하여 VM에 SSH를 설정합니다. Cloud Shell에서 처음으로 SSH를 사용한다면 비공개 키를 만들어야 합니다. 앞서
생성한 인스턴스의 영역과 이름을 입력합니다.

```bash
gcloud compute --project "{{project-id}}" ssh --zone <backend-zone> <backend-name>
```

### 백엔드 데이터베이스 설치

백엔드 인스턴스에 SSH를 연결했으면 이제 다음 명령어를 사용해 백엔드 데이터베이스를 설치합니다.

패키지를 업데이트하고 MongoDB를 설치합니다. 계속할지 묻는 메시지가 표시되면 `Y`를 입력합니다.

```bash
sudo apt-get update
```

```bash
sudo apt-get install mongodb
```

### 데이터베이스 실행

MongoDB 서비스는 설치 당시 시작되었습니다. 실행 방식을 변경하려면 서비스를 중지해야 합니다.

```bash
sudo service mongodb stop
```

MongoDB를 위한 디렉토리를 만든 다음 포트 80을 통해 백그라운드에서 MongoDB 서비스를 실행합니다.

```bash
sudo mkdir $HOME/db
```

```bash
sudo mongod --dbpath $HOME/db --port 80 --fork --logpath /var/tmp/mongodb
```

이후 `exit` 명령어를 사용해 SSH 세션을 종료합니다.

```bash
exit
```

## 프런트엔드 인스턴스에 연결

### 프런트엔드 VM에 웹 앱 설치 및 실행

백엔드 서버가 실행 중이므로 이제 프런트엔드 웹 애플리케이션을 설치할 차례입니다.

### 인스턴스에 연결

다음 명령어를 입력하여 VM에 SSH를 설정합니다. 앞서 생성한 인스턴스의 영역과 이름을 입력합니다.

```bash
gcloud compute --project "{{project-id}}" ssh --zone <frontend-zone> <frontend-name>
```

### 종속 항목 설치

프런트엔드 인스턴스에 연결했으면 이제 패키지를 업데이트하고 git, Node.js, npm을 설치합니다. 계속 진행할지 묻는 메시지가 표시되면
`Y`를 입력합니다.

```bash
sudo apt-get update
```

```bash
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
```

```bash
sudo apt-get install git nodejs
```

### 프런트엔드 웹 앱 설치 및 실행

샘플 애플리케이션을 복제하고 애플리케이션 종속 항목을 설치합니다.

```bash
git clone https://github.com/GoogleCloudPlatform/todomvc-mongodb.git
```

```bash
cd todomvc-mongodb; npm install
```

```bash
sed -i -e 's/8080/80/g' server.js
```

다음 명령어에 앞서 생성한 인스턴스의 [내부 IP 주소][spotlight-internal-ip]를 입력하여 할 일 웹 애플리케이션을
시작합니다.

```bash
sudo nohup nodejs server.js --be_ip <backend-internal-ip> --fe_ip <frontend-internal-ip> &
```

이후 `exit` 명령어를 사용해 SSH 세션을 종료합니다.

```bash
exit
```

### 애플리케이션 방문

프런트엔드 인스턴스 옆의 [외부 IP][spotlight-external-ip] 열에 나온 IP 주소로 웹 서버에 방문합니다.

## 삭제

인스턴스를 삭제하려면 인스턴스 이름 옆의 [확인란][spotlight-instance-checkbox]을 선택하고
[삭제 버튼][spotlight-delete-button]을 클릭합니다.

## 결론

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

설정이 완료되었습니다.

다음으로 수행할 작업은 아래와 같습니다.

*   [GitHub](http://googlecloudplatform.github.io/)에서 Google Cloud Platform 샘플을
    찾습니다.

*   [부하 분산](https://cloud.google.com/compute/docs/load-balancing/)을 설정하는 방법을
    알아봅니다.

*   [가상 머신에 파일을 전송](https://cloud.google.com/compute/docs/instances/transfer-files/)하는
    방법을 알아봅니다.

*   [컨테이너를 실행](https://cloud.google.com/compute/docs/containers)하는 방법을 알아봅니다.

[pricing]: https://cloud.google.com/compute/#compute-engine-pricing
[spotlight-boot-disk]: walkthrough://spotlight-pointer?cssSelector=vm-set-boot-disk
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-control-panel]: walkthrough://spotlight-pointer?cssSelector=#p6n-action-bar-container-main
[spotlight-create-instance]: walkthrough://spotlight-pointer?spotlightId=gce-zero-new-vm,gce-vm-list-new
[spotlight-delete-button]: walkthrough://spotlight-pointer?cssSelector=.p6n-icon-delete
[spotlight-external-ip]: walkthrough://spotlight-pointer?cssSelector=.p6n-external-link
[spotlight-firewall]: walkthrough://spotlight-pointer?spotlightId=gce-vm-add-firewall
[spotlight-instance-checkbox]: walkthrough://spotlight-pointer?cssSelector=.p6n-checkbox-form-label
[spotlight-instance-name]: walkthrough://spotlight-pointer?spotlightId=gce-vm-add-name
[spotlight-instance-zone]: walkthrough://spotlight-pointer?spotlightId=gce-vm-add-zone-select
[spotlight-internal-ip]: walkthrough://spotlight-pointer?cssSelector=gce-internal-ip
[spotlight-machine-type]: walkthrough://spotlight-pointer?spotlightId=gce-add-machine-type-select
[spotlight-notification-menu]: walkthrough://spotlight-pointer?cssSelector=.p6n-notification-dropdown,.cfc-icon-notifications
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-ssh-buttons]: walkthrough://spotlight-pointer?cssSelector=gce-connect-to-instance
[spotlight-submit-create]: walkthrough://spotlight-pointer?spotlightId=gce-submit
[spotlight-vm-list]: walkthrough://spotlight-pointer?cssSelector=vm2-instance-list%20.p6n-checkboxed-table
