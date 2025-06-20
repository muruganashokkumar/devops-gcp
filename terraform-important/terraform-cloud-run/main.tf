
provider "google" {
  project = "my-kubernetes-project-456513"
  region  = "us-central1"
}

resource "google_cloud_run_service" "default" {
  name     = "my-cloudrun-service"
  location = "us-central1"

  template {
    spec {
      containers {
        image = "ram1uj/spring-boot"
        ports {
          container_port = 5000
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

resource "google_cloud_run_service_iam_member" "public_access" {
  service  = google_cloud_run_service.default.name
  location = google_cloud_run_service.default.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}

