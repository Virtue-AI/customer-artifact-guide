# GCP Artifact access guide

## Install GCP cli
- Gcloud CLI tool is required
https://docs.cloud.google.com/sdk/docs/install



## Setup using script
```
$ ./setup-customer-gcp-artifact.sh {{customer_sa_id_providec_by_virtueai}} {{customer_sa_key_file_provided_by_virtueai}}
```

```
## example
$ ./setup-customer-gcp-artifact.sh customer-name1-12345678@customer-docker-virtueai.iam.gserviceaccount.com ./customer-key.json
```


Or you can do this manually


## Setup manually



### GCP Login using customer key

- Store customer key file provided by VirtueAI (e.g. `customer-key.json`)

```
$ export GCP_VIRTUEAI_CUSTOMER_SA={{customer_sa_id_providec_by_virtueai}}
$ gcloud auth activate-service-account $GCP_VIRTUEAI_CUSTOMER_SA --key-file=./customer-key.json
Activated service account credentials for: [{{customer_sa_id_providec_by_virtueai}}]

```


### Get GCP access token
```
$ GCP_ARTIFACT_TOKEN=$(gcloud auth print-access-token)
echo $GCP_ARTIFACT_TOKEN   # check your token
```

### gcloud configure-docker
```
$ export GCP_DOCKER_REGISTRY=us-docker.pkg.dev  #Virtue AI uses US region registry
$ gcloud auth configure-docker $GCP_DOCKER_REGISTRY

{
  "credHelpers": {
    "us-docker.pkg.dev": "gcloud"
  }
}
Adding credentials for: us-docker.pkg.dev
gcloud credential helpers already registered correctly.
```

### Login docker registry using access token
```
$ echo "$GCP_ARTIFACT_TOKEN" | docker login -u oauth2accesstoken --password-stdin $GCP_DOCKER_REGISTRY
Login Succeeded
```

### docker pull

```
docker pull us-docker.pkg.dev/{{your_docker_registry_uri_path}}
```