provider "aws" {
  profile                 = var.profile_name
  region                  = var.region
  shared_credentials_file = "~/.aws/credentials"
}
