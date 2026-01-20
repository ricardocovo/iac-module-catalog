// Azure Verified Module Reference: Private Endpoint
// Registry: br/public:avm/res/network/private-endpoint

metadata name = 'Private Endpoint'
metadata description = 'AVM reference for deploying Azure Private Endpoints'
metadata owner = 'Azure Verified Modules'

@description('The name of the private endpoint')
param name string

@description('The location for the private endpoint')
param location string = resourceGroup().location

@description('Subnet resource ID for the private endpoint')
param subnetResourceId string

@description('Service resource ID to connect to')
param serviceResourceId string

@description('Group IDs for the private endpoint connection')
param groupIds array

@description('Private DNS zone configurations')
param privateDnsZoneConfigs array = []

@description('Tags for the resource')
param tags object = {}

module privateEndpoint 'br/public:avm/res/network/private-endpoint:0.7.0' = {
  name: '${name}-deployment'
  params: {
    name: name
    location: location
    privateLinkServiceConnections: [
      {
        name: '${name}-connection'
        properties: {
          privateLinkServiceId: serviceResourceId
          groupIds: groupIds
        }
      }
    ]
    subnetResourceId: subnetResourceId
    privateDnsZoneGroup: {
      privateDnsZoneGroupConfigs: privateDnsZoneConfigs
    }
    tags: tags
  }
}

output resourceId string = privateEndpoint.outputs.resourceId
output name string = privateEndpoint.outputs.name
