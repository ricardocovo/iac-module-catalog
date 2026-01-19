# Application Insights Module

## Overview

This module deploys an Azure Application Insights using Azure Verified Modules (AVM).

## Module Reference

- **AVM Module**: `br/public:avm/res/insights/component:0.4.0`
- **Documentation**: [GitHub - AVM Module](https://github.com/Azure/bicep-registry-modules/tree/main/avm/res)

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `name` | string | Required | The name of the Application Insights component |
| `location` | string | `resourceGroup().location` | The Azure region for deployment |
| `applicationType` | string | `'web'` | Application type. Allowed values: web, other |
| `workspaceResourceId` | string | Required | Log Analytics workspace resource ID |
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
module applicationinsights '../application-insights/main.bicep' = {
  name: 'application-insights-deployment'
  params: {
    name: 'my-application-insights'
    location: 'eastus'
    tags: {
      environment: 'production'
    }
  }
}
```

## References

- [Azure Documentation](https://learn.microsoft.com/azure/azure-monitor/app/)
- [Azure Verified Modules](https://aka.ms/avm)
