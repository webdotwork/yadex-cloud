output "internal_ip_address_node1" {
  value = yandex_compute_instance.node1.network_interface.0.ip_address
}
output "internal_ip_address_node2" {
  value = yandex_compute_instance.node2.network_interface.0.ip_address
}

output "external_ip_address_node1" {
  value = yandex_compute_instance.node1.network_interface.0.nat_ip_address
}
output "external_ip_address_node2" {
  value = yandex_compute_instance.node2.network_interface.0.nat_ip_address
}

# output "internal_ip_address_node3" {
#   value = yandex_compute_instance.node3.network_interface.0.ip_address
# }
# output "external_ip_address_node3" {
#   value = yandex_compute_instance.node3.network_interface.0.nat_ip_address
# }

# output "yandex_vpc_subnet" {
#   value = resource.yandex_vpc_subnet.subnet[count.index]
# }