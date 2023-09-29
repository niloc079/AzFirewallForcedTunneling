#
resource "azurerm_firewall_policy" "afw-pol" {
    name                = "${var.identifier}${var.environment}${var.application}${var.iteration}-afw-pol"
    resource_group_name = azurerm_resource_group.rg.name
    location            = azurerm_resource_group.rg.location
    sku                 = var.sku
    tags                = var.tags

    #https://learn.microsoft.com/en-us/azure/firewall/snat-private-range
    #Requires Azure Route Server
    #auto_learn_private_ranges_enabled = false

    #ForcedTunneling
    #Never SNAT
    private_ip_ranges   = ["0.0.0.0/0"]
    #Always SNAT
    #private_ip_ranges   = ["255.255.255.255/32"]
    #IANA RFC 1918 (default), 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16, 100.64.0.0/10
    #private_ip_ranges   = ["IANAPrivateRanges"]

    dns {
      proxy_enabled = "true"
      #servers       = var.dns_servers
    }

    insights {
      enabled                             = true
      default_log_analytics_workspace_id  = azurerm_log_analytics_workspace.law-pol.id
      retention_in_days                   = 30
      log_analytics_workspace {
        id                = azurerm_log_analytics_workspace.law-pol.id
        firewall_location = var.location
      }
    } 
}

resource "azurerm_firewall_policy_rule_collection_group" "afw-rule-grp-nat" {
    depends_on         = [ azurerm_firewall_policy.afw-pol ]
    name               = "${var.identifier}${var.environment}${var.application}${var.iteration}-afw-rul-grp-nat"
    firewall_policy_id = azurerm_firewall_policy.afw-pol.id
    priority           = 100

    #No DNAT with forced tunneling, Yes when split tunneling and object is not forced through gateway

  #nat_rule_collection {
  #  name     = "DNAT-RDP"
  #  priority = 101
  #  action   = "DNAT"
  #  rule {
  #    name                = "DNAT-RDP-Allow"
  #    protocols           = ["TCP"]
  #    source_addresses    = ["*"]
  #    destination_address = azurerm_public_ip.pip-afw.ip_address
  #    destination_ports   = ["3389"]
  #    translated_address  = "10.200.32.196"
  #    translated_port     = "3389"
  #  }
  #}
}

resource "azurerm_firewall_policy_rule_collection_group" "afw-rule-grp-net" {
  depends_on         = [ azurerm_firewall_policy.afw-pol ]
  name               = "${var.identifier}${var.environment}${var.application}${var.iteration}-afw-rul-grp-net"
  firewall_policy_id = azurerm_firewall_policy.afw-pol.id
  priority           = 200
  
  network_rule_collection {
    name     = "ICMP"
    priority = 200
    action   = "Allow"
    rule {
      name                  = "ICMP-Allow"
      protocols             = ["ICMP"]
      source_addresses      = ["*"]
      destination_addresses = ["*"]
      destination_ports     = ["*"]
    }
  }

  network_rule_collection {
    name     = "DNS"
    priority = 201
    action   = "Allow"
    rule {
      name                  = "DNS-Allow"
      protocols             = ["TCP", "UDP"]
      source_addresses      = ["*"]
      destination_addresses = ["*"]
      destination_ports     = ["53"]
    }
  }

  network_rule_collection {
    name     = "ActiveDirectory"
    priority = 202
    action   = "Allow"
    rule {
      name                  = "ActiveDirectory-Allow"
      protocols             = ["Any"]
      source_addresses      = ["*"]
      destination_addresses = ["*"]
      destination_ports     = ["88","135","389","445","636","3268","5985","9389", "49152-65535"]
    }
  }

    network_rule_collection {
    name     = "RDP"
    priority = 203
    action   = "Allow"
    rule {
      name                  = "RDP-Allow"
      protocols             = ["Any"]
      source_addresses      = ["*"]
      destination_addresses = ["*"]
      destination_ports     = ["3389"]
    }
  }

    network_rule_collection {
    name     = "Any"
    priority = 299
    action   = "Allow"
    rule {
      name                  = "Any-Allow"
      protocols             = ["TCP", "UDP"]
      source_addresses      = ["*"]
      destination_addresses = ["*"]
      destination_ports     = ["*"]
    }
  }
}

resource "azurerm_firewall_policy_rule_collection_group" "afw-rule-grp-app" {
    depends_on         = [ azurerm_firewall_policy.afw-pol ]
    name               = "${var.identifier}${var.environment}${var.application}${var.iteration}-afw-rul-grp-app"
    firewall_policy_id = azurerm_firewall_policy.afw-pol.id
    priority           = 300

  application_rule_collection {
    name     = "HTTPS"
    priority = 301
    action   = "Allow"
    rule {
      name = "HTTPS-Allow"
      protocols {
        type = "Https"
        port = 443
      }
      source_addresses  = ["*"]
      destination_fqdns = ["*"]
    }
  }
}
