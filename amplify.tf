provider "aws" {
  region = "eu-west-1"
}

terraform {
  backend "remote" {
    organization = "louisphilip"

    workspaces {
      name = "personal-website"
    }
  }
}

resource "aws_amplify_app" "example" {
  name       = "app"
  repository = "https://github.com/louisphilip/website"
  # GitHub personal access token
  access_token = "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"

  enable_branch_auto_build = "true"

  # Setup redirect from https://example.com to https://www.example.com
  custom_rule {
    source = "https://www.louisphilip.co.za"
    status = "302"
    target = "https://www.louisphilip.co.za"
  }
}

resource "aws_amplify_branch" "master" {
  app_id      = aws_amplify_app.example.id
  branch_name = "main"
}

resource "aws_amplify_domain_association" "example" {
  app_id      = aws_amplify_app.example.id
  domain_name = "louisphilip.co.za"

  # https://example.com
  sub_domain {
    branch_name = aws_amplify_branch.master.branch_name
    prefix      = ""
  }

  # https://www.example.com
  sub_domain {
    branch_name = aws_amplify_branch.master.branch_name
    prefix      = "www"
  }
}
