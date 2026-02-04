<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_routeros"></a> [routeros](#requirement\_routeros) | 1.99.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_routeros"></a> [routeros](#provider\_routeros) | 1.99.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [routeros_ip_cloud.ip_cloud](https://registry.terraform.io/providers/terraform-routeros/routeros/1.99.0/docs/resources/ip_cloud) | resource |
| [routeros_ip_neighbor_discovery_settings.ip_neighbor_discovery_settings](https://registry.terraform.io/providers/terraform-routeros/routeros/1.99.0/docs/resources/ip_neighbor_discovery_settings) | resource |
| [routeros_ip_service.services](https://registry.terraform.io/providers/terraform-routeros/routeros/1.99.0/docs/resources/ip_service) | resource |
| [routeros_ip_settings.settings](https://registry.terraform.io/providers/terraform-routeros/routeros/1.99.0/docs/resources/ip_settings) | resource |
| [routeros_ip_ssh_server.ssh_server_settings](https://registry.terraform.io/providers/terraform-routeros/routeros/1.99.0/docs/resources/ip_ssh_server) | resource |
| [routeros_ip_upnp.ip_upnp](https://registry.terraform.io/providers/terraform-routeros/routeros/1.99.0/docs/resources/ip_upnp) | resource |
| [routeros_ipv6_settings.disable_ipv6](https://registry.terraform.io/providers/terraform-routeros/routeros/1.99.0/docs/resources/ipv6_settings) | resource |
| [routeros_system_user_settings.user_settings](https://registry.terraform.io/providers/terraform-routeros/routeros/1.99.0/docs/resources/system_user_settings) | resource |
| [routeros_tool_mac_server.mac_telnet](https://registry.terraform.io/providers/terraform-routeros/routeros/1.99.0/docs/resources/tool_mac_server) | resource |
| [routeros_tool_mac_server_ping.mac_winbox_ping](https://registry.terraform.io/providers/terraform-routeros/routeros/1.99.0/docs/resources/tool_mac_server_ping) | resource |
| [routeros_tool_mac_server_winbox.mac_winbox](https://registry.terraform.io/providers/terraform-routeros/routeros/1.99.0/docs/resources/tool_mac_server_winbox) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_disable_ipv6"></a> [disable\_ipv6](#input\_disable\_ipv6) | Whether to disable IPV6 or not | `bool` | `true` | no |
| <a name="input_enable_mac_winbox_ping"></a> [enable\_mac\_winbox\_ping](#input\_enable\_mac\_winbox\_ping) | Whether to enable MAC WinBox to perform pings | `bool` | `false` | no |
| <a name="input_ip_cloud"></a> [ip\_cloud](#input\_ip\_cloud) | RouterOS IP Cloud settings. For further details refer to Mikrotik's documentation:<br/>  * https://help.mikrotik.com/docs/spaces/ROS/pages/97779929/Cloud | <pre>object({<br/>    update_time           = optional(bool)<br/>    ddns_enabled          = optional(string)<br/>    ddns_update_interval  = optional(string)<br/>    vpn_prefer_relay_code = optional(string)<br/>  })</pre> | <pre>{<br/>  "ddns_enabled": "auto",<br/>  "ddns_update_interval": null,<br/>  "update_time": false,<br/>  "vpn_prefer_relay_code": null<br/>}</pre> | no |
| <a name="input_ip_global_security_settings"></a> [ip\_global\_security\_settings](#input\_ip\_global\_security\_settings) | RouterOS IP Global settings. For further details refer to Mikrotik's documentation:<br/>  * https://help.mikrotik.com/docs/spaces/ROS/pages/103841817/IP+Settings | <pre>object({<br/>    tcp_syncookies      = bool<br/>    send_redirects      = bool<br/>    accept_redirects    = bool<br/>    secure_redirects    = bool<br/>    accept_source_route = bool<br/>    rp_filter           = string<br/>    icmp_rate_limit     = number<br/>  })</pre> | <pre>{<br/>  "accept_redirects": false,<br/>  "accept_source_route": false,<br/>  "icmp_rate_limit": 10,<br/>  "rp_filter": "loose",<br/>  "secure_redirects": false,<br/>  "send_redirects": false,<br/>  "tcp_syncookies": true<br/>}</pre> | no |
| <a name="input_ip_neighbor_discovery_settings"></a> [ip\_neighbor\_discovery\_settings](#input\_ip\_neighbor\_discovery\_settings) | Neighbor discovery (LLDP/CDP/MNDP) configuration. For further details refer to Mikrotik's documentation:<br/>  * https://help.mikrotik.com/docs/spaces/ROS/pages/24805517/Neighbor+discovery#Neighbordiscovery-Discoveryconfiguration | <pre>object({<br/>    mode                     = string<br/>    discover_interface_list  = string<br/>    lldp_dcbx                = optional(bool)<br/>    lldp_mac_phy_config      = optional(bool)<br/>    lldp_max_frame_size      = optional(bool)<br/>    lldp_poe_power           = optional(bool)<br/>    lldp_vlan_info           = optional(bool)<br/>    lldp_med_net_policy_vlan = optional(string)<br/>    discover_interval        = optional(string)<br/>    protocol                 = optional(set(string))<br/>  })</pre> | <pre>{<br/>  "discover_interface_list": "MGMT",<br/>  "mode": "rx-only"<br/>}</pre> | no |
| <a name="input_ip_upnp"></a> [ip\_upnp](#input\_ip\_upnp) | UPnP configuration settings.<br/>For additional information about UPnP, refer to Mikrotik's documentation:<br/>  * https://help.mikrotik.com/docs/spaces/ROS/pages/24805490/UPnP | <pre>object({<br/>    allow_disable_external_interface = bool<br/>    enabled                          = bool<br/>    show_dummy_rule                  = bool<br/>  })</pre> | <pre>{<br/>  "allow_disable_external_interface": false,<br/>  "enabled": false,<br/>  "show_dummy_rule": false<br/>}</pre> | no |
| <a name="input_mgmt_interface_list"></a> [mgmt\_interface\_list](#input\_mgmt\_interface\_list) | Name of the MGMT interface list | `string` | `"MGMT"` | no |
| <a name="input_minimum_password_categories"></a> [minimum\_password\_categories](#input\_minimum\_password\_categories) | Specifies the complexity requirements of the password, with categories being uppercase, lowercase, digit, symbol. Allowed values are 0 to 4 | `number` | `4` | no |
| <a name="input_minimum_password_length"></a> [minimum\_password\_length](#input\_minimum\_password\_length) | Specifies the minimum character length of the users passwords | `number` | `16` | no |
| <a name="input_routeros_services"></a> [routeros\_services](#input\_routeros\_services) | Map of RouterOS services configuration for hardening and management | <pre>map(object({<br/>    port         = number<br/>    max_sessions = optional(number)<br/>    address      = optional(string)<br/>    certificate  = optional(string)<br/>    tls_version  = optional(string)<br/>    vrf          = optional(string)<br/>    disabled     = optional(bool, true)<br/>  }))</pre> | <pre>{<br/>  "api": {<br/>    "disabled": true,<br/>    "port": 8728<br/>  },<br/>  "api-ssl": {<br/>    "disabled": true,<br/>    "port": 8729<br/>  },<br/>  "ftp": {<br/>    "disabled": true,<br/>    "port": 21<br/>  },<br/>  "ssh": {<br/>    "disabled": false,<br/>    "port": 22<br/>  },<br/>  "telnet": {<br/>    "disabled": true,<br/>    "port": 23<br/>  },<br/>  "winbox": {<br/>    "disabled": false,<br/>    "port": 8291<br/>  },<br/>  "www": {<br/>    "disabled": true,<br/>    "port": 80<br/>  },<br/>  "www-ssl": {<br/>    "disabled": false,<br/>    "port": 443<br/>  }<br/>}</pre> | no |
| <a name="input_ssh_server_settings"></a> [ssh\_server\_settings](#input\_ssh\_server\_settings) | SSH server settings | <pre>object({<br/>    host_key_type      = string<br/>    ciphers            = string<br/>    forwarding_enabled = optional(string)<br/>    host_key_size      = optional(number)<br/>  })</pre> | <pre>{<br/>  "ciphers": "aes-gcm",<br/>  "forwarding_enabled": "no",<br/>  "host_key_type": "ed25519"<br/>}</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
