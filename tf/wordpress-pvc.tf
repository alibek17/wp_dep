resource "kubernetes_persistent_volume_claim" "wp_lv_claim" {
  metadata {
    name = "wp-lv-claim"

    labels {
      app = "wordpress"
    }
  }

  spec {
    access_modes = ["ReadWriteOnce"]

    resources {
      requests {
        storage = "10Gi"
      }
    }
  }
}

