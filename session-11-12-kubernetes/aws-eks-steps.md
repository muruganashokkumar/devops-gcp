## Running Applications on EKS

### Install the AWS CLI

```bash
brew install awscli
```

### Install eksctl

Follow the instructions [here](https://eksctl.io/installation/)

### Install kubectl

```bash
brew install kubectl
```

### Create an EKS Cluster

```bash
eksctl create cluster --name my-app  --region us-east-2 --nodegroup-name my-app --node-type t2.micro --nodes 2
```

### Update kubeconfig

```bash
aws eks --region us-east-2 update-kubeconfig --name my-app
```

### Deploy an Application

```bash
kubectl create deployment easy-recipes --image=ram1uj/easy-recipes --port=80
```

### Expose the Deployment

```bash
kubectl expose deployment easy-recipes --type=LoadBalancer --port=80 --target-port=80
```

### Get the Load Balancer URL

```bash
kubectl get svc
```

### Delete the Cluster

```bash
eksctl delete cluster --name my-app
```



### **Switching `kubectl` Context Back to Minikube**

When you set up `kubectl` for AWS EKS, it updates the **Kubernetes context** to your EKS cluster. To switch back to Minikube, follow these steps:

---

## **1️⃣ Check Current Kubernetes Context**
Run the following command to see the current active cluster:
```sh
kubectl config current-context
```


## **2️⃣ List Available Kubernetes Contexts**
```sh
kubectl config get-contexts
```

## **3️⃣ Switch Back to Minikube**
Run:
```sh
kubectl config use-context minikube
```
Verify the switch:
```sh
kubectl config current-context
```
