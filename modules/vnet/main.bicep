@description('Location for the VNET should be the same as the Resource Group location')
param location string
// param lock object
param vnetName string
param addressPrefixes array
param subnets array
@description('Tags applied to the Resource Group')
param tags object

module virtualNetwork 'br/public:avm/res/network/virtual-network:0.1.0' = {
  params: {
    addressPrefixes: addressPrefixes
    name: vnetName
    location: location
    // lock: lock
    subnets: subnets
    tags: tags
  }
}
