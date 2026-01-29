# Security Modules

Azure Verified Modules for security and identity in the Microsoft Foundry landing zone.

## Available Modules

| Module | AVM Reference | Versions | Description |
|--------|--------------|----------|-------------|
| [Managed Identity](managed-identity/) | `avm/res/managed-identity/user-assigned-identity` | [0.4.0](managed-identity/0.4.0/) \| [0.4.1](managed-identity/0.4.1/) \| [0.4.2](managed-identity/0.4.2/) \| [0.4.3](managed-identity/0.4.3/) \| [0.5.0](managed-identity/0.5.0/) | User Assigned Managed Identity |
| [Key Vault](key-vault/) | `avm/res/key-vault/vault` | [0.12.1](key-vault/0.12.1/) \| [0.13.0](key-vault/0.13.0/) \| [0.13.1](key-vault/0.13.1/) \| [0.13.2](key-vault/0.13.2/) \| [0.13.3](key-vault/0.13.3/) | Azure Key Vault |

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
