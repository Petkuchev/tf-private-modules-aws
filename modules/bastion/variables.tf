variable "region" {
  type    = string
  default = "eu-west-1"
}

variable "owners" {
  type    = list(string)
  default = ["679593333241"]
}

variable "filter_name_value" {
  type    = list(string)
  default = ["CIS Amazon Linux*"]
}

variable "instance_type" {
  type    = string
  default = "t3.micro"

  validation {
    condition     = can(regex("t3.micro", var.instance_type))
    error_message = "The recommended instance type is t3.micro. Please do not change it."

  }
}

variable "vpc_id" {
  type = string
}

variable "ingress_cidr" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "egress_cidr" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "sg_name_prefix" {
  type    = string
  default = "Bastion"
}

variable "subnet_id" {
  type = string
}

variable "tags" {
  type        = map(string)
  description = "List of tags added to all the resources created"
  default = {
    Terraform = true
  }
}

