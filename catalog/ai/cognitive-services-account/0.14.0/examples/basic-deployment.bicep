// Basic deployment of Cognitive Services Account
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'dev'

module cognitiveServices '../main.bicep' = {
  name: 'cognitive-services-basic'
  params: {
    name: 'openai-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    kind: 'OpenAI'
    skuName: 'S0'
    publicNetworkAccess: 'Enabled'
    tags: {
      environment: environment
      deploymentType: 'basic'
    }
  }
}

output resourceId string = cognitiveServices.outputs.resourceId
output endpoint string = cognitiveServices.outputs.endpoint
