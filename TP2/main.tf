provider "azurerm" {
  features {}

  subscription_id = "2f73798a-dd0a-4bec-91fe-103973fd77eb"
}


resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-rg-${var.environment}"
  location = var.location
}

module "acr" {
  source              = "./modules/acr"
  prefix              = var.prefix
  environment         = var.environment
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

module "mysql" {
  source              = "./modules/mysql"
  mysql_server_name   = "wpdemo-mysql-dev"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  admin_username      = var.mysql_admin_username
  admin_password      = var.mysql_admin_password
}

module "webapp" {
  source              = "./modules/webapp"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  # DB
  mysql_fqdn           = module.mysql.mysql_fqdn
  mysql_admin_username = var.mysql_admin_username
  mysql_admin_password = var.mysql_admin_password

  # ACR (registre docker)
  acr_login_server = module.acr.login_server
  acr_username     = module.acr.admin_username
  acr_password     = module.acr.admin_password

  # Config WordPress
  image_name  = "wordpress-custom:latest"
  prefix      = var.prefix
  environment = var.environment
}
