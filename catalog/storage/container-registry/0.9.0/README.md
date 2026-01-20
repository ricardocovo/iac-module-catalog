# Container Registry Module

## Overview

This module deploys an Azure Container Registry using Azure Verified Modules (AVM).

## Module Reference

- **AVM Module**: `br/public:avm/res/container-registry/registry:0.5.0`
- **Documentation**: [GitHub - AVM Module](https://github.com/Azure/bicep-registry-modules/tree/main/avm/res)

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `name` | string | Required | The name of the container registry |
| `location` | string | `resourceGroup().location` | The Azure region for deployment |
| `skuName` | string | `'Premium'` | SKU name. Allowed values: Basic, Standard, Premium |
| `adminUserEnabled` | bool | `false` | Enable admin user for registry |
| `publicNetworkAccess` | string | `'Disabled'` | Public network access. Allowed values: Enabled, Disabled |
| `networkRuleSetDefaultAction` | string | `'Deny'` | Network rule set default action. Allowed values: Allow, Deny |
| `networkRuleBypassOptions` | string | `'AzureServices'` | Network rule bypass options. Allowed values: None, AzureServices |
| `privateEndpoints` | array | `[]` | Array of private endpoint configurations |
| `zoneRedundancy` | string | `'Disabled'` | Zone redundancy. Allowed values: Enabled, Disabled |
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
module containerregistry '../container-registry/main.bicep' = {
  name: 'container-registry-deployment'
  params: {
    name: 'my-container-registry'
    location: 'eastus'
    tags: {
      environment: 'production'
    }
  }
}
```

## References

- [Azure Documentation](https://learn.microsoft.com/azure/container-registry/)
- [Azure Verified Modules](https://aka.ms/avm)
