// Basic deployment of PostgreSQL Flexible Server
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'dev'
@secure()
param administratorLogin string
@secure()
param administratorLoginPassword string

module postgresqlflexibleserver '../main.bicep' = {
  name: 'postgresql-flexible-server-basic'
  params: {
    name: 'postgresql-flexible-server-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorLoginPassword
    tags: {
      environment: environment
      deploymentType: 'basic'
    }
  }
}

output resourceId string = postgresqlflexibleserver.outputs.resourceId
output name string = postgresqlflexibleserver.outputs.name
