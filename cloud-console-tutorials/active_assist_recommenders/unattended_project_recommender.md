# Unattended Project Recommender

The Unattended Project Recommender checks for usage activity on projects and provides recommendations that help you discover, reclaim or remove unattended projects.

This tutorial shows you how to check if a single project is unattended, as well as a collection of projects in a Folder and even the entire Organization.

**Time to complete**: About 5 minutes

**Prerequisites**: You need a Viewer Role, or an equivalent role for the Project, Folder or Organization you will be scanning [(see required permissions)](https://cloud.google.com/recommender/docs/unattended-project-recommender#required_iam_permissions).

## Outline

This tutorial takes you through the following steps:

- Setup of your environment
- Checking for a recommendation in a single project
- Checking for recommendations for all projects in a Folder or an Organization

To get started with this tutorial and find unattended projects, click **Start** .

## Setup

### Sign in

You need to authenticate to `gcloud` to be able to complete the tutorial.

Paste the following command into your Cloud Shell and go through the sign in flow:

```bash
gcloud auth login
```


### Pick your operating project

You will use this project to enable and make calls to the Recommender API, instead of enabling the API in every project you want to examine.

*Hint: this should be an existing project where you are an Owner, or otherwise have permissions to enable APIs.*

<walkthrough-project-setup billing="true"></walkthrough-project-setup>

The project you selected is **{{project-id}}**. If this is blank, make sure you selected a project using the drop-down box above.

With a project selected, set it for the `gcloud config` context by pasting and running the following command in your Cloud Shell:

```bash
gcloud config set project {{project-id}}
```

### Enable the Recommender API

You need to enable the Recommender API in this project. You only need to do this once for your operating project.

<walkthrough-enable-apis apis="recommender.googleapis.com"></walkthrough-enable-apis> 

To begin checking for unattended projects, click **Next** 

## Check for unattended project recommendations

### In your operating project

To check whether you have an unattended project recommendation in your project, paste and run the following code into your Cloud Shell:

```bash
operating_project=$(gcloud config get-value project)
gcloud recommender recommendations list \
    --project={{project-id}} \
    --billing-project=$operating_project \
    --recommender=google.resourcemanager.projectUtilization.Recommender \
    --location=global
```

If the output says `Listed 0 items.`, this means that the project is actively used or the project is not older than 30 days. This makes sense if you picked an existing project that you actively use. Let's try a different project next.

### In another project

To check for recommendations in a different project, pick a different project and re-paste the above commands (the commands update when you choose different projects):

*Hint: This should be an existing project, don't create a new project*

<walkthrough-project-setup></walkthrough-project-setup>

What if you wanted to find all projects with a recommendation in a Folder, or even an Organization? 

To find all projects with recommendations in folders or organizations, click **Next**

## Find projects with recommendations in a Folder or even an Organization

You can find all projects in a given Folder or an Organization, and then iteratively call the Recommender API to identify unattended projects.

### Specify the Folder or Organization ID you'd like to scan

Set the session variable `parent_id` to the numeric ID of a Folder or an Organization that you want to scan. Paste the following command into your Cloud Shell and replace with the Folder or Organization ID as needed. 

The command should look something like `export parent_id=1234567890`

*Hint: You can find the required Folder or Org ID with the <walkthrough-spotlight-pointer spotlightId="purview-switcher">Project Picker</walkthrough-spotlight-pointer> in your Cloud Console.*

```sh
export parent_id=<FOLDER/ORG_ID>
```

### Find unattended projects in the specified Folder or Organization

With the session variable set to your Folder or Organization ID, the script below will:
- Find projects under the Folder or Organization ID you specified
- Iteratively check for unattended project recommendations in each project

Copy this script, paste it in your Cloud Shell and hit Enter:

```none
operating_project=$(gcloud config get-value project)
for project in $(gcloud projects list --filter="parent.id:$parent_id" --format="value(projectId)") 
do
    recommendation_id=$(gcloud recommender recommendations list --project=$project --billing-project=$operating_project --recommender=google.resourcemanager.projectUtilization.Recommender --verbosity error --format="value(RECOMMENDATION_ID)" --location=global )
    
    if [ -z "$recommendation_id" ]
    then
       :
    else
       subtype=$(gcloud recommender recommendations describe $recommendation_id --project=$project --billing-project=$operating_project --recommender=google.resourcemanager.projectUtilization.Recommender --location=global | sed 's/\|/ /' | awk '/recommenderSubtype:/ {print $2}')

      if [ -z "$subtype" ]; then : 
      else printf "Project ID:  $project\nRecommendation: $subtype\n \n"
      fi
    fi
done
```

If you'd like to check a different Folder or Organization, you can set the `parent_id` session variable to a different value, and simply re-run the script.

*Note: This script is not recursive - it will help you scan projects that are directly underneath a Folder, but will not look inside nested Folders*

If your Folder or an Organization has hundreds of projects, this script may take a long time to complete. 

To complete this tutorial and learn how to export recommendations at scale, click **Next**

## Congratulations!

You have successfully completed the tutorial.

You can automatically [export all recommendations from across your organization to BigQuery](https://cloud.google.com/recommender/docs/bq-export/export-recommendations-to-bq) and [use Connected Sheets to view, analyze, sort, filter and visualize](https://cloud.google.com/bigquery/docs/connected-sheets) all recommendations for your organization.

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>