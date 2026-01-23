// Production deployment of Azure Static Web App with Standard SKU
targetScope = 'resourceGroup'

param location string = 'eastus2'
param environment string = 'prod'
param appName string = 'myapp'

module staticWebApp '../main.bicep' = {
  name: 'swa-production'
  params: {
    name: 'swa-${appName}-${environment}'
    location: location
    skuName: 'Standard'
    stagingEnvironmentPolicy: 'Enabled'
    allowConfigFileUpdates: true
    managedIdentities: {
      systemAssigned: true
    }
    tags: {
      environment: environment
      deploymentType: 'production'
      application: appName
      costCenter: 'engineering'
    }
  }
}

output resourceId string = staticWebApp.outputs.resourceId
output name string = staticWebApp.outputs.name
output defaultHostname string = staticWebApp.outputs.defaultHostname
