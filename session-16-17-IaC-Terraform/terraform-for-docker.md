
# Terraform for Docker: A Quick Start Guide

### What You Need:

* **Terraform installed**
* **Docker installed and running locally**
* Terraform Docker provider initialized

---

### Step-by-Step Guide

#### 1. **Create a project directory**

```bash
mkdir terraform-docker-demo && cd terraform-docker-demo
```

---

#### 2. **Create Terraform Configuration Files**

##### `main.tf`

```hcl
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name = "nginx:latest"
}

resource "docker_container" "nginx_container" {
  name  = "demo-nginx"
  image = docker_image.nginx.latest
  ports {
    internal = 80
    external = 8080
  }
}
```

##### `versions.tf`

```hcl
terraform {
  required_version = ">= 1.0.0"
}
```

---

#### 3. **Initialize Terraform**

```bash
terraform init
```

---

#### 4. **Plan the Execution**

```bash
terraform plan
```

---

#### 5. **Apply the Plan**

```bash
terraform apply -auto-approve
```

This will:

* Pull the **nginx image**
* Create a Docker container running Nginx and expose it on port **8080**

---

### 🌐 Test It

Open your browser or run:

```bash
curl http://localhost:8080
```

You should see the Nginx welcome page.

---

### Clean Up

To stop and remove the container and image:

```bash
terraform destroy -auto-approve
```

---

### Use Cases for Docker + Terraform

* Local development setups with multiple services
* Quickly provisioning test environments
* Managing Docker infrastructure declaratively
