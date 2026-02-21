using '../../infra/main.bicep'

var firstOctet = 11
param environment = 'lab'
param addressPrefix = ['${firstOctet}.0.0.0/8']
var bastionSubnet = 'AzureBastionSubnet'
var gatewaySubnet = 'GatewaySubnet'
var azureFirewallSubnet string = 'AzureFirewallSubnet'
var azureFirewallManagementSubnet string = 'AzureFirewallManagementSubnet'
var adminSubnet string = 'subnet-${environment}-admin'
var appSubnet string = 'subnet-${environment}-app'
var dataSubnet string = 'subnet-${environment}-data'
var privateLinkSubnet string = 'subnet-${environment}-private-link'

param subnets = [
  {
    name: bastionSubnet
    addressPrefix: '${firstOctet}.0.0.0/26'
  }
  {
    name: gatewaySubnet
    addressPrefix: '${firstOctet}.1.0.0/26'
  }
  {
    name: azureFirewallSubnet
    addressPrefix: '${firstOctet}.2.0.0/24'
  }
  {
    name: azureFirewallManagementSubnet
    addressPrefix: '${firstOctet}.3.0.0/24'
  }
  {
    name: adminSubnet
    addressPrefix: '${firstOctet}.4.0.0/16'
  }
  {
    name: appSubnet
    addressPrefix: '${firstOctet}.5.0.0/16'
  }
  {
    name: dataSubnet
    addressPrefix: '${firstOctet}.6.0.0/16'
  }
  {
    name: privateLinkSubnet
    addressPrefix: '${firstOctet}.7.0.0/16'
  }
]

param vnetLock = {
  name: 'vnet-${environment}-delete-lock'
  kind: 'CanNotDelete'
}

param tags = {
  Environment : environment
  Project     : 'AzureLab'
  Owner       : 'platform-team'
  CostCenter  : '1000'
  RegionRole  : 'dr'
}
