# AKS Managed Cluster Module

## Overview

This module deploys an Azure Kubernetes Service (AKS) Managed Cluster using Azure Verified Modules (AVM).

## Module Reference

- **AVM Module**: `br/public:avm/res/container-service/managed-cluster:0.12.0`
- **Documentation**: [GitHub - AVM Module](https://github.com/Azure/bicep-registry-modules/tree/main/avm/res/container-service/managed-cluster)

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `name` | string | Required | The name of the AKS cluster |
| `location` | string | `resourceGroup().location` | The Azure region for deployment |
| `primaryAgentPoolProfiles` | array | Required | Properties of the primary agent pool (name, count, vmSize, etc.) |
| `kubernetesVersion` | string | `''` | Kubernetes version (empty uses default) |
| `networkPlugin` | string | `'azure'` | Network plugin (azure, kubenet, none) |
| `networkPolicy` | string | `'azure'` | Network policy (azure, calico) |
| `dnsServiceIP` | string | `''` | DNS service IP address |
| `serviceCidr` | string | `''` | Service CIDR range |
| `podCidr` | string | `''` | Pod CIDR range (for kubenet) |
| `enableRBAC` | bool | `true` | Enable Kubernetes RBAC |
| `aadProfile` | object | `{}` | Azure AD integration configuration |
| `managedIdentities` | object | `{}` | Managed identities configuration |
| `azurePolicyEnabled` | bool | `true` | Enable Azure Policy addon |
| `omsAgentEnabled` | bool | `true` | Enable OMS agent for monitoring |
| `monitoringWorkspaceResourceId` | string | `''` | Log Analytics workspace resource ID |
| `apiServerAccessProfile` | object | `{}` | API server access profile (for private clusters) |
| `autoScalerProfile` | object | `{}` | Cluster autoscaler configuration |
| `autoUpgradeProfile` | object | `{upgradeChannel: 'stable'}` | Auto-upgrade configuration |
| `disableLocalAccounts` | bool | `true` | Disable local Kubernetes accounts |
| `enableOidcIssuerProfile` | bool | `false` | Enable OIDC issuer profile |
| `diskEncryptionSetResourceId` | string | `''` | Disk encryption set resource ID |
| `skuTier` | string | `'Standard'` | SKU tier (Free, Standard, Premium) |
| `skuName` | string | `'Base'` | SKU name |
| `loadBalancerSku` | string | `'standard'` | Load balancer SKU |
| `outboundType` | string | `'loadBalancer'` | Outbound traffic routing method |
| `publicNetworkAccess` | string | `'Disabled'` | Public network access setting |
| `agentPools` | array | `[]` | Additional agent pools |
| `nodeResourceGroup` | string | Auto-generated | Node resource group name |
| `roleAssignments` | array | `[]` | RBAC role assignments |
| `diagnosticSettings` | array | `[]` | Diagnostic settings configuration |
| `lock` | object | `{}` | Resource lock configuration |
| `tags` | object | `{}` | Resource tags |

## Outputs

| Output | Type | Description |
|--------|------|-------------|
| `resourceId` | string | The resource ID of the AKS cluster |
| `name` | string | The name of the AKS cluster |
| `resourceGroupName` | string | The resource group name |
| `location` | string | The deployment location |
| `controlPlaneFQDN` | string | The control plane FQDN |
| `systemAssignedMIPrincipalId` | string | System-assigned managed identity principal ID |
| `kubeletIdentityObjectId` | string | Kubelet identity object ID |
| `kubeletIdentityClientId` | string | Kubelet identity client ID |
| `kubeletIdentityResourceId` | string | Kubelet identity resource ID |
| `oidcIssuerUrl` | string | OIDC issuer URL |
| `keyvaultIdentityObjectId` | string | Key Vault identity object ID |
| `keyvaultIdentityClientId` | string | Key Vault identity client ID |

## Usage

### Basic Azure CNI Cluster

```bicep
module aks '../managed-cluster/0.12.0/main.bicep' = {
  name: 'aks-deployment'
  params: {
    name: 'aks-foundry-prod'
    location: 'eastus2'
    primaryAgentPoolProfiles: [
      {
        name: 'system'
        count: 3
        vmSize: 'Standard_D4s_v3'
        mode: 'System'
        availabilityZones: ['1', '2', '3']
        enableAutoScaling: true
        minCount: 3
        maxCount: 5
      }
    ]
    networkPlugin: 'azure'
    networkPolicy: 'azure'
    managedIdentities: {
      systemAssigned: true
    }
    monitoringWorkspaceResourceId: logAnalyticsWorkspace.outputs.resourceId
    azurePolicyEnabled: true
    enableRBAC: true
    disableLocalAccounts: true
    tags: {
      environment: 'production'
      workload: 'kubernetes'
    }
  }
}
```

### Private Cluster with Azure AD Integration

```bicep
module aksPrivate '../managed-cluster/0.12.0/main.bicep' = {
  name: 'aks-private-deployment'
  params: {
    name: 'aks-foundry-private'
    location: 'eastus2'
    primaryAgentPoolProfiles: [
      {
        name: 'system'
        count: 3
        vmSize: 'Standard_D4s_v3'
        mode: 'System'
        vnetSubnetResourceId: subnetId
        availabilityZones: ['1', '2', '3']
      }
    ]
    apiServerAccessProfile: {
      enablePrivateCluster: true
      privateDNSZone: privateDnsZoneId
    }
    aadProfile: {
      managed: true
      enableAzureRBAC: true
      adminGroupObjectIDs: [
        'admin-group-id'
      ]
    }
    publicNetworkAccess: 'Disabled'
    disableLocalAccounts: true
  }
}
```

### Multi-Pool Cluster with Autoscaling

```bicep
module aksMultiPool '../managed-cluster/0.12.0/main.bicep' = {
  name: 'aks-multipool-deployment'
  params: {
    name: 'aks-foundry-multipool'
    location: 'eastus2'
    primaryAgentPoolProfiles: [
      {
        name: 'system'
        count: 3
        vmSize: 'Standard_D4s_v3'
        mode: 'System'
        enableAutoScaling: true
        minCount: 3
        maxCount: 6
      }
    ]
    agentPools: [
      {
        name: 'user'
        count: 2
        vmSize: 'Standard_D8s_v3'
        mode: 'User'
        enableAutoScaling: true
        minCount: 2
        maxCount: 10
      }
      {
        name: 'gpu'
        count: 1
        vmSize: 'Standard_NC6s_v3'
        mode: 'User'
        enableAutoScaling: true
        minCount: 0
        maxCount: 3
      }
    ]
    autoScalerProfile: {
      'balance-similar-node-groups': 'true'
      expander: 'random'
      'max-graceful-termination-sec': '600'
      'scale-down-delay-after-add': '10m'
    }
  }
}
```

## Best Practices

1. **Security**
   - Always enable Azure Policy (`azurePolicyEnabled: true`)
   - Disable local accounts (`disableLocalAccounts: true`)
   - Use Azure AD integration for authentication
   - Enable private cluster for production workloads
   - Use disk encryption set for data encryption at rest

2. **High Availability**
   - Deploy across availability zones
   - Use Standard SKU tier for production
   - Configure autoscaling for agent pools
   - Set appropriate min/max node counts

3. **Networking**
   - Use Azure CNI for better integration with Azure networking
   - Configure network policies for pod-to-pod communication control
   - Use private clusters to limit API server exposure
   - Plan IP address ranges carefully (service CIDR, pod CIDR)

4. **Monitoring**
   - Enable OMS agent for Container Insights
   - Connect to Log Analytics workspace
   - Configure diagnostic settings for control plane logs
   - Enable Azure Monitor for comprehensive observability

5. **Operations**
   - Enable auto-upgrade with appropriate channel (stable/rapid/patch)
   - Configure maintenance windows
   - Use managed identities instead of service principals
   - Tag resources appropriately for cost management

## Additional Resources

- [AKS Best Practices](https://learn.microsoft.com/azure/aks/best-practices)
- [AKS Network Concepts](https://learn.microsoft.com/azure/aks/concepts-network)
- [AKS Security Concepts](https://learn.microsoft.com/azure/aks/concepts-security)
- [AVM Module Documentation](https://github.com/Azure/bicep-registry-modules/tree/main/avm/res/container-service/managed-cluster)
