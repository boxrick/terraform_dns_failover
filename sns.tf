# SNS Group for notifications group

resource "aws_sns_topic" "dns_sns" {
  name                  = "${var.product}-sns"
  display_name          = "${var.product}-sns"
}

# Healthcheck alarm for web1

resource "aws_cloudwatch_metric_alarm" "web1_health_alarm" {
    alarm_name          = "${var.product}-healthcheck-web1-alarm"
    comparison_operator = "LessThanThreshold"
    evaluation_periods  = "${var.sns_monitoring_evaluation_period}"
    metric_name         = "HealthCheckStatus"
    namespace           = "AWS/Route53"
    period              = "${var.sns_monitoring_period}"
    statistic           = "Minimum"
    threshold           = "1"

    dimensions {
        HealthCheckId   = "${aws_route53_health_check.health_check_web1.id}"
    }

    alarm_description   = "Web 1 healthcheck has failed for ${var.sns_monitoring_period} seconds on ${var.product}-healthcheck-web1"
    alarm_actions       = ["${aws_sns_topic.dns_sns.arn}"]
}

# Healthcheck alarm for web2

resource "aws_cloudwatch_metric_alarm" "web2_health_alarm" {
    alarm_name          = "${var.product}-healthcheck-web2-alarm"
    comparison_operator = "LessThanThreshold"
    evaluation_periods  = "${var.sns_monitoring_evaluation_period}"
    metric_name         = "HealthCheckStatus"
    namespace           = "AWS/Route53"
    period              = "${var.sns_monitoring_period}"
    statistic           = "Minimum"
    threshold           = "1"

    dimensions {
        HealthCheckId   = "${aws_route53_health_check.health_check_web2.id}"
    }

    alarm_description   = "Web 2 healthcheck has failed for ${var.sns_monitoring_period} seconds on ${var.product}-healthcheck-web2"
    alarm_actions       = ["${aws_sns_topic.dns_sns.arn}"]
}
