# Container App Module

## Overview

This module deploys an Azure Container App using Azure Verified Modules (AVM).

## Module Reference

- **AVM Module**: `br/public:avm/res/app/container-app:0.8.0`
- **Documentation**: [GitHub - AVM Module](https://github.com/Azure/bicep-registry-modules/tree/main/avm/res)

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `name` | string | Required | The name of the container app |
| `location` | string | `resourceGroup().location` | The Azure region for deployment |
| `environmentResourceId` | string | Required | Container Apps environment resource ID |
| `containers` | array | Required | Array of container configurations |
| `ingressConfiguration` | object | `{}` | Ingress configuration (external, targetPort, transport) |
| `scaleConfiguration` | object | `{}` | Scale configuration (minReplicas, maxReplicas, rules) |
| `secretsConfiguration` | object | `{}` | Secrets configuration object (secure parameter) |
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
module containerapp '../container-app/main.bicep' = {
  name: 'container-app-deployment'
  params: {
    name: 'my-container-app'
    location: 'eastus'
    tags: {
      environment: 'production'
    }
  }
}
```

## References

- [Azure Documentation](https://learn.microsoft.com/azure/container-apps/)
- [Azure Verified Modules](https://aka.ms/avm)
