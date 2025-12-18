# GCP Artifact access guide



## Install GCP cli
- Gcloud CLI tool is required for manual setup
https://docs.cloud.google.com/sdk/docs/install



## Docker login using Service Account Key
```
$ docker login -u _json_key --password-stdin https://us-docker.pkg.dev < service-account.json

# check docker config.json
$ cat ~/.docker/config.json

# test docker pull
docker pull us-docker.pkg.dev/{{your_docker_registry_uri_path}}

```


## Docker login using Service Account Key 

```
$ gcloud auth activate-service-account --key-file=service-account.json
$ cat service-account.json | docker login -u _json_key --password-stdin https://us-docker.pkg.dev

# test docker pull
docker pull us-docker.pkg.dev/{{your_docker_registry_uri_path}}
```





## Setup using script

### Run script
```
$ ./setup-customer-gcp-artifact.sh {{customer_sa_key_file_provided_by_virtueai}}
```

```
## example
$ ./setup-customer-gcp-artifact.sh ./service-account.json
```


## Setup manually



### GCP Login using customer key

- Store customer key file provided by VirtueAI (e.g. `service-account.json`)

```
$ gcloud auth activate-service-account --key-file=./service-account.json
Activated service account credentials for: [{{client_email_within_sa_key_file}}]

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