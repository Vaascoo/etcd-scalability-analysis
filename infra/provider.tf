terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "2.4.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "5.3.0"
    }
  }
}

provider "google" {
  credentials = file(var.GCP_CONFIG_PATH)
  project     = var.GCP_PROJECT_ID
  zone        = var.GCP_ZONE
}

provider "local" {
}
