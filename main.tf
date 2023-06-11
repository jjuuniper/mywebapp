terraform{
    required_providers{
        azurerm = {
            source = "hashicorp/azurerm"
            version = "3.56.0"
        }
    }
}

provider "azurerm"{
    features{
      
    }
}

resource "azurerm_resource_group" "tf_rg_mywebapp" {
  name = var.iac_resource_group
  location = "eastus"

}

resource "azurerm_service_plan" "tf_service_plan" {
 name                = "mywebapp_sp"
 sku_name            = "B1"
 location            = "eastus"
 resource_group_name = azurerm_resource_group.tf_rg_mywebapp.name
 os_type             = "Linux"
}

resource "azurerm_linux_web_app" "tf_mywebapp_app_service" {
  name                = var.iac_linux_web_app
  location            = azurerm_resource_group.tf_rg_mywebapp.location
  resource_group_name = azurerm_resource_group.tf_rg_mywebapp.name
  service_plan_id     = azurerm_service_plan.tf_service_plan.id

  site_config {
    always_on = false
    application_stack {
      docker_image = var.iac_docker_image
	    docker_image_tag = var.image_build
    }
  }
}