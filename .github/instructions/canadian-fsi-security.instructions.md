---
applyTo: '**/*.bicep, **/*.bicepparam'
---

# Canadian Financial Services Institution (FSI) Security Requirements

This instruction file defines mandatory security controls for Azure infrastructure modules used in Canadian banking environments. All modules must comply with OSFI guidelines, PIPEDA, and industry best practices.

## 1. Data Residency & Sovereignty

### Mandatory Requirements
- **All resources MUST be deployed in Canadian Azure regions only**:
  - Primary: `canadacentral`
  - Secondary: `canadaeast`
- **Explicitly prohibit** deployment to non-Canadian regions
- For geo-replication scenarios, use paired Canadian regions only

### Implementation
```bicep
// ✅ CORRECT: Restrict to Canadian regions
@allowed([
  'canadacentral'
  'canadaeast'
])
param location string = 'canadacentral'

// ❌ INCORRECT: Allows non-Canadian regions
param location string = resourceGroup().location
```

### Verification
- Review all `location` parameters
- Ensure `@allowed` decorator restricts to Canadian regions
- Check paired region configurations for DR/HA

---

## 2. Encryption Standards

### Data at Rest
- **MANDATORY**: Enable encryption at rest for ALL data services
- **REQUIRED**: Use customer-managed keys (CMK) via Azure Key Vault where supported
- **MINIMUM**: Use Microsoft-managed keys if CMK not available

#### Services Requiring Encryption
- Azure SQL Database/Managed Instance (TDE with CMK)
- Azure Storage Accounts (CMK preferred)
- Azure Cosmos DB (CMK preferred)
- Azure Disk Encryption (CMK required)
- Azure Data Lake Storage (CMK required)

#### Implementation Example
```bicep
// Storage Account with CMK
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  properties: {
    encryption: {
      services: {
        blob: { enabled: true }
        file: { enabled: true }
      }
      keySource: 'Microsoft.Keyvault'
      keyvaultproperties: {
        keyname: keyVaultKeyName
        keyvaulturi: keyVaultUri
      }
    }
  }
}
```

### Data in Transit
- **MANDATORY**: Enforce TLS 1.2 minimum (TLS 1.3 preferred)
- **REQUIRED**: Disable insecure protocols (TLS 1.0, 1.1, SSL)
- **REQUIRED**: Enforce HTTPS-only access

```bicep
// ✅ CORRECT: Secure transfer enforced
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  properties: {
    supportsHttpsTrafficOnly: true
    minimumTlsVersion: 'TLS1_2'
  }
}
```

---

## 3. Network Security & Isolation

### Private Endpoints (Mandatory)
- **REQUIRED**: Use Private Endpoints for all PaaS services handling sensitive data
- **REQUIRED**: Disable public network access where possible
- **REQUIRED**: Integrate with Private DNS Zones

#### Services Requiring Private Endpoints
- Azure SQL Database
- Azure Storage Accounts
- Azure Key Vault
- Azure Cosmos DB
- Azure Container Registry
- Azure App Service (when handling PCI data)

```bicep
resource privateEndpoint 'Microsoft.Network/privateEndpoints@2023-05-01' = {
  name: '${serviceName}-pe'
  location: location
  properties: {
    subnet: {
      id: subnetId
    }
    privateLinkServiceConnections: [{
      name: '${serviceName}-plsc'
      properties: {
        privateLinkServiceId: serviceId
        groupIds: [ groupId ]
      }
    }]
  }
}

// Disable public access
resource service 'Microsoft.Sql/servers@2023-05-01-preview' = {
  properties: {
    publicNetworkAccess: 'Disabled'
  }
}
```

### Network Security Groups (NSGs)
- **REQUIRED**: Apply NSGs to all subnets
- **REQUIRED**: Follow least-privilege principle
- **REQUIRED**: Document all allow rules with business justification

```bicep
// NSG with explicit deny-all and minimal allows
resource nsg 'Microsoft.Network/networkSecurityGroups@2023-05-01' = {
  name: nsgName
  location: location
  properties: {
    securityRules: [
      {
        name: 'DenyAllInbound'
        properties: {
          priority: 4096
          direction: 'Inbound'
          access: 'Deny'
          protocol: '*'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
        }
      }
    ]
  }
}
```

### Firewall Rules
- **PROHIBITED**: `0.0.0.0-255.255.255.255` ranges (allow all)
- **REQUIRED**: Whitelist specific IP ranges only
- **REQUIRED**: Document purpose for each firewall rule

---

## 4. Identity & Access Management

### Managed Identities
- **MANDATORY**: Use Managed Identities for all Azure resource authentication
- **PREFERRED**: Use System-Assigned Managed Identity where possible
- **PROHIBITED**: Hardcoded credentials, connection strings with secrets

