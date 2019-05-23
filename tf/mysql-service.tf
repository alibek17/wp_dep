resource "kubernetes_service" "fuchicorp_mysql" {
  metadata {
    name = "fuchicorp-mysql"

    labels {
      app = "fuchicorp"
    }
  }

  spec {
    port {
      port = 3306
    }

    selector {
      app  = "fuchicorp"
      tier = "mysql"
    }

    cluster_ip = "None"
  }
}

