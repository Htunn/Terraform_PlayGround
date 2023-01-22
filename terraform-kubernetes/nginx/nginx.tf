resource "kubernetes_deployment_v1" "nginx_k8s" {
  metadata {
    name = "htunn-k8s"
    labels = {
      test = "htunn-nginx"
    }
  }

  spec {
    replicas = 0

    selector {
      match_labels = {
        test = "htunn-nginx"
      }
    }

    template {
      metadata {
        labels = {
          test = "htunn-nginx"
        }
      }

      spec {
        container {
          image = "nginx:1.21.6"
          name  = "htunn-nginx"

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }

          liveness_probe {
            http_get {
              path = "/"
              port = 80

              http_header {
                name  = "X-Custom-Header"
                value = "Awesome"
              }
            }

            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }
      }
    }
  }
}