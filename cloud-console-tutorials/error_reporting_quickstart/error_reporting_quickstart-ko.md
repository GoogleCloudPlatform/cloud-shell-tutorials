# Stackdriver Error Reporting

## 소개

Stackdriver Error Reporting은 클라우드 서비스에서 발생한 오류를 집계하고 표시합니다.

이 가이드에서는 Error Reporting 웹 인터페이스를 설명합니다. 애플리케이션 오류를 나열하고, 오류 세부정보를 확인하고, 조치를 취하는 방법에 관해 알아봅니다.

## 프로젝트 설정

<walkthrough-project-setup></walkthrough-project-setup>

## 오류 생성

계속하기 전에 인위적인 오류를 보고해야 합니다. 여기에서는 `gcloud` 명령어로 이 작업을 수행합니다.

실제 상황에서는 실행 중인 애플리케이션에서 이러한 오류가 바로 보고됩니다. 이 가이드를 마친 후 Error Reporting 설정 방법을 자세히 알아볼 수 있습니다.

### Google Cloud Shell 열기

콘솔 상단 탐색 메뉴에서
<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>
[아이콘][spotlight-open-devshell]을 클릭하여 Cloud Shell을 엽니다.

### 오류 보고

다음 스크립트 오른쪽 상단의 **클립보드로 복사** 버튼을 클릭하고 Cloud Shell에서 실행하여 샘플 오류를 생성합니다.

```bash
COUNTER=0
while [  $COUNTER -lt 11 ]; do
    gcloud beta error-reporting events report --service tutorial --service-version v$((COUNTER/10+1)) \
        --message "java.lang.RuntimeException: Error rendering template $COUNTER
          at com.example.TestClass.test(TestClass.java:51)
          at com.example.AnotherClass(AnotherClass.java:25)
          at javax.servlet.http.HttpServlet.service (HttpServlet.java:617)
          at javax.servlet.http.HttpServlet.service (HttpServlet.java:717)"
    if [ $COUNTER -lt 3 ]; then
      gcloud beta error-reporting events report --service tutorial --service-version v1 \
          --message "java.lang.ArrayIndexOutOfBoundsException: $COUNTER
            at com.example.AppController.createUser(AppController.java:42)
            at com.example.User(User.java:31)
            at javax.servlet.http.HttpServlet.service (HttpServlet.java:617)
            at javax.servlet.http.HttpServlet.service (HttpServlet.java:717)"
    fi
    if [ $COUNTER -eq 10 ]; then
      echo "All artificial errors reported."
    fi
    let COUNTER=COUNTER+1
done
```

### Cloud Shell 닫기

작업을 마쳤으면 Cloud Shell을 닫고 *계속*을 클릭합니다.

## 애플리케이션 오류 나열

Stackdriver Error Reporting을 사용하여 보고된 오류를 한눈에 볼 수 있습니다.

### Error Reporting 열기

콘솔 왼쪽에서 [메뉴][spotlight-console-menu]를 엽니다.

그런 다음 **Stackdriver** 카테고리로 스크롤하고 **Error Reporting**을 선택합니다.

<walkthrough-menu-navigation sectionid="CRASH_SECTION"></walkthrough-menu-navigation>

### *최초 발생 시간* 기준 정렬

애플리케이션에서 발생하는 오류는 스택 추적 분석을 통해 그룹화되고 중복 항목은 삭제됩니다. 이 목록의 각 항목은 애플리케이션에서 오류가 발생하기 시작한 시점, 발생 횟수, 최근 발생 시간을 확인할 수 있는 요약 정보를 제공합니다.

기본 정렬 기준은 *발생 횟수*입니다. 최근에 발생하기 시작한 오류부터 보려면 *최초 발생 시간* 열 헤더를 클릭합니다.

### 새로운 오류 발생 시 알림 수신 설정

프로젝트에서 이전에 없었던 새로운 오류가 발생할 때 이메일과 모바일 푸시 알림을 받을 수 있습니다. 이러한 알림을 수신하도록 설정하려면 *알림 사용*을 클릭합니다.

완료되면 *계속*을 클릭합니다.

## 오류 세부정보 알아보기

### 오류 보고서 열기

이 목록에서 오류를 클릭하여 세부정보를 확인합니다.

### 이 오류에 문제 연결

특정 오류의 정보와 기록을 살펴 보려면 이 페이지를 사용합니다.

새로운 오류를 살펴본 후 일반적인 다음 단계는 팀의 문제 추적기로 문제를 제출하는 것입니다. 그런 다음 Stackdriver Error Reporting에서 문제 추적기 항목을 오류에 다시 연결할 수 있습니다.

다음 단계를 따르세요.

  *  상단에서 *문제에 연결*을 클릭합니다. **추가 작업** 메뉴를 열어야 이 링크가 보이는 경우도 있습니다.
  *  대화상자에 `http://example.com/issues/1234`를 입력합니다.
  *  *저장*을 클릭합니다.

### 스택 추적 살펴보기

코드에 집중할 수 있도록 애플리케이션 코드에서 가져오지 않은 스택 추적 프레임을 숨깁니다.

프레임워크 스택 프레임을 표시하려면 오류 샘플에서 *모두 표시*를 클릭합니다.

## 마무리

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

수고 많으셨습니다. Stackdriver Error Reporting 가이드를 완료했습니다.

다음으로 할 수 있는 작업은 아래와 같습니다.

### 프로젝트에 Error Reporting 설정

[설정 문서][errors-setup]에서 실행 중인 서비스에 Error Reporting을 설정하는 방법을 자세히 알아보세요.

### 다른 Stackdriver 가이드 살펴보기

[Stackdriver Debugger][debug-quickstart] 퀵스타트를 통해 제작 애플리케이션을 디버깅하세요.

[Stackdriver Trace][trace-quickstart] 퀵스타트를 통해 애플리케이션 지연 시간에 관해 알아보세요.

[debug-quickstart]: https://cloud.google.com/debugger/docs/quickstart
[errors-setup]: https://cloud.google.com/error-reporting/docs/how-to
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[trace-quickstart]: https://cloud.google.com/trace/docs/quickstart
