# Storage Modules

Storage services for enterprise Azure deployments.

## Available Modules

| Module | Description |
|--------|-------------|
| [Storage Account](storage-account.bicep) | Azure Storage Account (blobs, files, queues, tables) |
| [Container Registry](container-registry.bicep) | Azure Container Registry for container images |

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
