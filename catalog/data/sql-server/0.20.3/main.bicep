// Azure Verified Module Reference: SQL Server
// Registry: br/public:avm/res/sql/server

metadata name = 'Azure SQL Server'
metadata description = 'AVM reference for deploying Azure SQL Server'
metadata owner = 'Azure Verified Modules'

@description('The name of the SQL server')
param name string

@description('The location')
param location string = resourceGroup().location

@description('Administrator login')
param administratorLogin string

@description('Administrator password')
@secure()
param administratorLoginPassword string

@description('Azure AD administrator')
param administrators object = {}

@description('Minimum TLS version')
@allowed(['1.0', '1.1', '1.2'])
param minimalTlsVersion string = '1.2'

@description('Public network access')
@allowed(['Enabled', 'Disabled'])
param publicNetworkAccess string = 'Disabled'

@description('Firewall rules')
param firewallRules array = []

@description('Private endpoints')
param privateEndpoints array = []

@description('Databases')
param databases array = []

@description('Managed identity')
param managedIdentities object = {}

@description('Tags')
param tags object = {}

module sqlServer 'br/public:avm/res/sql/server:0.20.3' = {
  name: '${name}-deployment'
  params: {
    name: name
    location: location
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorLoginPassword
    administrators: administrators
    minimalTlsVersion: minimalTlsVersion
    publicNetworkAccess: publicNetworkAccess
    restrictOutboundNetworkAccess: publicNetworkAccess == 'Disabled' ? 'Enabled' : 'Disabled'
    firewallRules: firewallRules
    privateEndpoints: privateEndpoints
    databases: databases
    managedIdentities: managedIdentities
    tags: tags
  }
}

output resourceId string = sqlServer.outputs.resourceId
output name string = sqlServer.outputs.name
