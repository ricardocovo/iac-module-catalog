# Network Modules

Azure Verified Modules for networking infrastructure in the Microsoft Foundry landing zone.

## Available Modules

| Module | AVM Reference | Versions | Description |
|--------|--------------|----------|-------------|
| [Virtual Network](virtual-network/) | `avm/res/network/virtual-network` | [0.6.0](virtual-network/0.6.0/) \| [0.6.1](virtual-network/0.6.1/) \| [0.7.0](virtual-network/0.7.0/) \| [0.7.1](virtual-network/0.7.1/) \| [0.7.2](virtual-network/0.7.2/) | Hub and spoke virtual networks |
| [Network Security Group](network-security-group/) | `avm/res/network/network-security-group` | [0.3.1](network-security-group/0.3.1/) \| [0.4.0](network-security-group/0.4.0/) \| [0.5.0](network-security-group/0.5.0/) \| [0.5.1](network-security-group/0.5.1/) \| [0.5.2](network-security-group/0.5.2/) | Network security groups |
| [Private Endpoint](private-endpoint/) | `avm/res/network/private-endpoint` | [0.9.1](private-endpoint/0.9.1/) \| [0.10.0](private-endpoint/0.10.0/) \| [0.10.1](private-endpoint/0.10.1/) \| [0.11.0](private-endpoint/0.11.0/) \| [0.11.1](private-endpoint/0.11.1/) | Private endpoints for secure connectivity |
| [Private DNS Zone](private-dns-zone/) | `avm/res/network/private-dns-zone` | [0.5.0](private-dns-zone/0.5.0/) \| [0.6.0](private-dns-zone/0.6.0/) \| [0.7.0](private-dns-zone/0.7.0/) \| [0.7.1](private-dns-zone/0.7.1/) \| [0.8.0](private-dns-zone/0.8.0/) | Private DNS zones for private link |
| [Azure Firewall](azure-firewall/) | `avm/res/network/azure-firewall` | [0.8.0](azure-firewall/0.8.0/) \| [0.8.1](azure-firewall/0.8.1/) \| [0.9.0](azure-firewall/0.9.0/) \| [0.9.1](azure-firewall/0.9.1/) \| [0.9.2](azure-firewall/0.9.2/) | Azure Firewall for network security |
| [Azure Bastion](bastion-host/) | `avm/res/network/bastion-host` | [0.6.1](bastion-host/0.6.1/) \| [0.7.0](bastion-host/0.7.0/) \| [0.8.0](bastion-host/0.8.0/) \| [0.8.1](bastion-host/0.8.1/) \| [0.8.2](bastion-host/0.8.2/) | Azure Bastion for secure RDP/SSH |
| [VPN Gateway](vpn-gateway/) | `avm/res/network/vpn-gateway` | [0.1.6](vpn-gateway/0.1.6/) \| [0.1.7](vpn-gateway/0.1.7/) \| [0.2.0](vpn-gateway/0.2.0/) \| [0.2.1](vpn-gateway/0.2.1/) \| [0.2.2](vpn-gateway/0.2.2/) | VPN Gateway for hybrid connectivity |
| [DDoS Protection](ddos-protection-plan/) | `avm/res/network/ddos-protection-plan` | [0.1.4](ddos-protection-plan/0.1.4/) \| [0.2.0](ddos-protection-plan/0.2.0/) \| [0.3.0](ddos-protection-plan/0.3.0/) \| [0.3.1](ddos-protection-plan/0.3.1/) \| [0.3.2](ddos-protection-plan/0.3.2/) | DDoS protection plan |
| [DNS Resolver](dns-resolver/) | `avm/res/network/dns-resolver` | [0.5.2](dns-resolver/0.5.2/) \| [0.5.3](dns-resolver/0.5.3/) \| [0.5.4](dns-resolver/0.5.4/) \| [0.5.5](dns-resolver/0.5.5/) \| [0.5.6](dns-resolver/0.5.6/) | Azure DNS Private Resolver |

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
