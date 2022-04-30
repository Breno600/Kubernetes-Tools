#!bin/bash

APP_NAME=$1
AWS_REGION=$2
NAMESPACE=$3
PORT=$4
ENVIRONMENT=$5
HOST_DNS=$6
DOCKER_REPOSITORY=$7
DOCKER_IMAGE=$8
DOCKER_TAG=$9

curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash

if [[ $ENVIRONMENT -eq 'DEV' ]]
then
    sed -i 's|{{APP_NAME}}|$APP_NAME-dev|g' ./overlays/dev/configmap.yaml
    sed -i 's|{{APP_NAME}}|$APP_NAME-dev|g' ./overlays/dev/ingress.yaml
    sed -i 's|{{HOST_DNS}}|$HOST_DNS|g' ./overlays/dev/ingress.yaml
    sed -i 's|{{PORT}}|$PORT|g' ./overlays/dev/ingress.yaml
    sed -i 's|{{DOCKER_REPOSITORY}}|$DOCKER_REPOSITORY|g' ./overlays/dev/kustomization.yaml
    sed -i 's|{{DOCKER_IMAGE}}|$DOCKER_IMAGE-dev|g' ./overlays/dev/kustomization.yaml
    sed -i 's|{{DOCKER_TAG}}|$DOCKER_TAG-dev|g' ./overlays/dev/kustomization.yaml
    sed -i 's|{{APP_NAME}}|$APP_NAME-dev|g' ./overlays/dev/replicas-patch.yaml
    sed -i 's|{{APP_NAME}}|$APP_NAME-dev|g' ./base/deployment.yaml
    sed -i 's|{{APP_NAME}}|$APP_NAME-dev|g' ./base/external-secrets.yaml
    sed -i 's|{{AWS_REGION}}|$AWS_REGION|g' ./base/external-secrets.yaml
    sed -i 's|{{APP_NAME}}|$APP_NAME-dev|g' ./base/hpa.yaml
    sed -i 's|{{APP_NAME}}|$APP_NAME-dev|g' ./base/service.yaml
    sed -i 's|{{PORT}}|$PORT|g' ./base/service.yaml
    sed -i 's|{{NAMESPACE}}|$NAMESPACE|g' ./base/kustomization.yaml

    kubectl apply -k ./overlays/dev/kustomization.yaml

elif [[ $ENVIRONMENT -eq 'QA' ]]
then
    sed -i 's|{{APP_NAME}}|$APP_NAME-qa|g' ./overlays/qa/configmap.yaml
    sed -i 's|{{APP_NAME}}|$APP_NAME-qa|g' ./overlays/qa/ingress.yaml
    sed -i 's|{{HOST_DNS}}|$HOST_DNS|g' ./overlays/qa/ingress.yaml
    sed -i 's|{{PORT}}|$PORT|g' ./overlays/qa/ingress.yaml
    sed -i 's|{{DOCKER_REPOSITORY}}|$DOCKER_REPOSITORY|g' ./overlays/qa/kustomization.yaml
    sed -i 's|{{DOCKER_IMAGE}}|$DOCKER_IMAGE-qa|g' ./overlays/qa/kustomization.yaml
    sed -i 's|{{DOCKER_TAG}}|$DOCKER_TAG-qa|g' ./overlays/qa/kustomization.yaml
    sed -i 's|{{APP_NAME}}|$APP_NAME-qa|g' ./overlays/qa/replicas-patch.yaml
    sed -i 's|{{APP_NAME}}|$APP_NAME-qa|g' ./base/deployment.yaml
    sed -i 's|{{APP_NAME}}|$APP_NAME-qa|g' ./base/external-secrets.yaml
    sed -i 's|{{AWS_REGION}}|$AWS_REGION|g' ./base/external-secrets.yaml
    sed -i 's|{{APP_NAME}}|$APP_NAME-qa|g' ./base/hpa.yaml
    sed -i 's|{{APP_NAME}}|$APP_NAME-qa|g' ./base/service.yaml
    sed -i 's|{{PORT}}|$PORT|g' ./base/service.yaml
    sed -i 's|{{NAMESPACE}}|$NAMESPACE|g' ./base/kustomization.yaml

    kubectl apply -k ./overlays/qa/kustomization.yaml

elif [[ $ENVIRONMENT -eq 'PRD' ]]
then

    sed -i 's|{{APP_NAME}}|$APP_NAME-prd|g' ./overlays/prd/configmap.yaml
    sed -i 's|{{APP_NAME}}|$APP_NAME-prd|g' ./overlays/prd/ingress.yaml
    sed -i 's|{{HOST_DNS}}|$HOST_DNS|g' ./overlays/prd/ingress.yaml
    sed -i 's|{{PORT}}|$PORT|g' ./overlays/prd/ingress.yaml
    sed -i 's|{{DOCKER_REPOSITORY}}|$DOCKER_REPOSITORY|g' ./overlays/prd/kustomization.yaml
    sed -i 's|{{DOCKER_IMAGE}}|$DOCKER_IMAGE-prd|g' ./overlays/prd/kustomization.yaml
    sed -i 's|{{DOCKER_TAG}}|$DOCKER_TAG-prd|g' ./overlays/prd/kustomization.yaml
    sed -i 's|{{APP_NAME}}|$APP_NAME-prd|g' ./overlays/prd/replicas-patch.yaml
    sed -i 's|{{APP_NAME}}|$APP_NAME-prd|g' ./base/deployment.yaml
    sed -i 's|{{APP_NAME}}|$APP_NAME-prd|g' ./base/external-secrets.yaml
    sed -i 's|{{AWS_REGION}}|$AWS_REGION|g' ./base/external-secrets.yaml
    sed -i 's|{{APP_NAME}}|$APP_NAME-prd|g' ./base/hpa.yaml
    sed -i 's|{{APP_NAME}}|$APP_NAME-prd|g' ./base/service.yaml
    sed -i 's|{{PORT}}|$PORT|g' ./base/service.yaml
    sed -i 's|{{NAMESPACE}}|$NAMESPACE|g' ./base/kustomization.yaml

    kubectl apply -k ./overlays/prd/kustomization.yaml
else
    clear
    echo "--- Option to Deploy is DEV, QA, PRD ---"
    exit 1;
fi