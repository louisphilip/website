resource "aws_amplify_app" "personal-website" {
  name       = "personal-website"
  repository = "https://github.com/louisphilip/website.git"
  enable_branch_auto_build = true
  build_spec = <<-EOT
    version: 0.1
    frontend:
      phases:
        preBuild:
          commands:
            - npm install
            - npm test -- --watchAll=false
        build:
          commands:
            - npm run build
      artifacts:
        baseDirectory: build
        files:
          - '**/*'
      cache:
        paths:
          - node_modules/**/*
  EOT
  # The default rewrites and redirects added by the Amplify Console.
  custom_rule {
    source = "/<*>"
    status = "404"
    target = "/index.html"
  }
  environment_variables = {
    ENV = "dev"
  }
}