terraform {
  required_version = "1.9.1"
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.77.0"
    }
  }
}
provider "proxmox" {
  endpoint = var.proxmox_endpoint
  api_token = var.proxmox_api_token
  insecure = true
  ssh {
    username = "root"
    agent = true
  }
}
resource "proxmox_virtual_environment_download_file" "ubuntu_24_20250430" {
  content_type = "iso"
  datastore_id = "local"
  node_name = "pve1"
  overwrite_unmanaged = true
  url = "http://cloud-images.ubuntu.com/noble/20250430/noble-server-cloudimg-amd64.img"
}
resource "proxmox_virtual_environment_vm" "test1" {
  name = "test1"
  vm_id = 2222
  node_name = "pve1"
  tags = ["tofu", "ubuntu"]
  on_boot = true
  protection = false
  migrate = true
  cpu {
    cores = 1
    type = "x86-64-v2-AES"
  }
  memory {
    dedicated = 1024
    floating = 1024
  }
  disk {
    datastore_id = "local-lvm"
    file_id = proxmox_virtual_environment_download_file.ubuntu_24_20250430.id
    interface = "virtio0"
    size = 10
    iothread = true
  }
  network_device {
    bridge = "vmbr0"
  }
  initialization {
    datastore_id = "local-lvm"
    ip_config {
      ipv4 {
        address = "192.168.0.201/24"
        gateway = "192.168.0.89.147"
      }
    }
    dns {
      domain = "si.impots.bj"
      servers = ["192.168.0.1"]
    }
    user_account {
      username = "ubuntu"
      password = "plopplop"
    }
  }
}