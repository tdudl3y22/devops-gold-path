# 1. PROVIDER CONFIGURATION
# This tells Terraform which plugins to download
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

# 2. PROVIDER INITIALIZATION
# This connects Terraform to your local Docker engine
provider "docker" {
  # Default settings work for most Windows and Mac installs
}

# 3. RESOURCE DEFINITIONS
# These are the actual "things" we want to build

# Pulls the Nginx image to your machine
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = true
}

# Creates the container using that image
resource "docker_container" "aegis_link_test" {
  image = docker_image.nginx.image_id
  name  = "aegis_link_test"

  # NEW: Resource Limits
  memory     = 16  # Limit to 64MB of RAM
  cpu_shares = 512 # Limit CPU priority

  ports {
    internal = 80
    external = 9000
  }

  # We add a label so our future "Self-Healing" script can find it
  labels {
    label = "project"
    value = "aegis"
  }
}