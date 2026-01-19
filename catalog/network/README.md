# Network Modules

Azure Verified Modules for networking infrastructure in the Microsoft Foundry landing zone.

## Available Modules

| Module | AVM Reference | Version | Description |
|--------|--------------|---------|-------------|
| [Virtual Network](virtual-network.bicep) | `avm/res/network/virtual-network` | 0.4.0 | Hub and spoke virtual networks |
| [Network Security Group](network-security-group.bicep) | `avm/res/network/network-security-group` | 0.4.0 | Network security groups |
| [Private Endpoint](private-endpoint.bicep) | `avm/res/network/private-endpoint` | 0.7.0 | Private endpoints for secure connectivity |
| [Private DNS Zone](private-dns-zone.bicep) | `avm/res/network/private-dns-zone` | 0.6.0 | Private DNS zones for private link |
| [Azure Firewall](azure-firewall.bicep) | `avm/res/network/azure-firewall` | 0.5.0 | Azure Firewall for network security |
| [Azure Bastion](bastion-host.bicep) | `avm/res/network/bastion-host` | 0.3.0 | Azure Bastion for secure RDP/SSH |
| [VPN Gateway](vpn-gateway.bicep) | `avm/res/network/vpn-gateway` | 0.2.0 | VPN Gateway for hybrid connectivity |
| [DDoS Protection](ddos-protection-plan.bicep) | `avm/res/network/ddos-protection-plan` | 0.3.0 | DDoS protection plan |
| [DNS Resolver](dns-resolver.bicep) | `avm/res/network/dns-resolver` | 0.3.0 | Azure DNS Private Resolver |

## Usage Example

```bicep
module vnet './virtual-network.bicep' = {
  name: 'spoke-vnet'
  params: {
    name: 'vnet-spoke-foundry-eastus2'
    location: 'eastus2'
    addressPrefixes: ['10.1.0.0/16']
    subnets: [
      {
        name: 'snet-app'
        addressPrefix: '10.1.0.0/24'
      }
      {
        name: 'snet-pe'
        addressPrefix: '10.1.1.0/24'
      }
    ]
    tags: {
      environment: 'production'
      workload: 'foundry'
    }
  }
}
```
