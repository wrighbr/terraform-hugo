variable "bucket" { default = "btw-blog"}
variable "bucket_content" { default = "myblog/public" }

resource "aws_s3_bucket" "blog" {
    bucket  = "${var.bucket}"
    acl     = "public-read"

    website {
        index_document  = "index.html"
    }
}
