// Azure Verified Module Reference: VPN Gateway
// Registry: br/public:avm/res/network/vpn-gateway

metadata name = 'VPN Gateway'
metadata description = 'AVM reference for deploying Azure VPN Gateway'
metadata owner = 'Azure Verified Modules'

@description('The name of the VPN gateway')
param name string

@description('The location for the gateway')
param location string = resourceGroup().location

@description('Virtual Hub resource ID')
param virtualHubResourceId string

@description('BGP settings')
param bgpSettings object = {}

@description('VPN connections')
param vpnConnections array = []

@description('Tags for the resource')
param tags object = {}

module vpnGateway 'br/public:avm/res/network/vpn-gateway:0.2.1' = {
  name: '${name}-deployment'
  params: {
    name: name
    location: location
    virtualHubResourceId: virtualHubResourceId
    bgpSettings: bgpSettings
    vpnConnections: vpnConnections
    tags: tags
  }
}

output resourceId string = vpnGateway.outputs.resourceId
output name string = vpnGateway.outputs.name
