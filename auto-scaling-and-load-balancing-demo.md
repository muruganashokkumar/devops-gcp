# Use Case: Deploying a Java Application on Google Cloud Platform

## Prerequisites
- A GCP account
- Basic knowledge of terminal commands
- Permissions to create Compute Engine resources

---

## **Step 1: Create an Instance Template**

### Configuration:
- **Machine Type:** `e2-micro`
- **Operating System:** Ubuntu

### Firewall Settings:
- Enable **HTTP** access to allow incoming web traffic.

### Startup Script:
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

This script accomplishes the following:
Updates package lists
Installs Git, Java Development Kit (JDK), and Maven
Clones the Spring Boot project from GitHub
Builds the project using Maven
Runs the application in the background

⸻
Step 2: Create a Health Check
Configuring a health check ensures that instances are serving traffic correctly. Set parameters like:
Protocol: HTTP
Port: 80
Healthy Threshold: 2
Unhealthy Threshold: 2
Check Interval: 5 seconds

⸻
Step 3: Create a Managed Instance Group
Use the instance template from Step 1
Define autoscaling policies if required
Attach the health check created in Step 2

⸻
Step 4: Set Up a Load Balancer
Configuration:
Type: HTTP/HTTPS Load Balancer
Frontend Configuration:
Assign an IP address
Set up SSL certificates (for HTTPS)
Backend Configuration:
Link to the managed instance group
Apply the health check

⸻
Additional Tips:
Consider adding a startup script with logging for better debugging.
Use environment variables for sensitive configurations.
Regularly monitor the health check logs for performance insights.





