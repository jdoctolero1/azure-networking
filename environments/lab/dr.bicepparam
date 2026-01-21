using '../../infra/main.bicep'

var firstOctet = 11
param environment = 'lab'
param addressPrefix = ['${firstOctet}.0.0.0/16']
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
    addressPrefix: '${firstOctet}.0.1.0/27'
  }
  {
    name: gatewaySubnet
    addressPrefix: '${firstOctet}.0.2.0/27'
  }
  {
    name: azureFirewallSubnet
    addressPrefix: '${firstOctet}.0.3.0/24'
  }
  {
    name: azureFirewallManagementSubnet
    addressPrefix: '${firstOctet}.0.4.0/24'
  }
  {
    name: adminSubnet
    addressPrefix: '${firstOctet}.0.10.0/24'
  }
  {
    name: appSubnet
    addressPrefix: '${firstOctet}.0.20.0/24'
  }
  {
    name: dataSubnet
    addressPrefix: '${firstOctet}.0.30.0/24'
  }
  {
    name: privateLinkSubnet
    addressPrefix: '${firstOctet}.0.40.0/24'
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
