variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "private_subnet_id" {
  type = string
}

variable "public_subnet_id" {
  type = string
}

variable "rds_sg_id" {
  type = string
}
