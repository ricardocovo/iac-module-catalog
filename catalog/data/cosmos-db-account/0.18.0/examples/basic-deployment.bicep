// Basic deployment of Cosmos DB Account
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'dev'

module cosmosdbaccount '../main.bicep' = {
  name: 'cosmos-db-account-basic'
  params: {
    name: 'cosmos-db-account-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    tags: {
      environment: environment
      deploymentType: 'basic'
    }
  }
}

output resourceId string = cosmosdbaccount.outputs.resourceId
output name string = cosmosdbaccount.outputs.name
