// Azure Verified Module Reference: DNS Resolver
// Registry: br/public:avm/res/network/dns-resolver

metadata name = 'DNS Resolver'
metadata description = 'AVM reference for deploying Azure DNS Private Resolver'
metadata owner = 'Azure Verified Modules'

@description('The name of the DNS resolver')
param name string

@description('The location for the resolver')
param location string = resourceGroup().location

@description('Virtual network resource ID')
param virtualNetworkResourceId string

@description('Inbound endpoints configuration')
param inboundEndpoints array = []

@description('Outbound endpoints configuration')
param outboundEndpoints array = []

@description('Tags for the resource')
param tags object = {}

module dnsResolver 'br/public:avm/res/network/dns-resolver:0.5.2' = {
  name: '${name}-deployment'
  params: {
    name: name
    location: location
    virtualNetworkResourceId: virtualNetworkResourceId
    inboundEndpoints: inboundEndpoints
    outboundEndpoints: outboundEndpoints
    tags: tags
  }
}

output resourceId string = dnsResolver.outputs.resourceId
output name string = dnsResolver.outputs.name
