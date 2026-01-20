# Key Vault Module

## Overview

This module deploys an Azure Key Vault using Azure Verified Modules (AVM).

## Module Reference

- **AVM Module**: `br/public:avm/res/key-vault/vault:0.9.0`
- **Documentation**: [GitHub - AVM Module](https://github.com/Azure/bicep-registry-modules/tree/main/avm/res)

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `name` | string | Required | The name of the key vault |
| `location` | string | `resourceGroup().location` | The Azure region for deployment |
| `skuName` | string | `'standard'` | SKU name. Allowed values: standard, premium |
| `enableRbacAuthorization` | bool | `true` | Enable RBAC authorization (recommended over access policies) |
| `enablePurgeProtection` | bool | `true` | Enable purge protection to prevent permanent deletion |
| `publicNetworkAccess` | string | `'Disabled'` | Public network access. Allowed values: Enabled, Disabled |
| `networkAcls` | object | `{}` | Network ACL configuration |
| `privateEndpoints` | array | `[]` | Array of private endpoint configurations |
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
module keyvault '../key-vault/main.bicep' = {
  name: 'key-vault-deployment'
  params: {
    name: 'my-key-vault'
    location: 'eastus'
    tags: {
      environment: 'production'
    }
  }
}
```

## References

- [Azure Documentation](https://learn.microsoft.com/azure/key-vault/)
- [Azure Verified Modules](https://aka.ms/avm)
