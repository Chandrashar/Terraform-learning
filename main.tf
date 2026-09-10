module "dev-app" {
  source        = "./module"
  my_env        = "dev"
  instance_type = "t2.micro"
  ami_id        = "ami-06f5453d29c62393b" # Amazon Linux
  #region = "us-east-1"
  instance_count = 1
  ssh_user       = "ec2-user" # Amazon Linux
}

module "qa-app" {
  source        = "./module"
  my_env        = "qa"
  instance_type = "t2.micro"
  ami_id        = "ami-06f5453d29c62393b" # Amazon Linux
  #region = "us-east-2"
  instance_count = 2
  ssh_user       = "ec2-user" # Amazon Linux
}

module "stg-app" {
  source        = "./module"
  my_env        = "stg"
  instance_type = "t2.micro"
  ami_id        = "ami-0e5497a77ef21b5ac" # Ubuntu
  # region = "us-west-1"
  instance_count = 3
  ssh_user       = "ubuntu" # Ubuntu
}


module "prod-app" {
  source        = "./module"
  my_env        = "prod"
  instance_type = "t2.micro"
  ami_id        = "ami-0e68dc81dc36750a1" # Debian
  # region = "us-west-2"
  instance_count = 4
  ssh_user       = "admin" # Debian
}
