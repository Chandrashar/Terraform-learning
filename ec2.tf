
# key pair
resource "aws_key_pair" "deployer" {
  key_name   = "tws-terra-key"
  public_key = file("/Users/chandra.sharma/global-workspace-2026/terraform/Terraform-learning/terra-key.pub")
}

# Defult Vpc
resource "aws_default_vpc" "default" {

  tags = {
    Name = "default"
  }

}

# Security Group

resource "aws_security_group" "chan-security-grp" {
  name        = "allowed ports"
  description = "This SG is to open SSh ports for EC2 instance"
  vpc_id      = aws_default_vpc.default.id # interpolation
  tags = {
    Name = "chan-terra-sg"
  }

  # Incoming Traffix
  ingress {
    description = "this is for SSH"
    from_port   = 22
    to_port     = 22
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

resource "aws_instance" "chan-instance" {
  #count = 3
  for_each = toset(["ec2-terra-instance-1","ec2-terra-instance-2","ec2-terra-instance-3"])
  #ami = "ami-0e5497a77ef21b5ac" # ubuntu@@
  ami = var.ec2_ami_id
  #instance_type = "t2.micro"
  instance_type   = var.ec2_instance_type
  key_name        = aws_key_pair.deployer.key_name
  security_groups = [aws_security_group.chan-security-grp.name]
  tags = {
    #Name = "terra-automate"
    Name = each.key
  }

  provisioner "local-exec" {
    command = "echo 'Chandra Sharma' > local-exec.txt"
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
      "hostname >> /tmp/chandra-remote-exec.txt",
      "uname -a >> /tmp/chandra-remote-exec.txt"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("terra-key")
      host        = self.public_ip
    }

  }

}