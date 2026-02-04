# ------------------------------------------
# Password Settings
# ------------------------------------------
resource "routeros_system_user_settings" "user_settings" {
  minimum_categories      = var.minimum_password_categories
  minimum_password_length = var.minimum_password_length
}

# ------------------------------------------
# Enable/Disable Services
# ------------------------------------------
resource "routeros_ip_service" "services" {
  for_each = var.routeros_services

  numbers      = each.key
  address      = lookup(each.value, "address", null)
  port         = each.value.port
  certificate  = lookup(each.value, "certificate", null)
  max_sessions = lookup(each.value, "max_sessions", null)
  tls_version  = lookup(each.value, "tls_version", null)
  vrf          = lookup(each.value, "vrf", null)
  disabled     = lookup(each.value, "disabled", true)
}
resource "routeros_ip_upnp" "ip_upnp" {
  allow_disable_external_interface = var.ip_upnp.allow_disable_external_interface
  enabled                          = var.ip_upnp.enabled
  show_dummy_rule                  = var.ip_upnp.show_dummy_rule
}
resource "routeros_ip_cloud" "ip_cloud" {
  ddns_enabled          = var.ip_cloud.ddns_enabled
  update_time           = var.ip_cloud.update_time
  ddns_update_interval  = var.ip_cloud.ddns_update_interval
  vpn_prefer_relay_code = var.ip_cloud.vpn_prefer_relay_code
}

# ------------------------------------------
# SSH
# ------------------------------------------
resource "routeros_ip_ssh_server" "ssh_server_settings" {
  strong_crypto      = true
  host_key_type      = var.ssh_server_settings.host_key_type
  host_key_size      = var.ssh_server_settings.host_key_size
  ciphers            = var.ssh_server_settings.ciphers
  forwarding_enabled = var.ssh_server_settings.forwarding_enabled
}

# ------------------------------------------
# MAC (Telnet/WinBox)
# ------------------------------------------
resource "routeros_tool_mac_server" "mac_telnet" {
  allowed_interface_list = "none"
}
resource "routeros_tool_mac_server_winbox" "mac_winbox" {
  allowed_interface_list = var.mgmt_interface_list
}
resource "routeros_tool_mac_server_ping" "mac_winbox_ping" {
  enabled = var.enable_mac_winbox_ping
}
resource "routeros_ip_neighbor_discovery_settings" "ip_neighbor_discovery_settings" {
  discover_interface_list  = var.ip_neighbor_discovery_settings.discover_interface_list
  mode                     = var.ip_neighbor_discovery_settings.mode
  lldp_med_net_policy_vlan = var.ip_neighbor_discovery_settings.lldp_med_net_policy_vlan
  discover_interval        = var.ip_neighbor_discovery_settings.discover_interval
  lldp_dcbx                = var.ip_neighbor_discovery_settings.lldp_dcbx
  lldp_mac_phy_config      = var.ip_neighbor_discovery_settings.lldp_mac_phy_config
  lldp_max_frame_size      = var.ip_neighbor_discovery_settings.lldp_max_frame_size
  lldp_poe_power           = var.ip_neighbor_discovery_settings.lldp_poe_power
  lldp_vlan_info           = var.ip_neighbor_discovery_settings.lldp_vlan_info
  protocol                 = var.ip_neighbor_discovery_settings.protocol
}

# ------------------------------------------
# Global IP settings
# ------------------------------------------
resource "routeros_ip_settings" "settings" {
  tcp_syncookies      = var.ip_global_security_settings.tcp_syncookies
  icmp_rate_limit     = var.ip_global_security_settings.icmp_rate_limit
  send_redirects      = var.ip_global_security_settings.send_redirects
  accept_redirects    = var.ip_global_security_settings.accept_redirects
  rp_filter           = var.ip_global_security_settings.rp_filter
  secure_redirects    = var.ip_global_security_settings.secure_redirects
  accept_source_route = var.ip_global_security_settings.accept_source_route
}

# ------------------------------------------
# Disable IPV6
# ------------------------------------------
resource "routeros_ipv6_settings" "disable_ipv6" {
  disable_ipv6 = var.disable_ipv6
}