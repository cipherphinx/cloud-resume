variable "region" {
  default = "ap-southeast-1"
}

variable "BUCKET_NAME" {
  default = "arfeljun-velasco-resume1"
}

# To avoid repeatedly specifying the path, we'll declare it as a variable
variable "website_root" {
  type        = string
  description = "Path to the root of website content"
  default     = "../webfiles"
}

variable "cf_domain" {
  default = "resume1.arfeljunvelasco.live"
}

variable "lambda_function_name" {
  default = "get-visitor-count-function"
}
