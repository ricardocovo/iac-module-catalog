// Production deployment of DDoS Protection Plan
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'prod'

module ddosprotectionplan '../main.bicep' = {
  name: 'ddos-protection-plan-prod'
  params: {
    name: 'ddos-protection-plan-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    tags: {
      environment: environment
      deploymentType: 'production'
      criticality: 'high'
    }
  }
}

output resourceId string = ddosprotectionplan.outputs.resourceId
output name string = ddosprotectionplan.outputs.name
