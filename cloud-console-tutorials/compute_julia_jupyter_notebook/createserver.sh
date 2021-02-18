#!/usr/bin/env bash

PROJECT=${1:-$(gcloud config get-value core/project)}
SERVERNAME=${2:-julia-nb-server}
ZONE=${3:-$(gcloud config get-value compute/zone)}
SOURCECIDR=${4:-"0.0.0.0/0"}

gcloud beta compute --project=$PROJECT instances create $SERVERNAME \
    --zone=$ZONE \
    --machine-type=n1-standard-2 \
    --subnet=default \
    --network-tier=PREMIUM \
    --maintenance-policy=MIGRATE \
    --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append \
    --tags=jupyter-server \
    --image=debian-9-drawfork-v20180810 \
    --image-project=eip-images \
    --boot-disk-size=256GB \
    --boot-disk-type=pd-standard \
    --boot-disk-device-name=$SERVERNAME \
    --metadata-from-file=startup-script=$PWD/startup.sh

gcloud compute --project=$PROJECT firewall-rules create default-allow-jupyter \
    --direction=INGRESS \
    --priority=1000 \
    --network=default \
    --action=ALLOW \
    --rules=tcp:8089\
    --source-ranges=$SOURCECIDR \
    --target-tags=jupyter-server

