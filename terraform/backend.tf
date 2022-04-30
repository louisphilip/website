terraform {
  cloud {
    organization = "louisphilip"

    workspaces {
      name = "amplify-website"
    }
  }
}