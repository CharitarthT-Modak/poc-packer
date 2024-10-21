packer {
  required_plugins {
    googlecompute = {
      source  = "github.com/hashicorp/googlecompute"
      version = "~> 1"
    }
  }
}

source "googlecompute" "ubuntu" {
  project_id          = var.project_id
  source_image_family = var.source_image_family
  zone                = var.zone
  image_name          = var.image_name
  image_family        = "yeedu-ubuntu"
  ssh_username        = "packer"
  machine_type        = "e2-medium"
  disk_size           = 50
  disk_type           = "pd-standard"
  preemptible         = false

  image_labels = {
    poc       = "packer"
    resources = "yeedu"
  }
}

build {
  sources = ["source.googlecompute.ubuntu"]

  provisioner "file" {
    source      = "script.sh"
    destination = "/tmp/"
  }

  provisioner "shell" {
    inline = [
      "sudo chmod +x /tmp/script.sh",
      "sudo /tmp/script.sh",
      "sudo rm -rf /tmp/script.sh"
    ]
  }
}