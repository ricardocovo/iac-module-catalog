// Azure Verified Module Reference: Azure Firewall
// Registry: br/public:avm/res/network/azure-firewall

metadata name = 'Azure Firewall'
metadata description = 'AVM reference for deploying Azure Firewall'
metadata owner = 'Azure Verified Modules'

@description('The name of the Azure Firewall')
param name string

@description('The location for the firewall')
param location string = resourceGroup().location

@description('Firewall SKU tier')
@allowed(['Standard', 'Premium'])
param skuTier string = 'Standard'

@description('Virtual network name for firewall subnet')
param virtualNetworkName string

@description('Public IP configuration')
param publicIPAddressObject object

@description('Tags for the resource')
param tags object = {}

module azureFirewall 'br/public:avm/res/network/azure-firewall:0.5.0' = {
  name: '${name}-deployment'
  params: {
    name: name
    location: location
    azureSkuTier: skuTier
    virtualNetworkResourceId: resourceId('Microsoft.Network/virtualNetworks', virtualNetworkName)
    publicIPAddressObject: publicIPAddressObject
    tags: tags
  }
}

output resourceId string = azureFirewall.outputs.resourceId
output name string = azureFirewall.outputs.name
