# Unattended Project Recommender

The Unattended Project Recommender checks for usage activity on projects and provides recommendations that help you discover, reclaim or remove unattended projects.

## Setup

### Pick your operating project

You will use this project to enable, and make calls to, the Recommender API.

<walkthrough-project-setup billing="true"></walkthrough-project-setup>

The project you selected is **{{project-id}}**. If this is blank, make sure you selected a project using the dropdown box above.

With a project picked, set it for the `gcloud config` context by pasting and running the following command in your Cloud Shell:

```bash
gcloud config set project {{project-id}}
```

### Enable the Recommender API

You need to enable the Recommender API in this project. You only need to do this once for your operating project.

<walkthrough-enable-apis apis="recommender.googleapis.com"></walkthrough-enable-apis> 

## Check for Unattended Project recommendations

### In your operating project

#### Permissions?

To check whether you have an Unattended Project recommendation for your project, paste and run the following code into your Cloud Shell:

```bash
operating_project=$(gcloud config get-value project)
gcloud recommender recommendations list \
    --project={{project-id}} \
    --billing-project=$operating_project \
    --recommender=google.resourcemanager.projectUtilization.Recommender \
    --location=global
```

### In another project

#### Permissions?

To check for recommendations in a different project, pick a different project and re-paste the above commands (the commands update when you choose different projects):

<walkthrough-project-setup></walkthrough-project-setup>

What if you wanted to find all projects with a recommendation in a Folder, or even an Org? Click Next to see how.

## Find projects with recommendations in a Folder or even an Org

You can find all Projects that belong to a given Folder or an Org, and then recursively call the Recommender API to identify Unattended projects.

#### Permissions?

To start, set the session variable `parent_id` to the numeric ID of a Folder or an Org that you want to scan. Paste the following command into your Cloud Shell and replace with the Folder or Org ID as needed. 

```bash
parent_id=<replace with folder/org ID>
```

You can use the project picker to find and Copy the ID:
<walkthrough-project-setup></walkthrough-project-setup>

```bash


```