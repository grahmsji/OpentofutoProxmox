terraform {
  required_version = "1.9.1"
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.77.0"
    }
  }
}
provider "proxmox" {
  endpoint  = var.proxmox_endpoint
  api_token = var.proxmox_api_token
  insecure  = true
}
data "proxmox_virtual_environment_version" "lab" {}
output "lab_version" {
  value = {
    release = data.proxmox_virtual_environment_version.lab.release
    version = data.proxmox_virtual_environment_version.lab.version
  }
}