resource "yandex_compute_instance" "node1" {
  name     = "node1"
  hostname = "node1"
  zone     = "ru-central1-a" #var.yc_region

  resources {
    cores  = 4
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8h34rub6pjpg4qgi8j" // ubuntu-1804-lts
      type     = "network-hdd"
      size     = "40"
    }
  }

  network_interface {
    subnet_id   = yandex_vpc_subnet.subnet10.id
    nat         = true
    ipv6        = false
  }

  #metadata = {
  #ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  #  user-data = "${file("/home/www/Desktop/CI/yandex/terraform/meta.txt")}"
  #}
  metadata = {
    user-data = "${file("meta.txt")}"
  }
}

resource "yandex_compute_instance" "node2" {
  name     = "node2"
  hostname = "node2"
  zone     = "ru-central1-b" #var.yc_region

  resources {
    cores  = 4
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8h34rub6pjpg4qgi8j" // ubuntu-1804-lts
      type     = "network-hdd"
      size     = "40"
    }
  }

  network_interface {
    subnet_id   = yandex_vpc_subnet.subnet20.id
    nat         = true
    ipv6        = false
  }

  #   metadata = {
  #   ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  # }
  metadata = {
    user-data = "${file("meta.txt")}"
  }
}

resource "yandex_compute_instance" "node3" {
  name     = "node3"
  hostname = "node3"
  zone     = "ru-central1-c" #var.yc_region

  resources {
    cores  = 4
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8h34rub6pjpg4qgi8j" // ubuntu-1804-lts
      type     = "network-hdd"
      size     = "40"
    }
  }

  network_interface {
    subnet_id   = yandex_vpc_subnet.subnet30.id
    nat         = true
    ipv6        = false
  }

  #   metadata = {
  #   ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  # }
  metadata = {
    user-data = "${file("meta.txt")}"
  }
}

# resource "yandex_compute_instance" "node3" {
#   name     = "node3"
#   hostname = "node3"
#   zone     = var.yc_region

#   resources {
#     cores  = 4
#     memory = 4
#   }

#   boot_disk {
#     initialize_params {
#       image_id = "fd8h34rub6pjpg4qgi8j" // ubuntu-1804-lts
#       type     = "network-hdd"
#       size     = "40"
#     }
#   }

#   network_interface {
#     subnet_id   = yandex_vpc_subnet.subnet[0].id
#     ipv6        = false
#   }

#   metadata = {
#     user-data = "${file("meta.txt")}"
#   }
# }

# # resource "yandex_compute_instance" "gitlab" {
# #   name     = "gitlab"
# #   hostname = "gitlab.podkovka.ru.net"
# #   zone     = var.zones[1]

# #   resources {
# #     cores  = 4
# #     memory = 4
# #   }

# #   boot_disk {
# #     initialize_params {
# #       image_id = "fd8h34rub6pjpg4qgi8j" // ubuntu-1804-lts
# #       type     = "network-hdd"
# #       size     = "10"
# #     }
# #   }

# #   network_interface {
# #     subnet_id   = yandex_vpc_subnet.subnet[1].id
# #     ipv6        = false
# #   }

# #   metadata = {
# #     user-data = "${file("meta.txt")}"
# #   }
# # }

# # resource "yandex_compute_instance" "runner" {
# #   name     = "runner"
# #   hostname = "runner.podkovka.ru.net"
# #   zone     = var.zones[2]

# #   resources {
# #     cores  = 4
# #     memory = 4
# #   }

# #   boot_disk {
# #     initialize_params {
# #       image_id = "fd8h34rub6pjpg4qgi8j" // ubuntu-1804-lts
# #       type     = "network-hdd"
# #       size     = "10"
# #     }
# #   }

# #   network_interface {
# #     subnet_id   = yandex_vpc_subnet.subnet[2].id
# #     ipv6        = false
# #   }

# #   metadata = {
# #     user-data = "${file("meta.txt")}"
# #   }
# # }

# # resource "yandex_compute_instance" "monitoring" {
# #   name     = "monitoring"
# #   hostname = "monitoring.podkovka.ru.net"
# #   zone     = var.zones[0]

# #   resources {
# #     cores  = 4
# #     memory = 4
# #   }

# #   boot_disk {
# #     initialize_params {
# #       image_id = "fd8h34rub6pjpg4qgi8j" // ubuntu-1804-lts
# #       type     = "network-hdd"
# #       size     = "10"
# #     }
# #   }

# #   network_interface {
# #     subnet_id   = yandex_vpc_subnet.subnet[0].id
# #     ipv6        = false
# #   }

# #   metadata = {
# #     user-data = "${file("meta.txt")}"
# #   }
# # }