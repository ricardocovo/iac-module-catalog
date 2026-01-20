// Azure Verified Module Reference: Application Insights
// Registry: br/public:avm/res/insights/component

metadata name = 'Application Insights'
metadata description = 'AVM reference for deploying Application Insights'
metadata owner = 'Azure Verified Modules'

@description('The name of the Application Insights')
param name string

@description('The location')
param location string = resourceGroup().location

@description('Application type')
@allowed(['web', 'other'])
param applicationType string = 'web'

@description('Workspace resource ID')
param workspaceResourceId string

@description('Public network access for ingestion')
@allowed(['Enabled', 'Disabled'])
param publicNetworkAccessForIngestion string = 'Enabled'

@description('Public network access for query')
@allowed(['Enabled', 'Disabled'])
param publicNetworkAccessForQuery string = 'Enabled'

@description('Tags')
param tags object = {}

module applicationInsights 'br/public:avm/res/insights/component:0.7.1' = {
  name: '${name}-deployment'
  params: {
    name: name
    location: location
    applicationType: applicationType
    workspaceResourceId: workspaceResourceId
    publicNetworkAccessForIngestion: publicNetworkAccessForIngestion
    publicNetworkAccessForQuery: publicNetworkAccessForQuery
    tags: tags
  }
}

output resourceId string = applicationInsights.outputs.resourceId
output name string = applicationInsights.outputs.name
output instrumentationKey string = applicationInsights.outputs.instrumentationKey
output connectionString string = applicationInsights.outputs.connectionString
