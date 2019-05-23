resource "kubernetes_deployment" "fuchicorp_mysql" {
  metadata {
    name = "fuchicorp-mysql"

    labels {
      app = "fuchicorp"
    }
  }

  spec {
    selector {
      match_labels {
        app  = "fuchicorp"
        tier = "mysql"
      }
    }

    template {
      metadata {
        labels {
          app  = "fuchicorp"
          tier = "mysql"
        }
      }

      spec {
        volume {
          name = "mysql-local-storage"

          persistent_volume_claim {
            claim_name = "mysql-pv-claim"
          }
        }

        container {
          name  = "mysql"
          image = "fsadykov/centos_mysql"

          port {
            name           = "mysql"
            container_port = 3306
          }

          env {
            name = "MYSQL_ROOT_PASSWORD"

            value_from {
              secret_key_ref {
                name = "mysql-creds"
                key  = "MYSQL_ROOT_PASSWORD"
              }
            }
          }

          env {
            name = "MYSQL_PASSWORD"

            value_from {
              secret_key_ref {
                name = "mysql-creds"
                key  = "MYSQL_USER_PASSWORD"
              }
            }
          }

          env {
            name  = "MYSQL_USER"
            value = "fuchicorp"
          }

          env {
            name  = "MYSQL_DATABASE"
            value = "fuchicorp"
          }
        }
      }
    }

    strategy {
      type = "Recreate"
    }
  }
}

