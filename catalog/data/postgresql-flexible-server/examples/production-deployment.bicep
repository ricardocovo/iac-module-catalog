// Production deployment of PostgreSQL Flexible Server
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'prod'

module postgresqlflexibleserver '../main.bicep' = {
  name: 'postgresql-flexible-server-prod'
  params: {
    name: 'postgresql-flexible-server-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    tags: {
      environment: environment
      deploymentType: 'production'
      criticality: 'high'
    }
  }
}

output resourceId string = postgresqlflexibleserver.outputs.resourceId
output name string = postgresqlflexibleserver.outputs.name
