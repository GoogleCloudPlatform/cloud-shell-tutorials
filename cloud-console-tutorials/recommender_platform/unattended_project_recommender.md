# Unattended Project Recommender

The Unattended Project Recommender checks for usage activity on projects and provides recommendations that help you discover, reclaim or remove unattended projects.

This tutorial shows you how to check if a single project is unattended, as well as a collection of projects in a Folder and even the entire Organization.

**Time to complete**: About 10 minutes

**Prerequisites**: You need a Viewer Role, or an equivalent role for the Project / Folder / Organization you will be scanning [(see required permissions)](https://cloud.google.com/recommender/docs/unattended-project-recommender#required_iam_permissions).

## Outline

This tutorial takes you through the following steps:

- Setup
- Check for a recommendation in a single project
- Check for recommendations for all projects in a Folder/Organization

Click the **Start** button below to get going.

## Setup

### Log in

You need to authenticate to `gcloud` to be able to complete the tutorial.

Paste the following command into your Cloud Shell and go through the login flow:

```bash
gcloud auth login
```


### Pick your operating project

You will use this project to enable, and make calls to, the Recommender API, instead of enabling the API in every project you want to examine.

*Hint: this should be a project where you are an Owner or otherwise have permissions to enable APIs.*

<walkthrough-project-setup billing="true"></walkthrough-project-setup>

The project you selected is **{{project-id}}**. If this is blank, make sure you selected a project using the dropdown box above.

With a project selected, set it for the `gcloud config` context by pasting and running the following command in your Cloud Shell:

```bash
gcloud config set project {{project-id}}
```

### Enable the Recommender API

You need to enable the Recommender API in this project. You only need to do this once for your operating project.

<walkthrough-enable-apis apis="recommender.googleapis.com"></walkthrough-enable-apis> 

Click **Next** to begin checking if your projects are unattended.

## Check for Unattended Project recommendations

### In your operating project

To check whether you have an Unattended Project recommendation for your project, paste and run the following code into your Cloud Shell:

```bash
operating_project=$(gcloud config get-value project)
gcloud recommender recommendations list \
    --project={{project-id}} \
    --billing-project=$operating_project \
    --recommender=google.resourcemanager.projectUtilization.Recommender \
    --location=global
```

If the output says `Listed 0 items.`, this means that the project is not unattended. Let's try a different project next.

### In another project

To check for recommendations in a different project, pick a different project and re-paste the above commands (the commands update when you choose different projects):

<walkthrough-project-setup></walkthrough-project-setup>

What if you wanted to find all projects with a recommendation in a Folder, or even an Organization? Click **Next** to see how.

## Find projects with recommendations in a Folder or even an Organization

You can find all Projects in a given Folder or an Organization, and then recursively call the Recommender API to identify Unattended projects.

### Identify the Folder/Organization ID you'd like to scan recursively

To start, set the session variable `parent_id` to the numeric ID of a Folder or an Organization that you want to scan. Paste the following command into your Cloud Shell and replace with the Folder or Organization ID as needed. 

The command should look something like `export parent_id=1234567890`

*Hint: you can find the required Folder/Org ID with the <walkthrough-spotlight-pointer spotlightId="purview-switcher">Project Picker</walkthrough-spotlight-pointer> in your Cloud Console.*

```bash
export parent_id=<REPLACE WITH FOLDER/ORG NUMERIC ID>
```

### Find unattended projects in the selected Folder/Organization

With the session variable set to your Folder/Organization ID, the script below will:
- find all projects under the Folder/Organization ID you specified
- iteratively check for unattended project recommendations in each project

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

If you'd like to check a different Folder/Organization, you can set the `parent_id` session variable to a different value, and simply re-run the script.

If your Folder or an Organization has hundreds of projects, this script may take a long time to complete. Click **Next** to learn how to export recommendations at scale and to complete the tutorial.

## Congratulations!

You have successfully clicked **Next** enough times to get to the end of this tutorial.

You can automatically [export all recommendations from across your organization to BigQuery](https://cloud.google.com/recommender/docs/bq-export/export-recommendations-to-bq) and then [use Connected Sheets to view/analyze/sort/filter/visualize](https://cloud.google.com/bigquery/docs/connected-sheets) all recommendations for your organization.

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>