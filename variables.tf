variable "proxmox_endpoint" {
  description = "Proxmox cluster URL"
  type        = string
}
variable "proxmox_api_token" {
  description = "Proxmox API user and token (USER@REALM:ID=TOKEN)"
  type        = string
  sensitive   = true
}