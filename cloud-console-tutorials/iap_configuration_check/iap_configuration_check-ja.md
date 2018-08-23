# GCE/GKE の IAP の有効化

Identity-Aware Proxy（IAP）は、ロードバランサを通過するトラフィックのみを保護します。不正な攻撃からアプリを保護するには、次の手順に沿って操作します。

[詳細](https://cloud.google.com/iap/docs/)

## 実行手順:

### ネットワーク構成を確認する

ロードバランサの IP（`130.211.0.0/22` と `35.191.0.0/16`）がバックエンドに到達できない場合、IAP は**機能しません**。

他のいずれかの IP からバックエンドにアクセスできる場合、そのトラフィックは IAP アクセス ポリシーを迂回します。モニタリング システムからバックエンドへの接続を許可する場合など、特定のアクセスではこの動作が役立つことがあります。

### ネットワーク構成をモニタリングする

IAP を有効にした後で構成を変更すると、安全性が損なわれる場合があります。Google が管理するオープンソース ツールの [Forseti Security][forseti-security] をデプロイして、プロジェクトの構成を継続的にモニタリングし、通知を送信してください。

### 署名済みヘッダーのチェックを実行する

次の場合のように、IAP アクセス ポリシーが迂回されることがないよう[アプリを保護する方法](https://cloud.google.com/iap/docs/signed-headers-howto)をご覧ください。

  *  プロジェクト管理者が IAP を誤って無効にする
  *  ネットワーク構成エラー
  *  ユーザーが VM にログインし、localhost を介してウェブサーバーに接続する

### 構成の表明

ドキュメントに従って GCE/GKE リソースを参照し、構成したことに同意します。

[手順を見る][spotlight-config-reviewed]

[forseti-security]: https://opensource.google.com/projects/forseti-security
[spotlight-config-reviewed]: walkthrough://spotlight-pointer?spotlightId=iap-network-config-reviewed
