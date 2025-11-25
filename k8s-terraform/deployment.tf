resource "kubernetes_deployment" "backend_app" {
  metadata {
    name      = "backend-deployment"
    namespace = kubernetes_namespace.demo.metadata[0].name
    labels = {
      app = "backend"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "backend"
      }
    }

    template {
      metadata {
        labels = {
          app = "backend"
        }
      }

      spec {
        container {
          image = "nginx:stable-alpine"
          name  = "backend"

          port {
            container_port = 80
          }
        }
      }
    }
  }
}
