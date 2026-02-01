# Integration Modules

Azure Verified Modules for integration and workflow automation services.

## Available Modules

| Module | AVM Reference | Versions | Description |
|--------|--------------|----------|-------------|
| [Logic App Workflow](logic-app-workflow/) | `avm/res/logic/workflow` | [0.5.0](logic-app-workflow/0.5.0/) | Serverless workflow automation and integration |

## Usage Examples

### Logic App Workflow - HTTP Trigger

```bicep
module logicApp './logic-app-workflow/0.5.0/main.bicep' = {
  name: 'logic-app-http-deployment'
  params: {
    name: 'logic-app-http-${environment}'
    location: location
    workflowTriggers: {
      manual: {
        type: 'Request'
        kind: 'Http'
        inputs: {
          schema: {}
        }
      }
    }
    workflowActions: {
      Response: {
        type: 'Response'
        kind: 'Http'
        inputs: {
          statusCode: 200
          body: {
            message: 'Workflow executed successfully'
          }
        }
        runAfter: {}
      }
    }
    managedIdentities: {
      systemAssigned: true
    }
    tags: {
      environment: environment
    }
  }
}
```

### Logic App Workflow - Scheduled Processing

```bicep
module logicApp './logic-app-workflow/0.5.0/main.bicep' = {
  name: 'logic-app-scheduled-deployment'
  params: {
    name: 'logic-app-scheduled-${environment}'
    location: location
    workflowTriggers: {
      recurrence: {
        type: 'Recurrence'
        recurrence: {
          frequency: 'Day'
          interval: 1
          startTime: '2024-01-01T00:00:00Z'
        }
      }
    }
    workflowActions: {
      ProcessData: {
        type: 'Http'
        inputs: {
          method: 'POST'
          uri: 'https://api.example.com/process'
          authentication: {
            type: 'ManagedServiceIdentity'
          }
        }
        runAfter: {}
      }
    }
    managedIdentities: {
      systemAssigned: true
    }
    diagnosticSettings: [
      {
        name: 'logs'
        workspaceResourceId: logAnalyticsWorkspaceId
        logCategoriesAndGroups: [
          {
            categoryGroup: 'allLogs'
            enabled: true
          }
        ]
      }
    ]
    tags: {
      environment: environment
    }
  }
}
```

## Common Integration Patterns

### API Integration
- Connect to REST APIs and web services
- Transform data between different formats
- Implement retry logic and error handling

### Event-Driven Processing
- React to Azure service events
- Process messages from Service Bus or Event Grid
- Implement asynchronous workflows

### Business Process Automation
- Implement approval workflows
- Automate document processing
- Orchestrate multi-step business processes

### Data Synchronization
- Sync data between systems
- Implement ETL pipelines
- Schedule recurring data transfers

## Security Best Practices

- **Managed Identity**: Use system-assigned or user-assigned managed identities for authentication
- **Access Control**: Configure access control for triggers, actions, and content
- **Private Endpoints**: Deploy Logic Apps in integration service environments for network isolation
- **Monitoring**: Enable diagnostic settings and send logs to Log Analytics
- **Resource Locks**: Apply locks to prevent accidental deletion in production

## References

- [Azure Logic Apps Documentation](https://learn.microsoft.com/azure/logic-apps/)
- [Workflow Definition Language](https://learn.microsoft.com/azure/logic-apps/logic-apps-workflow-definition-language)
- [Logic Apps Connectors](https://learn.microsoft.com/connectors/)
- [Azure Integration Services](https://azure.microsoft.com/solutions/integration/)
- [Azure Verified Modules](https://aka.ms/avm)
