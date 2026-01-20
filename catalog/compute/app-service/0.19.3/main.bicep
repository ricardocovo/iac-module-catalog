// Azure Verified Module Reference: App Service
// Registry: br/public:avm/res/web/site

metadata name = 'App Service'
metadata description = 'AVM reference for deploying Azure App Service'
metadata owner = 'Azure Verified Modules'

@description('The name of the app service')
param name string

@description('The location')
param location string = resourceGroup().location

@description('App Service Plan resource ID')
param serverFarmResourceId string

@description('Kind of site')
param kind string = 'app'

@description('Site configuration')
param siteConfig object = {}

@description('App settings')
param appSettingsKeyValuePairs object = {}

@description('Virtual network subnet ID for integration')
param virtualNetworkSubnetId string = ''

@description('Enable private endpoints')
param privateEndpoints array = []

@description('Managed identity configuration')
param managedIdentities object = {}

@description('Tags')
param tags object = {}

module appService 'br/public:avm/res/web/site:0.19.3' = {
  name: '${name}-deployment'
  params: {
    name: name
    location: location
    kind: kind
    serverFarmResourceId: serverFarmResourceId
    siteConfig: siteConfig
    appSettingsKeyValuePairs: appSettingsKeyValuePairs
    virtualNetworkSubnetId: virtualNetworkSubnetId
    privateEndpoints: privateEndpoints
    managedIdentities: managedIdentities
    tags: tags
  }
}

output resourceId string = appService.outputs.resourceId
output name string = appService.outputs.name
output defaultHostname string = appService.outputs.defaultHostname
