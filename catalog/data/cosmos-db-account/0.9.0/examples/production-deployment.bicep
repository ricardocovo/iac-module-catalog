// Production deployment of Cosmos DB Account
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'prod'

module cosmosdbaccount '../main.bicep' = {
  name: 'cosmos-db-account-prod'
  params: {
    name: 'cosmos-db-account-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    tags: {
      environment: environment
      deploymentType: 'production'
      criticality: 'high'
    }
  }
}

output resourceId string = cosmosdbaccount.outputs.resourceId
output name string = cosmosdbaccount.outputs.name
