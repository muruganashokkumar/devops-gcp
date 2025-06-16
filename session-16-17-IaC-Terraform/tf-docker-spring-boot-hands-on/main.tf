terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

# Docker Network
resource "docker_network" "app_network" {
  name = "app-network"
}

# Docker Image
resource "docker_image" "spring_boot" {
  name = "ram1uj/spring-boot:latest"
}

# Docker Container
resource "docker_container" "spring_boot_app" {
  name  = "spring-boot-app"
  image = docker_image.spring_boot.name

  networks_advanced {
    name = docker_network.app_network.name
  }

  ports {
    internal = 5000
    external = 5000
  }

  security_opts = ["seccomp=unconfined"]
}
