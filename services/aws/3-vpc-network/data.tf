data "aws_region" "current" {}

data "aws_organizations_organization" "current" {}

data "aws_availability_zones" "available" {
  state = "available"
}
