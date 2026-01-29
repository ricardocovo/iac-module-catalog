# Storage Modules

Storage services for enterprise Azure deployments.

## Available Modules

| Module | AVM Reference | Versions | Description |
|--------|--------------|----------|-------------|
| [Storage Account](storage-account/) | `avm/res/storage/storage-account` | [0.27.1](storage-account/0.27.1/) \| [0.28.0](storage-account/0.28.0/) \| [0.29.0](storage-account/0.29.0/) \| [0.30.0](storage-account/0.30.0/) \| [0.31.0](storage-account/0.31.0/) | Azure Storage Account (blobs, files, queues, tables) |
| [Container Registry](container-registry/) | `avm/res/container-registry/registry` | [0.9.0](container-registry/0.9.0/) \| [0.9.1](container-registry/0.9.1/) \| [0.9.2](container-registry/0.9.2/) \| [0.9.3](container-registry/0.9.3/) \| [0.10.0](container-registry/0.10.0/) | Azure Container Registry for container images |

## Usage Examples

### Storage Account

```bicep
module storageAccount './storage-account.bicep' = {
  name: 'st-deployment'
  params: {
    name: 'stfoundryeastus2'
    location: 'eastus2'
    skuName: 'Standard_ZRS'
    publicNetworkAccess: 'Disabled'
    privateEndpoints: [
      {
        subnetResourceId: peSubnetId
        service: 'blob'
        privateDnsZoneResourceIds: [blobDnsZoneId]
      }
    ]
  }
}
```

### Container Registry

```bicep
module containerRegistry './container-registry.bicep' = {
  name: 'acr-deployment'
  params: {
    name: 'acrfoundryeastus2'
    location: 'eastus2'
    skuName: 'Premium'
    adminUserEnabled: false
    publicNetworkAccess: 'Disabled'
    zoneRedundancy: 'Enabled'
    privateEndpoints: [
      {
        subnetResourceId: peSubnetId
        privateDnsZoneResourceIds: [acrDnsZoneId]
      }
    ]
    managedIdentities: {
      systemAssigned: true
    }
  }
}
```

## Key Features

### Storage Account
- **Blob Storage**: Object storage with hot, cool, and archive tiers
- **File Shares**: SMB file shares for cloud or hybrid scenarios
- **Zone Redundancy**: Data replicated across availability zones
- **Private Endpoints**: Secure access via private connectivity
- **Lifecycle Management**: Automatic tiering and deletion policies

### Container Registry
- **Premium SKU**: Zone redundancy and geo-replication support
- **Private Connectivity**: VNet integration via private endpoints
- **Content Trust**: Sign and verify container images
- **Vulnerability Scanning**: Integrated security scanning (requires Defender)
- **Managed Identity**: Authentication without credentials
- **Geo-Replication**: Multi-region registry replication (Premium)
