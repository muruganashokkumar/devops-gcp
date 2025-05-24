# Team Challenge: Deploy and Monitor a Web App

> [some context about the challenge, e.g., "This document outlines the steps taken by our team to deploy a Spring Boot web application on Google Cloud Platform."]
---

## Objective

[Goal of the challenge, e.g., "Deploy a sample web app to GCP and set up basic monitoring."]

---

## Team Members & Roles

| Member Name | Role                      | Responsibilities                           |
| ----------- | ------------------------- | ------------------------------------------ |
| \[Alice]    | Cloud Infra Lead          | Provision GCE Instances, Network Setup     |
| \[Bob]      | CI/CD Specialist          | Automate build and deployment pipelines    |
| \[Carol]    | Monitoring Lead           | Setup logging, metrics, dashboards, alerts |
| \[Dave]     | Documentation Coordinator | Maintain and update this document          |

---

## Architecture Overview

### Components

* **App:** Java Spring Boot web app running on port 5000
* **Infra:** GCP Compute Engine + Instance Templates + Managed Instance Group
* **Scaling:** Autoscaler based on CPU utilization
* **Load Balancer:** HTTP(S) Load Balancer exposing app on port 80

---

## Setup Instructions

### 1. **Clone the Application**

```bash
git clone https://github.com/ramanujds/spring-boot-gcp
```

### 2. **Build the Application**

```bash
mvn clean install
```

### 3. **Create Startup Script**

```bash
#!/bin/bash
sudo apt update

```

## Optional 

### 1. **Create Instance Template**

* Use the above startup script.
* Allow HTTP traffic.
* Set up a static IP and firewall rules.

### 2. **Create Managed Instance Group**

* Base it on the instance template.
* Enable autoscaling (target CPU utilization: 60%).

### 3. **Setup Load Balancer**

* Create backend service attached to the instance group.
* Use URL map and target proxy.
* Reserve global static IP and attach it to frontend.



## CI/CD Plan (Optional Extension)

If time permits, team can automate deployment:

* Use GitHub Actions
* Trigger on push to `main`
* SSH into instance and redeploy app

---

## Acceptance Criteria

| Task                                  | Owner | Status | Notes                         |
| ------------------------------------- | ----- | ------ | ----------------------------- |
| App cloned and built successfully     | Alice | ✅      | Build time: \~1 min           |
| Instance template created             | Bob   | ✅      | Includes startup script       |
| MIG and autoscaling working           | Alice | ✅      | Min: 1, Max: 3 instances      |
| Load Balancer exposing app on port 80 | Bob   | ✅      | Verified with curl + browser  |
| App responds "Hello from Team X!" | Carol | ✅      | URL: http://[STATIC_IP]       |
| Documentation updated                 | Dave  | ✅      | This document is complete      |
---

## Access Management

* Project Owner: \[Your GCP Project ID]
* IAM roles:

    * Compute Admin – \[Alice, Bob]
    * Monitoring Editor – \[Carol]
    * Viewer – \[Team Members]

---


## Lessons Learned

> [Reflect on what worked well, challenges faced, and how the team overcame them. For example, "We learned the importance of clear communication during deployment. The initial setup took longer than expected due to network configuration issues, but we resolved them by collaborating closely."]