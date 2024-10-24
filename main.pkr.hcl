# main.pkr.hcl
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
  ssh_username        = "yeedu"
  machine_type        = "e2-medium"
  disk_size           = 50
  disk_type           = "pd-standard"
  network_project_id  = "modak-nabu"
  network             = "modak-nabu-spark-vpc"
  subnetwork          = "custom-subnet-modak-nabu"
  use_internal_ip     = true
  startup_script_file = "scripts/setup.sh"

  image_labels = {
    poc       = "packer"
    resources = "yeedu"
  }
}



build {
  sources = ["source.googlecompute.ubuntu"]
}