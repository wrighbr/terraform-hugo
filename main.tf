variable "bucket" { default = "myblog.btwsolutions.net"}


resource "aws_s3_bucket" "blog" {
    bucket      = "${var.bucket}"
    acl         = "public-read"

    website {
        index_document  = "index.html"
        error_document  = "404.html"
    }
}

resource "aws_route53_record" "blog" {
    zone_id     = "${var.route53id}"
    name        = "myblog.btwsolutions.net" 
    type        = "CNAME"
    ttl         = "300"
    records     = ["${aws_s3_bucket.blog.website_endpoint}"]

}
