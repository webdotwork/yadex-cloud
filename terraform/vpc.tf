# VPC network
resource "yandex_vpc_network" "network" {
  name = "network"
}
# # VPC subnet
# resource "yandex_vpc_subnet" "subnet" {
#   #count          = 3
#   name           = "subnet-${var.yc_region}"
#   v4_cidr_blocks = ["10.0.10.0/24"]
#   zone           = var.yc_region
#   network_id     = yandex_vpc_network.network.id
# }

resource "yandex_vpc_subnet" "subnet10" {
  name           = "subnet_10"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["10.0.10.0/24"]
}

resource "yandex_vpc_subnet" "subnet20" {
  name           = "subnet_20"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["10.0.20.0/24"]
}

resource "yandex_vpc_subnet" "subnet30" {
  name           = "subnet_30"
  zone           = "ru-central1-c"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["10.0.30.0/24"]
}