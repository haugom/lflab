// https://registry.terraform.io/providers/hashicorp/google/latest/docs

provider "google" {
  project = var.project_id
  region  = var.project_region
  zone    = var.project_zone
}

//resource "google_compute_instance" "vm" {
//  name         = "gha-play"
//  machine_type = "f1-micro"
//
//  tags = ["play", "gha"]
//
//  boot_disk {
//    initialize_params {
//      image = "debian-cloud/debian-9"
//    }
//  }
//
//  network_interface {
//    # A default network is created for all GCP projects
//    network = google_compute_network.vpc.self_link
//    access_config {
//    }
//  }
//}

resource "google_compute_instance" "master" {
  name         = "gha-master-0"
  machine_type = "n1-standard-2"
  description = "kubernetes master for lf class for gha"

  tags = ["master", "gha"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
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

//resource "google_compute_instance" "master2" {
//  name         = "gha-master-1"
//  machine_type = "n1-standard-2"
//  description = "kubernetes master for lf class for gha"
//
//  tags = ["master", "gha"]
//
//  boot_disk {
//    initialize_params {
//      image = "ubuntu-os-cloud/ubuntu-1804-lts"
//      size = 20
//    }
//  }
//
//  network_interface {
//    # A default network is created for all GCP projects
//    network = google_compute_network.vpc.self_link
//    access_config {
//    }
//  }
//}

//resource "google_compute_instance" "master3" {
//  name         = "gha-master-2"
//  machine_type = "n1-standard-2"
//  description = "kubernetes master for lf class for gha"
//
//  tags = ["master", "gha"]
//
//  boot_disk {
//    initialize_params {
//      image = "ubuntu-os-cloud/ubuntu-1804-lts"
//      size = 20
//    }
//  }
//
//  network_interface {
//    # A default network is created for all GCP projects
//    network = google_compute_network.vpc.self_link
//    access_config {
//    }
//  }
//}

resource "google_compute_instance" "worker" {
  name         = "gha-worker-0"
  machine_type = "n1-standard-2"
  description = "kubernetes master for lf class for gha"

  tags = ["worker", "gha"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
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

resource "google_compute_instance" "worker2" {
  name         = "gha-worker-1"
  machine_type = "n1-standard-2"
  description = "kubernetes master for lf class for gha"

  tags = ["worker", "gha"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
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

//resource "google_compute_instance" "cp" {
//  name         = "gha-cp-0"
//  machine_type = "n1-standard-2"
//  description = "kubernetes master for lf class for gha"
//
//  tags = ["master", "gha"]
//
//  boot_disk {
//    initialize_params {
//      image = "ubuntu-os-cloud/ubuntu-1804-lts"
//      size = 20
//    }
//  }
//
//  network_interface {
//    # A default network is created for all GCP projects
//    network = google_compute_network.vpc.self_link
//    access_config {
//    }
//  }
//}
//
//resource "google_compute_instance" "worker-lab" {
//  name         = "gha-lab-worker-0"
//  machine_type = "n1-standard-2"
//  description = "kubernetes master for lf class for gha"
//
//  tags = ["worker", "gha"]
//
//  boot_disk {
//    initialize_params {
//      image = "ubuntu-os-cloud/ubuntu-1804-lts"
//      size = 20
//    }
//  }
//
//  network_interface {
//    # A default network is created for all GCP projects
//    network = google_compute_network.vpc.self_link
//    access_config {
//
//    }
//  }
//}
//

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
    ports    = ["6443", "2379-2380", "10250", "10251", "10252", "30000-32767", "80", "443", "179", "5473", "111", "2049", "6783", "8443"]
  }

  allow {
    protocol = "udp"
    ports    = ["179", "4789", "111", "2049", "6783", "6784"]
  }
  source_tags = ["worker", "master"]
}
