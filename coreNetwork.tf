resource "azurerm_resource_group" "Core" {
   name = "Core"
   location = "${var.loc}"
   tags = "${var.tags}"
}

resource "azurerm_public_ip" "GatewayIP" {
  name  =   "vpnGatewayPublicIp"
  location = "${azurerm_resource_group.Core.location}"
  public_ip_address_allocation = "dynamic"
  resource_group_name = "${azurerm_resource_group.Core.name}"
  tags = "${azurerm_resource_group.Core.tags}"
}

resource "azurerm_virtual_network" "CoreVNET" {
  name = "Core"
  resource_group_name = "${azurerm_resource_group.Core.name}"
  location = "${azurerm_resource_group.Core.location}"
  address_space = ["10.0.0.0/16"]
  dns_servers = ["1.1.1.1", "1.0.0.1"]
  tags = "${azurerm_resource_group.Core.tags}"
}

resource "azurerm_subnet" "GWSubnet" {
  name = "GatewaySubnet"
  virtual_network_name = "${azurerm_virtual_network.CoreVNET.name}"
  resource_group_name = "${azurerm_resource_group.Core.name}"
  address_prefix = "10.0.0.0/24"
}

resource "azurerm_subnet" "TrainingSubnet" {
  name = "TrainingSubnet"
  virtual_network_name = "${azurerm_virtual_network.CoreVNET.name}"
  resource_group_name = "${azurerm_resource_group.Core.name}"
  address_prefix = "10.0.1.0/24"
}

resource "azurerm_subnet" "DevSubnet" {
  name = "DevSubnet"
  virtual_network_name = "${azurerm_virtual_network.CoreVNET.name}"
  resource_group_name = "${azurerm_resource_group.Core.name}"
  address_prefix = "10.0.2.0/24"
}

/*
resource "azurerm_virtual_network_gateway" "vpnGateway" {
  name                = "vpnGateway"
  location            = "${azurerm_resource_group.Core.location}"
  resource_group_name = "${azurerm_resource_group.Core.name}"
  tags = "${azurerm_resource_group.Core.tags}"

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = true
  sku           = "Basic"

  ip_configuration {
    name                          = "vpnGwConfig1"
    public_ip_address_id          = "${azurerm_public_ip.GatewayIP.id}"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = "${azurerm_subnet.GWSubnet.id}"
  }
}
*/