```bicep
// ✅ CORRECT: Managed Identity enabled
resource appService 'Microsoft.Web/sites@2023-01-01' = {
  identity: {
    type: 'SystemAssigned'
  }
}
```

### Role-Based Access Control (RBAC)
- **REQUIRED**: Follow least-privilege access model
- **REQUIRED**: Use built-in roles where possible
- **PROHIBITED**: Owner or Contributor roles at subscription/resource group level
- **REQUIRED**: Specific resource-level permissions only

```bicep
// Grant specific permission to Managed Identity
resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(resourceId, principalId, roleDefinitionId)
  properties: {
    principalId: principalId
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', roleDefinitionId)
    principalType: 'ServicePrincipal'
  }
}
```

### Credential Management
- **MANDATORY**: Store all secrets in Azure Key Vault
- **PROHIBITED**: Secrets in parameters files, default values, or outputs
- **REQUIRED**: Use Key Vault references in Bicep

```bicep
// ✅ CORRECT: Key Vault reference
resource keyVault 'Microsoft.KeyVault/vaults@2023-02-01' existing = {
  name: keyVaultName
  scope: resourceGroup(keyVaultResourceGroup)
}

// Use secret reference, never expose the value
var sqlPassword = keyVault.getSecret('sqlAdminPassword')
```

---

## 5. Audit, Logging & Monitoring

### Diagnostic Settings (Mandatory)
- **REQUIRED**: Enable diagnostic logs for ALL resources
- **REQUIRED**: Send logs to centralized Log Analytics Workspace
- **REQUIRED**: Retention minimum 7 years (OSFI requirement)

```bicep
resource diagnosticSettings 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: '${resourceName}-diagnostics'
  scope: resource
  properties: {
    workspaceId: logAnalyticsWorkspaceId
    logs: [
      {
        category: 'AuditEvent'
        enabled: true
        retentionPolicy: {
          enabled: true
          days: 2555 // 7 years
        }
      }
    ]
    metrics: [
      {
        category: 'AllMetrics'
        enabled: true
        retentionPolicy: {
          enabled: true
          days: 2555
        }
      }
    ]
  }
}
```

### Azure Policy & Compliance
- **REQUIRED**: Tag all resources with data classification
- **REQUIRED**: Tag resources with cost center, owner, environment

```bicep
resource resource 'Microsoft.Xxx/xxx@2023-01-01' = {
  tags: {
    'data-classification': 'confidential' // public, internal, confidential, restricted
    'environment': 'production' // dev, test, staging, production
    'cost-center': 'CC-12345'
    'owner': 'team@bank.ca'
    'compliance': 'OSFI-B13,PCI-DSS'
  }
}
```

---

## 6. Backup & Disaster Recovery

### Backup Requirements
- **MANDATORY**: Enable automated backups for all stateful services
- **REQUIRED**: Backup retention minimum 7 years for financial records
- **REQUIRED**: Cross-region backup replication (within Canada)

```bicep
resource sqlDatabase 'Microsoft.Sql/servers/databases@2023-05-01-preview' = {
  properties: {
    backupConfiguration: {
      backupRetentionDays: 35 // Short-term
      geoRedundantBackup: 'Enabled'
      longTermRetentionPolicy: {
        weeklyRetention: 'P12W'
        monthlyRetention: 'P12M'
        yearlyRetention: 'P7Y' // 7 years for compliance
        weekOfYear: 1
      }
    }
  }
}
```

### High Availability
- **REQUIRED**: Zone-redundant deployment for production workloads
- **REQUIRED**: Multi-region DR strategy (within Canadian regions)

---

## 7. Regulatory Compliance

### OSFI Guideline B-13 (Technology & Cyber Risk)
- Enable Azure Defender/Microsoft Defender for Cloud
- Implement vulnerability scanning
- Enable Just-In-Time (JIT) VM access
- Implement network segmentation

### PIPEDA (Privacy)
- Minimize data collection
- Enable data lifecycle management
- Implement data retention policies
- Support data deletion requests

### PCI-DSS (Payment Card Industry)
For modules handling payment data:
- Network isolation (dedicated VNets)
- Web Application Firewall (WAF)
- Enhanced monitoring and alerting
- Regular security scanning

---

## 8. Module-Specific Security Controls

### Storage Accounts
```bicep
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  properties: {
    // ✅ Security requirements
    supportsHttpsTrafficOnly: true
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: false // ❗ MANDATORY: Disable public blobs
    allowSharedKeyAccess: false // Prefer Azure AD authentication
    publicNetworkAccess: 'Disabled' // Use private endpoints
    networkAcls: {
      defaultAction: 'Deny'
      bypass: 'AzureServices'
    }
  }
}
```

