# terraform {
#   required_providers {
#     yandex = {
#       source  = "yandex-cloud/yandex"
#       version = "0.86.0"
#     }
#   }
# }
# terraform {
#   required_providers {
#     yandex = {
#       source  = "yandex-cloud/yandex"
#       version = "0.82.0"
#     }
#   }
# }
terraform {
    required_providers {
        yandex = {
            source = "local/hashicorp/yandex"
            version = "0.82.0"
        }
    }
}