# Stackdriver Error Reporting

## はじめに

Stackdriver Error Reporting はクラウド サービスによって生成されたエラーを集計して表示します。

このチュートリアルでは、Error Reporting ウェブ インターフェースについて説明します。アプリケーションのエラーをリストし、それらの詳細を参照し、エラーに対処する方法を学習します。

## プロジェクトのセットアップ

<walkthrough-project-setup></walkthrough-project-setup>

## エラーの生成

まず最初に、人為的なエラーを報告する必要があります。そのために、`gcloud` コマンドを使用します。

実際のシナリオでは、エラーは実行中のアプリケーションから直接報告されます。このチュートリアルの後、Error Reporting の設定方法の詳細について学ぶことができます。

### Google Cloud Shell を開く

コンソールの上部にあるナビゲーション バーの<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[アイコン][spotlight-open-devshell]をクリックして、Cloud Shell を開きます。

### いくつかのエラーの報告

次のスクリプトの右上にある [**クリップボードにコピー**] ボタンをクリックし、Cloud Shell でスクリプトを実行してサンプルエラーを生成します。

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

### Cloud Shell を閉じる

完了したら、Cloud Shell を閉じて [*続行*] をクリックします。

## アプリケーション エラーの一覧表示

Stackdriver Error Reporting を使用して、報告されたエラーを一目で確認します。

### Error Reporting を開く

コンソールの左側にある[メニュー][spotlight-console-menu]を開きます。

次に、**Stackdriver** カテゴリまでスクロールし、[**Error Reporting**] を選択します。

<walkthrough-menu-navigation sectionid="CRASH_SECTION"></walkthrough-menu-navigation>

### **初回検知による並べ替え

アプリケーションで発生したエラーは、スタック トレースを分析することによってグループ化され、重複が排除されます。このリストの各項目には、アプリケーションがエラーを生成し始めた時期、発生頻度、最近の発生状況を判断するのに役立つ要約があります。

デフォルトの並べ替え順は [*発生回数*] です。**[初回検知] 列見出しをクリックすると、最近発生し始めたエラーが表示されます。

### 新しいエラーに関する通知の有効化

プロジェクトで新しいエラーが検知されたときに、メールとモバイル プッシュ通知を送信できます。これらの通知を有効にするには、[*通知をオンにする*] をクリックします。

完了したら、**[続行] をクリックします。

## エラーの詳細について理解する

### エラーレポートを開く

リスト内のエラーをクリックして、詳細を表示します。

### 問題をこのエラーにリンク

このページを使用して、特定のエラーの情報や履歴を調べます。

新しいエラーを確認した後の一般的な次のステップは、チームのバグトラッカーに問題を入力することです。バグトラッカーのエントリは Stackdriver Error Reporting のエラーにリンクできます。

方法は次のとおりです。

  *  上部の [*問題にリンク*] をクリックします（このリンクを表示するには、[**その他の操作**] メニューを開く必要がある場合があります）。
  *  ダイアログに `http://example.com/issues/1234` と入力します。
  *  [*保存*] をクリックします。

### スタック トレースの調査

コードに専念できるようにするために、アプリケーションのコードに由来しないスタック トレース フレームは非表示になっています。

エラーサンプルの **[すべて表示] をクリックして、フレームワーク スタック フレームを表示します。

## まとめ

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

これで、Stackdriver Error Reporting のチュートリアルは終了しました。

次にできる操作:

### プロジェクトの Error Reporting を設定する

実行中のサービスの Error Reporting を設定する方法については、[セットアップ文書][errors-setup]を参照してください。

### Stackdriver チュートリアルを調べる

[Stackdriver Debugger][debug-quickstart] クイックスタートを使用して本番環境アプリケーションをデバッグします。

[Stackdriver Trace][trace-quickstart] クイックスタートを使用して、アプリケーションのレイテンシを確認します。

[debug-quickstart]: https://cloud.google.com/debugger/docs/quickstart
[errors-setup]: https://cloud.google.com/error-reporting/docs/how-to
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[trace-quickstart]: https://cloud.google.com/trace/docs/quickstart
