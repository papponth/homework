# homework

This is my home task
It creates Kubernetes cluster in Azure Cloud with ingress and deploys simple application to cluster via Terraform

template for `variables.auto.tfvars` file:
```
subscription_id = "value"
k8s_version = "value"
k8s_network = "value"
k8s_cluster_name = "value"
resource_group_name = "value"

#####################Application########################
  app_name = "value"
  image = "value"
  image_tag = "value"
  image_pull_policy = "value"
  container_port = "value"
  service_port = "value"
  app_replicas_count = "value"
  cpu_limit = "value"
  mem_limit = "value"
  cpu_request = "value"
  mem_request = "value"
  liveness_probe_path = "value"
  liveness_probe_port = "value"
  liveness_initial_delay = "value"
  liveness_probe_period = "value"
  readiness_probe_path = "value"
  readiness_probe_port = "value"
  readiness_initial_delay = "value"
  readiness_probe_period = "value"
```