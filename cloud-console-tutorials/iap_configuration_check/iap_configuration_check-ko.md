# GCE/GKE에 IAP 사용 설정

IAP(Identity-Aware Proxy)는 부하 분산기를 거치는 트래픽에만 보안을 적용합니다. 다음 단계에 따라 승인되지 않은 공격으로부터 앱을 보호하세요.

[자세히 알아보기](https://cloud.google.com/iap/docs/)

## 완료할 단계는 다음과 같습니다.

### 네트워크 구성 검토

부하 분산기 `130.211.0.0/22` 및 `35.191.0.0/16`에서 백엔드에 연결할 수 없는 경우 IAP가 **작동하지 않습니다**.

다른 IP로 백엔드에 액세스할 수 있다면 트래픽이 IAP 액세스 정책을 우회합니다. 모니터링 시스템의 백엔드 연결을 허용하는 경우 등에는 이 방법이 유용할 수 있습니다.

### 네트워크 구성 모니터링

IAP를 사용 설정한 후 구성이 변경되면 안전하지 않을 수 있습니다.
Google에서 유지 관리하는 오픈소스 도구인 [Forseti Security][forseti-security]를 배포하여 지속적으로 프로젝트 구성을 모니터링하고 알림을 받으세요.

### 서명된 헤더 검사 구현

다음과 같은 IAP 액세스 정책 우회로부터 앱을 보호하는 [방법을 알아보세요](https://cloud.google.com/iap/docs/signed-headers-howto).

  *  프로젝트 관리자가 실수로 IAP 사용 중지
  *  네트워크 구성 오류
  *  사용자가 localhost를 통해 VM에 로그인하고 웹 서버에 연결

### 구성 적용

문서를 읽고 이에 따라 GCE/GKE 리소스를 구성했음에 동의합니다.

[방법 보기][spotlight-config-reviewed]

[forseti-security]: https://opensource.google.com/projects/forseti-security
[spotlight-config-reviewed]: walkthrough://spotlight-pointer?spotlightId=iap-network-config-reviewed
