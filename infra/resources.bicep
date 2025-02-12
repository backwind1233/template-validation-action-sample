@description('The location used for all deployed resources')
param location string = resourceGroup().location

@description('Tags that will be applied to all resources')
param tags object = {}

resource aks 'Microsoft.ContainerService/managedClusters@2024-02-01' = {
  name: 'aks-helloworld-aex1b'
  location: location
  tags: tags
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    dnsPrefix: 'dnsPrefix'
    agentPoolProfiles: [
      {
        name: 'agentpool'
        osDiskSizeGB: 0
        enableAutoScaling: true
        minCount: 1
        maxCount: 3
        count: 1
        vmSize: 'Standard_DS2_v2'
        osType: 'Linux'
        mode: 'System'
      }
    ]
    networkProfile: {
          loadBalancerSku: 'standard'
          networkPlugin: 'kubenet'
        }
  }
}

output AZURE_AKS_CLUSTER_NAME string = aks.name
