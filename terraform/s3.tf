terraform {
  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "nlab"
    region     = "ru-central1"
    key        = "terraform/terraform.tfstate"
    access_key = "YCAJEQIhNU4RSfazazVLJCXSi"
    secret_key = "YCN0LacUVo83HPr8Yj61yQsd0HNg3ThtJk2T2Ajg"
    skip_region_validation      = true
    skip_credentials_validation = true
  }
}