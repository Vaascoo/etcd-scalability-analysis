provider "google" {
    credentials = file("TODO")
    project = var.GCP_PROJECT_ID
    zone = var.GCP_ZONE
}
