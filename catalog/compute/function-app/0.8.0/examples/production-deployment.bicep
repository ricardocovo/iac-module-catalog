// Production deployment of Azure Function App with VNet integration and private endpoints
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'prod'
param serverFarmResourceId string
param storageAccountResourceId string
param storageAccountName string
param applicationInsightsResourceId string
param virtualNetworkSubnetId string
param privateEndpointSubnetId string
param privateDnsZoneResourceId string

module functionApp '../main.bicep' = {
  name: 'function-app-production'
  params: {
    name: 'func-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    kind: 'functionapp,linux'
    serverFarmResourceId: serverFarmResourceId
    storageAccountResourceId: storageAccountResourceId
    storageAccountName: storageAccountName
    applicationInsightsResourceId: applicationInsightsResourceId
    functionAppRuntime: 'dotnet'
    functionAppRuntimeVersion: '8'
    virtualNetworkSubnetId: virtualNetworkSubnetId
    managedIdentities: {
      systemAssigned: true
    }
    privateEndpoints: [
      {
        name: 'pe-func-${environment}'
        subnetResourceId: privateEndpointSubnetId
        privateDnsZoneResourceIds: [
          privateDnsZoneResourceId
        ]
        service: 'sites'
      }
    ]
    siteConfig: {
      linuxFxVersion: 'DOTNET-ISOLATED|8.0'
      alwaysOn: true
      ftpsState: 'Disabled'
      minTlsVersion: '1.2'
      http20Enabled: true
    }
    appSettingsKeyValuePairs: {
      WEBSITE_RUN_FROM_PACKAGE: '1'
      WEBSITE_ENABLE_SYNC_UPDATE_SITE: 'true'
    }
    tags: {
      environment: environment
      deploymentType: 'production'
      costCenter: 'engineering'
    }
  }
}

output resourceId string = functionApp.outputs.resourceId
output name string = functionApp.outputs.name
output defaultHostname string = functionApp.outputs.defaultHostname
output systemAssignedPrincipalId string = functionApp.outputs.systemAssignedPrincipalId
