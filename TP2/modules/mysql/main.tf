resource "azurerm_mysql_flexible_server" "mysql" {
  name                = var.mysql_server_name
  resource_group_name = var.resource_group_name
  location            = "francecentral"
  administrator_login = var.admin_username
  administrator_password = var.admin_password

  sku_name = "B_Standard_B1ms"
  version  = "8.0.21"

  storage {
    size_gb             = 32
    auto_grow_enabled   = true
    log_on_disk_enabled = false
  }

  lifecycle {
    ignore_changes = [
      zone
    ]
  }

}

resource "azurerm_mysql_flexible_database" "wordpress" {
  name                = "wordpressdb"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_flexible_server.mysql.name
  charset             = "utf8mb4"
  collation           = "utf8mb4_unicode_ci"
}