### Azure SQL Database
```bicep
resource sqlServer 'Microsoft.Sql/servers@2023-05-01-preview' = {
  properties: {
    // ✅ Security requirements
    publicNetworkAccess: 'Disabled' // ❗ MANDATORY
    minimalTlsVersion: '1.2'
    administrators: {
      administratorType: 'ActiveDirectory'
      azureADOnlyAuthentication: true // ❗ MANDATORY: AAD only
    }
  }
}

resource database 'Microsoft.Sql/servers/databases@2023-05-01-preview' = {
  properties: {
    // ✅ Enable TDE with CMK
    transparentDataEncryption: {
      state: 'Enabled'
    }
  }
}

// Enable Advanced Threat Protection
resource securityAlertPolicy 'Microsoft.Sql/servers/securityAlertPolicies@2023-05-01-preview' = {
  properties: {
    state: 'Enabled'
    emailAccountAdmins: true
  }
}
```

### Azure Key Vault
```bicep
resource keyVault 'Microsoft.KeyVault/vaults@2023-02-01' = {
  properties: {
    // ✅ Security requirements
    enableRbacAuthorization: true // ❗ MANDATORY: Use RBAC over access policies
    enableSoftDelete: true // ❗ MANDATORY
    softDeleteRetentionInDays: 90
    enablePurgeProtection: true // ❗ MANDATORY
    publicNetworkAccess: 'Disabled'
    networkAcls: {
      defaultAction: 'Deny'
      bypass: 'AzureServices'
    }
  }
}
```

### Azure Kubernetes Service (AKS)
```bicep
resource aksCluster 'Microsoft.ContainerService/managedClusters@2023-10-01' = {
  properties: {
    // ✅ Security requirements
    enableRBAC: true // ❗ MANDATORY
    aadProfile: {
      managed: true
      enableAzureRBAC: true
    }
    networkProfile: {
      networkPolicy: 'azure' // or 'calico'
      serviceCidr: '10.0.0.0/16'
      dnsServiceIP: '10.0.0.10'
    }
    apiServerAccessProfile: {
      enablePrivateCluster: true // ❗ MANDATORY for production
    }
    securityProfile: {
      defender: {
        securityMonitoring: {
          enabled: true
        }
      }
    }
  }
}
```

---

## 9. Code Review Checklist

Before approving any Bicep module, verify:

- [ ] All resources deployed to Canadian regions only (`canadacentral`, `canadaeast`)
- [ ] Encryption at rest enabled (CMK preferred)
- [ ] TLS 1.2+ enforced, HTTPS-only
- [ ] Private Endpoints configured for sensitive data services
- [ ] Public network access disabled where possible
- [ ] Managed Identities used (no hardcoded credentials)
- [ ] Diagnostic logs enabled with 7-year retention
- [ ] Backup configured with appropriate retention
- [ ] Required tags present (data-classification, environment, cost-center, owner)
- [ ] NSGs applied with least-privilege rules
- [ ] No `0.0.0.0/0` firewall rules
- [ ] Azure AD authentication enforced
- [ ] Soft delete and purge protection enabled (Key Vault, Storage)
- [ ] Module tested with `bicep lint`
- [ ] Security scanning passed (if applicable)

---

## 10. Prohibited Configurations

The following configurations are **STRICTLY PROHIBITED**:

❌ **Non-Canadian regions** for data storage
❌ **Public blob access** on Storage Accounts
❌ **Allow all firewall rules** (`0.0.0.0-255.255.255.255`)
❌ **SQL authentication** (use Azure AD only)
❌ **Hardcoded secrets** in code or parameters
❌ **TLS 1.0 or 1.1**
❌ **Disabled encryption**
❌ **Missing diagnostic logs**
❌ **Shared access keys** for storage (use Azure AD)
❌ **Public endpoints** for Key Vault, SQL Database

---

## References

- [OSFI Guideline B-13 - Technology and Cyber Risk Management](https://www.osfi-bsif.gc.ca/en/guidance/guidance-library/guideline-b-13-technology-cyber-risk-management)
- [PIPEDA - Personal Information Protection and Electronic Documents Act](https://www.priv.gc.ca/en/privacy-topics/privacy-laws-in-canada/the-personal-information-protection-and-electronic-documents-act-pipeda/)
- [Azure Security Baseline for Financial Services](https://learn.microsoft.com/azure/compliance/offerings/offering-osfi-canada)
- [Azure Landing Zones for Canadian Customers](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/)
- [Microsoft Cloud for Financial Services](https://learn.microsoft.com/industry/financial-services/)

---

## Maintenance

This instruction file should be reviewed and updated:
- Quarterly or when regulatory requirements change
- When new Azure services are adopted
- When security incidents reveal gaps
- Following internal/external security audits
