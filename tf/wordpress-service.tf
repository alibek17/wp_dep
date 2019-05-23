resource "kubernetes_service" "wordpress" {
  metadata {
    name = "wordpress"

    labels {
      app = "wordpress"
    }
  }

  spec {
    port {
      port        = 80
      target_port = "80"
    }

    selector {
      app  = "wordpress"
      tier = "frontend"
    }

    type = "LoadBalancer"
  }
}

