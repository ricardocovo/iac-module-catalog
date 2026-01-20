// Basic deployment of Azure Cache for Redis
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'dev'

module rediscache '../main.bicep' = {
  name: 'redis-cache-basic'
  params: {
    name: 'redis-cache-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    tags: {
      environment: environment
      deploymentType: 'basic'
    }
  }
}

output resourceId string = rediscache.outputs.resourceId
output name string = rediscache.outputs.name
