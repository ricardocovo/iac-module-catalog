# Log Analytics Workspace Module

## Overview

This module deploys an Azure Log Analytics Workspace using Azure Verified Modules (AVM).

## Module Reference

- **AVM Module**: `br/public:avm/res/operational-insights/workspace:0.7.0`
- **Documentation**: [GitHub - AVM Module](https://github.com/Azure/bicep-registry-modules/tree/main/avm/res)

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `name` | string | Required | The name of the Log Analytics workspace |
| `location` | string | `resourceGroup().location` | The Azure region for deployment |
| `skuName` | string | `'PerGB2018'` | SKU name. Allowed values: Free, PerGB2018, PerNode, Premium, Standalone, Standard |
| `dataRetention` | int | `30` | Data retention period in days (30-730) |
| `dailyQuotaGb` | int | `-1` | Daily ingestion quota in GB (-1 for unlimited) |
| `publicNetworkAccessForIngestion` | string | `'Enabled'` | Public network access for ingestion. Allowed values: Enabled, Disabled |
| `publicNetworkAccessForQuery` | string | `'Enabled'` | Public network access for query. Allowed values: Enabled, Disabled |
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
module loganalyticsworkspace '../log-analytics-workspace/main.bicep' = {
  name: 'log-analytics-workspace-deployment'
  params: {
    name: 'my-log-analytics-workspace'
    location: 'eastus'
    tags: {
      environment: 'production'
    }
  }
}
```

## References

- [Azure Documentation](https://learn.microsoft.com/azure/azure-monitor/logs/)
- [Azure Verified Modules](https://aka.ms/avm)
