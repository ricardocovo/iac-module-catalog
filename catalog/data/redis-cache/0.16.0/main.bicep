// Azure Verified Module Reference: Azure Cache for Redis
// Registry: br/public:avm/res/cache/redis

metadata name = 'Azure Cache for Redis'
metadata description = 'AVM reference for deploying Azure Cache for Redis'
metadata owner = 'Azure Verified Modules'

@description('The name of the Redis cache')
param name string

@description('The location')
param location string = resourceGroup().location

@description('SKU name')
@allowed(['Basic', 'Standard', 'Premium'])
param skuName string = 'Premium'

@description('SKU capacity')
param skuCapacity int = 1

@description('Enable non-SSL port')
param enableNonSslPort bool = false

@description('Minimum TLS version')
@allowed(['1.0', '1.1', '1.2'])
param minimumTlsVersion string = '1.2'

@description('Public network access')
@allowed(['Enabled', 'Disabled'])
param publicNetworkAccess string = 'Disabled'

@description('Redis configuration')
param redisConfiguration object = {}

@description('Private endpoints')
param privateEndpoints array = []

@description('Zone redundancy')
param zones array = []

@description('Tags')
param tags object = {}

module redisCache 'br/public:avm/res/cache/redis:0.16.0' = {
  name: '${name}-deployment'
  params: {
    name: name
    location: location
    skuName: skuName
    capacity: skuCapacity
    enableNonSslPort: enableNonSslPort
    minimumTlsVersion: minimumTlsVersion
    publicNetworkAccess: publicNetworkAccess
    redisConfiguration: redisConfiguration
    privateEndpoints: privateEndpoints
    zones: zones
    tags: tags
  }
}

output resourceId string = redisCache.outputs.resourceId
output name string = redisCache.outputs.name
output hostName string = redisCache.outputs.hostName
output sslPort int = redisCache.outputs.sslPort
