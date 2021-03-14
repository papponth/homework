resource "azurerm_resource_group" "aks_cloud" {
  name = var.resource_group_name
  location = var.location
}
# creating virtual network fr cluster
resource "azurerm_virtual_network" "virtual_network" {
  name                = "virtual_network"
  location            = azurerm_resource_group.aks_cloud.location
  resource_group_name = azurerm_resource_group.aks_cloud.name
  address_space       = var.address_space
}
# getting public IP for ingress controller
resource "azurerm_public_ip" "load_balancer" {
  name                = "virtual_network"
  location            = azurerm_resource_group.aks_cloud.location
  resource_group_name = azurerm_resource_group.aks_cloud.name
  allocation_method = "Static"
  sku = "Standard"
}
# assigning role Network Contributor to service principal 
# otherwise it won't get Public IP. I know it's not secure, but it's easy. 
resource "azurerm_role_assignment" "role_assignment_nc" {
  scope  = azurerm_resource_group.aks_cloud.id
  role_definition_name = "Network Contributor"
  principal_id  = var.object_id
  depends_on = [azurerm_virtual_network.virtual_network]
}
#creating workspace for native Azure analytics
resource "azurerm_log_analytics_workspace" "log_analytics" {
  name                = "log-analytics-32167"
  location            = azurerm_resource_group.aks_cloud.location
  resource_group_name = azurerm_resource_group.aks_cloud.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}
#creating linking k8s to analytics workspace
resource "azurerm_log_analytics_solution" "k8s_analytics" {
  solution_name         = "ContainerInsights"
  location              = azurerm_log_analytics_workspace.log_analytics.location
  resource_group_name   = azurerm_resource_group.aks_cloud.name
  workspace_resource_id = azurerm_log_analytics_workspace.log_analytics.id
  workspace_name        = azurerm_log_analytics_workspace.log_analytics.name
  plan {
      publisher = "Microsoft"
      product   = "OMSGallery/ContainerInsights"
  }
}
#creating k8s cluster
resource "azurerm_kubernetes_cluster" "k8s_cluster" {
  name                = var.k8s_cluster_name
  location            = azurerm_resource_group.aks_cloud.location
  resource_group_name = azurerm_resource_group.aks_cloud.name
  dns_prefix          = var.dns_prefix
  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }
  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }
  network_profile {
    network_plugin     = "azure"
    dns_service_ip     = var.k8s_dns_service_ip
    docker_bridge_cidr = var.k8s_docker_bridge_cidr
    service_cidr       = var.k8s_service_cidr
  }
  addon_profile {
    http_application_routing {
      enabled = false
    }
    kube_dashboard {
        enabled = true
    }
    oms_agent {
        enabled                    = true
        log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics.id
    }
  }
}



