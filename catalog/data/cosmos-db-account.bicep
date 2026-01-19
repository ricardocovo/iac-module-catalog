// Azure Verified Module Reference: Cosmos DB Account
// Registry: br/public:avm/res/document-db/database-account

metadata name = 'Cosmos DB Account'
metadata description = 'AVM reference for deploying Azure Cosmos DB Account'
metadata owner = 'Azure Verified Modules'

@description('The name of the Cosmos DB account')
param name string

@description('The location')
param location string = resourceGroup().location

@description('Default consistency level')
@allowed(['Eventual', 'ConsistentPrefix', 'Session', 'BoundedStaleness', 'Strong'])
param defaultConsistencyLevel string = 'Session'

@description('Enable automatic failover')
param automaticFailover bool = true

@description('Enable multiple write locations')
param enableMultipleWriteLocations bool = false

@description('Locations configuration')
param locations array = []

@description('Network restrictions configuration')
param networkRestrictions object = {
  publicNetworkAccess: 'Disabled'
  networkAclBypass: 'AzureServices'
}

@description('Private endpoints')
param privateEndpoints array = []

@description('SQL databases')
param sqlDatabases array = []

@description('Managed identity')
param managedIdentities object = {}

@description('Tags')
param tags object = {}

module cosmosDbAccount 'br/public:avm/res/document-db/database-account:0.9.0' = {
  name: '${name}-deployment'
  params: {
    name: name
    location: location
    defaultConsistencyLevel: defaultConsistencyLevel
    automaticFailover: automaticFailover
    enableMultipleWriteLocations: enableMultipleWriteLocations
    locations: locations
    networkRestrictions: networkRestrictions
    privateEndpoints: privateEndpoints
    sqlDatabases: sqlDatabases
    managedIdentities: managedIdentities
    tags: tags
  }
}

output resourceId string = cosmosDbAccount.outputs.resourceId
output name string = cosmosDbAccount.outputs.name
output endpoint string = cosmosDbAccount.outputs.endpoint
