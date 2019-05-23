resource "kubernetes_secret" "mysql_creds" {
  metadata {
    name = "mysql-creds"
  }

  data {
    MYSQL_ROOT_PASSWORD = "${var.mysql_password}"
    MYSQL_USER_PASSWORD = "${var.mysql_password}"
  }

  type = "Opaque"
}

