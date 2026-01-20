// Production deployment of Azure Cache for Redis
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'prod'

module rediscache '../main.bicep' = {
  name: 'redis-cache-prod'
  params: {
    name: 'redis-cache-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    tags: {
      environment: environment
      deploymentType: 'production'
      criticality: 'high'
    }
  }
}

output resourceId string = rediscache.outputs.resourceId
output name string = rediscache.outputs.name
