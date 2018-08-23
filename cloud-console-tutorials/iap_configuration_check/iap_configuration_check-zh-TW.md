# 開啟 GCE/GKE 的 IAP

Identity-Aware Proxy (IAP) 僅能保護通過負載平衡器的資料流量。請按照下列步驟操作，以免未獲授權的行為對您的應用程式發動惡意攻擊。

[瞭解詳情](https://cloud.google.com/iap/docs/)

## 您必須完成下列步驟：

### 檢查網路設定

如果無法透過 `130.211.0.0/22` 和 `35.191.0.0/16` 這兩個負載平衡器 IP 連線到您的後端系統，則 IAP 將**無法運作**。

如果其他 IP 可以存取您的後端系統，其資料流量將略過您的 IAP 存取權政策。在某些情況下，這項設定會相當實用，例如您可能會想允許監控系統連線至您的後端。

### 監控網路設定

如果您在啟用 IAP 之後變更設定，可能會影響安全性。不過請放心，只要您部署 [Forseti Security][forseti-security] (由 Google 負責維護的開放原始碼工具)，即可持續監控專案設定與傳送通知。

### 檢查標頭是否經過簽署

[瞭解](https://cloud.google.com/iap/docs/signed-headers-howto)如何防止他人在規避 IAP 存取權政策的情況下存取您的應用程式，可能的情境包括：

  *  專案管理員意外停用了 IAP
  *  網路設定錯誤
  *  使用者登入 VM，並透過本機主機連線至網路伺服器

### 聲明設定

您同意您已詳閱相關規定，並根據說明文件中的指示設定 GCE/GKE 資源。

[操作示範](逐步操作說明：//spotlight-pointer?spotlightId=iap-network-config-reviewed)

[forseti-security]: https://opensource.google.com/projects/forseti-security
[spotlight-config-reviewed]: walkthrough://spotlight-pointer?spotlightId=iap-network-config-reviewed
