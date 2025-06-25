variable "prefix" {
  description = "Préfixe du nom des ressources"
  type        = string
}

variable "location" {
  description = "Région Azure"
  type        = string
}

variable "environment" {
  description = "Environnement (ex: dev, prod)"
  type        = string
}

variable "resource_group_name" {
  description = "Nom du groupe de ressources"
  type        = string
}