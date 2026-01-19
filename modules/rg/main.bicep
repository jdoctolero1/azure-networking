targetScope = 'subscription'

@description('Name of the Resource Group to create')
param resourceGroupName string

@description('Tags applied to the Resource Group')
param tags object

module resourceGroup 'br/public:avm/res/resources/resource-group:0.4.3' = {
  params: {
    name: resourceGroupName
    lock: {
      kind: 'CanNotDelete'
      name: '${resourceGroupName}-delete-lock'
    }
    tags: tags
  }
}
