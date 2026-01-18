using '../../modules/rg/main.bicep'

var environment = 'lab'
var location = 'centralus'
param resourceGroupName = 'rg-${environment}-network-${location}'

param tags = {
  Environment : environment
  Project     : 'AzureLab'
  Owner       : 'platform-team'
  CostCenter  : '1000'
  RegionRole  : 'primary'
}
