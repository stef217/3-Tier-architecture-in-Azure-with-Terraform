terraform {
  required_version = ">=1.3.0"

  required_providers {

    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.43.0"

    }
  }
    cloud { 
    
    organization = "Terraformlearn21" 

    workspaces { 
      name = "3-Tier-architecture-in-Azure-with-Terraform" 
    } 
  }
}

provider "azurerm" {
  features {}
  subscription_id = "9734ed68-621d-47ed-babd-269110dbacb1"
  skip_provider_registration = true
}