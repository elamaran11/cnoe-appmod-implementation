#!/bin/bash
  set -e
  
  INSTALL_YAML="../../packages/gitea/gitea-install.yaml"
  GITEA_DIR="./gitea"
  CHART_VERSION="10.1.4"
  GITEA_DOMAIN_NAME="gitea.elamaras.people.aws.dev"
  GITEA_USERNAME="giteaAdmin"
  GITEA_PASSWORD="mysecretgiteapassword!"
  
  echo "# GITEA INSTALL RESOURCES" >${INSTALL_YAML}
  echo "# This file is auto-generated with 'gitea/generate-manifests.sh'" >>${INSTALL_YAML}
  sed "s/GITEA_USERNAME/${GITEA_USERNAME}/g" ${GITEA_DIR}/gitea-credentials.yaml.tmpl > ${GITEA_DIR}/gitea-credentials.yaml
  sed -i.bak "s/GITEA_PASSWORD/${GITEA_PASSWORD}/g" ${GITEA_DIR}/gitea-credentials.yaml
  
  helm repo add gitea-charts --force-update https://dl.gitea.com/charts/
  helm repo update
  helm template my-gitea gitea-charts/gitea -f ${GITEA_DIR}/values.yaml --version ${CHART_VERSION}>>${INSTALL_YAML}
  sed -i.bak '3d' ${INSTALL_YAML}

  sed -i.bak 's/namespace: default/namespace: gitea/g' ${INSTALL_YAML}
  sed "s/GITEA_DOMAIN_NAME/${GITEA_DOMAIN_NAME}/g" ${GITEA_DIR}/ingress-gitea.yaml.tmpl > ${GITEA_DIR}/ingress-gitea.yaml

  cat ${GITEA_DIR}/ingress-gitea.yaml >>${INSTALL_YAML}

  rm -rf "${INSTALL_YAML}.bak"