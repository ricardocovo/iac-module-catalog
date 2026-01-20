// Azure Verified Module Reference: Service Bus Namespace
// Registry: br/public:avm/res/service-bus/namespace

metadata name = 'Service Bus Namespace'
metadata description = 'AVM reference for deploying Azure Service Bus Namespace'
metadata owner = 'Azure Verified Modules'

@description('The name of the Service Bus namespace')
param name string

@description('The location')
param location string = resourceGroup().location

@description('SKU name')
@allowed(['Basic', 'Standard', 'Premium'])
param skuName string = 'Premium'

@description('SKU capacity (Premium only)')
param capacity int = 1

@description('Zone redundancy')
param zoneRedundant bool = true

@description('Minimum TLS version')
@allowed(['1.0', '1.1', '1.2'])
param minimumTlsVersion string = '1.2'

@description('Public network access')
@allowed(['Enabled', 'Disabled'])
param publicNetworkAccess string = 'Disabled'

@description('Disable local auth')
param disableLocalAuth bool = true

@description('Private endpoints')
param privateEndpoints array = []

@description('Queues')
param queues array = []

@description('Topics')
param topics array = []

@description('Managed identity')
param managedIdentities object = {}

@description('Tags')
param tags object = {}

module serviceBusNamespace 'br/public:avm/res/service-bus/namespace:0.14.0' = {
  name: '${name}-deployment'
  params: {
    name: name
    location: location
    skuObject: {
      name: skuName
      capacity: capacity
    }
    zoneRedundant: zoneRedundant
    minimumTlsVersion: minimumTlsVersion
    publicNetworkAccess: publicNetworkAccess
    disableLocalAuth: disableLocalAuth
    privateEndpoints: privateEndpoints
    queues: queues
    topics: topics
    managedIdentities: managedIdentities
    tags: tags
  }
}

output resourceId string = serviceBusNamespace.outputs.resourceId
output name string = serviceBusNamespace.outputs.name
