# GCP Infrastructure Automation

This repository contains Terraform configurations for setting up a secure and scalable infrastructure on Google Cloud Platform.

## Infrastructure Components

- **Network**

  - VPC with private and public subnets
  - Cloud NAT for private instances
  - Firewall rules for security
  - Cloud Router for network routing

- **IAM & Security**

  - Service accounts for applications and monitoring
  - IAM roles with least privilege principle
  - KMS encryption for sensitive data

- **Storage**

  - GCS buckets for application data and logs
  - Versioning enabled
  - Lifecycle policies for cost management
  - KMS encryption

- **Monitoring & Logging**
  - Cloud Monitoring setup
  - Log aggregation and storage
  - Alert policies for high CPU usage
  - Uptime checks

## Prerequisites

1. Google Cloud SDK installed
2. Terraform installed (version >= 1.0)
3. GCP project created
4. Service account with necessary permissions

## Authentication Setup

1. Create a service account in GCP:

   ```bash
   gcloud iam service-accounts create terraform-sa \
     --display-name="Terraform Service Account"
   ```

2. Grant necessary permissions to the service account:

   ```bash
   gcloud projects add-iam-policy-binding YOUR_PROJECT_ID \
     --member="serviceAccount:terraform-sa@YOUR_PROJECT_ID.iam.gserviceaccount.com" \
     --role="roles/editor"
   ```

3. Create and download the service account key:

   ```bash
   gcloud iam service-accounts keys create gcp-key.json \
     --iam-account=terraform-sa@YOUR_PROJECT_ID.iam.gserviceaccount.com
   ```

4. Place the downloaded `gcp-key.json` file in the `terraform` directory

5. Update `terraform.tfvars` with your project details:

   - Set your project ID
   - Update the region if needed
   - Set your allowed IP addresses for SSH access
   - Verify the credentials_file path points to your service account key

## Setup Instructions

1. Clone this repository
2. Navigate to the terraform directory:

   ```bash
   cd terraform
   ```

3. Initialize Terraform:

   ```bash
   terraform init
   ```

4. Review the planned changes:

   ```bash
   terraform plan
   ```

5. Apply the infrastructure:
   ```bash
   terraform apply
   ```

## Security Considerations

- All storage buckets are encrypted with KMS
- Private subnets are used for sensitive workloads
- Public access is restricted
- Service accounts follow least privilege principle
- Regular key rotation is configured
- Monitoring and logging are enabled for security events
- Service account keys should be stored securely and never committed to version control

## Maintenance

- Regularly review and update the allowed IP addresses
- Monitor the alert policies and adjust thresholds as needed
- Review and update IAM permissions periodically
- Check storage lifecycle policies and adjust retention periods
- Rotate service account keys regularly

## Cleanup

To destroy the infrastructure:

```bash
terraform destroy
```

**Note**: This will delete all resources. Make sure to backup any important data before running this command.
