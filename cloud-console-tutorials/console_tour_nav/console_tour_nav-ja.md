# Cloud Console ツアー

<walkthrough-tutorial-duration duration="5"></walkthrough-tutorial-duration>

## はじめに

このチュートリアルでは、Google Cloud Platform でアプリケーションをビルドして管理するための Cloud Console の主要機能について説明します。

次のコンセプトについて説明します。

  *  GCP プロジェクトとリソース
  *  リソースの概要とアクティビティ ログ
  *  コンソールのナビゲーションと検索
  *  ユーザーと権限の管理
  *  技術サポート
  *  GCP のブラウザベースのコマンドライン

さっそく始めましょう。

## GCP リソースの使用

GCP リソースは、すべての Google Cloud サービスを構成する基本的なコンポーネントです。リソースは階層的に編成され、GCP での作業を整理するのに役立ちます。

プロジェクトはリソース階層の最初のレベルであり、Cloud Storage バケットや Compute Engine インスタンスなどの他の下位リソースが含まれています。

[GCP リソースの詳細][gcp-resources]

### プロジェクトのナビゲーション

Cloud Console の[スコープ選択ツール][spotlight-project-select]を使用して、GCP プロジェクト間を簡単に移動できます。プロジェクトを切り替えると、そのプロジェクトとすべての子リソースに合わせてビューが調整されます。

<walkthrough-project-setup></walkthrough-project-setup>

## Google Cloud サービスの操作

### サービスのナビゲーション

Google Cloud サービスには、[ビッグデータ]、[コンピューティング]、[ネットワーキング] などのプロダクト領域別に整理されている[左側のナビゲーション メニュー][spotlight-console-menu]からアクセスできます。

### セクションの固定

定期的にアクセスするサービスは、セクション アイテムの上にカーソルを合わせて固定アイコンをクリックすることにより、ナビゲーション メニューの上部にセクションを固定できます。

ナビゲーション メニューを開き、[**ホーム**] を選択して続行します。

<walkthrough-menu-navigation sectionid="HOME_SECTION"></walkthrough-menu-navigation>

## プロジェクトの概要の参照

### ホーム ダッシュボード

ホーム ダッシュボードには、選択した GCP プロジェクトの概要が表示され、主な指標、請求などの有用な情報が目立つよう示されます。

### カスタマイズ

[[カスタマイズ][spotlight-customize-dashboard]] をクリックしてダッシュボードをカスタマイズできます。すべてのカードは、ページ上で非表示にしたり、表示したり、並べ替えたりできます。各カードには、カーソルを合わせたときに表示されるオーバーフロー メニューからアクセスできるカスタム オプションもあります。

## GCP リソース間のアクティビティの表示

[アクティビティ ストリーム][spotlight-activity-stream]を使用すると、GCP リソース全体で発生するすべてのアクティビティを 1 か所で把握できます。

同僚がプロジェクトに追加した内容を確認したり、問題を突き止めたり、アクセス履歴を確認したりします。フィードを使用してフィルタリングし、必要なものを簡単に見つけられます。

## Cloud Console の検索

Cloud Console の[検索バー][spotlight-search-bar]を使用すると、Google Cloud サービスや GCP 全体のあらゆるリソースにすばやくアクセスできます。

**App Engine** または自分のプロジェクトの名前を検索してみてください。

## サポートを利用する

作業に行き詰まった場合、または GCP の操作に関するサポートが必要な場合は、サポートチームがお手伝いします。

[サポートの詳細](http://cloud.google.com/support)

ナビゲーション メニューからサポートにアクセスします。

<walkthrough-menu-navigation sectionid="SUPPORT_SECTION"></walkthrough-menu-navigation>

## ユーザーと権限の管理

Google Cloud Identity and Access Management（Cloud IAM）では、GCP のリソースに対する権限を作成して、管理できます。

[IAM の詳細](https://cloud.google.com/iam/docs/)

チームの拡大に合わせて、[IAM と管理者] セクションで Cloud IAM を使用するチームメイトにアクセス権を付与できます。

ユーザー、グループ、またはサービス アカウントを追加し、これらに任意の数の役割を割り当て、必要とする権限を付与します。

<walkthrough-menu-navigation sectionid="IAM_ADMIN_SECTION"></walkthrough-menu-navigation>

## ブラウザからのコマンドラインへのアクセス

Google Cloud Shell ではコマンドラインを使って、ブラウザから直接クラウド リソースにアクセスできます。そのため、Google Cloud SDK などのツールをシステムにインストールしなくても、プロジェクトやリソースを簡単に管理できます。

[Cloud Shell][spotlight-open-devshell] では、必要な <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>Cloud SDK gcloud コマンドライン ツールなどのユーティリティをいつでも最新かつ認証済みの状態で使うことができます。

[Cloud Shell の詳細](https://cloud.google.com/shell/)

## GCP への移行を進める

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

新しいサービスやプロダクトを快適にご活用いただくための基盤を備えた Cloud Console と、そのナビゲーション機能について十分にご理解いただけたと思います。

Google の[詳細なドキュメント](https://cloud.google.com/docs/)にも、プロダクトの概要、クイックスタート ガイドや API のリファレンスなどの豊富な情報が記載されています。

その他のチュートリアルについては、スタートガイドのページに戻ってご覧ください。
<walkthrough-menu-navigation sectionid="ONBOARDING_SECTION"></walkthrough-menu-navigation>

[gcp-resources]: https://cloud.google.com/resource-manager/docs/cloud-platform-resource-hierarchy
[spotlight-activity-stream]: walkthrough://spotlight-pointer?cssSelector=.mat-tab-link:nth-of-type(2)
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-customize-dashboard]: walkthrough://spotlight-pointer?cssSelector=.cfc-customize-button
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-project-select]: walkthrough://spotlight-pointer?spotlightId=purview-switcher
[spotlight-search-bar]: walkthrough://spotlight-pointer?cssSelector=.p6n-search-bar,.pcc-platform-bar-search-bar
