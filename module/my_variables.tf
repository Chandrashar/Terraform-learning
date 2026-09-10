variable "my_env" {
  description = "This is the environment for Infra"
  type = string
}

variable "ami_id" {
    description = "this is AMI id"
    type = string
}

variable "instance_type" {
  description = "this is instance type for my Infra"
  type =string
}

# variable "region" {
#   description = "region value for different environment"
#   type = string
# }

variable "instance_count" {
  description = "Ec2 instance count per environment"
  type = number
}

variable "ssh_user" {
  description = "ssh_user for different environments over different instance_type"
  type = string
}
