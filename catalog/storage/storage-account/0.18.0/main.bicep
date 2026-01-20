// Azure Verified Module Reference: Storage Account
// Registry: br/public:avm/res/storage/storage-account

metadata name = 'Storage Account'
metadata description = 'AVM reference for deploying Azure Storage Accounts'
metadata owner = 'Azure Verified Modules'

@description('The name of the storage account')
param name string

@description('The location')
param location string = resourceGroup().location

@description('SKU name')
@allowed(['Standard_LRS', 'Standard_GRS', 'Standard_RAGRS', 'Standard_ZRS', 'Premium_LRS', 'Premium_ZRS'])
param skuName string = 'Standard_LRS'

@description('Kind of storage account')
@allowed(['Storage', 'StorageV2', 'BlobStorage', 'FileStorage', 'BlockBlobStorage'])
param kind string = 'StorageV2'

@description('Access tier')
@allowed(['Hot', 'Cool'])
param accessTier string = 'Hot'

@description('Public network access')
@allowed(['Enabled', 'Disabled'])
param publicNetworkAccess string = 'Disabled'

@description('Network ACLs')
param networkAcls object = {}

@description('Private endpoints')
param privateEndpoints array = []

@description('Blob services configuration')
param blobServices object = {}

@description('File services configuration')
param fileServices object = {}

@description('Managed identity')
param managedIdentities object = {}

@description('Tags')
param tags object = {}

module storageAccount 'br/public:avm/res/storage/storage-account:0.18.0' = {
  name: '${name}-deployment'
  params: {
    name: name
    location: location
    skuName: skuName
    kind: kind
    accessTier: accessTier
    publicNetworkAccess: publicNetworkAccess
    networkAcls: networkAcls
    privateEndpoints: privateEndpoints
    blobServices: blobServices
    fileServices: fileServices
    managedIdentities: managedIdentities
    tags: tags
  }
}

output resourceId string = storageAccount.outputs.resourceId
output name string = storageAccount.outputs.name
