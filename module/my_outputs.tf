output "ec2_instances" {
  description = "EC2 instances created by this module"
  value = {
    for idx, instance in aws_instance.chan-instance : idx => {
      public_ip   = instance.public_ip
      private_ip  = instance.private_ip
      instance_id = instance.id
      name        = try(instance.tags["Name"], null)
    }
  }
}