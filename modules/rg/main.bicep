targetScope = 'subscription'

param resourceGroupName string
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
