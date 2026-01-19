// Production deployment of VPN Gateway
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'prod'
param virtualHubResourceId string

module vpngateway '../main.bicep' = {
  name: 'vpn-gateway-prod'
  params: {
    name: 'vpn-gateway-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    virtualHubResourceId: virtualHubResourceId
    tags: {
      environment: environment
      deploymentType: 'production'
      criticality: 'high'
    }
  }
}

output resourceId string = vpngateway.outputs.resourceId
output name string = vpngateway.outputs.name
