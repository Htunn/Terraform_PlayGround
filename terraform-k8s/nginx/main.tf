terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.16.1"
    }
  }
}
provider "kubernetes" {
  # Configuration options
  config_path    = "~/.kube/config"
  config_context = "default"
}

  