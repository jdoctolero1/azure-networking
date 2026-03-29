using '../../infra/main.bicep'

param environment = 'lab'
param addressPrefix = ['10.191.240.0/20']
var bastionSubnet = 'AzureBastionSubnet'
var gatewaySubnet = 'GatewaySubnet'
var azureFirewallSubnet string = 'AzureFirewallSubnet'
var azureFirewallManagementSubnet string = 'AzureFirewallManagementSubnet'
var adminSubnet string = 'subnet-${environment}-admin'
var appGatewaySubnet string = 'subnet-${environment}-app-gateway'
var webSubnet string = 'subnet-${environment}-web'
var appSubnet string = 'subnet-${environment}-app'
var dataSubnet string = 'subnet-${environment}-data'
var privateLinkSubnet string = 'subnet-${environment}-private-link'

param subnets = [
  {
    name: bastionSubnet
    addressPrefix: '10.191.241.0/26'
  }
  {
    name: gatewaySubnet
    addressPrefix: '10.191.242.0/26'
  }
  {
    name: azureFirewallSubnet
    addressPrefix: '10.191.243.0/26'
  }
  {
    name: azureFirewallManagementSubnet
    addressPrefix: '10.191.244.0/26'
  }
  {
    name: adminSubnet
    addressPrefix: '10.191.245.0/24'
  }
  {
    name: appGatewaySubnet
    addressPrefix: '10.191.246.0/24'
  }
  {
    name: webSubnet
    addressPrefix: '10.191.247.0/24'
  }
  {
    name: appSubnet
    addressPrefix: '10.191.248.0/24'
  }
  {
    name: dataSubnet
    addressPrefix: '10.191.249.0/24'
  }
  {
    name: privateLinkSubnet
    addressPrefix: '10.191.250.0/24'
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
