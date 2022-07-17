resource "kubernetes_persistent_volume_claim_v1" "avalanche-claim0-persistent_volume_claim" {

  metadata {
    name = "avalanche-claim0"
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "700Gi"
    
      }
    }
  storage_class_name = "avalanche-storage-class"
  selector {
    match_labels = {
        name = "avalanche-claim0-persistent_volume"
    }
  }
  volume_name = "${kubernetes_persistent_volume_v1.avalanche-claim0-persistent_volume.metadata.0.name}"
}

depends_on = [kubernetes_persistent_volume_v1.avalanche-claim1-persistent_volume]
}

resource "kubernetes_persistent_volume_claim_v1" "avalanche-claim1-persistent_volume_claim" {

  metadata {
    name = "avalanche-claim1"
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "700Gi"
      }
    }
  storage_class_name = "avalanche-storage-class"
  selector {
    match_labels = {
        name = "avalanche-claim1-persistent_volume"
    }
  }

  volume_name = "${kubernetes_persistent_volume_v1.avalanche-claim1-persistent_volume.metadata.0.name}"
}

depends_on = [kubernetes_persistent_volume_claim_v1.avalanche-claim0-persistent_volume_claim]
}

