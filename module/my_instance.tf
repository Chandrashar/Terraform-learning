# EC2 Instance

resource "aws_instance" "chan-instance" {
  count = var.instance_count
  ami = var.ami_id
  instance_type   = var.instance_type
  key_name        = aws_key_pair.deployer.key_name # key
  vpc_security_group_ids = [aws_security_group.chan-security-grp.id]

  # Load the common script
  #user_data = file("${path.module}/../install_nginx.sh")
  
  # Pass the environment name into the script
  user_data = templatefile("${path.module}/../install_nginx.sh", {
    environment = var.my_env
  })



  tags = {
    Name = "${var.my_env}-ec2-terra-instance-${count.index+1}"
    Environment = var.my_env
  }

  provisioner "local-exec" {
    command = "echo 'Chandra Sharma' + ${var.my_env} > local-exec.txt"
  }

  provisioner "local-exec" {
    command = "echo ${self.public_ip} >> local-exec.txt"
  }

 provisioner "local-exec" {
    command = "hostname >> local-exec.txt"
  }

  provisioner "local-exec" {
    command = "uname -a >> local-exec.txt"
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Chandra Sharma' > /tmp/chandra-remote-exec.txt",
      "Environment >> ${var.my_env}",
      "hostname >> /tmp/chandra-remote-exec.txt",
      "uname -a >> /tmp/chandra-remote-exec.txt"
    ]

    connection {
      type        = "ssh"
      user        = var.ssh_user # variable for different environment
      private_key = file("terra-key")
      host        = self.public_ip
    }

  }

}

# key pair
resource "aws_key_pair" "deployer" {
  key_name   = "${var.my_env}-tws-terra-key"
  #public_key = file("/Users/chandra.sharma/global-workspace-2026/terraform/Terraform-learning/terra-key.pub")
  public_key = file("${path.module}/../terra-key.pub")   # or absolute path
}


# Defult Vpc
resource "aws_default_vpc" "default" {

  tags = {
    Name = "default"
  }

}

# Security Group

resource "aws_security_group" "chan-security-grp" {
  name        = "${var.my_env}-security-group"
  description = "SG for ${var.my_env} environment - SSH access"
  vpc_id      = aws_default_vpc.default.id # interpolation
  tags = {
    Name        = "${var.my_env}-chan-terra-sg"
    Environment = var.my_env
  }

  # Incoming Traffix
  ingress {
    description = "this is for SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # http port for nginx
    ingress {
    description = "this is for HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "This is for Outgoing traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}