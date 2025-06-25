variable "prefix" {}
variable "location" {}
variable "environment" {}
variable "mysql_admin_username" {}
variable "mysql_admin_password" {}
variable "mysql_fqdn" {
  description = "FQDN du serveur MySQL"
  type        = string
}
variable "acr_login_server" {
  description = "URL du registre ACR"
  type        = string
}

variable "acr_username" {
  description = "Nom d’utilisateur du registre ACR"
  type        = string
}

variable "acr_password" {
  description = "Mot de passe du registre ACR"
  type        = string
  sensitive   = true
}