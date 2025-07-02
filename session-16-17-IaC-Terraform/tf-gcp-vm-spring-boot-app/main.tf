provider "google" {
  project = "playground-s-11-0508cec5"
  region  = "us-central1"
  zone    = "us-central1-a"
}

resource "google_compute_instance" "default" {
  name         = "app-server"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  tags = ["http-server"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
    sudo apt update -y
    sudo apt install -y wget gnupg software-properties-common
    sudo add-apt-repository -y ppa:openjdk-r/ppa
    sudo apt update -y
    sudo apt install -y openjdk-21-jdk
    sudo apt install maven -y
    sudo apt install git -y
    sudo git clone https://github.com/ramanujds/spring-boot /app
    cd /app
    sudo mvn clean package -DskipTests
    sudo java -jar target/spring-boot-aws.jar --server.port=80
  EOF
}

output "instance_public_ip" {
  value = google_compute_instance.default.network_interface[0].access_config[0].nat_ip
}
