# Stackdriver Error Reporting

## Introduction

Stackdriver Error Reporting aggregates and displays errors produced by cloud
services.

This tutorial will guide you through the Error Reporting web interface. You will
learn how to list your application errors, see more details about them, and take
actions.

## Project Setup

<walkthrough-project-setup></walkthrough-project-setup>

## Generate errors

Before you continue, you need to report artificial errors. You'll use a `gcloud`
command to achieve this.

In a real scenario, these errors would be reported directly from your running
application. After this tutorial, you can learn more about how to set up Error
Reporting.

### Open Google Cloud Shell

Open Cloud Shell by clicking
<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>
[icon][spotlight-open-devshell] in the navigation bar at the top of the console.

### Report a few errors

Click the **Copy to clipboard** button at the top right of the following script
and execute it in Cloud Shell to generate sample errors.

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

### Close Cloud Shell

Close Cloud Shell and click *Continue* when you're done.

## List your application errors

You'll use Stackdriver Error Reporting to see the reported errors at a glance.

### Open Error Reporting

Open the [menu][spotlight-console-menu] on the left side of the console.

Then, scroll to the **Stackdriver** category, and select **Error Reporting**.

<walkthrough-menu-navigation sectionId="CRASH_SECTION"></walkthrough-menu-navigation>

### Sort by *First seen*

Errors occurring in your application are grouped and de-duplicated by analyzing
their stack traces. Each entry in this list provides a summary that helps you
determine when the application started to produce the error, how often it
occurred, and how recently it occurred.

The default sorting is *Occurrences*. Click the *First seen* column header to
see the errors that recently started to occur.

### Opt-in to be notified on new errors

An email and a mobile push notification can be sent when a newly seen error
occurs in the project. To opt-in to these notifications, click *Turn on
notifications*.

Click *Continue* when you're done.

## Understand the details of an error

### Open an error report

Click an error from this list to see its details.

### Link an issue to this error

Use this page to examine the information and history of a specific error.

After looking at a new error, a common next step is to file a issue in your
team's issue tracker. Your issue tracker entry can be linked back to the error
in Stackdriver Error Reporting.

To do so:

*   Click *Link to issue* at the top (you may need to open the **more actions**
    menu to see this link).
*   Enter `http://example.com/issues/1234` in the dialog.
*   Click *Save*.

### Explore stack traces

To help you focus on your code, we hide the stack trace frames that are not from
your application's code.

Click *Show all* in an error sample to display the framework stack frames.

## Conclusion

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Congratulations! You have successfully finished the Stackdriver Error Reporting
tutorial.

Here's what you can do next:

### Set up Error Reporting for your project

Learn how to set up Error Reporting for your running services in the [setup
documentation][errors-setup].

### Explore other Stackdriver tutorials

Debug a production application with the [Stackdriver Debugger][debug-quickstart]
quickstart.

Understand your application latency with the [Stackdriver
Trace][trace-quickstart] quickstart.

[errors-setup]: https://cloud.google.com/error-reporting/docs/how-to
[debug-quickstart]: https://cloud.google.com/debugger/docs/quickstart
[trace-quickstart]: https://cloud.google.com/trace/docs/quickstart
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
