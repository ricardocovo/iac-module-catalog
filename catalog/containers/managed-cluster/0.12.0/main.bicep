// Azure Verified Module Reference: AKS Managed Cluster
// Registry: br/public:avm/res/container-service/managed-cluster

metadata name = 'AKS Managed Cluster'
metadata description = 'AVM reference for deploying Azure Kubernetes Service (AKS) clusters'
metadata owner = 'Azure Verified Modules'

@description('The name of the AKS cluster')
param name string

@description('The location')
param location string = resourceGroup().location

@description('Properties of the primary agent pool')
param primaryAgentPoolProfiles array

@description('Kubernetes version')
param kubernetesVersion string = ''

@description('Network plugin (azure, kubenet, none)')
param networkPlugin string = 'azure'

@description('Network policy (azure, calico)')
param networkPolicy string = 'azure'

@description('DNS service IP address')
param dnsServiceIP string = ''

@description('Service CIDR')
param serviceCidr string = ''

@description('Pod CIDR')
param podCidr string = ''

@description('Enable RBAC')
param enableRBAC bool = true

@description('AAD profile configuration')
param aadProfile object = {}

@description('Managed identities configuration')
param managedIdentities object = {}

@description('Enable Azure Policy addon')
param azurePolicyEnabled bool = true

@description('Enable OMS agent for monitoring')
param omsAgentEnabled bool = true

@description('Resource ID of the Log Analytics workspace for monitoring')
param monitoringWorkspaceResourceId string = ''

@description('API Server access profile')
param apiServerAccessProfile object = {}

@description('Auto-scaler profile configuration')
param autoScalerProfile object = {}

@description('Auto-upgrade profile configuration')
param autoUpgradeProfile object = {
  upgradeChannel: 'stable'
}

@description('Disable local accounts')
param disableLocalAccounts bool = true

@description('Enable OIDC issuer profile')
param enableOidcIssuerProfile bool = false

@description('Disk encryption set resource ID')
param diskEncryptionSetResourceId string = ''

@description('SKU tier (Free, Standard, Premium)')
param skuTier string = 'Standard'

@description('SKU name')
param skuName string = 'Base'

@description('Load balancer SKU')
param loadBalancerSku string = 'standard'

@description('Outbound type')
param outboundType string = 'loadBalancer'

@description('Public network access (Enabled, Disabled, SecuredByPerimeter)')
param publicNetworkAccess string = 'Disabled'

@description('Additional agent pools')
param agentPools array = []

@description('Node resource group name')
param nodeResourceGroup string = '${resourceGroup().name}_aks_${name}_nodes'

@description('Role assignments')
param roleAssignments array = []

@description('Diagnostic settings')
param diagnosticSettings array = []

@description('Resource lock configuration')
param lock object = {}

@description('Tags')
param tags object = {}

module managedCluster 'br/public:avm/res/container-service/managed-cluster:0.12.0' = {
  name: '${name}-deployment'
  params: {
    name: name
    location: location
    primaryAgentPoolProfiles: primaryAgentPoolProfiles
    kubernetesVersion: kubernetesVersion
    networkPlugin: networkPlugin
    networkPolicy: networkPolicy
    dnsServiceIP: dnsServiceIP
    serviceCidr: serviceCidr
    podCidr: podCidr
    enableRBAC: enableRBAC
    aadProfile: aadProfile
    managedIdentities: managedIdentities
    azurePolicyEnabled: azurePolicyEnabled
    omsAgentEnabled: omsAgentEnabled
    monitoringWorkspaceResourceId: monitoringWorkspaceResourceId
    apiServerAccessProfile: apiServerAccessProfile
    autoScalerProfile: autoScalerProfile
    autoUpgradeProfile: autoUpgradeProfile
    disableLocalAccounts: disableLocalAccounts
    enableOidcIssuerProfile: enableOidcIssuerProfile
    diskEncryptionSetResourceId: diskEncryptionSetResourceId
    skuTier: skuTier
    skuName: skuName
    loadBalancerSku: loadBalancerSku
    outboundType: outboundType
    publicNetworkAccess: publicNetworkAccess
    agentPools: agentPools
    nodeResourceGroup: nodeResourceGroup
    roleAssignments: roleAssignments
    diagnosticSettings: diagnosticSettings
    lock: lock
    tags: tags
  }
}

output resourceId string = managedCluster.outputs.resourceId
output name string = managedCluster.outputs.name
output resourceGroupName string = managedCluster.outputs.resourceGroupName
output location string = managedCluster.outputs.location
output controlPlaneFQDN string = managedCluster.outputs.controlPlaneFQDN
output systemAssignedMIPrincipalId string = managedCluster.outputs.?systemAssignedMIPrincipalId ?? ''
output kubeletIdentityObjectId string = managedCluster.outputs.?kubeletIdentityObjectId ?? ''
output kubeletIdentityClientId string = managedCluster.outputs.?kubeletIdentityClientId ?? ''
output kubeletIdentityResourceId string = managedCluster.outputs.?kubeletIdentityResourceId ?? ''
output oidcIssuerUrl string = managedCluster.outputs.?oidcIssuerUrl ?? ''
output keyvaultIdentityObjectId string = managedCluster.outputs.?keyvaultIdentityObjectId ?? ''
output keyvaultIdentityClientId string = managedCluster.outputs.?keyvaultIdentityClientId ?? ''
