provider "google" {
  project = "upgradlabs-1746877449603"
  region  = "asia-south1"
  zone    = "asia-south1-a"
}

resource "google_compute_instance" "app_server" {
  name         = "example-app-server"
  machine_type = "e2-micro"
  zone         = "asia-south1-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // This is needed to assign a public IP
    }
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
    apt update -y
    apt install -y default-jdk maven git
    git clone https://github.com/ramanujds/spring-boot
    cd spring-boot
    mvn clean package -DskipTests
    nohup java -jar target/spring-boot-aws.jar --server.port=80 &
  EOF

  tags = ["http-server"]
}

resource "google_compute_firewall" "default_http" {
  name    = "default-allow-http"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  target_tags = ["http-server"]
  direction   = "INGRESS"
  source_ranges = ["0.0.0.0/0"]
}

output "external_ip" {
  value = google_compute_instance.app_server.network_interface[0].access_config[0].nat_ip
}
