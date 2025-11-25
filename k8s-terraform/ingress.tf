resource "kubernetes_ingress_v1" "backend_ingress" {
  metadata {
    name      = "backend-ingress"
    namespace = kubernetes_namespace.demo.metadata[0].name
    annotations = {
      "kubernetes.io/ingress.class" = "traefik"
    }
  }

  spec {
    rule {
      http {
        path {
          path     = "/"
          path_type = "Prefix"

          backend {
            service {
              name = kubernetes_service.backend_service.metadata[0].name
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}
