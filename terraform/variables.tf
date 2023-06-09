variable "yc_token" {
   default = "t1.9euelZqOnZ6Wj5SOj43MlcuWjIucme3rnpWax5OVk5eQjpOWkorPm4-RnJbl9PdYTHle-e9sIGfI3fT3GHt2XvnvbCBnyM3n9euelZqUmMqak4udkI2Oy8-TjImOk-_9.b3_MU3Dt_bjDkAi8vWkDwngvJpTU4whpfGImrf1sHUGV4YfyKHHX229wv9qpwkm0d7LL_iCOVpEF7kPs6htZAw"
}

variable "yc_cloud_id" {
  default = "b1gjto7m1imcroim1idm"
}

variable "yc_folder_id" {
  default = "b1g1kckip0s6fh9085gq"
}

variable "yc_k8_v" {
  default = "v1.25"
}

variable "yc_sa_name" {
  default = "webdotwork"
}

variable "yc_region" {
  default = "ru-central1-a"
}


# yc iam key create \
#   --service-account-id aje8ljlhoqlimu0dpnci \
#   --folder-name default \
#   --output key.json

# id: ajekg5eltborq40lsvql
# service_account_id: aje8ljlhoqlimu0dpnci
# created_at: "2023-03-09T16:32:52.937960722Z"
# key_algorithm: RSA_2048