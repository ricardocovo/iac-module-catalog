# Container Modules

Azure Verified Modules for containerized applications in the Microsoft Foundry landing zone.

## Available Modules

| Module | AVM Reference | Versions | Description |
|--------|--------------|----------|-------------|
| [Container Apps Environment](container-apps-environment/) | `avm/res/app/managed-environment` | [0.10.2](container-apps-environment/0.10.2/) \| [0.11.0](container-apps-environment/0.11.0/) \| [0.11.1](container-apps-environment/0.11.1/) \| [0.11.2](container-apps-environment/0.11.2/) \| [0.11.3](container-apps-environment/0.11.3/) | Container Apps managed environment |
| [Container App](container-app/) | `avm/res/app/container-app` | [0.18.0](container-app/0.18.0/) \| [0.18.1](container-app/0.18.1/) \| [0.18.2](container-app/0.18.2/) \| [0.19.0](container-app/0.19.0/) \| [0.20.0](container-app/0.20.0/) | Container App deployment |

## Usage Example

```bicep
// First, create the environment
module containerEnv './container-apps-environment.bicep' = {
  name: 'cae-deployment'
  params: {
    name: 'cae-foundry-eastus2'
    location: 'eastus2'
    workspaceResourceId: logAnalytics.outputs.resourceId
    zoneRedundant: true
    internalLoadBalancerEnabled: true
    infrastructureSubnetId: infrastructureSubnetId
  }
}

// Then deploy container apps
module containerApp './container-app.bicep' = {
  name: 'ca-deployment'
  params: {
    name: 'ca-chat-ui'
    location: 'eastus2'
    environmentResourceId: containerEnv.outputs.resourceId
    containers: [
      {
        name: 'chat-ui'
        image: 'mcr.microsoft.com/azuredocs/containerapps-helloworld:latest'
        resources: {
          cpu: '0.5'
          memory: '1Gi'
        }
      }
    ]
    ingressConfiguration: {
      external: false
      targetPort: 80
      transport: 'http'
    }
    managedIdentities: {
      userAssignedResourceIds: [managedIdentityId]
    }
  }
}
```

## Key Features

- **VNet Integration**: Deploy into private subnets
- **Dapr Integration**: Microservices building blocks
- **Scaling**: Auto-scale based on HTTP, CPU, memory, or custom metrics
- **Revisions**: Blue-green deployments and traffic splitting
- **Secrets Management**: Secure secret injection from Key Vault
