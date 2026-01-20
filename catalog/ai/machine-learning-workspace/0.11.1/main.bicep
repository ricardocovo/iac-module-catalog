// Azure Verified Module Reference: Azure Machine Learning
// Registry: br/public:avm/res/machine-learning-services/workspace

metadata name = 'Azure Machine Learning'
metadata description = 'AVM reference for deploying Azure ML Workspace (Foundry)'
metadata owner = 'Azure Verified Modules'

@description('The name of the ML workspace')
param name string

@description('The location')
param location string = resourceGroup().location

@description('SKU name')
@allowed(['Basic', 'Free', 'Premium', 'Standard'])
param skuName string = 'Basic'

@description('Storage account resource ID')
param storageAccountResourceId string

@description('Key vault resource ID')
param keyVaultResourceId string

@description('Application Insights resource ID')
param applicationInsightsResourceId string

@description('Container registry resource ID')
param containerRegistryResourceId string = ''

@description('Public network access')
@allowed(['Enabled', 'Disabled'])
param publicNetworkAccess string = 'Disabled'

@description('Private endpoints')
param privateEndpoints array = []

@description('Managed identity')
param managedIdentities object = {}

@description('Tags')
param tags object = {}

module mlWorkspace 'br/public:avm/res/machine-learning-services/workspace:0.11.1' = {
  name: '${name}-deployment'
  params: {
    name: name
    location: location
    sku: skuName
    associatedStorageAccountResourceId: storageAccountResourceId
    associatedKeyVaultResourceId: keyVaultResourceId
    associatedApplicationInsightsResourceId: applicationInsightsResourceId
    associatedContainerRegistryResourceId: containerRegistryResourceId
    publicNetworkAccess: publicNetworkAccess
    privateEndpoints: privateEndpoints
    managedIdentities: managedIdentities
    tags: tags
  }
}

output resourceId string = mlWorkspace.outputs.resourceId
output name string = mlWorkspace.outputs.name
