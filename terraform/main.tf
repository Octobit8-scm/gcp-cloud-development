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

