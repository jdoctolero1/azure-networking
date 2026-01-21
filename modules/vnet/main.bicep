@description('Location for the VNET should be the same as the Resource Group location')
param location string

@description('TODO: Add lock configuration for the Virtual Network')
param lock object

@description('Virtual Network name. Format: vnet-{environment}-{location}')
param vnetName string

@description('Address prefixes for the Virtual Network')
param addressPrefixes array

@description('Subnets to create within the Virtual Network')
param subnets array

@description('Tags applied to the VNet')
param tags object

module virtualNetwork 'br/public:avm/res/network/virtual-network:0.1.0' = {
  params: {
    addressPrefixes: addressPrefixes
    name: vnetName
    location: location
    lock: lock
    subnets: subnets
    tags: tags
  }
}
