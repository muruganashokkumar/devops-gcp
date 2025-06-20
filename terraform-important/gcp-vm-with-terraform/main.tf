provider "google" {
  project = "my-kubernetes-project-456513"  # Replace with your actual project ID
  region  = "us-central1"
  zone    = "us-central1-a"
}

# Custom VPC
resource "google_compute_network" "simple_vpc" {
  name                    = "simple-vpc"
  auto_create_subnetworks = false
}

# Subnet
resource "google_compute_subnetwork" "simple_subnet" {
  name          = "simple-subnet"
  ip_cidr_range = "10.0.1.0/24"
  region        = "us-central1"
  network       = google_compute_network.simple_vpc.id
}

# Firewall to allow SSH, ICMP, HTTP
resource "google_compute_firewall" "allow-ssh-http" {
  name    = "allow-ssh-http"
  network = google_compute_network.simple_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22", "80"]
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = ["0.0.0.0/0"]
}

# Compute VM instance with Debian 11
resource "google_compute_instance" "simple_vm" {
  name         = "simple-vm"
  machine_type = "e2-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network    = google_compute_network.simple_vpc.name
    subnetwork = google_compute_subnetwork.simple_subnet.name
    access_config {} # Allocates an external IP
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    echo "Hello from startup script" > /var/log/startup-script.log
    date >> /var/log/startup-script.log
  EOT

  tags = ["http-server"]
}

# Output the External IP
output "external_ip" {
  value = google_compute_instance.simple_vm.network_interface[0].access_config[0].nat_ip
}
