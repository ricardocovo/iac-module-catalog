// Production deployment of Container App Job (Scheduled)
targetScope = 'resourceGroup'

param location string = 'canadacentral'
param environment string = 'production'
param environmentResourceId string
param containerRegistry string = ''
param managedIdentityId string = ''

module job '../main.bicep' = {
  name: 'job-production'
  params: {
    name: 'job-${environment}-nightly-processor'
    location: location
    environmentResourceId: environmentResourceId
    triggerType: 'Schedule'
    scheduleTriggerConfig: {
      cronExpression: '0 2 * * *'  // Daily at 2 AM
      parallelism: 1
      replicaCompletionCount: 1
    }
    containers: [
      {
        name: 'processor'
        image: !empty(containerRegistry) ? '${containerRegistry}/processor:latest' : 'mcr.microsoft.com/azuredocs/containerapps-helloworld:latest'
        resources: {
          cpu: json('1.0')
          memory: '2Gi'
        }
        env: [
          {
            name: 'ENVIRONMENT'
            value: environment
          }
          {
            name: 'LOG_LEVEL'
            value: 'INFO'
          }
        ]
      }
    ]
    replicaTimeout: 3600  // 1 hour
    replicaRetryLimit: 1
    managedIdentities: !empty(managedIdentityId) ? {
      userAssignedResourceIds: [
        managedIdentityId
      ]
    } : {
      systemAssigned: true
    }
    registries: !empty(containerRegistry) ? [
      {
        server: containerRegistry
        identity: !empty(managedIdentityId) ? managedIdentityId : 'system'
      }
    ] : []
    tags: {
      environment: environment
      workload: 'batch-processing'
      dataClassification: 'confidential'
      costCenter: 'engineering'
    }
  }
}

output resourceId string = job.outputs.resourceId
output name string = job.outputs.name
output location string = job.outputs.location
