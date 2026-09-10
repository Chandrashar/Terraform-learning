variable "dynamodb_table_name" {
  type        = string
  default     = "terra-dynamodb-table"
  description = "This is default table name for Dynamo Db created by Terraform"
}

variable "ec2_ami_id" {
  type        = string
  default     = "ami-0e5497a77ef21b5ac" # Ubuntu latest
  description = "This is default instance name for UBuntu machine"

}

variable "ec2_instance_type" {
  type        = string
  default     = "t2.micro"
  description = "This is default instance type for EC2 machine"

}