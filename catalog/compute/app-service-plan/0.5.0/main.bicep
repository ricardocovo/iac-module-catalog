// Azure Verified Module Reference: App Service Plan
// Registry: br/public:avm/res/web/serverfarm

metadata name = 'App Service Plan'
metadata description = 'AVM reference for deploying Azure App Service Plans'
metadata owner = 'Azure Verified Modules'

@description('The name of the app service plan')
param name string

@description('The location')
param location string = resourceGroup().location

@description('SKU name')
param skuName string = 'P1v3'

@description('SKU capacity')
param skuCapacity int = 1

@description('Kind of resource')
@allowed(['Windows', 'Linux', 'FunctionApp'])
param kind string = 'Linux'

@description('Tags')
param tags object = {}

module appServicePlan 'br/public:avm/res/web/serverfarm:0.5.0' = {
  name: '${name}-deployment'
  params: {
    name: name
    location: location
    skuName: skuName
    skuCapacity: skuCapacity
    kind: kind
    reserved: kind == 'Linux'
    tags: tags
  }
}

output resourceId string = appServicePlan.outputs.resourceId
output name string = appServicePlan.outputs.name
