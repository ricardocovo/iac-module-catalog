# PostgreSQL Flexible Server Module

## Overview

This module deploys an Azure PostgreSQL Flexible Server using Azure Verified Modules (AVM).

## Module Reference

- **AVM Module**: `br/public:avm/res/db-for-postgre-sql/flexible-server:0.2.0`
- **Documentation**: [GitHub - AVM Module](https://github.com/Azure/bicep-registry-modules/tree/main/avm/res)

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `name` | string | Required | The name of the PostgreSQL server |
| `location` | string | `resourceGroup().location` | The Azure region for deployment |
| `skuName` | string | `'Standard_D2ds_v4'` | SKU name for compute tier |
| `storageSizeGB` | int | `32` | Storage size in GB |
| `version` | string | `'16'` | PostgreSQL version. Allowed values: 11, 12, 13, 14, 15, 16 |
| `administratorLogin` | string | Required | Administrator login username |
| `administratorLoginPassword` | string | Required | Administrator password (secure parameter) |
| `highAvailability` | string | `'Disabled'` | High availability mode. Allowed values: Disabled, ZoneRedundant, SameZone |
| `backupRetentionDays` | int | `7` | Backup retention period in days |
| `geoRedundantBackup` | bool | `false` | Enable geo-redundant backup |
| `delegatedSubnetResourceId` | string | `''` | Delegated subnet resource ID for VNet integration |
| `privateDnsZoneResourceId` | string | `''` | Private DNS zone resource ID |
| `firewallRules` | array | `[]` | Array of firewall rule configurations |
| `databases` | array | `[]` | Array of database configurations |
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
module postgresqlflexibleserver '../postgresql-flexible-server/main.bicep' = {
  name: 'postgresql-flexible-server-deployment'
  params: {
    name: 'my-postgresql-flexible-server'
    location: 'eastus'
    tags: {
      environment: 'production'
    }
  }
}
```

## References

- [Azure Documentation](https://learn.microsoft.com/azure/postgresql/)
- [Azure Verified Modules](https://aka.ms/avm)
