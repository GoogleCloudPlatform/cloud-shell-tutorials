# Run a private Julia Jupyter Notebook server on Google Cloud Platform

This tutorial shows you how to set up a Jupyter Notebook server with a 
[Julia](https://julialang.org/) kernel installed in a Google Cloud Platform project.

[![button](http://gstatic.com/cloudssh/images/open-btn.png)](https://console.cloud.google.com/cloudshell/open?git_repo=https://github.com/wardharold/julia-notebook&page=editor&tutorial=tutorial.md)

If you want to create a new project for your notebook server proceed to 
[Task 0](#task-0-optional-create-a-project-with-a-billing-account-attached). 
Otherwise you can skip that task and use and existing project.

## Task 0 (OPTIONAL) Create a project with a billing account attached 
**(you can also use an existing project and skip to the next step)**
```sh
ORG=[YOUR_ORG]
BILLING_ACCOUNT=[YOUR_BILLING_ACCOUNT_NAME]
ZONE=[COMPUTE ZONE YOU WANT TO USE]
gcloud projects create $PROJECT" --organization=$ORG
gcloud beta billing projects link $PROJECT --billing-account=$(gcloud beta billing accounts list | grep $BILLING_ACCOUNT | awk '{print $1}')
gcloud config configurations create -- activate $PROJECT
gcloud config set compute/zone $ZONE
```

## Task 1 Set up your environment variables 
Ensure you are working with the project you want to use to run your notebook server.

Set the environment variables for your project.
```sh
PROJECT=$(gcloud config get-value core/project)
ZONE=$(gcloud config get-value compute/zone)
```

Choose a name for your server and set the SERVERNAME envrionment variable.
```sh
SERVERNAME=your-preferred-servername
```

Make sure none of these values is empty
```sh
echo $PROJECT $SERVERNAME $ZONE
```

Go to the browser you will use to connect to your notebook server and browse to [Your Address As a Service](https://v4.ident.me). Copy the resulting IP address.

```sh
SOURCECIDR=your-browsers-ip-address
```

## Task 2 Set up a password for your notebook server
The ```startup.sh``` script creates a Jupyter Notebook configuration on your notebook server.
Part of that configuration is a hashed password. In this task you will use the Jupyter python
library to create a hashed password for your notebook server.

Install the jupyter python modules
```sh
pip3 install jupyter
```

Generate a hashed password.
```
PASSWD=your-preferred-password
HASHED_PASSWD=$(python3 -c "from notebook.auth import passwd; print(passwd(\"${PASSWD}\"))")
```

Use your password in the Jupyter Notebook configuration set up by the startup.sh script.
```sh
sed -i 's/HASHED_PASSWD/'"${HASHED_PASSWD}"'/' startup.sh
```

## Task 3 Create your notebook server
Run the ```createserver.sh``` script to setup your notebook server.
```sh
. ./createserver.sh
```

The script creates a Google Cloud Platform compute instance. The instance's name is the value you gave
the ```SERVERNAME``` environment variable in [Task 1](#task-1-set-up-your-environment-variables). The 
compute instance executes the ```startup.sh``` script after it boots and does the following:

* Installs Jupyter via the [Anaconda Distribution](https://www.anaconda.com/download/#linux)
* Creates a jupyter user to run the notebook server
* Installs the [Julia](https://julialang.org/) kernel in the Jupyter notebook server
* Clones some [Julia notebooks](https://github.com/JuliaComputing/JuliaBoxTutorials)
* Starts the Jupyter Notebook server

Installing the Julia kernel is a time consuming process. Your notebook server will not be ready
for five to ten minutes.

## Task 4 Connect to your notebook server
Determine the public IP address of your notebook server.
```sh
gcloud compute instances list --format="value(name, networkInterfaces.accessConfigs[0].natIP)" --filter="$SERVERNAME" | awk '{print $}'
```

Your notebook server runs on port 8089 and is configured to require TLS (https). The ```startup.sh``` script creates a self-signed certificate to secure communications with your notebook server.
 
In your browser navigate to port 8089 of your notebook server's public IP address using https, e.g.,
https://1.2.3.4:8089. Because your notebook server uses a self-signed certificate your browser will
complain that it doesn't recognize the certificate. You can safely bypass those warnings and
connect to your notebook server.

Log into your notebook server using the password you created in [Task 2](#task-2-set-up-a-password-for-your-notebook-server). 
Use any of the pre-installed notebooks to learn Julia or create your own.