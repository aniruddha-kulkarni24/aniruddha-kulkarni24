resource "kubernetes_service_v1" "avalanche-service" {
  metadata {
    name      = "avalanche"
  }
  spec {
    type = "LoadBalancer"
    port {
      name        = "9650"
      port        = 9650
      target_port = 9650
    }
    port {
      name        = "9651"
      port        = 9651
      target_port = 9651
    }

  }
depends_on = [kubernetes_deployment_v1.avalanche-deployment]

}

locals {
  lb_name = split("-", split(".", kubernetes_service_v1.avalanche-service.status.0.load_balancer.0.ingress.0.hostname).0).0
}

# Read information about the load balancer using the AWS provider.
data "aws_elb" "example" {
  name = local.lb_name
}

output "load_balancer_name" {
  value = local.lb_name
}

output "load_balancer_hostname" {
  value = kubernetes_service_v1.avalanche-service.status.0.load_balancer.0.ingress.0.hostname
}

output "load_balancer_info" {
  value = data.aws_elb.example
}


