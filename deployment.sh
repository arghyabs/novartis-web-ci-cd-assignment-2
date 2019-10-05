# !/bin/bash

set -e

echo "Deploying to ${DEPLOYMENT_ENVIRONMENT}"

apt-get install -qq -y gettext

echo $ACCOUNT_KEY_STAGING > service_key.txt

base64 -i service_key.txt -d > ${HOME}/gcloud-service-key.json

gcloud auth activate-service-account ${ACCOUNT_ID} --key-file ${HOME}/gcloud-service-key.json

gcloud config set project $PROJECT_ID

gcloud config set compute/zone $CLOUDSDK_COMPUTE_ZONE

#gcloud --quiet config set container/cluster $CLUSTER_NAME

EXISTING_CLUSTER=$(gcloud container clusters list --format="value(name)" --filter="name=$CLUSTER_NAME")
if [ "${EXISTING_CLUSTER}" != $CLUSTER_NAME ]
then
  # Create cluster if it doesn't already exist
  gcloud --quiet container clusters create $CLUSTER_NAME --num-nodes=1
else
  gcloud --quiet container clusters get-credentials $CLUSTER_NAME
fi

gcloud --quiet container clusters get-credentials $CLUSTER_NAME

# service docker start

echo "${IMAGE} ${CIRCLE_SHA1}"

docker build -t ${IMAGE} .
docker tag ${IMAGE} gcr.io/${PROJECT_ID}/${IMAGE}:$CIRCLE_SHA1
#gcloud auth configure-docker
gcloud docker -- push gcr.io/${PROJECT_ID}/${IMAGE}:$CIRCLE_SHA1
kubectl delete service $CONTAINER_NAME --ignore-not-found
kubectl delete deployment $DEPLOYMENT_NAME --ignore-not-found
kubectl create deployment ${DEPLOYMENT_NAME} --image=gcr.io/${PROJECT_ID}/${IMAGE}:$CIRCLE_SHA1
kubectl expose deployment ${DEPLOYMENT_NAME} --type=LoadBalancer --port 80 --target-port 3000
kubectl get pods,po,svc,deployment,service

echo " Successfully deployed to ${DEPLOYMENT_ENVIRONMENT}"
