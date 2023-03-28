variable "yc_token" {
   default = "t1.9euelZqYlIuVnouUnsuelp6bmZKNme3rnpWax5OVk5eQjpOWkorPm4-RnJbl8_cPcX9e-e8DZ24d_t3z908ffV757wNnbh3-zef1656VmpSYypqTi52QjY7Lz5OMiY6T7_0.l5aCH3dPwLcRSikz8SpJ70S5i2Mo_34pdetpxIlfsfgCd3h8ssLbZ6Tzed9nqlJQCE65KLUIqX4K_7jpekahCQ"
}

variable "yc_cloud_id" {
  default = "b1gjto7m1imcroim1idm"
}

variable "yc_folder_id" {
  default = "b1g1kckip0s6fh9085gq"
}

variable "yc_region" {
  default = "ru-central1-a"
}

variable "yc_k8_v" {
  default = "v1.25"
}

variable "yc_sa_name" {
  default = "aje8ljlhoqlimu0dpnci"
}
# yc iam key create \
#   --service-account-id aje8ljlhoqlimu0dpnci \
#   --folder-name default \
#   --output key.json

# id: ajekg5eltborq40lsvql
# service_account_id: aje8ljlhoqlimu0dpnci
# created_at: "2023-03-09T16:32:52.937960722Z"
# key_algorithm: RSA_2048