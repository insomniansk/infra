terraform {
  # Версия terraform
  #required_version = "0.11.11"
}
provider "google" {
  # Версия провайдераS
  #version = "2.0.0"
  # ID проекта
  project = var.project
  region  = var.region
  #zone    = "us-central1-a"
}

resource "google_compute_project_metadata" "my_ssh_keys" {
  metadata = {
    ssh-keys = "gcpuser1:${file(var.public_key_path)}gcpuser2:${file(var.public_key_path)}gcpuser3:${file(var.public_key_path)}"
    }
}

resource "google_compute_instance" "app" {
  name         = "reddit-app"
  machine_type = "e2-micro"
  zone         = var.zone

  tags = ["reddit-app"]

  boot_disk {
    initialize_params {
      type  = "pd-standard"
      size  = "10"
      image = var.disk_image
    }
  }
  metadata = {
    ssh-keys = "gcpuser:${file(var.public_key_path)}"
  }
  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }
  connection {
    type        = "ssh"
    user        = "gcpuser"
    agent       = false
    host        = google_compute_instance.app.network_interface.0.access_config.0.nat_ip
    private_key = file(var.private_key_path)
  }

  provisioner "file" {
    source      = "files/puma.service"
    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    script = "files/deploy.sh"

  }
}

resource "google_compute_firewall" "firewall_puma" {

  name    = "allow-puma-default"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["reddit-app"]
}
