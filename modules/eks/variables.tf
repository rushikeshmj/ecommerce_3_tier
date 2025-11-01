variable "cluster_name" { type = string }
variable "cluster_version" { type = string, default = "1.29" }
variable "vpc_id" { type = string }
variable "subnet_ids" { type = list(string) }
variable "node_desired" { type = number, default = 3 }
variable "node_min" { type = number, default = 2 }
variable "node_max" { type = number, default = 5 }
variable "instance_types" { type = list(string), default = ["t3.medium"] }
variable "project_name" { type = string, default = "ecommerce" }
variable "environment" { type = string, default = "dev" }
