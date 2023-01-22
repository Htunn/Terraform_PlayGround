# Provision an EKS Cluster with nodegroup EC2 type

# Configure kubectl after EKS deployment  

aws eks --region $(terraform output -raw region) update-kubeconfig \
    --name $(terraform output -raw cluster_name)