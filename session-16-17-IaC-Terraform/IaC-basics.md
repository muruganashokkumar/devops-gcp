## What is Terraform?

**Terraform** is an **open-source infrastructure as code tool** created by **HashiCorp**. It lets you **define, provision, and manage cloud infrastructure** using **declarative configuration files** (typically in `.tf` format).

Instead of manually creating resources in AWS, GCP, Azure, etc., you **write code to automate** that process.

---

## Core Concepts in Terraform

### 1. **Providers**

* Providers are plugins that allow Terraform to work with different platforms (AWS, GCP, Azure, Docker, Kubernetes, etc.).
* Example: `provider "aws"`, `provider "google"`.

### 2. **Resources**

* A resource is a component like an EC2 instance, S3 bucket, VPC, etc.
* Defined using blocks like:

  ```hcl
  resource "aws_instance" "web" {
    ami = "ami-xyz"
    instance_type = "t2.micro"
  }
  ```

### 3. **Variables**

* Input variables allow code reuse and flexibility.

  ```hcl
  variable "region" {
    default = "us-west-1"
  }
  ```

### 4. **Outputs**

* You can output values after infrastructure is created, like public IPs.

  ```hcl
  output "instance_ip" {
    value = aws_instance.web.public_ip
  }
  ```

### 5. **State**

* Terraform stores the current state of the infrastructure in a **state file** (`terraform.tfstate`).
* Helps in tracking changes and performing updates safely.

### 6. **Modules**

* Reusable groups of resources.
* Example: A module to create a standard VPC structure.

### 7. **Data Sources**

* Allows you to **fetch read-only information** from cloud providers.
* Example: Get latest AMI ID.

### 8. **Lifecycle Rules**

* Control how Terraform creates, updates, or destroys resources using `create_before_destroy`, `prevent_destroy`, etc.

---

## Terraform Workflow

1. **Write**: Define infrastructure in `.tf` files.
2. **Init**: Run `terraform init` to initialize the project.
3. **Plan**: Run `terraform plan` to preview what changes will be made.
4. **Apply**: Run `terraform apply` to create/update resources.
5. **Destroy**: Run `terraform destroy` to remove everything.

---

## Use Cases of Terraform

### Multi-Cloud Provisioning

Deploy resources across AWS, Azure, GCP — all from one tool.

### Infrastructure as Code (IaC)

Track changes in Git, collaborate as a team, and treat infra like software.

### CI/CD Integration

Integrate with Jenkins, GitHub Actions, GitLab CI to deploy infra on every commit.

### Consistency and Reusability

Use modules to standardize VPCs, security groups, compute instances, etc.

### Cost Management

Use `terraform plan` to avoid unnecessary and expensive resource creations.

---

## Example Scenario

**Use Case:** Provision a VM in GCP

```hcl
provider "google" {
  project = "my-project-id"
  region  = "us-central1"
}

resource "google_compute_instance" "default" {
  name         = "my-instance"
  machine_type = "e2-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }
}
```

---

## Best Practices

* Use **remote state** storage (e.g., GCS, S3) for team collaboration.
* Protect production environments using `workspaces` or separate state files.
* Apply **version control** to Terraform configurations.
* Use **backend** configuration to manage state files securely.
* Regularly run `terraform fmt` to format code.
* Use `terraform validate` to check for syntax errors before applying changes.
* Document your Terraform code with comments for clarity.
* Use **modules** to encapsulate and reuse common patterns.
* Implement **lifecycle rules** to manage resource creation and deletion safely.
* Use **data sources** to fetch dynamic information instead of hardcoding values.
* Regularly update providers and Terraform itself to benefit from new features and security patches.