# App Service (Web App) Module

## Overview

This module deploys an Azure App Service (Web App) using Azure Verified Modules (AVM).

## Module Reference

- **AVM Module**: `br/public:avm/res/web/site:0.9.0`
- **Documentation**: [GitHub - AVM Module](https://github.com/Azure/bicep-registry-modules/tree/main/avm/res)

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `name` | string | Required | The name of the app service |
| `location` | string | `resourceGroup().location` | The Azure region for deployment |
| `serverFarmResourceId` | string | Required | App Service Plan resource ID |
| `kind` | string | `'app'` | Kind of site |
| `siteConfig` | object | `{}` | Site configuration settings |
| `appSettingsKeyValuePairs` | object | `{}` | App settings key-value pairs |
| `virtualNetworkSubnetId` | string | `''` | Virtual network subnet ID for VNet integration |
| `privateEndpoints` | array | `[]` | Array of private endpoint configurations |
| `managedIdentities` | object | `{}` | Managed identity configuration |
| `tags` | object | `{}` | Resource tags |

## Outputs

This module returns the standard outputs from the underlying AVM module, typically including:
- `resourceId` - The resource ID
- `name` - The resource name
- Additional resource-specific outputs

## Usage

### Basic Deployment

See [examples/basic-deployment.bicep](examples/basic-deployment.bicep) for a minimal configuration.

### Production Deployment

See [examples/production-deployment.bicep](examples/production-deployment.bicep) for a production-ready configuration.

## Example

```bicep
module appservice '../app-service/main.bicep' = {
  name: 'app-service-deployment'
  params: {
    name: 'my-app-service'
    location: 'eastus'
    tags: {
      environment: 'production'
    }
  }
}
```

## References

- [Azure Documentation](https://learn.microsoft.com/azure/app-service/)
- [Azure Verified Modules](https://aka.ms/avm)
