// Azure Verified Module Reference: Static Web App
// Registry: br/public:avm/res/web/static-site

metadata name = 'Static Web App'
metadata description = 'AVM reference for deploying Azure Static Web Apps'
metadata owner = 'Azure Verified Modules'

@description('The name of the static web app')
param name string

@description('The location')
param location string = resourceGroup().location

@description('The SKU name')
@allowed([
  'Free'
  'Standard'
])
param skuName string = 'Free'

@description('The custom domains to configure')
param customDomains array = []

@description('The staging environment policy')
@allowed([
  'Enabled'
  'Disabled'
])
param stagingEnvironmentPolicy string = 'Enabled'

@description('Allow configuration file updates')
param allowConfigFileUpdates bool = true

@description('The app build configuration')
param buildProperties object = {}

@description('Enable private endpoints')
param privateEndpoints array = []

@description('Managed identity configuration')
param managedIdentities object = {}

@description('Tags')
param tags object = {}

module staticWebApp 'br/public:avm/res/web/static-site:0.9.3' = {
  name: '${name}-deployment'
  params: {
    name: name
    location: location
    sku: skuName
    customDomains: customDomains
    stagingEnvironmentPolicy: stagingEnvironmentPolicy
    allowConfigFileUpdates: allowConfigFileUpdates
    buildProperties: buildProperties
    privateEndpoints: privateEndpoints
    managedIdentities: managedIdentities
    tags: tags
  }
}

output resourceId string = staticWebApp.outputs.resourceId
output name string = staticWebApp.outputs.name
output defaultHostname string = staticWebApp.outputs.defaultHostname
