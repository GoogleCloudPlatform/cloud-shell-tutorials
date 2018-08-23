# Stackdriver 錯誤報告

## 簡介

Stackdriver 錯誤報告會匯總雲端服務產生的錯誤，並向您顯示相關資料。

本教學課程將逐步介紹 Error Reporting 的網頁介面。另外，您也能瞭解如何列出應用程式錯誤、進一步查看相關詳情及採取相應的行動。

## 專案設定

<walkthrough-project-setup></walkthrough-project-setup>

## 產生錯誤

您必須先回報人為錯誤，才能繼續後續操作。如要這麼做，請使用 `gcloud` 指令。

在實際情況中，系統會直接從執行中的應用程式回報錯誤。本教學課程完成後，您就能更加瞭解如何設定 Error Reporting。

### 開啟 Google Cloud Shell

請點選主控台頂端導覽列中的 <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon> [圖示](walkthrough://spotlight-pointer?spotlightId=devshell-activate-button)來開啟 Cloud Shell。

### 回報其中幾項錯誤

點選下列指令碼右上方的「**複製到剪貼簿**」按鈕，並在 Cloud Shell 中執行該指令碼以產生錯誤範例。

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

### 關閉 Cloud Shell

關閉 Cloud Shell，並在完成後點選 [**繼續**]。

## 列出應用程式錯誤

您可以透過 Stackdriver 錯誤報告大致瞭解系統回報的錯誤。

### 開啟 Error Reporting

開啟主控台左側的[選單](walkthrough://spotlight-pointer?spotlightId=console-nav-menu)。

捲動至「**Stackdriver**」類別，然後選取 [**錯誤報告**]。

<walkthrough-menu-navigation sectionid="CRASH_SECTION"></walkthrough-menu-navigation>

### 依「**首次發生時間**」排序

系統會將應用程式中發生的錯誤分門別類，並分析其堆疊追蹤來排除重複的錯誤。這份清單中的每個項目都附有摘要，以便您判定應用程式最初發生錯誤的時間、錯誤的發生頻率，以及最近發生錯誤的時間。

系統預設的排序依據為「**發生次數**」。點選 [**首次發生時間**] 這個資料欄標頭，即可查看最近才開始出現的錯誤。

### 選擇接收新錯誤通知

您可以選擇在系統偵測到專案中出現新的錯誤時，是否接收電子郵件和行動裝置推播通知。如想接收這類通知，請點選 [**啟用通知功能**]。

完成後，請點選 [**繼續**]。

## 瞭解錯誤詳情

### 開啟錯誤報告

點選這份清單中的某項錯誤，即可查看相關詳情。

### 將問題與這項錯誤相連結

您可以在這個頁面中查看特定錯誤的相關資訊與記錄。

大致瞭解新的錯誤之後，下一步通常是在所屬團隊的問題追蹤工具中提交問題。系統會將問題追蹤工具中的這個項目連結回 Stackdriver 錯誤報告中的該項錯誤。

方法如下：

  *  點選網頁頂端的 [**連結到問題**]。請注意，您可能需要開啟「**更多動作**」選單，才能看到這個連結。
  *  在對話方塊中輸入「`http://example.com/issues/1234`」。
  *  點選 [**儲存**]。

### 探索堆疊追蹤

為了讓您可以專心查看程式碼，如果堆疊追蹤頁框並非由您的應用程式碼產生，系統會自動將其隱藏。

點選錯誤範例中的 [**全部顯示**]，即可查看架構堆疊頁框。

## 結論

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

恭喜！您已順利完成 Stackdriver 錯誤報告的教學課程。

以下是您可以採取的後續步驟：

### 為您的專案設定 Error Reporting

參閱[設定說明文件][errors-setup]，瞭解如何為執行中的服務設定 Error Reporting。

### 瀏覽其他 Stackdriver 教學課程

利用 [Stackdriver Debugger][debug-quickstart] 快速入門導覽課程，瞭解如何針對正式版應用程式進行偵錯。

透過 [Stackdriver Trace][trace-quickstart] 快速入門導覽課程，瞭解應用程式的延遲情況。

[debug-quickstart]: https://cloud.google.com/debugger/docs/quickstart
[errors-setup]: https://cloud.google.com/error-reporting/docs/how-to
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[trace-quickstart]: https://cloud.google.com/trace/docs/quickstart
