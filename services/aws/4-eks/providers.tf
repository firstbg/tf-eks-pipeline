# provider "aws" {
#   region = var.common_region
# }

provider "aws" {
  region = var.common_region
  alias  = "shared"
  assume_role {
    role_arn = format(
      "%s%s%s%s",
      "arn:aws:iam::",
      var.account_id,
      ":role/",
      local.terraform_assume_role_name,
    )
  }
}
