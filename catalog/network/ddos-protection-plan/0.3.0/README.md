# DDoS Protection Plan Module

## Overview

This module deploys an Azure DDoS Protection Plan using Azure Verified Modules (AVM).

## Module Reference

- **AVM Module**: `br/public:avm/res/network/ddos-protection-plan:0.2.0`
- **Documentation**: [GitHub - AVM Module](https://github.com/Azure/bicep-registry-modules/tree/main/avm/res)

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `name` | string | Required | The name of the DDoS protection plan |
| `location` | string | `resourceGroup().location` | The Azure region for deployment |
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
module ddosprotectionplan '../ddos-protection-plan/main.bicep' = {
  name: 'ddos-protection-plan-deployment'
  params: {
    name: 'my-ddos-protection-plan'
    location: 'eastus'
    tags: {
      environment: 'production'
    }
  }
}
```

## References

- [Azure Documentation](https://learn.microsoft.com/azure/ddos-protection/)
- [Azure Verified Modules](https://aka.ms/avm)
