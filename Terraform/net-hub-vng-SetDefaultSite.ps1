$ResourceGroupName = "?Resource Group?"
$LocalNetworkGatewayName = "?LNG?"
$VNGGatewayName = "?VNG?"

$LocalGateway = Get-AzLocalNetworkGateway `
    -ResourceGroupName $ResourceGroupName `
    -Name $LocalNetworkGatewayName

$VirtualGateway = Get-AzVirtualNetworkGateway `
    -ResourceGroupName $ResourceGroupName `
    -Name $VNGGatewayName

Set-AzVirtualNetworkGatewayDefaultSite `
    -GatewayDefaultSite $LocalGateway `
    -VirtualNetworkGateway $VirtualGateway
