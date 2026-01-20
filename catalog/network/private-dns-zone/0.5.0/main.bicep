// Azure Verified Module Reference: Private DNS Zone
// Registry: br/public:avm/res/network/private-dns-zone

metadata name = 'Private DNS Zone'
metadata description = 'AVM reference for deploying Azure Private DNS Zones'
metadata owner = 'Azure Verified Modules'

@description('The name of the private DNS zone')
param name string

@description('Virtual network links')
param virtualNetworkLinks array = []

@description('Tags for the resource')
param tags object = {}

module privateDnsZone 'br/public:avm/res/network/private-dns-zone:0.5.0' = {
  name: '${name}-deployment'
  params: {
    name: name
    virtualNetworkLinks: virtualNetworkLinks
    tags: tags
  }
}

output resourceId string = privateDnsZone.outputs.resourceId
output name string = privateDnsZone.outputs.name
