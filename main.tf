provider "azurerm" {
    subscription_id = var.subscription_id 
    features {}
}

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "=2.40.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = ">= 2.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = ">= 2.0"
    }
  }
}

module "identity" {
  source = "./identity"
  k8s_cluster_name = var.k8s_cluster_name
}

module "aks" {
  source = "./module_for_aks"
  k8s_cluster_name = var.k8s_cluster_name
  resource_group_name = var.resource_group_name
  location = var.location
  client_id = module.identity.cluster_client_id
  client_secret = module.identity.cluster_sp_secret
  object_id = module.identity.cluster_object_id
  depends_on = [ module.identity ]
}

module "k8s" {
  source = "./module_for_k8s"
  resource_group_name = var.resource_group_name
  client_certificate = module.aks.client_certificate
  kube_config = module.aks.kube_config
  client_key = module.aks.client_key
  cluster_ca_certificate = module.aks.cluster_ca_certificate
  cluster_username = module.aks.cluster_username
  cluster_password = module.aks.cluster_password
  k8s_api_host = module.aks.host
#  depends_on = [ module.aks ]
  external_address = module.aks.external_address
}

module "app" {
  source = "./module_for_app"
  resource_group_name = var.resource_group_name
  client_certificate = module.aks.client_certificate
  kube_config = module.aks.kube_config
  client_key = module.aks.client_key
  cluster_ca_certificate = module.aks.cluster_ca_certificate
  cluster_username = module.aks.cluster_username
  cluster_password = module.aks.cluster_password
  k8s_api_host = module.aks.host
  app_name = var.app_name
  image = var.image
  image_pull_policy = var.image_pull_policy
  app_replicas_count = var.app_replicas_count
  container_port = var.container_port
  service_port = var.service_port
  cpu_limit = var.cpu_limit
  mem_limit = var.mem_limit
  cpu_request = var.cpu_request
  mem_request = var.mem_request
  liveness_probe_path = var.liveness_probe_path
  liveness_probe_port = var.liveness_probe_port
  liveness_initial_delay = var.liveness_initial_delay
  liveness_probe_period = var.liveness_probe_period
  readiness_probe_path = var.readiness_probe_path
  readiness_probe_port = var.readiness_probe_port
  readiness_initial_delay = var.readiness_initial_delay
  readiness_probe_period = var.readiness_probe_period
#  depends_on = [ module.aks ]
}
