# Private Endpoint Module

## Overview

This module deploys an Azure Private Endpoint using Azure Verified Modules (AVM).

## Module Reference

- **AVM Module**: `br/public:avm/res/network/private-endpoint:0.7.0`
- **Documentation**: [GitHub - AVM Module](https://github.com/Azure/bicep-registry-modules/tree/main/avm/res)

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `name` | string | Required | The name of the private endpoint |
| `location` | string | `resourceGroup().location` | The Azure region for deployment |
| `subnetResourceId` | string | Required | Subnet resource ID where the private endpoint will be created |
| `serviceResourceId` | string | Required | Service resource ID to connect to (e.g., storage account, key vault) |
| `groupIds` | array | Required | Group IDs for the private endpoint connection (e.g., ['blob'], ['vault']) |
| `privateDnsZoneConfigs` | array | `[]` | Array of private DNS zone configurations |
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
module privateendpoint '../private-endpoint/main.bicep' = {
  name: 'private-endpoint-deployment'
  params: {
    name: 'my-private-endpoint'
    location: 'eastus'
    tags: {
      environment: 'production'
    }
  }
}
```

## References

- [Azure Documentation](https://learn.microsoft.com/azure/private-link/)
- [Azure Verified Modules](https://aka.ms/avm)
