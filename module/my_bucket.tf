# S3 bucket
resource "aws_s3_bucket" "chan-bucket" {
  bucket = "${var.my_env}-chan-tf-bucket"

  tags = {
    Name = "${var.my_env}-chan-tf-bucket"
    Environment = var.my_env
  }

}