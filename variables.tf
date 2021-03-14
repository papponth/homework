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
  description = "value"
}
variable "image" {
  description = "value"
}
variable "image_tag" {
  description = "value"
}
variable "image_pull_policy" {
  description = "value"
}
variable "container_port" {
  description = "value"
}
variable "app_replicas_count" {
  description = "value"
}
variable "service_port" {
  description = "value"
}
variable "cpu_limit" {
  description = "value"
}
variable "mem_limit" {
  description = "value"
}
variable "cpu_request" {
  description = "value"
}
variable "mem_request" {
  description = "value"
}
variable "liveness_probe_path" {
  description = "value"
}
variable "liveness_probe_port" {
  description = "value"
}
variable "liveness_initial_delay" {
  description = "value"
}
variable "liveness_probe_period" {
  description = "value"
}
variable "readiness_probe_path" {
  description = "value"
}
variable "readiness_probe_port" {
  description = "value"
}
variable "readiness_initial_delay" {
  description = "value"
}
variable "readiness_probe_period" {
  description = "value"
}
