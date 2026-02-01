# Container App Job Module

## Overview

This module deploys an Azure Container App Job using Azure Verified Modules (AVM). Container App Jobs are used for running containerized tasks that run to completion, including scheduled tasks, event-driven processing, and manual job execution.

## Module Reference

- **AVM Module**: `br/public:avm/res/app/job:0.7.1`
- **Documentation**: [GitHub - AVM Module](https://github.com/Azure/bicep-registry-modules/tree/main/avm/res/app/job)

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `name` | string | Required | The name of the container app job |
| `location` | string | `resourceGroup().location` | The Azure region for deployment |
| `environmentResourceId` | string | Required | Container Apps environment resource ID |
| `containers` | array | Required | Array of container configurations |
| `triggerType` | string | Required | Trigger type for the job: 'Manual', 'Schedule', or 'Event' |
| `manualTriggerConfig` | object | `{}` | Manual trigger configuration |
| `scheduleTriggerConfig` | object | `{}` | Schedule trigger configuration (cronExpression, parallelism, replicaCompletionCount) |
| `eventTriggerConfig` | object | `{}` | Event trigger configuration (scale rules) |
| `replicaTimeout` | int | `1800` | Replica timeout in seconds (max 1800) |
| `replicaRetryLimit` | int | `0` | Replica retry limit |
| `secretsConfiguration` | object | `{}` | Secrets configuration object (secure parameter) |
| `managedIdentities` | object | `{}` | Managed identity configuration |
| `tags` | object | `{}` | Resource tags |
| `registries` | array | `[]` | Container registries for pulling images |

## Outputs

| Output | Type | Description |
|--------|------|-------------|
| `resourceId` | string | The resource ID of the job |
| `name` | string | The name of the job |
| `resourceGroupName` | string | The resource group the job was deployed into |
| `location` | string | The location the job was deployed into |

## Usage

### Basic Manual Job

See [examples/basic-deployment.bicep](examples/basic-deployment.bicep) for a minimal manual job configuration.

### Scheduled Job

See [examples/production-deployment.bicep](examples/production-deployment.bicep) for a production-ready scheduled job configuration.

## Examples

### Manual Trigger Job

```bicep
module job '../job/0.7.1/main.bicep' = {
  name: 'job-manual-deployment'
  params: {
    name: 'job-data-processor'
    location: 'canadacentral'
    environmentResourceId: containerEnv.outputs.resourceId
    triggerType: 'Manual'
    containers: [
      {
        name: 'processor'
        image: 'myregistry.azurecr.io/data-processor:latest'
        resources: {
          cpu: '0.5'
          memory: '1Gi'
        }
      }
    ]
    managedIdentities: {
      systemAssigned: true
    }
    tags: {
      environment: 'production'
      workload: 'batch-processing'
    }
  }
}
```

### Scheduled Job (Cron)

```bicep
module job '../job/0.7.1/main.bicep' = {
  name: 'job-scheduled-deployment'
  params: {
    name: 'job-nightly-backup'
    location: 'canadacentral'
    environmentResourceId: containerEnv.outputs.resourceId
    triggerType: 'Schedule'
    scheduleTriggerConfig: {
      cronExpression: '0 2 * * *'  // Daily at 2 AM
      parallelism: 1
      replicaCompletionCount: 1
    }
    containers: [
      {
        name: 'backup'
        image: 'myregistry.azurecr.io/backup:latest'
        resources: {
          cpu: '1.0'
          memory: '2Gi'
        }
      }
    ]
    replicaTimeout: 3600  // 1 hour timeout
    managedIdentities: {
      systemAssigned: true
    }
    tags: {
      environment: 'production'
      workload: 'backup'
    }
  }
}
```

## References

- [Azure Container Apps Jobs Documentation](https://learn.microsoft.com/azure/container-apps/jobs)
- [Azure Verified Modules](https://aka.ms/avm)
- [AVM Module Source](https://github.com/Azure/bicep-registry-modules/tree/main/avm/res/app/job)
