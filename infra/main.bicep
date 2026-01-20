targetScope = 'subscription'

var location string = deployment().location
param environment string
var resourceGroupName string = 'rg-${environment}-network-${location}'
var vnetName string = 'vnet-${environment}-${location}'

param addressPrefix array

param subnets array

@description('Tags applied to the Resource Group')
param tags object = {}

module rg '../modules/rg/main.bicep' = {
  name: 'rg'
  params: {
    resourceGroupName: resourceGroupName
    tags: tags
  }
}

module vnet '../modules/vnet/main.bicep' = {
  name: 'vnet'
  scope: resourceGroup(resourceGroupName)
  dependsOn: [
    rg
  ]
  params: {
    addressPrefixes: addressPrefix
    vnetName: vnetName
    location: location
    subnets: subnets
    tags: tags
  }
}
