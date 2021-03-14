#subscription
variable "subscription_id" {
  description = "Azure Subscription ID"
}
variable "location" {
  description = "Cluster location"
  default = "West Europe"
}
variable "k8s_version" {
  description = "Kubernetes version"
}
variable "k8s_network" {
  description = "Kubernetes network"
}
variable "k8s_cluster_name" {
  description = "Kubernetes Cluster name"
}
variable "resource_group_name" {
  description = "Resource Group name"
}


##############Application################
variable "app_name" {
  description = "Application name"
}
variable "image" {
  description = "Application's image"
}
variable "image_tag" {
  description = "tag"
}
variable "image_pull_policy" {
  description = "pull policy for App's image"
}
variable "container_port" {
  description = "Container's exposed port"
}
variable "app_replicas_count" {
  description = "neded number of replicas"
}
variable "service_port" {
  description = "service port"
}
variable "cpu_limit" {
  description = "CPU limit"
}
variable "mem_limit" {
  description = "Memory limit"
}
variable "cpu_request" {
  description = "CPU request"
}
variable "mem_request" {
  description = "Memory requesr"
}
variable "liveness_probe_path" {
  description = "path for liveness probe"
}
variable "liveness_probe_port" {
  description = "port for liveness probe"
}
variable "liveness_initial_delay" {
  description = "initial delay for liveness probe"
}
variable "liveness_probe_period" {
  description = "liveness probe period in sec"
}
variable "readiness_probe_path" {
  description = "readiness probe path"
}
variable "readiness_probe_port" {
  description = "readiness probe port"
}
variable "readiness_initial_delay" {
  description = "readiness initial delay in sec"
}
variable "readiness_probe_period" {
  description = "readiness probe period in sec"
}
