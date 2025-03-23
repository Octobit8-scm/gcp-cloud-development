project_id  = "your-project-id"
region      = "us-central1"
environment = "dev"

vpc_cidr            = "10.0.0.0/16"
private_subnet_cidr = "10.0.1.0/24"
public_subnet_cidr  = "10.0.2.0/24"
allowed_ips         = ["0.0.0.0/0"] # Replace with your IP address
credentials_file    = "json key"    # Path to your service account key file
