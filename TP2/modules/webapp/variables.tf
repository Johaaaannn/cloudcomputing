variable "prefix" {}
variable "location" {}
variable "environment" {}
variable "resource_group_name" {}

variable "acr_login_server" {}
variable "acr_username" {}
variable "acr_password" {}
variable "image_name" {}  # ex: wordpress-custom

variable "mysql_fqdn" {
  description = "FQDN du serveur MySQL"
  type        = string
}
variable "mysql_admin_username" {}
variable "mysql_admin_password" {}
