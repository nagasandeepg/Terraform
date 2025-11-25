resource "kubernetes_service" "backend_service" {
  metadata {
    name      = "backend-service"
    namespace = kubernetes_namespace.demo.metadata[0].name
  }

  spec {
    selector = {
      app = "backend"
    }

    port {
      port        = 80
      target_port = 80
      node_port   = 30001
    }

    type = "NodePort"
  }
}
