# Service Bus Namespace Module

## Overview

This module deploys an Azure Service Bus Namespace using Azure Verified Modules (AVM).

## Module Reference

- **AVM Module**: `br/public:avm/res/service-bus/namespace:0.9.0`
- **Documentation**: [GitHub - AVM Module](https://github.com/Azure/bicep-registry-modules/tree/main/avm/res)

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `name` | string | Required | The name of the Service Bus namespace |
| `location` | string | `resourceGroup().location` | The Azure region for deployment |
| `skuName` | string | `'Premium'` | SKU name. Allowed values: Basic, Standard, Premium |
| `capacity` | int | `1` | SKU capacity (Premium tier only, 1-16 messaging units) |
| `zoneRedundant` | bool | `true` | Enable zone redundancy for high availability |
| `minimumTlsVersion` | string | `'1.2'` | Minimum TLS version. Allowed values: 1.0, 1.1, 1.2 |
| `publicNetworkAccess` | string | `'Disabled'` | Public network access. Allowed values: Enabled, Disabled |
| `disableLocalAuth` | bool | `true` | Disable local authentication (use Azure AD only) |
| `privateEndpoints` | array | `[]` | Array of private endpoint configurations |
| `queues` | array | `[]` | Array of queue configurations |
| `topics` | array | `[]` | Array of topic configurations |
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
module servicebusnamespace '../service-bus-namespace/main.bicep' = {
  name: 'service-bus-namespace-deployment'
  params: {
    name: 'my-service-bus-namespace'
    location: 'eastus'
    tags: {
      environment: 'production'
    }
  }
}
```

## References

- [Azure Documentation](https://learn.microsoft.com/azure/service-bus-messaging/)
- [Azure Verified Modules](https://aka.ms/avm)
