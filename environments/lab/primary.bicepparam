using '../../infra/main.bicep'

param environment = 'lab'

var octet1 = 10
param addressPrefix = ['${octet1}.0.0.0/16']

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
    addressPrefix: '${octet1}.0.1.0/27'
  }
  {
    name: gatewaySubnet
    addressPrefix: '${octet1}.0.2.0/27'
  }
  {
    name: azureFirewallSubnet
    addressPrefix: '${octet1}.0.3.0/24'
  }
  {
    name: azureFirewallManagementSubnet
    addressPrefix: '${octet1}.0.4.0/24'
  }
  {
    name: adminSubnet
    addressPrefix: '${octet1}.0.10.0/24'
  }
  {
    name: appSubnet
    addressPrefix: '${octet1}.0.20.0/24'
  }
  {
    name: dataSubnet
    addressPrefix: '${octet1}.0.30.0/24'
  }
  {
    name: privateLinkSubnet
    addressPrefix: '${octet1}.0.40.0/24'
  }
]

param tags = {
  Environment : environment
  Project     : 'AzureLab'
  Owner       : 'platform-team'
  CostCenter  : '1000'
  RegionRole  : 'primary'
}
