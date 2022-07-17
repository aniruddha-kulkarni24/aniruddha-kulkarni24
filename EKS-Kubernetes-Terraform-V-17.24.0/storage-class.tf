
resource "kubernetes_storage_class_v1" "avalanche-claim0-storage-class" {
  metadata {
    name = "avalanche-storage-class"
  }
  storage_provisioner = "kubernetes.io/aws-ebs"
  reclaim_policy      = "Retain"
  parameters = {
    type = "gp2"
    fs_type = "ext4"
  }
  volume_binding_mode = "Immediate"
}
