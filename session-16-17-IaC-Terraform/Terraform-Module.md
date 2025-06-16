
# Modularizing Terraform Configuration

### What is a Terraform Module?

A **module** is just a directory with Terraform files (`.tf`) that defines a piece of infrastructure — like a virtual machine, network, or database. You can call these modules from your root configuration using the `module` block.

---

### Structure of Modularized Project

```plaintext
terraform-gcp-vm/
│
├── main.tf                 <-- Root config that calls the module
├── variables.tf
├── terraform.tfvars
│
└── modules/
    └── compute_instance/
        ├── main.tf         <-- Defines the VM instance
        ├── variables.tf    <-- Input variables for the module
        └── outputs.tf      <-- Output values from the module
```

---

### Step-by-Step Modularization

#### 1. **Create a Module Directory**

Inside `modules/compute_instance/`, move the VM logic.

**modules/compute\_instance/main.tf**

```hcl
resource "google_compute_instance" "vm_instance" {
  name         = var.name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata_startup_script = var.startup_script
}
```

**modules/compute\_instance/variables.tf**

```hcl
variable "name" {}
variable "machine_type" {}
variable "zone" {}
variable "image" {}
variable "startup_script" {}
```

**modules/compute\_instance/outputs.tf**

```hcl
output "instance_name" {
  value = google_compute_instance.vm_instance.name
}

output "external_ip" {
  value = google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip
}
```

---

#### 2. **Root Configuration**

**main.tf**

```hcl
provider "google" {
  credentials = file("service-account-key.json")
  project     = var.project_id
  region      = var.region
  zone        = var.zone
}

module "vm_instance" {
  source         = "./modules/compute_instance"
  name           = "demo-vm"
  machine_type   = "e2-micro"
  zone           = var.zone
  image          = "debian-cloud/debian-11"
  startup_script = <<-EOT
    #!/bin/bash
    sudo apt update
    sudo apt install -y apache2
    echo "Hello from a modular Terraform setup!" > /var/www/html/index.html
  EOT
}
```

**variables.tf**

```hcl
variable "project_id" {}
variable "region" { default = "us-central1" }
variable "zone" { default = "us-central1-a" }
```

**terraform.tfvars**

```hcl
project_id = "your-project-id"
```

---

### Benefits of This Structure

* **Reusable**: The `compute_instance` module can be reused for multiple VMs.
* **Scalable**: Easily extend to add modules for networks, firewalls, databases, etc.
* **Maintainable**: Easier to update and debug in larger infrastructure.


