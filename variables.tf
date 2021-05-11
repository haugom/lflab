variable "project_id" {
  type = string
  description = "project name"
}

variable "project_region" {
  type = string
  description = "region in cloud provider"
}

variable "project_zone" {
  type = string
  description = "zone in cloud provider"
}

variable "cidr" {
  type    = list(string)
  description = "cidr to represent a network"
}
