# Cosmos DB Account Module

## Overview

This module deploys an Azure Cosmos DB Account using Azure Verified Modules (AVM).

## Module Reference

- **AVM Module**: `br/public:avm/res/document-db/database-account:0.8.0`
- **Documentation**: [GitHub - AVM Module](https://github.com/Azure/bicep-registry-modules/tree/main/avm/res)

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `name` | string | Required | The name of the Cosmos DB account |
| `location` | string | `resourceGroup().location` | The Azure region for deployment |
| `defaultConsistencyLevel` | string | `'Session'` | Default consistency level. Allowed values: Eventual, ConsistentPrefix, Session, BoundedStaleness, Strong |
| `automaticFailover` | bool | `true` | Enable automatic failover for high availability |
| `enableMultipleWriteLocations` | bool | `false` | Enable multiple write locations (multi-region writes) |
| `locations` | array | `[]` | Array of location configurations for geo-replication |
| `networkRestrictions` | object | `{ publicNetworkAccess: 'Disabled', networkAclBypass: 'AzureServices' }` | Network restrictions configuration |
| `privateEndpoints` | array | `[]` | Array of private endpoint configurations |
| `sqlDatabases` | array | `[]` | Array of SQL database configurations |
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
module cosmosdbaccount '../cosmos-db-account/main.bicep' = {
  name: 'cosmos-db-account-deployment'
  params: {
    name: 'my-cosmos-db-account'
    location: 'eastus'
    tags: {
      environment: 'production'
    }
  }
}
```

## References

- [Azure Documentation](https://learn.microsoft.com/azure/cosmos-db/)
- [Azure Verified Modules](https://aka.ms/avm)
