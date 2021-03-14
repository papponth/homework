variable "resource_group_name" {
  description = "Resource Group name"
}
variable "location" {
  description = "Cluster location"
}
variable "address_space" {
  description = "Cluster network"
  type = list(string)
  default = ["10.0.0.0/16"]
}
variable "k8s_cluster_name" {
  description = "Kubernetes Cluster name"
}
variable "dns_prefix" {
  description = "DNS prefix"
  default = "aks"
}
variable "k8s_service_cidr" {
  description = "A CIDR notation IP range from which to assign service cluster IPs."
  default     = "10.10.0.0/16"
}
variable "k8s_dns_service_ip" {
  description = "Containers DNS server IP address."
  default     = "10.10.0.10"
}
variable "k8s_docker_bridge_cidr" {
  description = "A CIDR notation IP for Docker bridge."
  default     = "172.17.0.1/16"
}
variable "client_id" {
  description = "Client's ID from identity"
}
variable "client_secret" {
  description = "Client's Sertificate from identity"
}
variable "object_id" {
  description = "Object ID for role assignment"
  default = ""
 }