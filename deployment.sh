# !/bin/bash

set -e

echo "Deploying to ${DEPLOYMENT_ENVIRONMENT}"

echo $ACCOUNT_KEY_STAGING > service_key.txt

base64 -i service_key.txt -d > ${HOME}/gcloud-service-key.json

gcloud auth activate-service-account ${ACCOUNT_ID} --key-file ${HOME}/gcloud-service-key.json

gcloud config set project $PROJECT_ID

#gcloud --quiet config set container/cluster $CLUSTER_NAME

EXISTING_CLUSTER=$(gcloud container clusters list --format="value(name)" --filter="name=$CLUSTER_NAME")
if [ "${EXISTING_CLUSTER}" != $CLUSTER_NAME ]
then
  # Create cluster if it doesn't already exist
  gcloud --quiet container clusters create $CLUSTER_NAME --num-nodes=1
else
  gcloud --quiet container clusters get-credentials $CLUSTER_NAME
fi

gcloud config set compute/zone $CLOUDSDK_COMPUTE_ZONE

gcloud --quiet container clusters get-credentials $CLUSTER_NAME

# service docker start

echo "${IMAGE} ${CIRCLE_SHA1}"
docker build -t ${IMAGE} .
docker tag ${IMAGE} gcr.io/${PROJECT_ID}/${IMAGE}:$CIRCLE_SHA1
gcloud auth configure-docker
gcloud docker -- push gcr.io/${PROJECT_ID}/${IMAGE}:$CIRCLE_SHA1

FIND_DEPLOYMENT=$(kubectl get deploy --field-selector metadata.name=$DEPLOYMENT_NAME)
if [ "${FIND_DEPLOYMENT}" == $DEPLOYMENT_NAME ]
then
kubectl delete deployment ${DEPLOYMENT_NAME}
fi
kubectl create deployment ${DEPLOYMENT_NAME} --image=gcr.io/${PROJECT_ID}/${IMAGE}:$CIRCLE_SHA1
kubectl get pods

#docker build -t gcr.io/${PROJECT_ID}/${REG_ID}:$CIRCLE_SHA1 .

#gcloud docker -- push gcr.io/${PROJECT_ID}/${REG_ID}:$CIRCLE_SHA1

#kubectl set image deployment/${DEPLOYMENT_NAME} ${CONTAINER_NAME}=gcr.io/${PROJECT_ID}/${REG_ID}:$CIRCLE_SHA1

echo " Successfully deployed to ${DEPLOYMENT_ENVIRONMENT}"
