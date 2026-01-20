// Basic deployment of DDoS Protection Plan
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'dev'

module ddosprotectionplan '../main.bicep' = {
  name: 'ddos-protection-plan-basic'
  params: {
    name: 'ddos-protection-plan-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    tags: {
      environment: environment
      deploymentType: 'basic'
    }
  }
}

output resourceId string = ddosprotectionplan.outputs.resourceId
output name string = ddosprotectionplan.outputs.name
