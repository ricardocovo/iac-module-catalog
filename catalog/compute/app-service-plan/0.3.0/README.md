# App Service Plan Module

## Overview

This module deploys an Azure App Service Plan using Azure Verified Modules (AVM).

## Module Reference

- **AVM Module**: `br/public:avm/res/web/serverfarm:0.2.0`
- **Documentation**: [GitHub - AVM Module](https://github.com/Azure/bicep-registry-modules/tree/main/avm/res)

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `name` | string | Required | The name of the app service plan |
| `location` | string | `resourceGroup().location` | The Azure region for deployment |
| `skuName` | string | `'P1v3'` | SKU name for the service plan |
| `skuCapacity` | int | `1` | SKU capacity (number of instances) |
| `kind` | string | `'Linux'` | Kind of resource. Allowed values: Windows, Linux, FunctionApp |
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
module appserviceplan '../app-service-plan/main.bicep' = {
  name: 'app-service-plan-deployment'
  params: {
    name: 'my-app-service-plan'
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
