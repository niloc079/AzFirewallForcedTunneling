#
#Tags
variable "identifier" {
  type = string
}

variable "environment" {
  type = string
}

variable "application" {
  type = string
}

variable "location" {
  type = string
}

variable "iteration" {
  type = string
}

variable "application_owner" {
  type = string
}

variable "deployment_source" {
  type = string
}

variable "tags" {
  type = map
}

#VNG
variable "defaultroutecidr" {
  type = string
}

variable "lng_shared_key" {
  type = string
  sensitive = true
}

variable "lng_address" {
  type = string
}

variable "lng_cidr" {
  type = list(string)
}

#AFW
variable "vnet_cidr" {
  type = list(string)
}

variable "vnet_cidr_sub1" {
  type = list(string)
}

variable "vnet_cidr_sub2" {
  type = list(string)
}

variable "vnet_cidr_sub3" {
  type = list(string)
}

variable "vnet_cidr_sub4" {
  type = list(string)
}

variable "vnet_cidr_sub5" {
  type = list(string)
}

variable "dns_servers" {
  type = list(string)
}

variable "sku" {
  type = string
}
