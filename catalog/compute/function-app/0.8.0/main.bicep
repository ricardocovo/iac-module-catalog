// Azure Verified Module Reference: Function App
// Registry: br/public:avm/res/web/site

metadata name = 'Function App'
metadata description = 'AVM reference for deploying Azure Function App'
metadata owner = 'Azure Verified Modules'

@description('The name of the function app')
param name string

@description('The location')
param location string = resourceGroup().location

@description('App Service Plan resource ID')
param serverFarmResourceId string

@description('Kind of site - use functionapp for Windows or functionapp,linux for Linux')
param kind string = 'functionapp'

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

@description('Storage account resource ID for function app')
param storageAccountResourceId string = ''

@description('Storage account name for function app')
param storageAccountName string = ''

@description('Application Insights resource ID')
param applicationInsightsResourceId string = ''

@description('Function app runtime (dotnet, node, python, java, powershell, custom)')
param functionAppRuntime string = 'dotnet'

@description('Function app runtime version')
param functionAppRuntimeVersion string = '8'

module functionApp 'br/public:avm/res/web/site:0.8.0' = {
  name: '${name}-deployment'
  params: {
    name: name
    location: location
    kind: kind
    serverFarmResourceId: serverFarmResourceId
    appSettingsKeyValuePairs: union(
      !empty(appSettingsKeyValuePairs) ? appSettingsKeyValuePairs : {},
      !empty(storageAccountName) ? {
        AzureWebJobsStorage: 'DefaultEndpointsProtocol=https;AccountName=${storageAccountName};EndpointSuffix=${environment().suffixes.storage};AccountKey=${listKeys(storageAccountResourceId, '2021-09-01').keys[0].value}'
        WEBSITE_CONTENTAZUREFILECONNECTIONSTRING: 'DefaultEndpointsProtocol=https;AccountName=${storageAccountName};EndpointSuffix=${environment().suffixes.storage};AccountKey=${listKeys(storageAccountResourceId, '2021-09-01').keys[0].value}'
        WEBSITE_CONTENTSHARE: toLower(name)
      } : {},
      !empty(applicationInsightsResourceId) ? {
        APPLICATIONINSIGHTS_CONNECTION_STRING: reference(applicationInsightsResourceId, '2020-02-02').ConnectionString
      } : {},
      {
        FUNCTIONS_EXTENSION_VERSION: '~4'
        FUNCTIONS_WORKER_RUNTIME: functionAppRuntime
      }
    )
    siteConfig: siteConfig
    virtualNetworkSubnetId: virtualNetworkSubnetId
    privateEndpoints: privateEndpoints
    managedIdentities: managedIdentities
    tags: tags
  }
}

output resourceId string = functionApp.outputs.resourceId
output name string = functionApp.outputs.name
output defaultHostname string = functionApp.outputs.defaultHostname
output systemAssignedPrincipalId string = functionApp.outputs.systemAssignedMIPrincipalId
