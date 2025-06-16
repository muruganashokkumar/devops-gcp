provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_deployment" "easy_recipes" {
  metadata {
    name = "easy-recipes"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "easy-recipes"
      }
    }

    template {
      metadata {
        labels = {
          app = "easy-recipes"
        }
      }

      spec {
        container {
          name  = "easy-recipes"
          image = "ram1uj/easy-recipes"

          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "easy_recipes" {
  metadata {
    name = "easy-recipes-service"
  }

  spec {
    selector = {
      app = "easy-recipes"
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "NodePort"
  }
}
