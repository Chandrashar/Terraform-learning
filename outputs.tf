/*output "my_ec2_ip" {
    
  value = aws_instance.chan-instance.public_ip
}*/

output "my_ec2_instances" {
  value = {
    for key, instance in aws_instance.chan-instance : key => {
      public_ip  = instance.public_ip
      private_ip = instance.private_ip
      instance_id = instance.id
    }
  }
  description = "All EC2 instance details"
}