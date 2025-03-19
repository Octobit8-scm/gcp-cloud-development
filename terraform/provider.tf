provider "google" {
  credentials = file("gcp_key.json")
  project     = "amazon-data-analysis-431706"
  region      = "us-central1"
}

provider "google-beta" {
  credentials = file("gcp_key.json")
  project     = "amazon-data-analysis-431706"
  region      = "us-central1"
}
