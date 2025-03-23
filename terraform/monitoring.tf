# Enable required APIs
resource "google_project_service" "monitoring_services" {
  for_each = toset([
    "monitoring.googleapis.com",
    "logging.googleapis.com",
    "cloudtrace.googleapis.com"
  ])

  project = var.project_id
  service = each.key

  disable_on_destroy = false
}

# Log Sink for application logs
resource "google_logging_project_sink" "app_logs" {
  name        = "${var.environment}-app-logs"
  destination = "storage.googleapis.com/${google_storage_bucket.logs.name}"
  filter      = "resource.type = gce_instance AND severity >= INFO"
}

# Monitoring Alert Policy
resource "google_monitoring_alert_policy" "high_cpu" {
  display_name = "High CPU Usage"
  combiner     = "OR"
  conditions {
    display_name = "CPU Usage > 80%"
    condition_threshold {
      filter          = "metric.type=\"compute.googleapis.com/instance/cpu/utilization\" resource.type=\"gce_instance\""
      duration        = "300s"
      comparison      = "COMPARISON_GT"
      threshold_value = 0.8
    }
  }

  notification_channels = [google_monitoring_notification_channel.email.name]
}

# Notification Channel
resource "google_monitoring_notification_channel" "email" {
  display_name = "Email Notifications"
  type         = "email"
  labels = {
    email_address = "admin@example.com" # Replace with actual email
  }
}

# Uptime Check
resource "google_monitoring_uptime_check_config" "app_uptime" {
  display_name = "Application Uptime Check"
  timeout      = "10s"
  http_check {
    port = 80
    path = "/health"
  }
  monitored_resource {
    type = "uptime_url"
    labels = {
      host = "example.com" # Replace with actual domain
    }
  }
}
