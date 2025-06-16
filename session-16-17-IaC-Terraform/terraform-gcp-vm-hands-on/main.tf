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
