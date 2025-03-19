provider "google" {
  credentials = file("gcp_key.json")
  project     = "amazon-data-analysis-431706"
  region      = "us-central1"
}
