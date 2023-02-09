terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.10.0"
    }
  }
}

resource "azurerm_resource_group" "rghackthon" {
  name     = "rghackthon"
  location = "West Europe"
}

resource "azurerm_container_registry" "acr" {
  name                = "containerRegistry1"
  resource_group_name = azurerm_resource_group.rghackthon.name
  location            = azurerm_resource_group.rghackthon.location
  sku                 = "Basic"
}

resource "azurerm_kubernetes_cluster" "akc" {
  name                = "kubernetes-aks1"
  location            = azurerm_resource_group.rghackthon.location
  resource_group_name = azurerm_resource_group.rghackthon.name
  dns_prefix          = "kubernetesaks1"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Test"
  }
}
