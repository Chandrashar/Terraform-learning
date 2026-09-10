/*output "my_ec2_ip" {
    
  value = aws_instance.chan-instance.public_ip
}*/

# output "my_ec2_instances" {
#   value = {
#     for key, instance in aws_instance.chan-instance : key => {
#       public_ip  = instance.public_ip
#       private_ip = instance.private_ip
#       instance_id = instance.id
#     }
#   }
#   description = "All EC2 instance details"
# }

# output "all_environments" {
#   description = "EC2 details for every environment"
#   value = {
#     dev  = module.dev-app.ec2_instances
#     qa   = module.qa-app.ec2_instances
#     stg  = module.stg-app.ec2_instances
#     prod = module.prod-app.ec2_instances
#   }
# }

# Optional – flatter version
output "all_ec2_instances" {
  description = "Flattened map of all EC2 instances"
  value = merge(
    { for k, v in module.dev-app.ec2_instances : "dev-${(k + 1)}" => v },
    { for k, v in module.qa-app.ec2_instances : "qa-${(k + 1)}" => v },
    { for k, v in module.stg-app.ec2_instances : "stg-${(k + 1)}" => v },
    { for k, v in module.prod-app.ec2_instances : "prod-${(k + 1)}" => v }
  )
}