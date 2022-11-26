// https://registry.terraform.io/providers/hashicorp/google/latest/docs

provider "google" {
  project = var.project_id
  region  = var.project_region
  zone    = var.project_zone
}

resource "google_compute_instance" "master0" {
  name         = "gha-master-0"
  machine_type = "n1-standard-2"
  description = "kubernetes master for lf class for gha"

  tags = ["master", "gha"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size = 20
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network = google_compute_network.vpc.self_link
    access_config {
    }
  }
}
resource "google_compute_instance" "minion0" {
  name         = "gha-minion-0"
  machine_type = "n1-standard-2"
  description = "kubernetes master for lf class for gha"

  tags = ["minion", "gha"]

  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size = 20
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network = google_compute_network.vpc.self_link
    access_config {

    }
  }
}
resource "google_compute_instance" "minion1" {
  name         = "gha-minion-1"
  machine_type = "n1-standard-2"
  description = "kubernetes master for lf class for gha"

  tags = ["minion", "gha"]

  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size = 20
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network = google_compute_network.vpc.self_link
    access_config {

    }
  }
}

resource "google_compute_instance" "storage0" {
  name         = "gha-storage-0"
  machine_type = "e2-medium"
  description = "kubernetes master for lf class for gha"

  tags = ["minion", "gha"]

  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size = 30
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network = google_compute_network.vpc.self_link
    access_config {

    }
  }
}

resource "google_compute_network" "vpc" {
  name                    = "gha-kubernetes"
  auto_create_subnetworks = "true"
}

resource "google_compute_firewall" "public" {
  name    = "gha-lab"
  network = google_compute_network.vpc.name
  priority = 100

  allow {
    protocol = "tcp"
    ports    = ["22", "6443", "80", "443", "30000-32767"]
  }
  source_ranges = var.cidr
}

resource "google_compute_firewall" "public_http" {
  name    = "gha-lab-http"
  network = google_compute_network.vpc.name

  priority = 1001
  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }
}

resource "google_compute_firewall" "kubernetes" {
  name    = "gha-lab-kubernetes"
  network = google_compute_network.vpc.name

  allow {
    protocol = "ipip"
  }

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["6443", "2379-2380", "10250", "10251", "10252", "30000-32767", "80", "443", "179", "5473", "111", "2049", "6783", "8443", "8765"]
  }

  allow {
    protocol = "udp"
    ports    = ["179", "4789", "111", "2049", "6783", "6784"]
  }
  source_tags = ["worker", "master", "minion"]
}
