# App Engine Quickstart

<walkthrough-tutorial-url url="https://cloud.google.com/appengine/docs/python/quickstart"></walkthrough-tutorial-url>
<walkthrough-watcher-constant value="https://github.com/GoogleCloudPlatform/python-docs-samples" key="repo-url"></walkthrough-watcher-constant>
<walkthrough-watcher-constant value="python-docs-samples/appengine/standard/hello_world" key="repo-dir"></walkthrough-watcher-constant>

## Introduction

This tutorial shows you how to deploy a sample [Python](https://python.org/)
application to Google App Engine using the `gcloud` command.

Here are the steps that you will be taking:

  *  **Create a project**

     Projects bundle code, VMs and other resources together for easier
development and monitoring.

  *  **Build and run your 'Hello, world!' app**

     You will learn how to run your app using Google Cloud Shell, directly in your
browser. At the end you'll deploy your app to the web using the `gcloud`
command.

  *  **After the tutorial…**

     Your app will be real and you'll be able to experiment with it after you
deploy, or you can remove it and start afresh.

['Python' and the Python logos are trademarks or registered trademarks of the
Python Software Foundation.](walkthrough://footnote)

## Project setup

To deploy an application, you first need to create a project.

Google Cloud Platform organises resources into projects. This allows you to
collect all the related resources for a single application in one place.

<walkthrough-devshell-precreate></walkthrough-devshell-precreate>

<walkthrough-project-setup></walkthrough-project-setup>

## Using Google Cloud Shell

Cloud Shell is a built-in command-line tool for the console. We're going to use
Cloud Shell to deploy our app.

### Open Google Cloud Shell

Open Cloud Shell by clicking the
<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>
[icon][spotlight-open-devshell] in the navigation bar at the top of the console.

### Clone the sample code

Use Cloud Shell to clone and navigate to the 'Hello World' code. The sample code
is cloned from your project repository to the Cloud Shell.

Note: If the directory already exists, remove the previous files before cloning.

In Cloud Shell enter:

```bash
git clone {{repo-url}}
```

Then switch to the tutorial directory:

```bash
cd {{repo-dir}}
```

## Configuring your deployment

You are now in the main directory for the sample code. We'll look at the files
that configure your application.

### Exploring the application

Enter the following command to view your application code:

```bash
cat main.py
```

The application is a simple Python application that uses the
[webapp2](https://webapp2.readthedocs.io/) web framework. This Python script
responds to a request with an HTTP header and the message `Hello, World!`.

### Exploring your configuration

Google App Engine uses YAML files to specify a deployment's configuration.
`app.yaml` files contain information about your application, like the runtime
environment, URL handlers and more.

Enter the following command to view your configuration file:

```bash
cat app.yaml
```

From top to bottom, this configuration file says the following about this
application:

  *  This code runs in the `python` runtime environment.
  *  This application is `threadsafe`, so the same instance can handle several
     simultaneous requests. Threadsafe is an advanced feature and can result in
     erratic behaviour if your application is not specifically designed to be
     threadsafe.
  *  Every request to a URL whose path matches the regular expression `/.*` (all
     URLs) should be handled by the app object in the `main` Python module.

The syntax of this file is [YAML](http://www.yaml.org). For a complete list of
configuration options, see the [`app.yaml`][app-yaml-reference] reference.

## Testing your app

### Test your app on Cloud Shell

Cloud Shell lets you test your app before deploying to make sure that it's running as
intended, just like debugging on your local machine.

To test your app, enter:

```bash
dev_appserver.py $PWD
```

### Preview your app with 'Web preview'

Your app is now running on Cloud Shell. You can access the app by using [Web
preview][spotlight-web-preview]
<walkthrough-web-preview-icon></walkthrough-web-preview-icon> to connect to port
8080.

### Terminating the preview instance

Terminate the instance of the application by pressing `Ctrl+C` in the Cloud
Shell.

## Deploying to Google App Engine

### Create an application

In order to deploy your app, you need to create an app in a region:

```bash
gcloud app create
```

Note: If you've already created an app, you can skip this step.

### Deploying with Cloud Shell

You can use Cloud Shell to deploy your app. To deploy your app, enter:

```bash
gcloud app deploy app.yaml --project {{project-id}}
```

### Visit your app

Congratulations! Your app has been deployed. The default URL of your app is
[{{project-gae-url}}](http://{{project-gae-url}}). Click the URL to visit it.

### View your app's status

You can monitor the status of your app on the App Engine dashboard.

Open the [menu][spotlight-console-menu] on the left-hand side of the console.

Then, select the **App Engine** section.

<walkthrough-menu-navigation sectionid="APPENGINE_SECTION"></walkthrough-menu-navigation>

## Conclusion

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

You have successfully deployed an App Engine application!

Here are some next steps:

**Download the Google Cloud SDK and develop locally**

Install the [Google Cloud SDK][cloud-sdk-installer] on your local machine.

**Build your next application**

Learn how to use App Engine with other Google Cloud Platform products:

<walkthrough-tutorial-card label="django" url="python/django/appengine" icon="APPENGINE_SECTION">
  **Run Django**
  Develop Django apps running on App Engine.
</walkthrough-tutorial-card>

<walkthrough-tutorial-card label="datastore" url="appengine/docs/python/datastore/" icon="DATASTORE_SECTION">
  **Learn to use Cloud Datastore**
  Cloud Datastore is a highly scalable NoSQL database for your applications.
</walkthrough-tutorial-card>

[app-yaml-reference]: https://cloud.google.com/appengine/docs/standard/python/config/appref
[cloud-sdk-installer]: https://cloud.google.com/sdk/downloads#interactive
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-web-preview]: walkthrough://spotlight-pointer?spotlightId=devshell-web-preview-button
