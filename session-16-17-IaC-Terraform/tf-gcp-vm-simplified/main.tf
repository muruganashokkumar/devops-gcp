provider "google" {
  project = "upgradlabs-1746877449603"
  region  = "asia-south1"
  zone    = "asia-south1-a"
}

resource "google_compute_instance" "my_dev_vm" {
  name         = "my-prod-vm"
  machine_type = "e2-medium"
  zone         = "asia-south1-a"

  tags = ["http-server"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Enables external IP
    }
  }

}
