targetScope = 'subscription'

@description('Environment name (e.g., lab, dev, stg, prd)')
param environment string

param primaryLocation string
param drLocation string

@description('Primary Virtual Network name')
var primaryVnetName string = 'vnet-${environment}-${primaryLocation}'

@description('DR Virtual Network name')
var drVnetName string = 'vnet-${environment}-${drLocation}'

@description('Resource Group name for the Network resources')
var primaryRg string = 'rg-${environment}-network-${primaryLocation}'

@description('Resource Group name for the Network resources')
var drRG string = 'rg-${environment}-network-${drLocation}'

var primaryPeeringName string = 'peering-${drVnetName}'
var drPeeringName string = 'peering-${primaryVnetName}'

// Use 'existing' if they are already deployed, or define them as resources here
resource primaryVnet 'Microsoft.Network/virtualNetworks@2023-05-01' existing = {
  scope: resourceGroup(primaryRg)
  name: primaryVnetName
}

resource drVnet 'Microsoft.Network/virtualNetworks@2023-05-01' existing = {
  scope: resourceGroup(drRG)
  name: drVnetName
}

// 1. Peer Primary to DR
module primaryToDr '../modules/vnet-peering/main.bicep' = {
  name: primaryPeeringName
  scope: resourceGroup(primaryRg)
  params: {
    localVnetName: primaryVnet.name
    remoteVnetId: drVnet.id
    peeringName: primaryPeeringName
  }
}

// 2. Peer DR to Primary
module drToPrimary '../modules/vnet-peering/main.bicep' = {
  name: drPeeringName
  scope: resourceGroup(drRG)
  params: {
    localVnetName: drVnet.name
    remoteVnetId: primaryVnet.id
    peeringName: drPeeringName
  }
}
