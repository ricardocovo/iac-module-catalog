// Azure Verified Module Reference: Azure Bastion
// Registry: br/public:avm/res/network/bastion-host

metadata name = 'Azure Bastion'
metadata description = 'AVM reference for deploying Azure Bastion'
metadata owner = 'Azure Verified Modules'

@description('The name of the Azure Bastion')
param name string

@description('The location for the bastion')
param location string = resourceGroup().location

@description('Virtual network name for bastion subnet')
param virtualNetworkName string

@description('SKU name')
@allowed(['Basic', 'Standard'])
param skuName string = 'Basic'

@description('Tags for the resource')
param tags object = {}

module bastionHost 'br/public:avm/res/network/bastion-host:0.7.0' = {
  name: '${name}-deployment'
  params: {
    name: name
    location: location
    virtualNetworkResourceId: resourceId('Microsoft.Network/virtualNetworks', virtualNetworkName)
    skuName: skuName
    tags: tags
  }
}

output resourceId string = bastionHost.outputs.resourceId
output name string = bastionHost.outputs.name
