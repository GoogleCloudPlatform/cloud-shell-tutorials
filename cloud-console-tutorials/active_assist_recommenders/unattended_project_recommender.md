# Unattended Project Recommender

The Unattended Project Recommender checks for usage activity on projects and provides recommendations that help you discover, reclaim or remove unattended projects.

This tutorial shows you how to find unattended projects in a Folder or an Org, and then how to examine usage details of identified projects.

**Time to complete**: About 5 minutes

**Prerequisites**: You need a Viewer Role, or an equivalent role for the Project, Folder or Organization you will be scanning [(see required permissions)](https://cloud.google.com/recommender/docs/unattended-project-recommender#required_iam_permissions).

## Outline

This tutorial takes you through the following steps:

- Setup of your environment
- Find unattended projects in a Folder or an Organization
- Examine usage details of individual projects that were found

To get started with this tutorial and find unattended projects, click **Start** .

## Setup

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

To begin searching for unattended projects, click **Next** 

## Find unattended projects in a Folder or an Organization

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
output="Project-ID Recommendation Priority KgCO2e Rec-ID"
operating_project=$(gcloud config get-value project)

p=$(gcloud projects list --filter="parent.id:$parent_id" --format="value(projectId)")

arr=($p)
projects=${#arr[@]}
current_project=0

for project in ${!arr[@]}; do
    recommendation=$(gcloud recommender recommendations list --project=${arr[project]} --billing-project=$operating_project --recommender=google.resourcemanager.projectUtilization.Recommender --verbosity error --format=json --location=global )

    current_project=$((current_project + 1))
    printf "Examined $current_project out of $projects projects"\\r

    if [ -z "$recommendation" ]
    then
      :
    else
      subtype=$( jq -r .[].recommenderSubtype  <<< "${recommendation}" )
      priority=$( jq -r .[].priority  <<< "${recommendation}" )
      rec_id=$( jq -r .[].name  <<< "${recommendation}" )
      carbon=$( jq -r .[].additionalImpact[0].sustainabilityProjection.kgCO2e  <<< "${recommendation}" )
      
      if [ "$carbon" == null ]; then carbon="N/A" ; fi

      if [ -z "$subtype" ]; then : 
      else 
        output="$output\n${arr[project]} $subtype $priority $carbon ${rec_id: -36}\n"
      fi
    fi   
done
echo -e $output | column -t

```

If you'd like to check a different Folder or Organization, you can set the `parent_id` session variable to a different value, and simply re-paste the script.

*Note: This script is not recursive - it will help you scan projects that are directly underneath a Folder, but will not look inside nested Folders*

*Note: If your Folder or an Organization has hundreds of projects, this script may take a long time to complete.*

To examine the usage details of unattended projects that were found, click **Next**

## Examine usage details of individual projects that were found

Now that you've identified some unattended projects, you can examine individual project's usage details.

### Select a project

To begin, use the project selector below to pick a project that was identified as unattended in your Folder/Organization scan.

*Hint: This should be an existing project, don't create a new project*

<walkthrough-project-setup></walkthrough-project-setup>

The project you selected is **{{project-id}}**. If this is blank, make sure you selected a project using the drop-down box above.

### Examine the usage details of the project you selected

With a project selected, you can copy/paste the following command to see usage details for the project.

```bash
operating_project=$(gcloud config get-value project)
gcloud recommender insights list \
    --project={{project-id}} \
    --billing-project=$operating_project \
    --insight-type=google.resourcemanager.projectUtilization.Insight \
    --location=global \
    --format=yaml
```

### In another project

To check usage details of a different project, pick a different project and re-paste the above commands (the commands update when you choose different projects).

To complete this tutorial and learn how to export recommendations at scale, click **Next**

## Congratulations!

You have successfully completed the tutorial.

You can automatically [export all recommendations from across your organization to BigQuery](https://cloud.google.com/recommender/docs/bq-export/export-recommendations-to-bq) and [use Connected Sheets to view, analyze, sort, filter and visualize](https://cloud.google.com/bigquery/docs/connected-sheets) all recommendations for your organization.

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>