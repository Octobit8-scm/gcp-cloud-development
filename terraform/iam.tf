# Service Accounts
resource "google_service_account" "app_service_account" {
  account_id   = "${var.environment}-app-sa"
  display_name = "Application Service Account"
  description  = "Service account for application workloads"
}

resource "google_service_account" "monitoring_service_account" {
  account_id   = "${var.environment}-monitoring-sa"
  display_name = "Monitoring Service Account"
  description  = "Service account for monitoring and logging"
}

# IAM Roles
resource "google_project_iam_member" "app_service_account_roles" {
  for_each = toset([
    "roles/cloudtrace.agent",
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter"
  ])

  project = var.project_id
  role    = each.key
  member  = "serviceAccount:${google_service_account.app_service_account.email}"
}

resource "google_project_iam_member" "monitoring_service_account_roles" {
  for_each = toset([
    "roles/monitoring.admin",
    "roles/logging.admin"
  ])

  project = var.project_id
  role    = each.key
  member  = "serviceAccount:${google_service_account.monitoring_service_account.email}"
}

# Service Account Keys (Optional - Comment out if not needed)
# resource "google_service_account_key" "app_service_account_key" {
#   service_account_id = google_service_account.app_service_account.name
# }

# resource "google_service_account_key" "monitoring_service_account_key" {
#   service_account_id = google_service_account.monitoring_service_account.name
# } 
