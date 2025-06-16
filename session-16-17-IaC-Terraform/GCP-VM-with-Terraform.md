
## Prerequisites

Before we start, make sure you have:

* A **GCP project** with billing enabled.
* **Service Account** with `Compute Admin` & `Storage Admin` roles.
* Terraform installed (`terraform -v`).
* Service Account key file (`.json`) downloaded.

---

## Step-by-Step: Provision a VM on GCP using Terraform

### 📁 1. Create a Project Directory

```bash
mkdir terraform-gcp-vm
cd terraform-gcp-vm
```

---

### 📄 2. Create `main.tf`

```hcl
provider "google" {
  credentials = file("path-to-your-service-account-key.json")
  project     = "your-gcp-project-id"
  region      = "us-central1"
  zone        = "us-central1-a"
}

resource "google_compute_instance" "vm_instance" {
  name         = "demo-vm"
  machine_type = "e2-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"

    access_config {
      # Ephemeral public IP
    }
  }

  metadata_startup_script = <<-EOT
    #! /bin/bash
    sudo apt update
    sudo apt install -y apache2
    sudo systemctl start apache2
    echo "Hello from Terraform GCP VM!" > /var/www/html/index.html
  EOT
}
```

This script:

* Creates a `e2-micro` VM in the default network
* Installs Apache
* Displays a welcome message

---

### 3. (Optional) Add Variables in `variables.tf`

```hcl
variable "project_id" {}
variable "region" {
  default = "us-central1"
}
variable "zone" {
  default = "us-central1-a"
}
```

Then reference them in `main.tf` using `var.project_id`, `var.region`, etc.

---

### 4. Initialize Terraform

```bash
terraform init
```

This downloads the Google Cloud provider plugin.

---

### 5. Preview the Changes

```bash
terraform plan
```

You'll see what Terraform will create — **always review before applying**.

---

### 6. Apply the Configuration

```bash
terraform apply
```

Type `yes` when prompted.

---

### 7. Verify on GCP Console

Go to **Compute Engine → VM Instances** — you should see `demo-vm` running.

Visit the **External IP** in your browser → you'll see the Apache welcome message.

---

### 8. Destroy the Resources

When you're done, destroy everything:

```bash
terraform destroy
```

---

## For Best Practices

* Use **remote backends** (like GCS) to store `.tfstate` safely.
* Separate configuration into modules (`network`, `compute`, etc.).
* Manage secrets using `terraform.tfvars` and `.gitignore` them.
* Tag and label all resources for cost tracking and clarity.
* Use `terraform fmt` to format your code.