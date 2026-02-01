// Scheduled Logic App Workflow
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'prod'
param logAnalyticsWorkspaceId string

module logicApp '../main.bicep' = {
  name: 'logic-app-scheduled'
  params: {
    name: 'logic-scheduled-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    state: 'Enabled'
    workflowTriggers: {
      recurrence: {
        type: 'Recurrence'
        recurrence: {
          frequency: 'Hour'
          interval: 1
          timeZone: 'Eastern Standard Time'
          startTime: '2024-01-01T09:00:00Z'
        }
      }
    }
    workflowActions: {
      LogMessage: {
        type: 'Compose'
        inputs: {
          timestamp: '@{utcNow()}'
          message: 'Scheduled workflow executed'
          environment: environment
        }
        runAfter: {}
      }
    }
    workflowOutputs: {
      executionTime: {
        type: 'String'
        value: '@{utcNow()}'
      }
    }
    managedIdentities: {
      systemAssigned: true
    }
    diagnosticSettings: [
      {
        name: 'diag-${environment}'
        workspaceResourceId: logAnalyticsWorkspaceId
        logCategoriesAndGroups: [
          {
            categoryGroup: 'allLogs'
            enabled: true
          }
        ]
        metricCategories: [
          {
            category: 'AllMetrics'
            enabled: true
          }
        ]
      }
    ]
    tags: {
      environment: environment
      deploymentType: 'scheduled'
      schedule: 'hourly'
    }
  }
}

output resourceId string = logicApp.outputs.resourceId
output name string = logicApp.outputs.name
output systemAssignedPrincipalId string = logicApp.outputs.systemAssignedPrincipalId
