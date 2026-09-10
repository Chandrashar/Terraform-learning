#!/bin/bash
set -e

echo "===== Terraform Apply started at $(date) =====" | tee terraform-apply.log
terraform apply -auto-approve 2>&1 | tee terraform-apply.log
echo "===== Terraform Apply finished at $(date) =====" | tee terraform-apply.log