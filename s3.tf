resource "aws_s3_bucket" "chan-bucket" {
  bucket = "chan-tf-bucket"

  tags = {
    Name = "chan-tf-bucket"
    #Environment = "Dev"
  }

}