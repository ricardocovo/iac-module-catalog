// Production deployment of SQL Server
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'prod'

module sqlserver '../main.bicep' = {
  name: 'sql-server-prod'
  params: {
    name: 'sql-server-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    tags: {
      environment: environment
      deploymentType: 'production'
      criticality: 'high'
    }
  }
}

output resourceId string = sqlserver.outputs.resourceId
output name string = sqlserver.outputs.name
