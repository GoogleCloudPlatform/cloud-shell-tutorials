# Cloud Console Tour

<walkthrough-tutorial-duration duration="5"></walkthrough-tutorial-duration>

## Introduction

This tutorial covers the core features of Cloud Console to get you ready to
build and manage your applications on Google Cloud Platform.

You'll learn about the following concepts:

-   GCP projects and resources
-   High-level resource overview and activity logs
-   Console navigation and search
-   User and permissions management
-   Technical support
-   GCP's browser-based command line

Let's get started!

## Use GCP Resources

GCP resources are the fundamental components that make up all Google Cloud
services. Resources are organized hierarchically and help organize your work on
GCP.

Projects are the first level of the resource hierarchy, and they contain other
low-level resources like Cloud Storage buckets and Compute Engine instances.

[Learn more about GCP resources][gcp-resources]

### Project navigation

Easily navigate across your GCP projects using the [scope
picker][spotlight-project-select] in Cloud Console. Switching projects will
tailor the view to that project and all of its child resources.

<walkthrough-project-setup></walkthrough-project-setup>

## Navigate Google Cloud Services

### Service navigation

Google Cloud services are accessible in the [left-hand navigation
menu][spotlight-console-menu] organized by product area including Big Data,
Compute, Networking, etc.

### Section pinning

For any service that you visit regularly, pin the section to the top of the
navigation menu by hovering over the section item and clicking the pin icon.

Open the navigation menu and select **Home** to continue.

<walkthrough-menu-navigation sectionId="HOME_SECTION"></walkthrough-menu-navigation>

## See a high-level overview of any project

### Home dashboard

The Home dashboard provides a high-level overview of the selected GCP project,
highlighting key metrics, billing, and other useful information.

### Customization

You can customize your dashboard by clicking
[Customize][spotlight-customize-dashboard]. Any card can be hidden, shown, and
reordered on the page. Each card also has custom options accessible from the
overflow menu when hovering a card.

## View activity across your GCP resources

With [Activity Stream][spotlight-activity-stream], you'll be able to understand
all the activities that occur across your GCP resources in one place.

See what your teammates are updating in any project to track down issues and
audit access. Easily filter through the feed to find exactly what you need.

## Search across Cloud Console

The [search bar][spotlight-search-bar] in Cloud Console allows you to quickly
access Google Cloud products and any of your resources across GCP.

Try running a search for **App Engine** or the name of one of your projects.

## Get support anytime

If you ever get stuck, or need help navigating the world of GCP, our support
team is here to help.

[Learn more about Support](http://cloud.google.com/support)

Access support from the navigation menu.

<walkthrough-menu-navigation sectionId="SUPPORT_SECTION"></walkthrough-menu-navigation>

## Manage users and permissions

Google Cloud Identity and Access Management (Cloud IAM) enables you to manage
and create permissions for your GCP resources.

[Learn more about IAM](https://cloud.google.com/iam/docs/)

As your team continues to grow, you can grant access to teammates using Cloud
IAM in the "IAM & Admin" section.

Add users, groups, or service accounts and assign them any number of roles to
grant them the permissions they need.

<walkthrough-menu-navigation sectionId="IAM_ADMIN_SECTION"></walkthrough-menu-navigation>

## Access the command line from your browser

Google Cloud Shell provides you with command-line access to your cloud resources
directly from your browser. You can easily manage your projects and resources
without having to install the Google Cloud SDK or other tools on your system.

With <walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon> [Cloud
Shell][spotlight-open-devshell], the Cloud SDK gcloud command-line tool and
other utilities you need are always available, up to date and fully
authenticated when you need them.

[Learn more about Cloud Shell](https://cloud.google.com/shell/)

## Continue on your GCP journey

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

You should now have a good feel for navigating Cloud Console with a solid
foundation for exploring new services and products.

Our [detailed documentation](https://cloud.google.com/docs/) also provides a
wealth of information from product overviews to quickstart guides and API
reference.

Head back to the Getting Started page for more tutorials.
<walkthrough-menu-navigation sectionId="ONBOARDING_SECTION"></walkthrough-menu-navigation>

[gcp-resources]: https://cloud.google.com/resource-manager/docs/cloud-platform-resource-hierarchy
[spotlight-project-select]: walkthrough://spotlight-pointer?spotlightId=purview-switcher
[spotlight-console-menu]: walkthrough://spotlight-pointer?spotlightId=console-nav-menu
[spotlight-customize-dashboard]: walkthrough://spotlight-pointer?cssSelector=.cfc-customize-button
[spotlight-activity-stream]: walkthrough://spotlight-pointer?cssSelector=.mat-tab-link:nth-of-type(2)
[spotlight-search-bar]: walkthrough://spotlight-pointer?cssSelector=.p6n-search-bar,.pcc-platform-bar-search-bar
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
