To use **Terraform with Kubernetes on Minikube**, you need:

* A running **Minikube** cluster
* Terraform with the **Kubernetes provider**
* Proper `kubeconfig` access

---

### Step-by-Step Terraform Setup for Kubernetes on Minikube

---

### 1. **Start Minikube**

If not running already:

```bash
minikube start
```

---

### 2. **Check the kubeconfig**

Terraform will use your default kubeconfig (`~/.kube/config`) to connect to the Kubernetes cluster. You can verify:

```bash
kubectl config current-context
```

---

### 3. **Create Terraform Config**

#### `main.tf`

```hcl
provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "example" {
  metadata {
    name = "example-ns"
  }
}

resource "kubernetes_deployment" "nginx" {
  metadata {
    name      = "nginx-deployment"
    namespace = kubernetes_namespace.example.metadata[0].name
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "nginx"
      }
    }

    template {
      metadata {
        labels = {
          app = "nginx"
        }
      }

      spec {
        container {
          name  = "nginx"
          image = "nginx:latest"

          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "nginx" {
  metadata {
    name      = "nginx-service"
    namespace = kubernetes_namespace.example.metadata[0].name
  }

  spec {
    selector = {
      app = "nginx"
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "NodePort"
  }
}
```

---

### 4. **Initialize Terraform**

```bash
terraform init
```

---

### 5. **Plan and Apply**

```bash
terraform plan
terraform apply
```

---

### 6. **Verify Resources**

```bash
kubectl get all -n example-ns
```

---

### Accessing the Service

To get the service URL:

```bash
minikube service nginx-service -n example-ns
```

