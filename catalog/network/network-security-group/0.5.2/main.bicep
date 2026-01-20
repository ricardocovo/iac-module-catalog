// Azure Verified Module Reference: Network Security Group
// Registry: br/public:avm/res/network/network-security-group

metadata name = 'Network Security Group'
metadata description = 'AVM reference for deploying Azure Network Security Groups'
metadata owner = 'Azure Verified Modules'

@description('The name of the network security group')
param name string

@description('The location for the NSG')
param location string = resourceGroup().location

@description('Security rules configuration')
param securityRules array = []

@description('Tags for the resource')
param tags object = {}

// Reference the official AVM module
module nsg 'br/public:avm/res/network/network-security-group:0.5.2' = {
  name: '${name}-deployment'
  params: {
    name: name
    location: location
    securityRules: securityRules
    tags: tags
  }
}

output resourceId string = nsg.outputs.resourceId
output name string = nsg.outputs.name
