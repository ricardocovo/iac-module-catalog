// Azure Verified Module Reference: Virtual Network
// Registry: br/public:avm/res/network/virtual-network

metadata name = 'Virtual Network'
metadata description = 'AVM reference for deploying Azure Virtual Networks (Hub/Spoke topology)'
metadata owner = 'Azure Verified Modules'

@description('The name of the virtual network')
param name string

@description('The location for the virtual network')
param location string = resourceGroup().location

@description('Address prefixes for the virtual network')
param addressPrefixes array

@description('Subnets configuration')
param subnets array = []

@description('DNS servers for the virtual network')
param dnsServers array = []

@description('DDoS protection plan resource ID')
param ddosProtectionPlanResourceId string = ''

@description('Tags for the resource')
param tags object = {}

// Reference the official AVM module
module virtualNetwork 'br/public:avm/res/network/virtual-network:0.7.0' = {
  name: '${name}-deployment'
  params: {
    name: name
    location: location
    addressPrefixes: addressPrefixes
    subnets: subnets
    dnsServers: !empty(dnsServers) ? dnsServers : null
    ddosProtectionPlanResourceId: !empty(ddosProtectionPlanResourceId) ? ddosProtectionPlanResourceId : null
    tags: tags
  }
}

@description('The resource ID of the virtual network')
output resourceId string = virtualNetwork.outputs.resourceId

@description('The name of the virtual network')
output name string = virtualNetwork.outputs.name

@description('The subnet resource IDs')
output subnetResourceIds array = virtualNetwork.outputs.subnetResourceIds
