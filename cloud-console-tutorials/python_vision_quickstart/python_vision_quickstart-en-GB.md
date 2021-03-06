# Cloud Vision API

<walkthrough-test-start-page url="/start?tutorial=python_vision_quickstart_v2"></walkthrough-test-start-page>

<walkthrough-tutorial-url url="https://cloud.google.com/vision/docs/label-tutorial"></walkthrough-tutorial-url>

<walkthrough-watcher-constant value="https://github.com/GoogleCloudPlatform/python-docs-samples.git" key="repo-url"></walkthrough-watcher-constant>

<walkthrough-watcher-constant value="python-docs-samples" key="repo-name"></walkthrough-watcher-constant>

<walkthrough-devshell-precreate></walkthrough-devshell-precreate>

## Introduction

This tutorial walks you through a basic Vision API application, using a
`LABEL_DETECTION` request. A `LABEL_DETECTION` request annotates an image with a
label (or 'tag') that is selected based on the image content. For example, a
picture of a barn may produce a label of 'barn', 'farm' or some other similar
annotation.

Here are the steps that you will be taking:

*   **Run your label detection app** You will learn how to run your app using
    Google Cloud Shell, right in your browser.
*   **After the app...** Your app will be real and you'll be able to experiment
    with it, or you can remove it and start afresh.

['Python' and the Python logos are trademarks or registered trademarks of the
Python Software Foundation.](walkthrough://footnote)

# Project setup

You will need to enable the Cloud Vision API through a project.

Google Cloud Platform organises resources into projects. This allows you to
collect all of the related resources for a single application in one place.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## Enable the Vision API

Your project must enable the Vision API to accept requests.

### Navigate to the API manager

The API manager sets which APIs are enabled for your project.

Open the
[menu](walkthrough://spotlight-pointer?spotlightId=console-nav-menu)
on the left side of the console.

Then select the **APIs & Services** section.

<walkthrough-menu-navigation sectionid="API_SECTION"></walkthrough-menu-navigation>

### View available APIs

To enable APIs, click the [Enable API](walkthrough://spotlight-pointer?cssSelector=.p6n-action-bar-button) button.

### Select Vision API

Click on the [Vision API](walkthrough://spotlight-pointer?spotlightId=api-vision.googleapis.com)link.

### Enable Vision API

To enable the Vision API, click the
[Enable](walkthrough://spotlight-pointer?spotlightId=api-enable-vision.googleapis.com)
button. You will create credentials for your project later in this tutorial.

## Using Google Cloud Shell

Cloud Shell is a built-in, command-line tool for the console. You're going to
use Cloud Shell to run your app.

### Open Google Cloud Shell

Open Cloud Shell by clicking the
<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>
[icon](walkthrough://spotlight-pointer?spotlightId=devshell-activate-button)
in the navigation bar at the top of the console.

### Clone the sample code

Use Cloud Shell to clone and navigate to the 'Hello World' code. The sample code
is cloned from your project repository to the Cloud Shell.

Note: If the directory already exists, remove the previous files before cloning:

```bash
rm -rf {{repo-name}}
```

Clone a sample repository:

```bash
git clone {{repo-url}}
```

Then switch to the tutorial directory:

```bash
cd {{repo-name}}/vision/cloud-client/quickstart
```

## Configuring your deployment

You are now in the main directory for the sample code. You'll look at the files
that configure your application.

### Exploring the application

Enter the following command to view your application code:

```bash
cat quickstart.py
```

The `quickstart.py` file formats your request information, like the request type
and content. Expand each section below to learn about the details.

Requests to the Vision API are provided as JSON objects. See the [Vision API
Reference][vision-request-doc] for complete information on the specific
structure of such a request. Your JSON request is only sent when you call
`execute`. This pattern allows you to pass around such requests and call
`execute` as needed.

## Testing the application

In order to use the API, you need to set up credentials. To use a Cloud API, you
will need to set up the proper [credentials][auth-doc] for your application.
This will enable your application to authenticate its identity to the service
and to obtain authorisation to perform tasks. Then you will test the API with
sample images.

### Create a service account

You need to create a service account to authenticate your API requests. If you
already have the service account created, it will be reused.

```bash
gcloud iam service-accounts create vision-quickstart
```

### Create credentials

Next, create a service account key and set it as your default credentials.

```bash
gcloud iam service-accounts keys create key.json --iam-account \
  vision-quickstart@{{project-id}}.iam.gserviceaccount.com
```

```bash
export GOOGLE_APPLICATION_CREDENTIALS=key.json
```

<walkthrough-test-code-output text="created key"></walkthrough-test-code-output>

### Test your app

To test your app with a sample image enter:

```bash
python quickstart.py
```

The image resource, `resources/wakeupcat.jpg`, is specified in the source.
([View image][cat-picture])

## Conclusion

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Congratulations! You are ready to use the Cloud Vision API.

Here's what you can do next:

*   Work through the [face detection][face-tutorial] tutorial.
*   Try the [document text][document-text-tutorial] tutorial.
*   See the [sample applications][vision-samples].
*   Download the [Google Cloud SDK][get-cloud-sdk] to run on your local machine.

[auth-doc]: https://cloud.google.com/vision/docs/auth
[cat-picture]: https://raw.githubusercontent.com/GoogleCloudPlatform/python-docs-samples/master/vision/cloud-client/quickstart/resources/wakeupcat.jpg
[document-text-tutorial]: https://cloud.google.com/vision/docs/fulltext-annotations
[face-tutorial]: https://cloud.google.com/vision/docs/face-tutorial
[get-cloud-sdk]: https://cloud.google.com/sdk/
[vision-request-doc]: https://cloud.google.com/vision/reference/rest
[vision-samples]: https://cloud.google.com/vision/docs/samples
