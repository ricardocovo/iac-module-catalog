# Compute & Web Modules

Azure Verified Modules for compute and web services in the Microsoft Foundry landing zone.

## Available Modules

| Module | AVM Reference | Version | Description |
|--------|--------------|---------|-------------|
| [App Service Plan](app-service-plan.bicep) | `avm/res/web/serverfarm` | 0.3.0 | App Service Plan for hosting |
| [App Service](app-service.bicep) | `avm/res/web/site` | 0.9.0 | App Service (Web App) for chat UI |

## Usage Example

```bicep
module appServicePlan './app-service-plan.bicep' = {
  name: 'asp-deployment'
  params: {
    name: 'asp-foundry-eastus2'
    location: 'eastus2'
    skuName: 'P1v3'
    kind: 'Linux'
  }
}

module appService './app-service.bicep' = {
  name: 'app-deployment'
  params: {
    name: 'app-foundry-chat-eastus2'
    location: 'eastus2'
    serverFarmResourceId: appServicePlan.outputs.resourceId
    kind: 'app'
    virtualNetworkSubnetId: subnetId
    privateEndpoints: [
      {
        subnetResourceId: peSubnetId
        privateDnsZoneResourceIds: [dnsZoneId]
      }
    ]
  }
}
```
