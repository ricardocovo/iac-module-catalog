# VPN Gateway Module

## Overview

This module deploys an Azure VPN Gateway using Azure Verified Modules (AVM).

## Module Reference

- **AVM Module**: `br/public:avm/res/network/vpn-gateway:0.3.0`
- **Documentation**: [GitHub - AVM Module](https://github.com/Azure/bicep-registry-modules/tree/main/avm/res)

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `name` | string | Required | The name of the VPN gateway |
| `location` | string | `resourceGroup().location` | The Azure region for deployment |
| `virtualHubResourceId` | string | Required | Virtual Hub resource ID for the VPN gateway |
| `bgpSettings` | object | `{}` | BGP settings configuration |
| `vpnConnections` | array | `[]` | Array of VPN connection configurations |
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
module vpngateway '../vpn-gateway/main.bicep' = {
  name: 'vpn-gateway-deployment'
  params: {
    name: 'my-vpn-gateway'
    location: 'eastus'
    tags: {
      environment: 'production'
    }
  }
}
```

## References

- [Azure Documentation](https://learn.microsoft.com/azure/vpn-gateway/)
- [Azure Verified Modules](https://aka.ms/avm)
