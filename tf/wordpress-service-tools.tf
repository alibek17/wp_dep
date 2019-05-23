resource "kubernetes_service" "wordpress_tools" {
  metadata {
    name      = "wordpress-tools"
    namespace = "tools"
  }

  spec {
    port {
      port = 80
    }

    type          = "ExternalName"
    external_name = "wordpress.default.svc.cluster.local"
  }
}

