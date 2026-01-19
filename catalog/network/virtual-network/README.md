# Virtual Network Module

## Overview

This module deploys an Azure Virtual Network using Azure Verified Modules (AVM).

## Module Reference

- **AVM Module**: `br/public:avm/res/network/virtual-network:0.4.0`
- **Documentation**: [GitHub - AVM Module](https://github.com/Azure/bicep-registry-modules/tree/main/avm/res)

## Parameters

See [main.bicep](main.bicep) for the complete list of parameters and their descriptions.

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
module virtualnetwork '../virtual-network/main.bicep' = {
  name: 'virtual-network-deployment'
  params: {
    name: 'my-virtual-network'
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
