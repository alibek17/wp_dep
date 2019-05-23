resource "kubernetes_deployment" "wordpress" {
  metadata {
    name = "wordpress"

    labels {
      app = "wordpress"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels {
        app = "wordpress"
      }
    }
    template {
      metadata {
        labels {
          tier = "frontend"
          app  = "wordpress"
        }
      }

      spec {
        volume {
          name = "wordpress-local-storage"

          persistent_volume_claim {
            claim_name = "wp-lv-claim"
          }
        }

        container {
          name  = "wordpress"
          image = "wordpress:5.1.1-php7.1-apache"

          port {
            name           = "wordpress"
            container_port = 80
          }

          env {
            name  = "WORDPRESS_DB_HOST"
            value = "fuchicorp-mysql"
          }

          env {
            name  = "WORDPRESS_DB_USER"
            value = "fuchicorp"
          }

          env {
            name = "WORDPRESS_DB_PASSWORD"

            value_from {
              secret_key_ref {
                name = "mysql-creds"
                key  = "MYSQL_USER_PASSWORD"
              }
            }
          }

          env {
            name  = "WORDPRESS_DB_NAME"
            value = "fuchicorp"
          }

          volume_mount {
            name       = "wordpress-local-storage"
            mount_path = "/var/www/html"
          }
        }
      }
    }
  }
}

