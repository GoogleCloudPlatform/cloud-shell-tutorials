# Stackdriver Error Reporting

## 简介

Stackdriver Error Reporting 可汇总并显示云端服务所产生的错误。

本教程将引导您熟悉 Error Reporting 网页界面。您将了解如何列出应用错误、查看错误详情以及采取相应措施。

## 项目设置

<walkthrough-project-setup></walkthrough-project-setup>

## 生成错误

在继续操作之前，您需要报告一些虚构的错误。您将使用 `gcloud` 命令来实现这一点。

在真实场景中，系统会直接从您正在运行的应用中报告此类错误。在完成本教程的学习后，您可以详细了解如何设置 Error Reporting。

### 打开 Google Cloud Shell

点击控制台顶部导航栏中的相应<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>[图标][spotlight-open-devshell]即可打开 Cloud Shell。

### 报告一些错误

点击以下脚本右上角的**复制到剪贴板**按钮，然后在 Cloud Shell 中执行该脚本以生成示例错误。

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

### 关闭 Cloud Shell

完成后，关闭 Cloud Shell 并点击“继续”**。

## 列出您的应用错误

您将使用 Stackdriver Error Reporting 快速查看已报告的错误。

### 打开 Error Reporting

打开控制台左侧的[菜单][spotlight-console-menu]。

然后，滚动到 **Stackdriver** 类别并选择 **Error Reporting**。

<walkthrough-menu-navigation sectionid="CRASH_SECTION"></walkthrough-menu-navigation>

### 按“首次出现时间”排序**

系统会通过分析相应的堆栈跟踪来对应用中出现的错误进行分组和去重。通过此列表中每个条目所提供的摘要信息，您可以确定应用何时开始出现相关错误，错误出现的频率有多高，以及最近一次出现在什么时候。

默认排序依据为“出现次数”**。点击“首次出现时间”列标题可查看最近开始出现的错误。**

### 选择在有新错误出现时接收通知

当项目中出现新错误时，系统可发送一封电子邮件和一则移动设备推送通知。要选择接收这些通知，请点击“开启通知”**。

完成后点击“继续”**。

## 了解错误详情

### 打开错误报告

点击此列表中的某个错误即可查看其详细信息。

### 将问题关联至此错误

在此页面上，您可以查看特定错误的相关信息和历史记录。

了解新错误后，下一步通常是在团队的问题跟踪器中提交一个问题。您可以将自己的问题跟踪器条目关联至 Stackdriver Error Reporting 中的相应错误。

如需关联，请执行以下操作：

  *  点击顶部的“关联到问题”**（您可能需要打开**更多操作**菜单才能看到此链接）。
  *  在对话框中输入 `http://example.com/issues/1234`。
  *  点击“保存”**。

### 查看堆栈跟踪

为了让您专心处理自己的代码，我们会将并非来自您的应用代码的堆栈跟踪帧隐藏起来。

点击错误示例中的“全部显示”**即可显示框架堆栈帧。

## 总结

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

恭喜！您已成功完成 Stackdriver Error Reporting 教程的学习。

接下来，您可以执行以下操作：

### 为您的项目设置 Error Reporting

请查阅[设置文档][errors-setup]了解如何为运行中的服务设置 Error Reporting。

### 浏览其他 Stackdriver 教程

参阅 [Stackdriver Debugger][debug-quickstart] 快速入门对生产环境中的应用进行调试。

参阅 [Stackdriver Trace][trace-quickstart] 快速入门了解应用的延迟时间。

[debug-quickstart]: https://cloud.google.com/debugger/docs/quickstart
[errors-setup]: https://cloud.google.com/error-reporting/docs/how-to
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[trace-quickstart]: https://cloud.google.com/trace/docs/quickstart
