provider "kubernetes" {
#  load_config_file       = "false"
  host                   = var.k8s_api_host
  username               = var.cluster_username
  password               = var.cluster_password
  client_certificate     = base64decode(var.client_certificate)
  client_key             = base64decode(var.client_key)
  cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
}

resource "kubernetes_deployment" "app_deploy" {
  metadata {
    name = var.app_name
    labels = {
      app = var.app_name
    }
  }
  spec {
    replicas = var.app_replicas_count

    selector {
      match_labels = {
        app = var.app_name
      }
    }
    template {
      metadata {
        labels = {
          app = var.app_name
        }
      }
      spec {
        container {
          image = var.image
          name  = var.app_name
          image_pull_policy = var.image_pull_policy
          port {
            container_port = var.container_port
          }
          resources {
            limits = {
              cpu    = var.cpu_limit
              memory = var.mem_limit
            }
            requests = {
              cpu    = var.cpu_request
              memory = var.mem_request
            }
          }
          liveness_probe {
            http_get {
              path = var.liveness_probe_path
              port = var.liveness_probe_port
            }
            initial_delay_seconds = var.liveness_initial_delay
            period_seconds        = var.liveness_probe_period
          }
          readiness_probe {
           http_get {
              path = var.readiness_probe_path
              port = var.readiness_probe_port
           }
           initial_delay_seconds = var.readiness_initial_delay
           period_seconds = var.readiness_probe_period
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "app_service" {
  metadata {
    name = "${var.app_name}-service"
  }
  spec {
    selector = {
      app = var.app_name
    }
    session_affinity = "ClientIP"
    port {
      port        = var.service_port
      target_port = var.container_port
    }

    type = "LoadBalancer"
  }
}

resource "kubernetes_ingress" "app_ingress" {
  metadata {
    name = "${var.app_name}-ingress"
  }

  spec {
    backend {
      service_name = "${var.app_name}-service"
      service_port = var.service_port
    }

  }
}