# Variables required for configuration

######## Generic Variables ########


variable "product" {
  description = "What is this product"
  default     = "web"
}

variable "web_1_ip" {
  description = "What is the IP of web 1"
  default     = ""
}

variable "web_2_ip" {
  description = "What is the IP of web 2"
  default     = ""
}

variable "area" {
  description = "Area the box is based in"
  default     = "eu"
}

variable "resource_owner" {
  description = "Owner of the resource"
  default     = ""
}

######## Domain Variables ########

variable "domain" {
  description = "Our domain name"
  default     = ""
}

variable "aws_zone" {
  description = "Our Zone ID for route 53 domain"
  default     = ""
}

######## SNS Monitoring Variables ########

variable "sns_general_threshhold" {
  description = "What % threshhold should we use for alerting"
  default     = "80"
}

variable "sns_monitoring_period" {
  description = "What period of time should we monitor over, ie how long should the above occur for before it is a problem in seconds"
  default     = "60"
}

variable "sns_monitoring_evaluation_period" {
  description = "How many times should we evaluate the above alarms before it is an issue"
  default     = "1"
}
