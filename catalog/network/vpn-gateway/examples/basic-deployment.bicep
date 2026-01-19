// Basic deployment of VPN Gateway
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'dev'
param virtualHubResourceId string

module vpngateway '../main.bicep' = {
  name: 'vpn-gateway-basic'
  params: {
    name: 'vpn-gateway-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    virtualHubResourceId: virtualHubResourceId
    tags: {
      environment: environment
      deploymentType: 'basic'
    }
  }
}

output resourceId string = vpngateway.outputs.resourceId
output name string = vpngateway.outputs.name
