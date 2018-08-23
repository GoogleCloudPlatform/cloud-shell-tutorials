# Cloud Console 導覽

<walkthrough-tutorial-duration duration="5"></walkthrough-tutorial-duration>

## 簡介

本教學課程將說明 Cloud Console 的核心功能，讓您可以游刃有餘地在 Google Cloud Platform 上打造及管理應用程式。

您將會瞭解以下概念：

  *  GCP 專案與資源
  *  高層級資源總覽畫面與活動記錄
  *  主控台導覽和搜尋功能
  *  使用者與權限管理
  *  技術支援
  *  在瀏覽器中運作的 GCP 指令列

開始教學課程！

## 使用 GCP 資源

GCP 資源是構成所有 Google Cloud 服務的基本元件。系統會以階級化的方式整理資源，讓您在 GCP 上工作時能夠更加井井有條。

專案是資源階層的第一層，當中包含 Cloud Storage 值區和 Compute Engine 執行個體等其他低層級資源。

[進一步瞭解 GCP 資源][gcp-resources]

### 專案導覽

使用 Cloud Console 中的[範圍選取器](walkthrough://spotlight-pointer?spotlightId=purview-switcher)，您就能輕鬆找到所需的 GCP 專案。另外，切換專案即可查看特定專案的專屬視圖及其所有子資源。

<walkthrough-project-setup></walkthrough-project-setup>

## 前往 Google Cloud 服務

### 服務導覽

您可以透過[左側導覽選單](walkthrough://spotlight-pointer?spotlightId=console-nav-menu)使用各種 Google Cloud 服務，該選單會顯示大數據、運算、網路等不同的產品領域。

### 固定顯示特定的服務

您可以讓導覽選單固定顯示您常用的服務。只要將游標移至服務項目上方，然後點選固定圖示，以後您就可以在選單頂端找到這些服務。

開啟導覽選單，並選取「**首頁**」即可繼續。

<walkthrough-menu-navigation sectionid="HOME_SECTION"></walkthrough-menu-navigation>

## 查看任何專案的高層級總覽畫面

### 首頁資訊主頁

選定 GCP 專案之後，您可以在首頁資訊主頁中查看該項專案的高層級總覽資料，包括重要指標、費用與其他實用資訊。

### 自訂

只要點選 [[自訂](walkthrough://spotlight-pointer?cssSelector=.cfc-customize-button)]，您就能打造專屬的資訊主頁。您可以選擇隱藏或顯示頁面上的任何資訊卡，也可以自由調整資訊卡的顯示順序。將游標移至資訊卡上方，即可透過溢位選單使用各資訊卡的自訂選項。

## 查看所有 GCP 資源的活動

您可以透過[活動訊息串](walkthrough://spotlight-pointer?cssSelector=.mat-tab-link:nth-of-type(2))查看 GCP 資源中的所有活動。

您可以檢視團隊成員在任何專案中更新的內容，以便追蹤問題及查核存取情況。另外，您也能在這個頁面中輕鬆篩選動態消息，準確找到所需資料。

## 在 Cloud Console 中進行搜尋

您可以透過 Google Console 中的[搜尋列](walkthrough://spotlight-pointer?cssSelector=.p6n-search-bar,.pcc-platform-bar-search-bar)快速找到各種 Google Cloud 產品及所有 GCP 資源。

請嘗試搜尋「**App Engine**」或是某項專案的名稱。

## 隨時取得支援

如果您遇到困難或是在使用 GCP 時需要幫忙，我們的支援小組很樂意為您提供協助。

[進一步瞭解支援服務](http://cloud.google.com/support)

透過導覽選單取得支援。

<walkthrough-menu-navigation sectionid="SUPPORT_SECTION"></walkthrough-menu-navigation>

## 管理使用者與權限

有了 Google Cloud Identity & Access Management (Cloud IAM)，您就能輕鬆管理及建立 GCP 資源的權限。

[進一步瞭解 IAM](https://cloud.google.com/iam/docs/)

隨著團隊不斷壯大，您可以利用「IAM 與管理」專區中的 Cloud IAM 來授予團隊成員相關存取權限。

新增使用者、使用者群組或服務帳戶，並為他們指派角色 (數量不限)，藉此授予他們所需的權限。

<walkthrough-menu-navigation sectionid="IAM_ADMIN_SECTION"></walkthrough-menu-navigation>

## 在瀏覽器中使用指令列

Google Cloud Shell 讓您可以直接在瀏覽器中使用指令列來存取您的雲端資源。這樣一來，您不需要在自有系統上安裝 Google Cloud SDK 或其他工具，也能輕鬆管理專案和資源。

在 <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[Cloud Shell](walkthrough://spotlight-pointer?spotlightId=devshell-activate-button) 的輔助下，您隨時都能使用所需的 Cloud SDK gcloud 指令列工具和其他必要公用程式。更棒的是，這些工具和程式皆會隨時更新，而且均已通過完整的驗證程序。

[進一步瞭解 Cloud Shell](https://cloud.google.com/shell/)

## 繼續您的 GCP 旅程

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

您現在應該已經熟悉 Cloud Console 的操作方式，也具備相當充分的知識，可以在探索其他服務和產品時駕輕就熟。

我們也在[這篇詳細說明文章](https://cloud.google.com/docs/)中針對產品總覽、快速入門指南和 API 參考資料等方面提供了豐富的資訊，歡迎多加利用。

返回「入門指南」頁面，即可瀏覽更多教學課程。
<walkthrough-menu-navigation sectionid="ONBOARDING_SECTION"></walkthrough-menu-navigation>

[gcp-resources]: https://cloud.google.com/resource-manager/docs/cloud-platform-resource-hierarchy
[spotlight-activity-stream]: walkthrough://spotlight-pointer?cssSelector=.mat-tab-link:nth-of-type(2)
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-customize-dashboard]: walkthrough://spotlight-pointer?cssSelector=.cfc-customize-button
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-project-select]: walkthrough://spotlight-pointer?spotlightId=purview-switcher
[spotlight-search-bar]: walkthrough://spotlight-pointer?cssSelector=.p6n-search-bar,.pcc-platform-bar-search-bar
