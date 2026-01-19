# Network Security Group Module

## Overview

This module deploys an Azure Network Security Group using Azure Verified Modules (AVM).

## Module Reference

- **AVM Module**: `br/public:avm/res/network/network-security-group:0.4.0`
- **Documentation**: [GitHub - AVM Module](https://github.com/Azure/bicep-registry-modules/tree/main/avm/res)

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `name` | string | Required | The name of the network security group |
| `location` | string | `resourceGroup().location` | The Azure region for deployment |
| `securityRules` | array | `[]` | Array of security rule configurations |
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
module networksecuritygroup '../network-security-group/main.bicep' = {
  name: 'network-security-group-deployment'
  params: {
    name: 'my-network-security-group'
    location: 'eastus'
    tags: {
      environment: 'production'
    }
  }
}
```

## References

- [Azure Documentation](https://learn.microsoft.com/azure/virtual-network/)
- [Azure Verified Modules](https://aka.ms/avm)
