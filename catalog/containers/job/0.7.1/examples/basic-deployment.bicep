// Basic deployment of Container App Job (Manual Trigger)
targetScope = 'resourceGroup'

param location string = 'canadacentral'
param environment string = 'dev'
param environmentResourceId string

module job '../main.bicep' = {
  name: 'job-basic'
  params: {
    name: 'job-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    environmentResourceId: environmentResourceId
    triggerType: 'Manual'
    containers: [
      {
        name: 'processor'
        image: 'mcr.microsoft.com/azuredocs/containerapps-helloworld:latest'
        resources: {
          cpu: json('0.25')
          memory: '0.5Gi'
        }
      }
    ]
    manualTriggerConfig: {}
    tags: {
      environment: environment
      deploymentType: 'basic'
    }
  }
}

output resourceId string = job.outputs.resourceId
output name string = job.outputs.name
