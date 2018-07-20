# Stackdriver Debugger

## Introduction

Stackdriver Debugger lets you inspect the state of an application at any code
location without stopping or slowing down your applications.

This tutorial will guide you through the Debug interface. You will learn how to
inspect variable values using application snapshots, and you will add a new log
statement without changing the application's code.

## Project Setup

Cloud Debugger needs a project to create resources.

<walkthrough-project-setup></walkthrough-project-setup>

## Open Stackdriver Debugger

Open the [menu][spotlight-console-menu] on the left side of the console.

Scroll to find the **Stackdriver** category and select **Debug**.

<walkthrough-menu-navigation sectionId="DEBUG_SECTION"></walkthrough-menu-navigation>

## Snapshot the state of the application

### Navigate to a file

Type `markov` in the [file search][spotlight-file-search] to open the
`Markov.java` file located in `java/com/callbyreference/demos/markov/`.

You can also achieve this using the file tree on the left.

### Take a new snapshot

A snapshot captures the local variables and call stack at a specific line
location in your source code. The snapshot location applies to all running
instances of your application.

Click in the gutter of line 66 to take a new snapshot.

### Wait for the snapshot to hit

Wait until a request triggers the code at the location you set the snapshot.

### Examine the local variables

Use the **Variables** section in the right panel to click on the `markers`
variable to expand and inspect its values.

## Set log statements on the fly

Stackdriver Debugger allows you add new log statement to your application
without the need to re-deploy your code.

### Open the Logs panel

Click **Show Logs** at the bottom on the page to open the Logs panel.

### Open Google Cloud Shell

Open Cloud Shell by clicking the <walkthrough-cloud-shell-icon/>
[icon](walkthrough://spotlight-pointer?spotlightId=devshell-activate-button) in
the navigation bar at the top of the console.

### Set a logpoint

Use the `gcloud` command inside Cloud Shell to add a logpoint.

```bash
gcloud beta debug logpoints create 'MarkovServlet.java:100' 'markov size is {this.markov.n}'
```

You are adding a logpoint to line 100 of the file `MarkovServlet.java`.

### Look for the dynamically added log entries

Refresh the logs panel using the refresh button, and see the log entries created
by the logpoint you just added.

Click the **Continue** button when you are done.

### Click the file link of a log entry

Navigate to the source file and line by clicking the source link in the log
message.

## Close Cloud Shell

Close Cloud Shell and click the **Continue** button when you are done.

## Conclusion

Congratulations! You have successfully finished the Stackdriver Debugger
tutorial.

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Here's what to do next:

### Setup Stackdriver Debugger for your project

Stackdriver Debugger is already setup for App Engine applications, learn how to
setup Stackdriver Debugger other platforns in the [setup
documentation][debug-setup].

### Explore other Stackdriver tutorials

Understand your errors with the [Stackdriver Error
Reporting][error-reporting-tutorial] tutorial.

Understand your application latency with the [Stackdriver Trace][trace-tutorial]
tutorial.

[debug-setup]: https://cloud.google.com/debugger/docs/how-to
[error-reporting-tutorial]: https://cloud.google.com/error-reporting/docs/quickstart
[trace-tutorial]: https://cloud.google.com/trace/docs/quickstart
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-file-search]: walkthrough://spotlight-pointer?cssSelector=.p6n-clouddiag-debug-search-box-container
