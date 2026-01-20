// Azure Verified Module Reference: Key Vault
// Registry: br/public:avm/res/key-vault/vault

metadata name = 'Key Vault'
metadata description = 'AVM reference for deploying Azure Key Vault'
metadata owner = 'Azure Verified Modules'

@description('The name of the key vault')
param name string

@description('The location')
param location string = resourceGroup().location

@description('SKU name')
@allowed(['standard', 'premium'])
param skuName string = 'standard'

@description('Enable RBAC authorization')
param enableRbacAuthorization bool = true

@description('Enable purge protection')
param enablePurgeProtection bool = true

@description('Public network access')
@allowed(['Enabled', 'Disabled'])
param publicNetworkAccess string = 'Disabled'

@description('Network ACLs')
param networkAcls object = {}

@description('Private endpoints')
param privateEndpoints array = []

@description('Tags')
param tags object = {}

module keyVault 'br/public:avm/res/key-vault/vault:0.13.2' = {
  name: '${name}-deployment'
  params: {
    name: name
    location: location
    sku: skuName
    enableRbacAuthorization: enableRbacAuthorization
    enablePurgeProtection: enablePurgeProtection
    publicNetworkAccess: publicNetworkAccess
    networkAcls: networkAcls
    privateEndpoints: privateEndpoints
    tags: tags
  }
}

output resourceId string = keyVault.outputs.resourceId
output name string = keyVault.outputs.name
output uri string = keyVault.outputs.uri
