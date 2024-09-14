#!/bin/bash
set -e -o pipefail

REPO_ROOT=$(git rev-parse --show-toplevel)

# Deploy the base cluster with prerequisites like ArgoCD and Ingress-nginx
${REPO_ROOT}/terraform/mgmt-cluster/install.sh

# Set the DNS_HOSTNAME to be checked
export DNS_HOSTNAME=$(kubectl get service  ingress-nginx-controller -n ingress-nginx -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')

# Replace dns with the value of DNS_HOSTNAME
sed -e "s/INGRESS_DNS/${DNS_HOSTNAME}/g" ${REPO_ROOT}/setups/default-config.yaml > ${REPO_ROOT}/setups/config.yaml

# Deploy the apps

${REPO_ROOT}/setups/install.sh

echo "ArgoCD URL is: https://$DNS_HOSTNAME/argocd"

echo "GITEA URL is: https://$DNS_HOSTNAME/gitea"

echo "Keycloak URL is: https://$DNS_HOSTNAME/keycloak"

echo "Backstage URL is: https://$DNS_HOSTNAME/"

echo "ArgoWorkflows URL is: https://$DNS_HOSTNAME/argo-workflows"



# # Function to check if the dns is null or empty
# check_dnshost() {
#     if [ -z "$DNS_HOSTNAME" ]; then
#         echo "DNS_HOSTNAME is empty or null."
#         return 0  # Return true (0) if the DNS_HOSTNAME is empty or null
#     else
#         echo "DNS_HOSTNAME is not empty or null."
#         return 1  # Return false (1) if the DNS_HOSTNAME is not empty or null
#     fi
# }

# # Counter for retry attempts
# retry_count=0
# max_retries=3

# # Loop to retry the operation
# while true; do
#     # Check the DNS_HOSTNAME
#     check_dnshost

#     # If the dns host is empty or null, sleep for 5 minutes
#     if [ $? -eq 0 ]; then
#         echo "Sleeping for 5 minutes..."
#         sleep 5m
#         retry_count=$((retry_count+1))

#         # Check if the maximum number of retries has been reached
#         if [ $retry_count -eq $max_retries ]; then
#             echo "Maximum number of retries reached. Exiting with error."
#             exit 1
#         fi
#     else
#         echo "DNS_HOSTNAME is not empty or null. Exiting."
#         exit 0
#     fi
# done

