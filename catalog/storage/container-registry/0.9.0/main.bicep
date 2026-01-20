// Module: Container Registry
// Deploys Azure Container Registry with private endpoints

metadata name = 'Container Registry'
metadata description = 'Deploys Azure Container Registry for container image storage'
metadata owner = 'Platform Engineering'

@description('The name of the container registry')
param name string

@description('The location')
param location string = resourceGroup().location

@description('SKU name')
@allowed(['Basic', 'Standard', 'Premium'])
param skuName string = 'Premium'

@description('Admin user enabled')
param adminUserEnabled bool = false

@description('Public network access')
@allowed(['Enabled', 'Disabled'])
param publicNetworkAccess string = 'Disabled'

@description('Network rule set default action')
@allowed(['Allow', 'Deny'])
param networkRuleSetDefaultAction string = 'Deny'

@description('Network rule bypass options')
@allowed(['None', 'AzureServices'])
param networkRuleBypassOptions string = 'AzureServices'

@description('Private endpoints')
param privateEndpoints array = []

@description('Zone redundancy')
@allowed(['Enabled', 'Disabled'])
param zoneRedundancy string = 'Disabled'

@description('Managed identity')
param managedIdentities object = {}

@description('Tags')
param tags object = {}

module containerRegistry 'br/public:avm/res/container-registry/registry:0.9.0' = {
  name: '${name}-deployment'
  params: {
    name: name
    location: location
    acrSku: skuName
    acrAdminUserEnabled: adminUserEnabled
    publicNetworkAccess: publicNetworkAccess
    networkRuleSetDefaultAction: networkRuleSetDefaultAction
    networkRuleBypassOptions: networkRuleBypassOptions
    privateEndpoints: privateEndpoints
    zoneRedundancy: zoneRedundancy
    managedIdentities: managedIdentities
    tags: tags
  }
}

output resourceId string = containerRegistry.outputs.resourceId
output name string = containerRegistry.outputs.name
output loginServer string = containerRegistry.outputs.loginServer
