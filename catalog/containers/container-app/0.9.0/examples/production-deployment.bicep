// Production deployment of Container App
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'prod'
param environmentResourceId string
param containerImage string

module containerapp '../main.bicep' = {
  name: 'container-app-prod'
  params: {
    name: 'container-app-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    environmentResourceId: environmentResourceId
    containers: [
      {
        name: 'main'
        image: containerImage
        resources: {
          cpu: json('1.0')
          memory: '2Gi'
        }
      }
    ]
    ingressConfiguration: {
      external: true
      targetPort: 80
      transport: 'auto'
    }
    scaleConfiguration: {
      minReplicas: 2
      maxReplicas: 10
    }
    tags: {
      environment: environment
      deploymentType: 'production'
      criticality: 'high'
    }
  }
}

output resourceId string = containerapp.outputs.resourceId
output name string = containerapp.outputs.name
