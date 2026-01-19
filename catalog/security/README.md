# Security Modules

Azure Verified Modules for security and identity in the Microsoft Foundry landing zone.

## Available Modules

| Module | AVM Reference | Version | Description |
|--------|--------------|---------|-------------|
| [Managed Identity](managed-identity.bicep) | `avm/res/managed-identity/user-assigned-identity` | 0.4.0 | User Assigned Managed Identity |
| [Key Vault](key-vault.bicep) | `avm/res/key-vault/vault` | 0.9.0 | Azure Key Vault |

## Usage Example

```bicep
module managedIdentity './managed-identity.bicep' = {
  name: 'mi-deployment'
  params: {
    name: 'mi-foundry-eastus2'
    location: 'eastus2'
  }
}

module keyVault './key-vault.bicep' = {
  name: 'kv-deployment'
  params: {
    name: 'kv-foundry-eastus2'
    location: 'eastus2'
    enableRbacAuthorization: true
    publicNetworkAccess: 'Disabled'
    privateEndpoints: [
      {
        subnetResourceId: peSubnetId
        privateDnsZoneResourceIds: [kvDnsZoneId]
      }
    ]
  }
}
```
