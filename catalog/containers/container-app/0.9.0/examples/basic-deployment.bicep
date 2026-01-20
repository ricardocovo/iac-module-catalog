// Basic deployment of Container App
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'dev'
param environmentResourceId string

module containerapp '../main.bicep' = {
  name: 'container-app-basic'
  params: {
    name: 'container-app-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    environmentResourceId: environmentResourceId
    containers: [
      {
        name: 'main'
        image: 'mcr.microsoft.com/azuredocs/containerapps-helloworld:latest'
        resources: {
          cpu: json('0.25')
          memory: '0.5Gi'
        }
      }
    ]
    tags: {
      environment: environment
      deploymentType: 'basic'
    }
  }
}

output resourceId string = containerapp.outputs.resourceId
output name string = containerapp.outputs.name
