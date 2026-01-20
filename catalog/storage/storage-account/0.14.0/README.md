# Storage Account Module

## Overview

This module deploys an Azure Storage Account using Azure Verified Modules (AVM).

## Module Reference

- **AVM Module**: `br/public:avm/res/storage/storage-account:0.14.0`
- **Documentation**: [GitHub - AVM Module](https://github.com/Azure/bicep-registry-modules/tree/main/avm/res)

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `name` | string | Required | The name of the storage account |
| `location` | string | `resourceGroup().location` | The Azure region for deployment |
| `skuName` | string | `'Standard_LRS'` | SKU name. Allowed values: Standard_LRS, Standard_GRS, Standard_RAGRS, Standard_ZRS, Premium_LRS, Premium_ZRS |
| `kind` | string | `'StorageV2'` | Kind of storage account. Allowed values: Storage, StorageV2, BlobStorage, FileStorage, BlockBlobStorage |
| `accessTier` | string | `'Hot'` | Access tier for blob storage. Allowed values: Hot, Cool |
| `publicNetworkAccess` | string | `'Disabled'` | Public network access. Allowed values: Enabled, Disabled |
| `networkAcls` | object | `{}` | Network ACL configuration |
| `privateEndpoints` | array | `[]` | Array of private endpoint configurations |
| `blobServices` | object | `{}` | Blob services configuration |
| `fileServices` | object | `{}` | File services configuration |
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
module storageaccount '../storage-account/main.bicep' = {
  name: 'storage-account-deployment'
  params: {
    name: 'my-storage-account'
    location: 'eastus'
    tags: {
      environment: 'production'
    }
  }
}
```

## References

- [Azure Documentation](https://learn.microsoft.com/azure/storage/)
- [Azure Verified Modules](https://aka.ms/avm)
