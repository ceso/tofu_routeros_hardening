# ------------------------------------------
# Password Settings
# ------------------------------------------
variable "minimum_password_categories" {
  description = "Specifies the complexity requirements of the password, with categories being uppercase, lowercase, digit, symbol. Allowed values are 0 to 4"
  type        = number
  default     = 4

  validation {
    condition     = var.minimum_password_categories >= 0 && var.minimum_password_categories <= 4
    error_message = "'minimum_categories' must be between 0 and 4"
  }
}
variable "minimum_password_length" {
  description = "Specifies the minimum character length of the users passwords"
  type        = number
  default     = 16

  validation {
    condition     = var.minimum_password_length >= 16 && var.minimum_password_length <= 4294967295
    error_message = "'minimum_password_length' must be between 0 and 4294967295"
  }
}

# ------------------------------------------
# Services
# ------------------------------------------
variable "routeros_services" {
  description = "Map of RouterOS services configuration for hardening and management"
  type = map(object({
    port         = number
    max_sessions = optional(number)
    address      = optional(string)
    certificate  = optional(string)
    tls_version  = optional(string)
    vrf          = optional(string)
    disabled     = optional(bool, true)
  }))
  default = {
    telnet = {
      port     = 23
      disabled = true
    }
    ftp = {
      port     = 21
      disabled = true
    }
    www = {
      port     = 80
      disabled = true
    }
    api = {
      port     = 8728
      disabled = true
    }
    "api-ssl" = {
      port     = 8729
      disabled = true
    }
    "www-ssl" = {
      port     = 443
      disabled = false
    }
    ssh = {
      port     = 22
      disabled = false
    }
    winbox = {
      port     = 8291
      disabled = false
    }
  }
}
variable "ip_upnp" {
  description = <<-EOT
  UPnP configuration settings.
  For additional information about UPnP, refer to Mikrotik's documentation:
    * https://help.mikrotik.com/docs/spaces/ROS/pages/24805490/UPnP
  EOT    
  type = object({
    allow_disable_external_interface = bool
    enabled                          = bool
    show_dummy_rule                  = bool
  })
  default = {
    allow_disable_external_interface = false
    enabled                          = false
    show_dummy_rule                  = false
  }
}
variable "ip_cloud" {
  description = <<-EOT
  RouterOS IP Cloud settings. For further details refer to Mikrotik's documentation:
    * https://help.mikrotik.com/docs/spaces/ROS/pages/97779929/Cloud
  EOT    
  type = object({
    update_time           = optional(bool)
    ddns_enabled          = optional(string)
    ddns_update_interval  = optional(string)
    vpn_prefer_relay_code = optional(string)
  })
  default = {
    update_time           = false
    ddns_enabled          = "auto"
    ddns_update_interval  = null
    vpn_prefer_relay_code = null
  }

  validation {
    condition = (
      (
        var.ip_cloud.ddns_enabled == null ||
        contains(["yes", "auto"], var.ip_cloud.ddns_enabled)
      )
    )
    error_message = "'ip_cloud.ddns_enabled' yes' or 'auto'"
  }
  validation {
    condition = (
      var.ip_cloud.update_time == null ||
      can(tobool(var.ip_cloud.update_time))
    )
    error_message = "'ip_cloud.update_time' must be 'true' or 'false'."
  }
  validation {
    condition = (
      var.ip_cloud.ddns_update_interval == null ||
      can(regex("^\\d+[smhd]$", var.ip_cloud.ddns_update_interval))
    )
    error_message = "'ip_cloud.ddns_update_interval' must match <number>[s|m|h|d], e.g. \"30m\"."
  }
}

