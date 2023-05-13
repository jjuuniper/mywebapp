terraform{
    required_providers{
        azurerm = {
            source = "hashicorp/azurerm"
            version = "3.0.0"
        }
    }
}

provider "azurerm"{
    features{

    }
}

resource "azurerm_resource_group" "tf_rg_mywebapp" {
  name = "jjuunipertfrg"
  location = "centralus"

}

resource "azurerm_container_group" "tf_cg_mywebapp" {
  name = "cg_mywebapp"
  location = "centralus"
  resource_group_name = azurerm_resource_group.tf_rg_mywebapp.name

  ip_address_type = "Public"
  dns_name_label = "mywebapptf"
  os_type = "Linux"

  container {
    name = "mywebapp"
    image = "juuniper/mywebapp"
    cpu = "1"
    memory = "1"

    ports{
        port = 80
        protocol = "TCP"
    }
  }
}