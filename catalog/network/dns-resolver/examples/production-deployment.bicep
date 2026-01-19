// Production deployment of DNS Resolver
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'prod'

module dnsresolver '../main.bicep' = {
  name: 'dns-resolver-prod'
  params: {
    name: 'dns-resolver-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    tags: {
      environment: environment
      deploymentType: 'production'
      criticality: 'high'
    }
  }
}

output resourceId string = dnsresolver.outputs.resourceId
output name string = dnsresolver.outputs.name
