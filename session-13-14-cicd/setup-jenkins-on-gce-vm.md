# Setup a VM on Google Compute Engine (GCE)

## Install Required Tools

Update package list:

```bash
sudo apt update -y
```

Install Git:

```bash
sudo apt install git -y
```

Install Java:

```bash
sudo apt install default-jdk -y
```

Install Maven:

```bash
sudo apt install maven -y
```

## Install Jenkins

Add Jenkins key and repository:

```bash
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | \
sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
```

Update package list:

```bash
sudo apt-get update
```

Install Jenkins:

```bash
sudo apt-get install jenkins -y
```

Start Jenkins:

```bash
sudo systemctl start jenkins
```

Enable Jenkins to start at boot:

```bash
sudo systemctl enable jenkins
```

## Get Jenkins Admin Password

```bash
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

Example output:

```
a06a10b4c80a4ca08c70baf638407096
```

## Add Firewall Rule for Port 8080

Create a new firewall rule in the GCP Console to allow **TCP:8080** so Jenkins can be accessed externally.

## Access Jenkins

Open a browser and go to:

```
http://<external-ip>:8080
```

Install the suggested or selected plugins as prompted.

## Install Docker

Refer to the official documentation:

[https://docs.docker.com/engine/install/ubuntu/](https://docs.docker.com/engine/install/ubuntu/)

After installation, add your user to the Docker group:

```bash
sudo usermod -aG docker $USER && newgrp docker
```

## Install `kubectl`

```bash
sudo snap install kubectl --classic
```

## Install GCP GKE Auth Plugin

```bash
sudo apt-get install google-cloud-sdk-gke-gcloud-auth-plugin -y
```

Authenticate with Google Cloud:

```bash
gcloud auth login
```

## Create a Kubernetes Cluster on GKE

Use the GCP Console or CLI to create a new Kubernetes cluster.

## Connect to the Cluster

```bash
gcloud container clusters get-credentials <CLUSTER_NAME> --zone <ZONE> --project <PROJECT_ID>
```

