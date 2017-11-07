
// Standard Variables

variable "name" {
  description = "Name"
}
variable "environment" {
  description = "Environment (ex: dev, qa, stage, prod)"
}
variable "namespaced" {
  description = "Namespace all resources (prefixed with the environment)?"
  default     = true
}
variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}

// Module specific Variables

variable "num_of_azs" {
  description = "Number of multipe AZ to be utilized"
  default     = 2
}
variable "vpc_id" {
  description = "AWS VPC ID"
}
variable "public_subnet_ids" {
  type = "list"
}
