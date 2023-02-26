# Verify the results: Test the Kubernetes cluster

az aks get-credentials --name <aks_cluster_name>  \
   --resource-group <resource_group_name> \
   --overwrite-existing

kubectl get nodes

# Install Azure AD Pod Identity

# Install Helm

#  Install AGIC Helm Chart

wget https://raw.githubusercontent.com/Azure/application-gateway-kubernetes-ingress/master/docs/examples/sample-helm-config.yaml -O helm-config.yaml

