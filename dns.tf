# Set up DNS

# Health checks for each web box
resource "aws_route53_health_check" "health_check_web1" {
  ip_address               = "${var.web_1_ip}"
  port                     = 80
  type                     = "HTTP"
  resource_path            = "/index.html"
  failure_threshold        = "5"
  request_interval         = "30"

  tags {
      Name                 = "${var.product}-healthcheck-web1"
      Owner                = "${var.resource_owner}"
  }
}

resource "aws_route53_health_check" "health_check_web2" {
  ip_address               = "${var.web_2_ip}"
  port                     = 80
  type                     = "HTTP"
  resource_path            = "/index.html"
  failure_threshold        = "5"
  request_interval         = "30"

  tags {
      Name                 = "${var.product}-healthcheck-web2"
      Owner                = "${var.resource_owner}"
  }
}

# A Records for our main domain, these will be weighted and point to aliased A records which the web boxes update directly
resource "aws_route53_record" "web1" {
  zone_id                  = "${var.aws_zone}"
  name                     = "${var.product}-${var.area}"
  type                     = "A"
  ttl                      = "60"
  set_identifier           = "1"
  health_check_id          = "${aws_route53_health_check.health_check_web1.id}"
  records                  = [ "${var.web_1_ip}" ]
  weighted_routing_policy
  {
      weight = 50
  }
}

resource "aws_route53_record" "web2" {
  zone_id                  = "${var.aws_zone}"
  name                     = "${var.product}-${var.area}"
  type                     = "A"
  ttl                      = "60"
  set_identifier           = "2"
  health_check_id          = "${aws_route53_health_check.health_check_web2.id}"
  records                  = [ "${var.web_2_ip}" ]
  weighted_routing_policy
  {
      weight = 50
  }
}

# Output value so we can clearly see the FQDN
output "primary_fqdn" {
  value                    = "${var.product}-${var.area}.${var.domain}"
}
