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
  credentials = file("keys/esle-402917-2bc146125413.json")
  project     = var.GCP_PROJECT_ID
  zone        = var.GCP_ZONE
}

provider "local" {
}
