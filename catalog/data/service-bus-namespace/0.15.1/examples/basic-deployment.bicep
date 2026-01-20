// Basic deployment of Service Bus Namespace
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'dev'

module servicebusnamespace '../main.bicep' = {
  name: 'service-bus-namespace-basic'
  params: {
    name: 'service-bus-namespace-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    tags: {
      environment: environment
      deploymentType: 'basic'
    }
  }
}

output resourceId string = servicebusnamespace.outputs.resourceId
output name string = servicebusnamespace.outputs.name
