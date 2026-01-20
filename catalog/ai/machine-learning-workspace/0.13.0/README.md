# Machine Learning Workspace Module

## Overview

This module deploys an Azure Machine Learning Workspace using Azure Verified Modules (AVM).

## Module Reference

- **AVM Module**: `br/public:avm/res/machine-learning-services/workspace:0.7.0`
- **Documentation**: [GitHub - AVM Module](https://github.com/Azure/bicep-registry-modules/tree/main/avm/res)

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `name` | string | Required | The name of the ML workspace |
| `location` | string | `resourceGroup().location` | The Azure region for deployment |
| `skuName` | string | `'Basic'` | SKU name. Allowed values: Basic, Free, Premium, Standard |
| `storageAccountResourceId` | string | Required | Storage account resource ID |
| `keyVaultResourceId` | string | Required | Key vault resource ID |
| `applicationInsightsResourceId` | string | Required | Application Insights resource ID |
| `containerRegistryResourceId` | string | `''` | Container registry resource ID (optional) |
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
module machinelearningworkspace '../machine-learning-workspace/main.bicep' = {
  name: 'machine-learning-workspace-deployment'
  params: {
    name: 'my-machine-learning-workspace'
    location: 'eastus'
    tags: {
      environment: 'production'
    }
  }
}
```

## References

- [Azure Documentation](https://learn.microsoft.com/azure/machine-learning/)
- [Azure Verified Modules](https://aka.ms/avm)
