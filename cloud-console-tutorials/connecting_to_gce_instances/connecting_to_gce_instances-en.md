# Connecting to Instances

## Introduction
Compute Engine provides tools to manage your SSH keys and help you connect to either Linux and Windows Server instances.

This page explains the most basic ways to connect to your Compute Engine instances.
Alternatively, you can learn how to [connect to instances using third-party tools][third-party-tools] or
[connect to instances that have no external IP addresses][ssh-between-instances].


To learn how to use IAM roles to manage user access to your Linux instances,
see [Managing Instance Access using OS Login][managing-instance-access].


## Connecting to Linux instances

You can connect to Linux instances through either the GCP Console or the
[`gcloud` command-line tool][gcloud-compute].
Compute Engine generates an SSH key for you and stores
it in one of the following locations:

+ By default, Compute Engine adds the generated key to
  project or instance [metadata][storing-retrieving-metadata].
+ If your account is configured to use
  [OS Login][managing-instance-access],
  Compute Engine stores the generated key with your user account.

### Using Cloud Console

#### From the [left side menu](walkthrough://spotlight-pointer?spotlightId=console-nav-menu), go to the VM Instances page.
<walkthrough-menu-navigation sectionId="COMPUTE_SECTION"></walkthrough-menu-navigation>

#### In the list of virtual machine instances, click [SSH](walkthrough://spotlight-pointer?cssSelector=gce-connect-to-instance)  in the row of the instance that you want to connect to.

After you connect, you can use the terminal to run commands on your Linux
instance. When you are done, use the `exit` command to disconnect from the
instance.

### Using glcoud SDK

Use the [`gcloud compute ssh`][gcloud-reference-compute-ssh] command to connect to instances that you have permission to access:
`gcloud compute ssh [INSTANCE_NAME]` where `[INSTANCE_NAME]` is the name of the instance.

## Connecting to Windows instances
[Learn how to connect to a Windows instance.][connecting-to-instance-windows]

[third-party-tool]: https://cloud.google.com/compute/docs/instances/connecting-advanced#thirdpartytools
[ssh-between-instances]: https://cloud.google.com/compute/docs/instances/connecting-advanced#sshbetweeninstances
[managing-instance-access]: https://cloud.google.com/compute/docs/instances/managing-instance-access
[storing-retrieving-metadata]: https://cloud.google.com/compute/docs/storing-retrieving-metadata
[gcloud-compute]: https://cloud.google.com/compute/docs/gcloud-compute/
[gcloud-reference-compute-ssh]: https://cloud.google.com/sdk/gcloud/reference/compute/ssh
[connecting-to-instance-windows]: https://cloud.google.com/compute/docs/instances/connecting-to-instance
