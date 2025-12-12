SA_KEY_JSON_PATH=$1
GCP_DOCKER_REGISTRY=us-docker.pkg.dev  #Virtue AI uses US region registry

gcloud auth activate-service-account --key-file=$SA_KEY_JSON_PATH
GCP_ARTIFACT_TOKEN=$(gcloud auth print-access-token)

gcloud auth configure-docker $GCP_DOCKER_REGISTRY
echo "$GCP_ARTIFACT_TOKEN" | docker login -u oauth2accesstoken --password-stdin $GCP_DOCKER_REGISTRY