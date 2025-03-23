# GCS Bucket for application data
resource "google_storage_bucket" "app_data" {
  name          = "${var.project_id}-${var.environment}-app-data"
  location      = var.region
  force_destroy = false

  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }

  encryption {
    default_kms_key_name = google_kms_crypto_key.bucket_key.id
  }

  lifecycle_rule {
    condition {
      age = 90
    }
    action {
      type = "Delete"
    }
  }

  public_access_prevention = "enforced"
}

# GCS Bucket for logs
resource "google_storage_bucket" "logs" {
  name          = "${var.project_id}-${var.environment}-logs"
  location      = var.region
  force_destroy = false

  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }

  encryption {
    default_kms_key_name = google_kms_crypto_key.bucket_key.id
  }

  lifecycle_rule {
    condition {
      age = 365
    }
    action {
      type = "Delete"
    }
  }

  public_access_prevention = "enforced"
}

# KMS Key for bucket encryption
resource "google_kms_key_ring" "bucket_keyring" {
  name     = "${var.environment}-bucket-keyring"
  location = var.region
}

resource "google_kms_crypto_key" "bucket_key" {
  name            = "${var.environment}-bucket-key"
  key_ring        = google_kms_key_ring.bucket_keyring.id
  rotation_period = "7776000s" # 90 days
}

# IAM bindings for the buckets
resource "google_storage_bucket_iam_member" "app_data_writer" {
  bucket = google_storage_bucket.app_data.name
  role   = "roles/storage.objectViewer"
  member = "serviceAccount:${google_service_account.app_service_account.email}"
}

resource "google_storage_bucket_iam_member" "logs_writer" {
  bucket = google_storage_bucket.logs.name
  role   = "roles/storage.objectViewer"
  member = "serviceAccount:${google_service_account.monitoring_service_account.email}"
}
