variable "project_name" { type = string }
variable "environment" { type = string }
variable "subnet_ids" { type = list(string) }
variable "db_name" { type = string, default = "ecommerce_db" }
variable "engine" { type = string, default = "mysql" }
variable "instance_class" { type = string, default = "db.t3.micro" }
variable "allocated_storage" { type = number, default = 20 }
variable "username" { type = string, default = "admin" }
variable "password" { type = string, default = "Password@123" }
variable "vpc_security_group_ids" { type = list(string), default = [] }
