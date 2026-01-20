// Azure Verified Module Reference: Managed Identity
// Registry: br/public:avm/res/managed-identity/user-assigned-identity

metadata name = 'Managed Identity'
metadata description = 'AVM reference for deploying User Assigned Managed Identities'
metadata owner = 'Azure Verified Modules'

@description('The name of the managed identity')
param name string

@description('The location')
param location string = resourceGroup().location

@description('Tags')
param tags object = {}

module managedIdentity 'br/public:avm/res/managed-identity/user-assigned-identity:0.7.0' = {
  name: '${name}-deployment'
  params: {
    name: name
    location: location
    tags: tags
  }
}

output resourceId string = managedIdentity.outputs.resourceId
output name string = managedIdentity.outputs.name
output principalId string = managedIdentity.outputs.principalId
output clientId string = managedIdentity.outputs.clientId
