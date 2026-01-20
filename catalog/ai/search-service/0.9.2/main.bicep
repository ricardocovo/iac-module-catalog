// Azure Verified Module Reference: Azure AI Search
// Registry: br/public:avm/res/search/search-service

metadata name = 'Azure AI Search'
metadata description = 'AVM reference for deploying Azure AI Search'
metadata owner = 'Azure Verified Modules'

@description('The name of the search service')
param name string

@description('The location')
param location string = resourceGroup().location

@description('SKU name')
@allowed(['free', 'basic', 'standard', 'standard2', 'standard3', 'storage_optimized_l1', 'storage_optimized_l2'])
param skuName string = 'standard'

@description('Replica count')
param replicaCount int = 1

@description('Partition count')
param partitionCount int = 1

@description('Public network access')
@allowed(['Enabled', 'Disabled'])
param publicNetworkAccess string = 'Disabled'

@description('Private endpoints')
param privateEndpoints array = []

@description('Managed identity')
param managedIdentities object = {}

@description('Tags')
param tags object = {}

module searchService 'br/public:avm/res/search/search-service:0.9.2' = {
  name: '${name}-deployment'
  params: {
    name: name
    location: location
    sku: skuName
    replicaCount: replicaCount
    partitionCount: partitionCount
    publicNetworkAccess: publicNetworkAccess
    privateEndpoints: privateEndpoints
    managedIdentities: managedIdentities
    tags: tags
  }
}

output resourceId string = searchService.outputs.resourceId
output name string = searchService.outputs.name
