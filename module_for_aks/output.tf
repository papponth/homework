output "external_address" {
  value = azurerm_public_ip.load_balancer.ip_address
}
output "client_certificate" {
  value = azurerm_kubernetes_cluster.k8s_cluster.kube_config.0.client_certificate
}
output "kube_config" {
  value = azurerm_kubernetes_cluster.k8s_cluster.kube_config_raw
}
output "client_key" {
  value = azurerm_kubernetes_cluster.k8s_cluster.kube_config.0.client_key
}
output "cluster_ca_certificate" {
  value = azurerm_kubernetes_cluster.k8s_cluster.kube_config.0.cluster_ca_certificate
}
output "cluster_username" {
  value = azurerm_kubernetes_cluster.k8s_cluster.kube_config.0.username
}
output "cluster_password" {
  value = azurerm_kubernetes_cluster.k8s_cluster.kube_config.0.password
}
output "host" {
  value = azurerm_kubernetes_cluster.k8s_cluster.kube_config.0.host
}