// Azure Verified Module Reference: Container Apps Environment
// Registry: br/public:avm/res/app/managed-environment

metadata name = 'Container Apps Environment'
metadata description = 'AVM reference for deploying Azure Container Apps Environment'
metadata owner = 'Azure Verified Modules'

@description('The name of the container apps environment')
param name string

@description('The location')
param location string = resourceGroup().location

@description('Log Analytics workspace resource ID')
param workspaceResourceId string

@description('Zone redundancy')
param zoneRedundant bool = false

@description('Internal load balancer enabled')
param internalLoadBalancerEnabled bool = false

@description('Virtual network subnet resource ID')
param infrastructureSubnetId string = ''

@description('Docker bridge CIDR')
param dockerBridgeCidr string = ''

@description('Platform reserved CIDR')
param platformReservedCidr string = ''

@description('Platform reserved DNS IP')
param platformReservedDnsIP string = ''

@description('Tags')
param tags object = {}

module containerAppsEnvironment 'br/public:avm/res/app/managed-environment:0.11.1' = {
  name: '${name}-deployment'
  params: {
    name: name
    location: location
    logAnalyticsWorkspaceResourceId: workspaceResourceId
    zoneRedundant: zoneRedundant
    internal: internalLoadBalancerEnabled
    infrastructureSubnetId: infrastructureSubnetId
    dockerBridgeCidr: dockerBridgeCidr
    platformReservedCidr: platformReservedCidr
    platformReservedDnsIP: platformReservedDnsIP
    tags: tags
  }
}

output resourceId string = containerAppsEnvironment.outputs.resourceId
output name string = containerAppsEnvironment.outputs.name
output defaultDomain string = containerAppsEnvironment.outputs.defaultDomain
