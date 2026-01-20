// Azure Verified Module Reference: Azure OpenAI / Cognitive Services
// Registry: br/public:avm/res/cognitive-services/account

metadata name = 'Azure OpenAI'
metadata description = 'AVM reference for deploying Azure OpenAI / Cognitive Services'
metadata owner = 'Azure Verified Modules'

@description('The name of the cognitive services account')
param name string

@description('The location')
param location string = resourceGroup().location

@description('Kind of cognitive service')
@allowed(['OpenAI', 'CognitiveServices', 'FormRecognizer', 'ComputerVision'])
param kind string = 'OpenAI'

@description('SKU name')
param skuName string = 'S0'

@description('Public network access')
@allowed(['Enabled', 'Disabled'])
param publicNetworkAccess string = 'Disabled'

@description('Custom subdomain name')
param customSubDomainName string = name

@description('Deployments (models)')
param deployments array = []

@description('Private endpoints')
param privateEndpoints array = []

@description('Managed identity')
param managedIdentities object = {}

@description('Tags')
param tags object = {}

module cognitiveServicesAccount 'br/public:avm/res/cognitive-services/account:0.14.0' = {
  name: '${name}-deployment'
  params: {
    name: name
    location: location
    kind: kind
    customSubDomainName: customSubDomainName
    sku: skuName
    publicNetworkAccess: publicNetworkAccess
    deployments: deployments
    privateEndpoints: privateEndpoints
    managedIdentities: managedIdentities
    tags: tags
  }
}

output resourceId string = cognitiveServicesAccount.outputs.resourceId
output name string = cognitiveServicesAccount.outputs.name
output endpoint string = cognitiveServicesAccount.outputs.endpoint
