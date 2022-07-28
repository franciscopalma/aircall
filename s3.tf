resource "aws_s3_bucket" "b" {
  bucket = "aircall-francisco-bucket"
  acl    = "public-read"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}