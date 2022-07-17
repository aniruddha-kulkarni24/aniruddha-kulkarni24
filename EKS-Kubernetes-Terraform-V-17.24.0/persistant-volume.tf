resource "kubernetes_persistent_volume_v1" "avalanche-claim0-persistent_volume" {
  metadata {
    name = "avalanche-claim0-volume"
    labels = {
      name = "avalanche-claim0-persistent_volume"
    }
  }
  spec {
    capacity = {
      storage = "700Gi"
    }
    access_modes = ["ReadWriteOnce"]
    persistent_volume_source {
      aws_elastic_block_store {
        volume_id = aws_ebs_volume.avalanche-claim0_volume.id
      }
    }
    storage_class_name = "avalanche-storage-class"
  }
  depends_on = [aws_ebs_volume.avalanche-claim1_volume]
}


resource "kubernetes_persistent_volume_v1" "avalanche-claim1-persistent_volume" {
  metadata {
    name = "avalanche-claim1-volume"
    labels = {
      name = "avalanche-claim1-persistent_volume"
    }

  }
  spec {
    capacity = {
      storage = "700Gi"
    }
    access_modes = ["ReadWriteOnce"]
    persistent_volume_source {
      aws_elastic_block_store {
        volume_id = aws_ebs_volume.avalanche-claim1_volume.id
      }
    }
    storage_class_name = "avalanche-storage-class"
  }
 depends_on = [kubernetes_persistent_volume_v1.avalanche-claim0-persistent_volume]

}
             
