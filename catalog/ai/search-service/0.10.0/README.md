# Azure AI Search Service Module

## Overview

This module deploys an Azure Azure AI Search Service using Azure Verified Modules (AVM).

## Module Reference

- **AVM Module**: `br/public:avm/res/search/search-service:0.7.0`
- **Documentation**: [GitHub - AVM Module](https://github.com/Azure/bicep-registry-modules/tree/main/avm/res)

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `name` | string | Required | The name of the search service |
| `location` | string | `resourceGroup().location` | The Azure region for deployment |
| `skuName` | string | `'standard'` | SKU name. Allowed values: free, basic, standard, standard2, standard3, storage_optimized_l1, storage_optimized_l2 |
| `replicaCount` | int | `1` | Number of replicas for high availability |
| `partitionCount` | int | `1` | Number of partitions for scaling |
| `publicNetworkAccess` | string | `'Disabled'` | Public network access. Allowed values: Enabled, Disabled |
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
module searchservice '../search-service/main.bicep' = {
  name: 'search-service-deployment'
  params: {
    name: 'my-search-service'
    location: 'eastus'
    tags: {
      environment: 'production'
    }
  }
}
```

## References

- [Azure Documentation](https://learn.microsoft.com/azure/search/)
- [Azure Verified Modules](https://aka.ms/avm)
