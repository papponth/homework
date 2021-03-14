provider "kubernetes" {
#  load_config_file       = "false"
  host                   = var.k8s_api_host
  username               = var.cluster_username
  password               = var.cluster_password
  client_certificate     = base64decode(var.client_certificate)
  client_key             = base64decode(var.client_key)
  cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
#    load_config_file = "false"
    host                   = var.k8s_api_host
    username               = var.cluster_username
    password               = var.cluster_password
    client_certificate     = base64decode(var.client_certificate)
    client_key             = base64decode(var.client_key)
    cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
  }
}

resource "helm_release" "ingress_nginx" {
  name = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart = "ingress-nginx"
  set {
    name = "controller.service.loadBalancerIP"
    value = var.external_address
  }

   set {
    name  = "rbac.create"
    value = "true"
  }
  set {
    name = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/azure-load-balancer-resource-group"
    value = var.resource_group_name
    type = "string"
  }



  values = [ <<EOF
    controller:
      config:
        use-proxy-protocol: "false"
        proxy-buffer-size: 16k
        proxy-buffers: "8 16k"
        proxy-body-size: "0"

      publishService:
        enabled: true
      metrics:
        enabled: true
      service:
        externalTrafficPolicy: "Local"

EOF
]

# #wait = false

}