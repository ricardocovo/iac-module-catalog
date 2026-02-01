# Logic App Workflow Module

## Overview

This module deploys an Azure Logic App Workflow using Azure Verified Modules (AVM). Azure Logic Apps is a cloud platform where you can create and run automated workflows with little to no code. By using the visual designer and selecting from prebuilt operations, you can quickly build a workflow that integrates and manages your apps, data, services, and systems.

## Module Reference

- **AVM Module**: `br/public:avm/res/logic/workflow:0.5.0`
- **Documentation**: [GitHub - AVM Module](https://github.com/Azure/bicep-registry-modules/tree/main/avm/res/logic/workflow)

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `name` | string | Required | The name of the logic app workflow |
| `location` | string | `resourceGroup().location` | The Azure region for deployment |
| `state` | string | `'Enabled'` | The state of the workflow (NotSpecified, Completed, Enabled, Disabled, Deleted, Suspended) |
| `workflowTriggers` | object | `{}` | The definitions for one or more triggers that instantiate your workflow |
| `workflowActions` | object | `{}` | The definitions for one or more actions to execute at workflow runtime |
| `workflowOutputs` | object | `{}` | The definitions for the outputs to return from a workflow run |
| `workflowParameters` | object | `{}` | The definitions for one or more parameters that pass the values to use at your logic app's runtime |
| `managedIdentities` | object | `{}` | Managed identity configuration (system-assigned or user-assigned) |
| `integrationAccount` | object | `{}` | The integration account configuration |
| `roleAssignments` | array | `[]` | Array of role assignments to create |
| `diagnosticSettings` | array | `[]` | Diagnostic settings configuration |
| `lock` | object | `{}` | Lock configuration for the resource |
| `tags` | object | `{}` | Resource tags |
| `enableTelemetry` | bool | `true` | Enable/Disable usage telemetry for module |

## Outputs

| Output | Type | Description |
|--------|------|-------------|
| `resourceId` | string | The resource ID of the logic app workflow |
| `name` | string | The name of the logic app workflow |
| `location` | string | The location the resource was deployed into |
| `resourceGroupName` | string | The resource group the logic app was deployed into |
| `systemAssignedPrincipalId` | string | The principal ID of the system-assigned managed identity |

## Usage

### Basic HTTP Trigger Workflow

See [examples/basic-http-trigger.bicep](examples/basic-http-trigger.bicep) for a simple HTTP-triggered workflow.

### Scheduled Workflow

See [examples/scheduled-workflow.bicep](examples/scheduled-workflow.bicep) for a workflow that runs on a schedule.

### Integration with Azure Services

See [examples/azure-service-integration.bicep](examples/azure-service-integration.bicep) for a workflow that integrates with other Azure services.

## Example

```bicep
module logicApp '../logic-app-workflow/0.5.0/main.bicep' = {
  name: 'logic-app-deployment'
  params: {
    name: 'logic-my-workflow'
    location: 'eastus'
    state: 'Enabled'
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
    managedIdentities: {
      systemAssigned: true
    }
    tags: {
      environment: 'production'
      application: 'integration'
    }
  }
}
```

## Notes

- Logic Apps workflows can be triggered by various events including HTTP requests, schedules, or Azure service events
- Workflows support integration with hundreds of connectors for popular SaaS services and protocols
- System-assigned or user-assigned managed identities can be used for secure authentication to Azure resources
- Use integration accounts for B2B scenarios requiring EDI and XML processing capabilities
- Diagnostic settings enable monitoring and logging to Log Analytics, Event Hubs, or Storage Accounts

## Related Modules

- [Integration Account](../../integration-account/) (if available)
- [API Connection](../../api-connection/) (if available)
- [Log Analytics Workspace](../../../monitoring/log-analytics-workspace/)
- [Application Insights](../../../monitoring/application-insights/)

## Workflow Definition Language

Logic Apps uses the Workflow Definition Language to define triggers, actions, and outputs. For more information, see:
- [Workflow Definition Language schema reference](https://docs.microsoft.com/azure/logic-apps/logic-apps-workflow-definition-language)
- [Connectors overview](https://docs.microsoft.com/azure/connectors/apis-list)

