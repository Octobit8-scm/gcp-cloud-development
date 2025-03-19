terraform {
  backend "remote" {
    # The name of your Terraform Cloud organization.
    organization = "Octobit8-Private-Limited"

    # The name of the Terraform Cloud workspace to store Terraform state files in.
    workspaces {
      name = "gcp-cloud-development"
    }
  }
}

provider "google" {
  project     = "amazon-data-analysis-431706"
  region      = "us-central-1"
  credentials = var.GOOGLE_APPLICATION_CREDENTIALS
}

# An example resource that does nothing.
resource "null_resource" "example" {
  triggers = {
    value = "A example resource that does nothing!"
  }
}
