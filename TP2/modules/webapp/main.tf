resource "azurerm_app_service_plan" "plan" {
  name                = "wpdemo-plan-dev"
  location            = var.location
  resource_group_name = var.resource_group_name
  kind                = "Linux"
  reserved            = true

  sku {
    tier     = "Basic"
    size     = "B1"
    capacity = 1
  }
}


resource "azurerm_app_service" "webapp" {
  name                = "${var.prefix}-web-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.plan.id

  site_config {
  linux_fx_version = "DOCKER|wpdemoacrdev.azurecr.io/wordpress-custom:latest"
}

app_settings = {
  WEBSITES_ENABLE_APP_SERVICE_STORAGE = "false"
  DOCKER_REGISTRY_SERVER_URL          = "https://${var.acr_login_server}"
  DOCKER_REGISTRY_SERVER_USERNAME     = var.acr_username
  DOCKER_REGISTRY_SERVER_PASSWORD     = var.acr_password
  WORDPRESS_DB_HOST                   = var.mysql_fqdn
  WORDPRESS_DB_NAME                   = "wordpressdb"
  WORDPRESS_DB_USER                   = "${var.mysql_admin_username}@${var.mysql_fqdn}"
  WORDPRESS_DB_PASSWORD               = var.mysql_admin_password
  WEBSITES_PORT                       = "80"
}

}
