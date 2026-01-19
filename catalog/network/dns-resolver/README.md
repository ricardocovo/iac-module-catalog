# DNS Resolver Module

## Overview

This module deploys an Azure DNS Resolver using Azure Verified Modules (AVM).

## Module Reference

- **AVM Module**: `br/public:avm/res/network/dns-resolver:0.4.0`
- **Documentation**: [GitHub - AVM Module](https://github.com/Azure/bicep-registry-modules/tree/main/avm/res)

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `name` | string | Required | The name of the DNS resolver |
| `location` | string | `resourceGroup().location` | The Azure region for deployment |
| `virtualNetworkResourceId` | string | Required | Virtual network resource ID for DNS resolver |
| `inboundEndpoints` | array | `[]` | Array of inbound endpoint configurations |
| `outboundEndpoints` | array | `[]` | Array of outbound endpoint configurations |
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
module dnsresolver '../dns-resolver/main.bicep' = {
  name: 'dns-resolver-deployment'
  params: {
    name: 'my-dns-resolver'
    location: 'eastus'
    tags: {
      environment: 'production'
    }
  }
}
```

## References

- [Azure Documentation](https://learn.microsoft.com/azure/dns/)
- [Azure Verified Modules](https://aka.ms/avm)
