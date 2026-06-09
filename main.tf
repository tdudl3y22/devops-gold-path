# 1. Define the "Provider" (Like choosing AWS, but we're using Docker)
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

# 2. Define the "Image" (The 'Gold Image' or AMI equivalent)
resource "docker_image" "app_image" {
  name         = "nginx:latest"
  keep_locally = false
}

# 3. Define the "Container" (The 'Instance' or EC2 equivalent)
resource "docker_container" "app_container" {
  image = docker_image.app_image.image_id
  name  = "portfolio-web-server"
  ports {
    internal = 80
    external = 8080
  }
}
