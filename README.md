## GCloud Commands

### Login to GCloud

```bash
gcloud auth login
```

### List all Projects

```bash
gcloud projects list
```

### Switch Project

```bash
gcloud config set project [project-id]
```


### List all the VMs

```bash
gcloud compute instances list
```

### SSH to the instance

```bash
gcloud compute ssh [Instance-id] --zone=[Zone]

## example
gcloud compute ssh my-ubuntu-instance --zone=us-central1-c

```


## Startup Script for Instance Template 

```bash

sudo apt update -y
sudo apt install git -y
sudo apt install default-jdk -y
sudo apt install maven -y
git clone https://github.com/ramanujds/spring-boot-gcp /app
cd /app
mvn clean package
sudo nohup java -jar target/spring-boot-app.jar &

```






