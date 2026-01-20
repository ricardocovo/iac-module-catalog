# Container Apps Environment Module

## Overview

This module deploys an Azure Container Apps Environment using Azure Verified Modules (AVM).

## Module Reference

- **AVM Module**: `br/public:avm/res/app/managed-environment:0.5.0`
- **Documentation**: [GitHub - AVM Module](https://github.com/Azure/bicep-registry-modules/tree/main/avm/res)

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `name` | string | Required | The name of the container apps environment |
| `location` | string | `resourceGroup().location` | The Azure region for deployment |
| `workspaceResourceId` | string | Required | Log Analytics workspace resource ID |
| `zoneRedundant` | bool | `false` | Enable zone redundancy for high availability |
| `internalLoadBalancerEnabled` | bool | `false` | Enable internal load balancer |
| `infrastructureSubnetId` | string | `''` | Virtual network subnet resource ID (optional) |
| `dockerBridgeCidr` | string | `''` | Docker bridge CIDR (required for VNet integration) |
| `platformReservedCidr` | string | `''` | Platform reserved CIDR (required for VNet integration) |
| `platformReservedDnsIP` | string | `''` | Platform reserved DNS IP (required for VNet integration) |
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
module containerappsenvironment '../container-apps-environment/main.bicep' = {
  name: 'container-apps-environment-deployment'
  params: {
    name: 'my-container-apps-environment'
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
