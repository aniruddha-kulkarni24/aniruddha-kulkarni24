provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  token                  = data.aws_eks_cluster_auth.cluster.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", local.cluster_name]
    command     = "aws"
  }
}

resource "kubernetes_deployment_v1" "avalanche-deployment" {
  metadata {
    labels = {
       service = "avalanche"
    }
    name = "avalanche"

  }
  spec {
    replicas = 1
    selector {
    match_labels = {
      service = "avalanche"
    }  
    }
    strategy {
      type = "Recreate"
    }
    template {
      metadata {
        name = "avalanche"
	labels = {
          service = "avalanche"
        }
    }
      
      spec {
        container {
          args = [
		"/avalanchego/build/avalanchego",
                 "--db-dir=/data/avax",
                 "--api-admin-enabled=true",
                 "--http-host=0.0.0.0",
                 "' --staking-tls-cert-file=/keys/staker.crt'",
                 "' --staking-tls-key-file=/keys/staker.key'" 
	  ]
          image = "avaplatform/avalanchego"
          name  = "avax"
          port {
            container_port =  9650
          }
	  port {
            container_port =  9651
          }

          resources  {}
          #requests:
          #    memory: "400Gi"
          volume_mount {
            mount_path = "/data/avax"
            name       = "avalanche-claim0"
	  }
	  volume_mount {
 	     mount_path = "/keys"
 		name	= "avalanche-claim1"
          }
        }
        restart_policy = "Always"
        volume {
          name = "avalanche-claim0"
          persistent_volume_claim  {
          claim_name = "avalanche-claim0"
	 }
        }
	volume {
	  name = "avalanche-claim1"
          persistent_volume_claim  {
          claim_name = "avalanche-claim1" 
          }
        }
      }
    }
  }

depends_on = [kubernetes_persistent_volume_claim_v1.avalanche-claim1-persistent_volume_claim]
}

