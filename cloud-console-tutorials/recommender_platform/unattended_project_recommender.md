# Unattended Project Recommender

The Unattended Project Recommender checks for usage activity on projects and provides recommendations that help you discover, reclaim or remove unattended projects.

This tutorial shows you how to check if a single project is unattended, as well as a collection of projects in a Folder and even the entire Organization.

**Time to complete**: About 10 minutes

**Prerequisites**: You need a Viewer Role, or an equivalent role for the Project / Folder / Org you will be scanning [(see required permissions)](https://cloud.google.com/recommender/docs/unattended-project-recommender#required_iam_permissions).

## Outline

This tutorial takes you through the following steps:

- Setup
- Check for a recommendation in a single project
- Check for recommendations for all projects in a Folder/Org

Click the **Start** button below to get going.

## Setup

### Log in

You need to authenticate to `gcloud` to be able to complete the tutorial.

Paste the following command into your Cloud Shell and go through the login flow:

```bash
gcloud auth login
```


### Pick your operating project

You will use this project to enable, and make calls to, the Recommender API.

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

The output most likely says `Listed 0 items.` This means that the project is not unattended. Let's try a different project next.

### In another project

To check for recommendations in a different project, pick a different project and re-paste the above commands (the commands update when you choose different projects):

<walkthrough-project-setup></walkthrough-project-setup>

What if you wanted to find all projects with a recommendation in a Folder, or even an Org? Click **Next** to see how.

## Find projects with recommendations in a Folder or even an Org

You can find all Projects in a given Folder or an Org, and then recursively call the Recommender API to identify Unattended projects.

### Identify the Folder/Org ID you'd like to scan recursively

To start, set the session variable `parent_id` to the numeric ID of a Folder or an Org that you want to scan. Paste the following command into your Cloud Shell and replace with the Folder or Org ID as needed. 

The command should look something like `export parent_id=1234567890`

*Hint: you can use the <walkthrough-spotlight-pointer spotlightId="purview-switcher">Project Picker</walkthrough-spotlight-pointer> in your Cloud Console to get the required Folder/Org ID.*

```bash
export parent_id=<REPLACE WITH FOLDER/ORG NUMERIC ID>
```

### Find unattended projects in the selected Folder/Org

With the session variable set to your Folder/Org ID, the script below will:
- find all projects under the Folder/Org ID you specified
- recursively check for an unattended project recommendation in each project


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
      else echo "ProjectId:  $project  Recommendation: $subtype"
      fi
    fi
done
```

If you'd like to check a different Folder/Org, you can set `parent_id` session variable again, and simply re-run the script.

Click **Next** to complete this tutorial.

## Congratulations!

You have successfully clicked **Next** enough times to get to the end of this tutorial.

The script you ran to find unattended projects in a Folder/Org may take a long time to complete if you have hundreds of projects. In this case, you can automatically [export all recommendations from across your org to BigQuery](https://cloud.google.com/recommender/docs/bq-export/export-recommendations-to-bq) and then [use Connected Sheets to view/analyze/sort/filter](https://cloud.google.com/bigquery/docs/connected-sheets) the variety of recommendations produced.

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>