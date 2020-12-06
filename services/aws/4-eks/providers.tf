provider "aws" {
  version = "~> 2.0"
  region  = "eu-central-1"
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
