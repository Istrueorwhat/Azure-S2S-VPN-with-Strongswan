# Declare variables
  $RG = "strongSwan"
  $VMname = "WebServer"
  $Location = "North Europe"
  $VNetName  = "WEB-vnet"
  $FESubName = "default"
  $VNetPrefix1 = "172.16.0.0/16"
  $FESubPrefix = "172.16.0.0/24"

# Create a virtual network
$virtualNetwork = New-AzVirtualNetwork `
  -ResourceGroupName $RG `
  -Location $Location `
  -Name $VNetName `
  -AddressPrefix $VNetPrefix1
# Create a subnet configuration
$subnetConfig = Add-AzVirtualNetworkSubnetConfig `
  -Name $FESubName `
  -AddressPrefix $FESubPrefix `
  -VirtualNetwork $virtualNetwork
# Set the subnet configuration for the virtual network
$virtualNetwork | Set-AzVirtualNetwork
#Create VM
New-AzVm `
    -ResourceGroupName $RG `
    -Name $VMname `
    -Location $Location `
    -VirtualNetworkName $VNetName `
    -SubnetName $FESubName `
    -SecurityGroupName 'myNetworkSecurityGroup' `
    -PublicIpAddressName 'myPublicIpAddress' `
    -OpenPorts 80,3389
