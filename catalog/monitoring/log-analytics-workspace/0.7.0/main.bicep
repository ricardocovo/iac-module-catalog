// Azure Verified Module Reference: Log Analytics Workspace
// Registry: br/public:avm/res/operational-insights/workspace

metadata name = 'Log Analytics Workspace'
metadata description = 'AVM reference for deploying Log Analytics Workspace'
metadata owner = 'Azure Verified Modules'

@description('The name of the workspace')
param name string

@description('The location')
param location string = resourceGroup().location

@description('SKU name')
@allowed(['Free', 'PerGB2018', 'PerNode', 'Premium', 'Standalone', 'Standard'])
param skuName string = 'PerGB2018'

@description('Retention in days')
param dataRetention int = 30

@description('Daily quota in GB')
param dailyQuotaGb int = -1

@description('Public network access for ingestion')
@allowed(['Enabled', 'Disabled'])
param publicNetworkAccessForIngestion string = 'Enabled'

@description('Public network access for query')
@allowed(['Enabled', 'Disabled'])
param publicNetworkAccessForQuery string = 'Enabled'

@description('Tags')
param tags object = {}

module logAnalyticsWorkspace 'br/public:avm/res/operational-insights/workspace:0.7.0' = {
  name: '${name}-deployment'
  params: {
    name: name
    location: location
    skuName: skuName
    dataRetention: dataRetention
    dailyQuotaGb: dailyQuotaGb
    publicNetworkAccessForIngestion: publicNetworkAccessForIngestion
    publicNetworkAccessForQuery: publicNetworkAccessForQuery
    tags: tags
  }
}

output resourceId string = logAnalyticsWorkspace.outputs.resourceId
output name string = logAnalyticsWorkspace.outputs.name
output customerId string = logAnalyticsWorkspace.outputs.logAnalyticsWorkspaceId
