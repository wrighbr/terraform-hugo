variable "bucket" { default = "btw-blog"}
variable "bucket_content" { default = "myblog/public" }

resource "aws_s3_bucket" "blog" {
    bucket  = "${var.bucket}"
    acl     = "public-read"

    website {
        index_document  = "index.html"
    }
}

resource "aws_s3_bucket_object" "blog_content" {
    bucket  = "${var.bucket}"
    key     =
    content = "${var.bucket_content}"
}