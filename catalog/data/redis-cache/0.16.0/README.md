# Azure Cache for Redis Module

## Overview

This module deploys an Azure Azure Cache for Redis using Azure Verified Modules (AVM).

## Module Reference

- **AVM Module**: `br/public:avm/res/cache/redis:0.3.0`
- **Documentation**: [GitHub - AVM Module](https://github.com/Azure/bicep-registry-modules/tree/main/avm/res)

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `name` | string | Required | The name of the Redis cache |
| `location` | string | `resourceGroup().location` | The Azure region for deployment |
| `skuName` | string | `'Premium'` | SKU name. Allowed values: Basic, Standard, Premium |
| `skuCapacity` | int | `1` | SKU capacity (cache size) |
| `enableNonSslPort` | bool | `false` | Enable non-SSL port 6379 |
| `minimumTlsVersion` | string | `'1.2'` | Minimum TLS version. Allowed values: 1.0, 1.1, 1.2 |
| `publicNetworkAccess` | string | `'Disabled'` | Public network access. Allowed values: Enabled, Disabled |
| `redisConfiguration` | object | `{}` | Redis-specific configuration settings |
| `privateEndpoints` | array | `[]` | Array of private endpoint configurations |
| `zones` | array | `[]` | Availability zones for zone redundancy |
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
module rediscache '../redis-cache/main.bicep' = {
  name: 'redis-cache-deployment'
  params: {
    name: 'my-redis-cache'
    location: 'eastus'
    tags: {
      environment: 'production'
    }
  }
}
```

## References

- [Azure Documentation](https://learn.microsoft.com/azure/azure-cache-for-redis/)
- [Azure Verified Modules](https://aka.ms/avm)
