module "iam_iam-user" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "5.28.0"
  name = "max"
  # insert the 1 required variable here
  create_iam_user_login_profile = false
  create_iam_access_key         = false
}

resource "aws_iam_user" "cloud" {
     name = split(":",var.cloud_users)[count.index]
     count = length(split(":",var.cloud_users))
  
}
resource "aws_s3_bucket" "sonic_media" {
     bucket = var.bucket
  
}
resource "aws_s3_object" "upload_sonic_media" {
     bucket = aws_s3_bucket.sonic_media.id
     key =  substr(each.value, 7, 20)
     source = each.value
     for_each = var.media 

}

resource "aws_instance" "mario_servers" {
     ami = var.ami
     instance_type = var.name == "tiny" ? var.small : var.large
     tags = {
          Name = var.name

     }

}