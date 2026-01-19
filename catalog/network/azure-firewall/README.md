# Azure Firewall Module

## Overview

This module deploys an Azure Azure Firewall using Azure Verified Modules (AVM).

## Module Reference

- **AVM Module**: `br/public:avm/res/network/azure-firewall:0.3.0`
- **Documentation**: [GitHub - AVM Module](https://github.com/Azure/bicep-registry-modules/tree/main/avm/res)

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `name` | string | Required | The name of the Azure Firewall |
| `location` | string | `resourceGroup().location` | The Azure region for deployment |
| `skuTier` | string | `'Standard'` | Firewall SKU tier. Allowed values: Standard, Premium |
| `virtualNetworkName` | string | Required | Virtual network name for firewall subnet (AzureFirewallSubnet) |
| `publicIPAddressObject` | object | Required | Public IP address configuration |
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
module azurefirewall '../azure-firewall/main.bicep' = {
  name: 'azure-firewall-deployment'
  params: {
    name: 'my-azure-firewall'
    location: 'eastus'
    tags: {
      environment: 'production'
    }
  }
}
```

## References

- [Azure Documentation](https://learn.microsoft.com/azure/firewall/)
- [Azure Verified Modules](https://aka.ms/avm)
