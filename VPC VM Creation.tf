# Create Resource Group
resource "azurerm_resource_group" "example" {
  name     = "example-rg"
  location = "East US"
}

# Virtual Network Creation
resource "azurerm_virtual_network" "example" {
  name                = "example-vnet"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  address_space       = ["10.0.0.0/16"]
}

# Public and Private Subnets
resource "azurerm_subnet" "public_subnet1" {
  name                 = "public-subnet-1"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "private_subnet1" {
  name                 = "private-subnet-1"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.4.0/24"]
}

# Public IP and NAT Gateway for Private Subnets
resource "azurerm_public_ip" "example_public_ip" {
  name                         = "example-public-ip"
  location                     = azurerm_resource_group.example.location
  resource_group_name          = azurerm_resource_group.example.name
  allocation_method            = "Static"
  sku                          = "Basic"
}

resource "azurerm_nat_gateway" "example" {
  name                = "example-nat-gateway"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  public_ip_id        = azurerm_public_ip.example_public_ip.id
}

# Network Interface Creation with Public IP
resource "azurerm_network_interface" "example_nic" {
  name                = "example-nic"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.public_subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.example_public_ip.id
  }
}

# Virtual Machine with Public IP
resource "azurerm_linux_virtual_machine" "example_vm" {
  name                = "example-vm"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  admin_password      = "P@ssw0rd1234!"
  network_interface_ids = [azurerm_network_interface.example_nic.id]
  
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
