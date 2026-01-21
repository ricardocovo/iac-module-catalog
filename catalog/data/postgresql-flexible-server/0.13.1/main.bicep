// Azure Verified Module Reference: PostgreSQL Flexible Server
// Registry: br/public:avm/res/db-for-postgre-sql/flexible-server

metadata name = 'PostgreSQL Flexible Server'
metadata description = 'AVM reference for deploying Azure Database for PostgreSQL Flexible Server'
metadata owner = 'Azure Verified Modules'

@description('The name of the PostgreSQL server')
param name string

@description('The location')
param location string = resourceGroup().location

@description('SKU name')
param skuName string = 'Standard_D2ds_v4'

@description('Storage size in GB')
param storageSizeGB int = 32

@description('PostgreSQL version')
@allowed(['11', '12', '13', '14', '15', '16'])
param version string = '16'

@description('Administrator login')
param administratorLogin string

@description('Administrator password')
@secure()
param administratorLoginPassword string

@description('High availability mode')
@allowed(['Disabled', 'ZoneRedundant', 'SameZone'])
param highAvailability string = 'Disabled'

@description('Backup retention days')
param backupRetentionDays int = 7

@description('Geo-redundant backup')
param geoRedundantBackup bool = false


@description('Delegated subnet resource ID')
param delegatedSubnetResourceId string = ''

@description('Private DNS zone resource ID')
param privateDnsZoneResourceId string = ''

@description('Firewall rules')
param firewallRules array = []

@description('Databases')
param databases array = []

@description('Tags')
param tags object = {}

module postgresqlServer 'br/public:avm/res/db-for-postgre-sql/flexible-server:0.13.1' = {
  name: '${name}-deployment'
  params: {
    name: name
    location: location
    availabilityZone: 1
    skuName: skuName
    tier: 'GeneralPurpose'
    storageSizeGB: storageSizeGB
    version: version
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorLoginPassword
    highAvailability: highAvailability
    backupRetentionDays: backupRetentionDays
    geoRedundantBackup: geoRedundantBackup ? 'Enabled' : 'Disabled'
    delegatedSubnetResourceId: delegatedSubnetResourceId
    privateDnsZoneArmResourceId: privateDnsZoneResourceId
    firewallRules: firewallRules
    databases: databases
    tags: tags
  }
}

output resourceId string = postgresqlServer.outputs.resourceId
output name string = postgresqlServer.outputs.name
output fqdn string = postgresqlServer.outputs.fqdn
