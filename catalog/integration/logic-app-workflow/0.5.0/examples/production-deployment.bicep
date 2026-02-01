// Production deployment of Logic App Workflow with managed identity and monitoring
targetScope = 'resourceGroup'

param location string = 'eastus'
param environment string = 'prod'
param logAnalyticsWorkspaceId string

module logicAppWorkflow '../main.bicep' = {
  name: 'logic-app-workflow-production'
  params: {
    name: 'logic-app-${environment}-${uniqueString(resourceGroup().id)}'
    location: location
    state: 'Enabled'
    
    // Enable system-assigned managed identity
    managedIdentities: {
      systemAssigned: true
    }
    
    // Recurrence trigger - runs every hour
    workflowTriggers: {
      recurrence: {
        type: 'Recurrence'
        recurrence: {
          frequency: 'Hour'
          interval: 1
        }
      }
    }
    
    // Sample workflow actions
    workflowActions: {
      Initialize_variable: {
        type: 'InitializeVariable'
        inputs: {
          variables: [
            {
              name: 'ProcessingTime'
              type: 'String'
              value: '@utcNow()'
            }
          ]
        }
        runAfter: {}
      }
      HTTP_Action: {
        type: 'Http'
        inputs: {
          method: 'GET'
          uri: 'https://api.example.com/data'
          authentication: {
            type: 'ManagedServiceIdentity'
          }
        }
        runAfter: {
          Initialize_variable: [
            'Succeeded'
          ]
        }
      }
    }
    
    // Diagnostic settings for monitoring
    diagnosticSettings: [
      {
        name: 'diagnostic-logs'
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
    
    // Resource lock
    lock: {
      kind: 'CanNotDelete'
      name: 'lock-logic-app'
    }
    
    tags: {
      environment: environment
      deploymentType: 'production'
      compliance: 'required'
    }
  }
}

output resourceId string = logicAppWorkflow.outputs.resourceId
output name string = logicAppWorkflow.outputs.name
output location string = logicAppWorkflow.outputs.location
output systemAssignedMIPrincipalId string = logicAppWorkflow.outputs.systemAssignedMIPrincipalId