# ------------------------------------------
# SSH
# ------------------------------------------
variable "ssh_server_settings" {
  description = "SSH server settings"
  type = object({
    host_key_type      = string
    ciphers            = string
    forwarding_enabled = optional(string)
    host_key_size      = optional(number)
  })
  default = {
    host_key_type      = "ed25519"
    ciphers            = "aes-gcm"
    forwarding_enabled = "no"
  }

  validation {
    condition = (
      contains(["ed25519", "rsa", "ecdsa", "dsa"], var.ssh_server_settings.host_key_type) &&
      (
        var.ssh_server_settings.host_key_type != "rsa" ||
        (
          var.ssh_server_settings.host_key_size != null &&
          var.ssh_server_settings.host_key_size >= 1024 &&
          var.ssh_server_settings.host_key_size <= 8192
        )
      )
    )
    error_message = "Invalid SSH host key configuration. RSA requires key size 1024–8192"
  }
  validation {
    condition = (
      var.ssh_server_settings.ciphers == null ||
      contains(
        ["auto", "3des-cbc", "aes-cbc", "aes-ctr", "aes-gcm"],
        var.ssh_server_settings.ciphers
      )
    )
    error_message = "Invalid SSH cipher. Must be one of: auto, 3des-cbc, aes-cbc, aes-ctr, aes-gcm"
  }
  validation {
    condition = (
      var.ssh_server_settings.forwarding_enabled == null ||
      contains(
        ["both", "local", "remote", "no"],
        var.ssh_server_settings.forwarding_enabled
      )
    )
    error_message = "Invalid 'forwarding_enabled' value. Must be one of: both, local, remote, no"
  }
}

# ------------------------------------------
# MAC (Telnet/WinBox)
# ------------------------------------------
variable "mgmt_interface_list" {
  description = "Name of the MGMT interface list"
  type        = string
  default     = "MGMT"
}
variable "enable_mac_winbox_ping" {
  description = "Whether to enable MAC WinBox to perform pings"
  type        = bool
  default     = false
}
variable "ip_neighbor_discovery_settings" {
  description = <<-EOT
  Neighbor discovery (LLDP/CDP/MNDP) configuration. For further details refer to Mikrotik's documentation:
    * https://help.mikrotik.com/docs/spaces/ROS/pages/24805517/Neighbor+discovery#Neighbordiscovery-Discoveryconfiguration
  EOT
  type = object({
    mode                     = string
    discover_interface_list  = string
    lldp_dcbx                = optional(bool)
    lldp_mac_phy_config      = optional(bool)
    lldp_max_frame_size      = optional(bool)
    lldp_poe_power           = optional(bool)
    lldp_vlan_info           = optional(bool)
    lldp_med_net_policy_vlan = optional(string)
    discover_interval        = optional(string)
    protocol                 = optional(set(string))
  })
  default = {
    mode                    = "rx-only"
    discover_interface_list = "MGMT"
  }
}

# ------------------------------------------
# Global IP settings
# ------------------------------------------
variable "ip_global_security_settings" {
  description = <<-EOT
  RouterOS IP Global settings. For further details refer to Mikrotik's documentation:
    * https://help.mikrotik.com/docs/spaces/ROS/pages/103841817/IP+Settings
  EOT    
  type = object({
    tcp_syncookies      = bool
    send_redirects      = bool
    accept_redirects    = bool
    secure_redirects    = bool
    accept_source_route = bool
    rp_filter           = string
    icmp_rate_limit     = number
  })
  default = {
    tcp_syncookies      = true
    send_redirects      = false
    accept_redirects    = false
    secure_redirects    = false
    accept_source_route = false
    rp_filter           = "loose"
    icmp_rate_limit     = 10
  }

  validation {
    condition = (
      var.ip_global_security_settings.icmp_rate_limit >= 0 &&
      contains(["no", "strict", "loose"], var.ip_global_security_settings.rp_filter)
    )
    error_message = "Invalid ip_global_security_settings icmp_rate_limit must be >= 0 & rp_filter must be no, strict, or loose"
  }
}

# ------------------------------------------
# Disable IPV6
# ------------------------------------------
variable "disable_ipv6" {
  description = "Whether to disable IPV6 or not"
  type        = bool
  default     = true
}
