// Basic deployment of DNS Resolver
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'dev'

module dnsresolver '../main.bicep' = {
  name: 'dns-resolver-basic'
  params: {
    name: 'dns-resolver-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    tags: {
      environment: environment
      deploymentType: 'basic'
    }
  }
}

output resourceId string = dnsresolver.outputs.resourceId
output name string = dnsresolver.outputs.name
