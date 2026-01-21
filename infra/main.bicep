targetScope = 'subscription'

@description('Region Location for all resources within this deployment')
var location string = deployment().location

@description('Resource Group name for the Network resources')
var resourceGroupName string = 'rg-${environment}-network-${location}'

@description('Virtual Network name')
var vnetName string = 'vnet-${environment}-${location}'

@description('Environment name (e.g., lab, dev, stg, prd)')
param environment string

@description('Address prefixes for the Virtual Network')
param addressPrefix array

@description('Subnets to create within the Virtual Network')
param subnets array

@description('Lock object to apply to the Virtual Network (optional)')
param vnetLock object = {}

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
    lock: vnetLock
    subnets: subnets
    tags: tags
  }
}
