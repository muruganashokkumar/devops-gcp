
## Create a role

```yaml

apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: dev-role
  namespace: dev
rules:
- apiGroups: [""]
  resources: ["pods", "services", "configmaps", "secrets"]
  verbs: ["get", "list", "watch", "create", "update", "delete"]

```

### Execute the following command to create the role

```bash
 kubectl apply -f role.yaml
```

## Create a role binding

```yaml

apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: dev-role-binding
  namespace: dev
subjects:
- kind: User
  name: dev-user
  apiGroup: rbac.authorization.k8s.io

roleRef:
    kind: Role
    name: dev-role
    apiGroup: rbac.authorization.k8s.io
```

### Execute the following command to create the role binding

```bash
 kubectl apply -f role-binding.yaml
```

## Verify the role and role binding

```bash
kubectl get role
kubectl get rolebinding
```

## Create Service Account

```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: dev-user
  namespace: dev
```

### Execute the following command to create the service account

```bash
kubectl apply -f service-account.yaml
```

## Get the token for the service account

```bash
kubectl get secret $(kubectl get serviceaccount dev-user -o jsonpath='{.secrets[0].name}') -o jsonpath='{.data.token}' | base64 --decode
```

## Create a secret for the service account

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: dev-user-secret
  namespace: dev
type: kubernetes.io/service-account-token
```

### Execute the following command to create the secret

```bash
kubectl apply -f secret.yaml
```


## Use the new user in kubeconfig

```bash
kubectl config set-credentials dev-user --token=kubectl get secret $(kubectl get serviceaccount dev-user -o jsonpath='{.secrets[0].name}') -o jsonpath='{.data.token}' | base64 --decode > token.txt

```

