variable "ami" {
  description = "AWS AMI used for the OpenVPN connector instance"
  type        = string
  nullable    = false
}

variable "instance_type" {
  description = "AWS Instance type used for the OpenVPN connector instance"
  type        = string
  default     = "t2.micro"
}

variable "key_pair_name" {
  description = "AWS Key pair name used for the OpenVPN connector instance"
  type        = string
  nullable    = false
}

variable "key_pair_value" {
  description = "AWS Key pair value used for the OpenVPN connector instance"
  type        = string
  default     = null
  sensitive   = true
}

variable "name" {
  description = "Name for the OpenVPN connector instance. It will also be used as a prefix for other resources created in this module"
  type        = string
  default     = "OpenVPN-connector"
}

variable "openvpn_repo_pkg_key_url" {
  description = "URL to the Key used for downloading the tool 'python3-openvpn-connector-setup'"
  type        = string
  nullable    = false
  default     = "https://swupdate.openvpn.net/repos/openvpn-repo-pkg-key.pub"
}

variable "openvpn_repo_url" {
  description = "URL to the Repository used for downloading the tool 'python3-openvpn-connector-setup'"
  type        = string
  nullable    = false
  default     = "https://swupdate.openvpn.net/community/openvpn3/repos/openvpn3-focal.list"
}

variable "openvpn_token" {
  description = "OpenVPN token used to connect to the main OpenVPN instance"
  type        = string
  nullable    = false
  sensitive   = true
}

variable "subnet_id" {
  description = "AWS Subnet id where the OpenVPN connector instance will be created"
  type        = string
  nullable    = false
}

variable "tags" {
  type        = map(string)
  description = "List of tags added to all the resources created"
  default = {
    Terraform = true
  }
}

variable "vpc_id" {
  description = "AWS VPC id where the OpenVPN connector instance will be created"
  type        = string
  nullable    = false
}