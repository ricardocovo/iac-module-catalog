# Logic App Workflow Module

## Overview

This module deploys an Azure Logic Apps Workflow using Azure Verified Modules (AVM). Logic Apps enables you to create automated workflows that integrate apps, data, services, and systems.

## Module Reference

- **AVM Module**: `br/public:avm/res/logic/workflow:0.5.0`
- **Documentation**: [GitHub - AVM Logic Workflow Module](https://github.com/Azure/bicep-registry-modules/tree/main/avm/res/logic/workflow)

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `name` | string | Required | The name of the Logic App workflow (1-80 characters) |
| `location` | string | `resourceGroup().location` | The Azure region for deployment |
| `state` | string | `'Enabled'` | The state of the workflow. Allowed values: NotSpecified, Completed, Enabled, Disabled, Deleted, Suspended |
| `workflowTriggers` | object | `{}` | The definitions for one or more triggers that instantiate your workflow |
| `workflowActions` | object | `{}` | The definitions for one or more actions to execute at workflow runtime |
| `workflowOutputs` | object | `{}` | The definitions for the outputs to return from a workflow run |
| `workflowParameters` | object | `{}` | The definitions for parameters that pass values to use at runtime |
| `definitionParameters` | object | `{}` | Parameters for the definition template |
| `managedIdentities` | object | `{}` | Managed identity configuration (system-assigned or user-assigned) |
| `integrationAccount` | object | `{}` | Integration account configuration for B2B scenarios |
| `integrationServiceEnvironment` | object | `{}` | Integration service environment settings |
| `actionsAccessControlConfiguration` | object | `{}` | Access control configuration for workflow actions |
| `contentsAccessControlConfiguration` | object | `{}` | Access control configuration for accessing workflow run contents |
| `triggersAccessControlConfiguration` | object | `{}` | Access control configuration for invoking workflow triggers |
| `workflowManagementAccessControlConfiguration` | object | `{}` | Access control configuration for workflow management |
| `diagnosticSettings` | array | `[]` | Diagnostic settings configuration |
| `lock` | object | `{}` | Resource lock settings |
| `roleAssignments` | array | `[]` | Array of role assignments to create |
| `tags` | object | `{}` | Resource tags |
| `enableTelemetry` | bool | `true` | Enable/Disable usage telemetry for module |

## Outputs

| Output | Type | Description |
|--------|------|-------------|
| `name` | string | The name of the Logic App workflow |
| `resourceId` | string | The resource ID of the Logic App workflow |
| `resourceGroupName` | string | The resource group the Logic App workflow was deployed into |
| `location` | string | The location the Logic App workflow was deployed into |
| `systemAssignedMIPrincipalId` | string | The principal ID of the system assigned identity |

## Usage

### Basic Deployment

See [examples/basic-deployment.bicep](examples/basic-deployment.bicep) for a minimal configuration with an HTTP trigger.

### Production Deployment

See [examples/production-deployment.bicep](examples/production-deployment.bicep) for a production-ready configuration with managed identity and private networking.

## Example - HTTP Trigger Workflow

```bicep
module logicApp '../main.bicep' = {
  name: 'logic-app-deployment'
  params: {
    name: 'my-logic-app-workflow'
    location: 'eastus'
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
            message: 'Hello from Logic Apps!'
          }
        }
        runAfter: {}
      }
    }
    tags: {
      environment: 'production'
    }
  }
}
```

## Example - Recurrence Trigger with Service Bus

```bicep
module logicApp '../main.bicep' = {
  name: 'logic-app-service-bus'
  params: {
    name: 'logic-app-service-bus-processor'
    location: 'eastus'
    managedIdentities: {
      systemAssigned: true
    }
    workflowTriggers: {
      recurrence: {
        type: 'Recurrence'
        recurrence: {
          frequency: 'Minute'
          interval: 5
        }
      }
    }
    workflowActions: {
      CheckServiceBus: {
        type: 'ServiceBus'
        inputs: {
          queueName: 'myqueue'
        }
        runAfter: {}
      }
    }
    tags: {
      environment: 'production'
    }
  }
}
```

## Common Use Cases

- **API Integration**: Create workflows that integrate with REST APIs and web services
- **Data Processing**: Automate data transformation and processing pipelines
- **Business Processes**: Implement approval workflows and business logic automation
- **Event-Driven Automation**: Respond to events from Azure services and external systems
- **B2B Integration**: Build EDI and B2B workflows using integration accounts

## References

- [Azure Logic Apps Documentation](https://learn.microsoft.com/azure/logic-apps/)
- [Workflow Definition Language](https://learn.microsoft.com/azure/logic-apps/logic-apps-workflow-definition-language)
- [Azure Verified Modules](https://aka.ms/avm)
- [Logic Apps Connectors](https://learn.microsoft.com/connectors/)
