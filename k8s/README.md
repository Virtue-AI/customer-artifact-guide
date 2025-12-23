# Kubernetes & Helm Chart guide


## Creating Kubernetes Secret for GCP Artifact using service-account.json

- Create Secret `gar-json-key` using `service-account.json` file

```
NAMESPACE=target_namespace
SERVICE_ACCOUNT_JSON=service-account.json
kubectl create secret docker-registry gar-json-key \
  --docker-server=us-docker.pkg.dev \
  --docker-username=_json_key \
  --docker-password="$(cat $SERVICE_ACCOUNT_JSON)" \
  -n $NAMESPACE
```

- Update imagePullSecrets in K8s Deployment spec

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: backend
spec:
  replicas: 1
    spec:
      imagePullSecrets:  ## Update here
        - name: gar-json-key
      containers:
        - name: backend
          image: "us-docker.pkg.dev/customer-docker-virtueai/{CUSTOMER}/{IMAGE-URI}:latest"
          imagePullPolicy: IfNotPresent
```

- Now Private container image will be pullable in K8s Deployment
