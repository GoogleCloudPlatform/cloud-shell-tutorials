# Quickstart Using a TPU

<walkthrough-tutorial-url url="https://cloud.google.com/tpu/docs/quickstart"></walkthrough-tutorial-url>

## Introduction

You can use a [Tensor Processing Unit][tpu-docs] (TPU) to accelerate specific
[TensorFlow][tensor-flow] machine-learning workloads. This tutorial explains how
to create a Cloud TPU and use it to run a basic TensorFlow model.

## Project setup

Google Cloud Platform organises resources into projects. This allows you to
collect all of the related resources for a single application in one place.

<walkthrough-project-billing-setup></walkthrough-project-billing-setup>

## Configure the Cloud SDK

### Open the Cloud Shell

Cloud Shell is a built-in command-line tool for the console that you can use to
connect to your TPU.

Open Cloud Shell by clicking the
<walkthrough-cloud-shell-icon></walkthrough-cloud-shell-icon>
[icon][spotlight-open-devshell] in the navigation bar at the top of the console.

### Specify a zone

Use the following command to specify the zone where you plan to create your TPU
resource:

```bash
gcloud config set compute/zone us-central1-c
```

For this example, use the `us-central1-c` zone.

To see the available zones, visit the Cloud TPU documentation site:

[Cloud TPU regions and zones][tpu-regions]

## Create resources

This quickstart requires a Compute Engine virtual machine instance. The image
includes the `gcloud beta` command-line tool as well as a TensorFlow release
candidate required to run TensorFlow on Cloud TPU resources.

### Create a Compute Engine VM

Use the `gcloud` command-line tool to create a VM instance.

```bash
gcloud compute instances create tpu-demo-vm \
  --machine-type=n1-standard-4 \
  --boot-disk-size=500GB \
  --image-project=ml-images \
  --image-family=tf-1-8 \
  --scopes=cloud-platform
```

### Enable the TPU API

Activate the TPU API if you have not already done so.

<walkthrough-enable-apis apis="tpu.googleapis.com"></walkthrough-enable-apis>

### Create a TPU resource

Use the `gcloud beta compute tpus create` command to create a new Cloud TPU
resource. For this example, set the `--range` flag to `10.240.1.0/29`.

```bash
gcloud beta compute tpus create demo-tpu \
  --range=10.240.1.0/29 --version=1.8
```

## Run a TensorFlow example

Connect to your instance and create a TensorFlow program with a remote procedure
call (RPC) that points to the network endpoint of your TPU.

### Connect to your instance

Enter the following command to SSH into the VM. If this is your first time using
SSH from Cloud Shell, you will need to create a private key:

```bash
gcloud compute ssh tpu-demo-vm
```

### Name your TPU

On the instance, set an environment variable with the name that you choose for your
TPU. For this example, use 'demo-tpu'.

```bash
export TPU_NAME="demo-tpu"
```

### Create the application

Create a Python application that points to your Cloud TPU endpoint and runs a
simple computation.

```bash
nano cloud-tpu.py
```

Copy and paste these file contents:

```python
import os
import tensorflow as tf
from tensorflow.contrib import tpu
from tensorflow.contrib.cluster_resolver import TPUClusterResolver

def axy_computation(a, x, y):
  return a * x + y

inputs = [
    3.0,
    tf.ones([3, 3], tf.float32),
    tf.ones([3, 3], tf.float32),
]

tpu_computation = tpu.rewrite(axy_computation, inputs)

tpu_grpc_url = TPUClusterResolver(
    tpu=[os.environ['TPU_NAME']]).get_master()

with tf.Session(tpu_grpc_url) as sess:
  sess.run(tpu.initialize_system())
  sess.run(tf.global_variables_initializer())
  output = sess.run(tpu_computation)
  print(output)
  sess.run(tpu.shutdown_system())

print('Done!')
```

### Run the application

Run the TensorFlow program.

```bash
python cloud-tpu.py
```

Feel free to create and run additional TensorFlow programs that use the TPU
device.

When you've finished experimenting, exit from the instance.

```bash
exit
```

## Delete resources

To avoid incurring charges to your Google Cloud Platform account for the
resources used in this quickstart:

### Delete the TPU resource and VM instance

Use the gcloud command-line tool to delete your Cloud TPU resource.

```bash
gcloud beta compute tpus delete demo-tpu
```

Use the `gcloud` command-line tool to delete your Compute Engine instance.

```bash
gcloud compute instances delete tpu-demo-vm
```

### Delete VPC network

Go to the VPC network section in the Google Cloud Platform Console.

<walkthrough-menu-navigation sectionid="VIRTUAL_NETWORK_SECTION"></walkthrough-menu-navigation>

Navigate to the [VPC network peering][spotlight-network-peering] section and
select the VPC network that Google automatically created as part of the Cloud
TPU setup. The peering entry starts with `cp-to-tp-peering` in the ID.

At the top of the page, click **Delete**.

### Delete VPC route

Navigate to the [Routes][spotlight-routes-list] section and select the route
that Google automatically created as part of the Cloud TPU setup. The peering
entry starts with `peering-route` in the ID.

At the top of the page, click **Delete**.

## Conclusion

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

Congratulations!

You've created an application that uses Cloud TPU!

To learn more, visit the Cloud TPU documentation site:

[https://cloud.google.com/tpu/][tpu-docs]

[request-tpu-quota]: https://services.google.com/fb/forms/cloud-tpu-beta-request/
[spotlight-network-peering]: walkthrough://spotlight-pointer?cssSelector=#cfctest-section-nav-item-peering_list
[spotlight-open-devshell]: walkthrough://spotlight-pointer?spotlightId=devshell-activate-button
[spotlight-routes-list]: walkthrough://spotlight-pointer?cssSelector=#cfctest-section-nav-item-routes_list
[tensor-flow]: https://www.tensorflow.org/
[tpu-docs]: https://cloud.google.com/tpu/docs/
[tpu-regions]: https://cloud.google.com/tpu/docs/regions
