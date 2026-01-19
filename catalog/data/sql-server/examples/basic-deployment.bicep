// Basic deployment of SQL Server
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'dev'
@secure()
param administratorLogin string
@secure()
param administratorLoginPassword string

module sqlserver '../main.bicep' = {
  name: 'sql-server-basic'
  params: {
    name: 'sql-server-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorLoginPassword
    tags: {
      environment: environment
      deploymentType: 'basic'
    }
  }
}

output resourceId string = sqlserver.outputs.resourceId
output name string = sqlserver.outputs.name
