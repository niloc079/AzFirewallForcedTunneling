$ResourceGroupName = "cl1hubnet-rg"
$LocalNetworkGatewayName = "cl1hubnet-lng"
$VNGGatewayName = "cl1hubnet-vng"

$LocalGateway = Get-AzLocalNetworkGateway -ResourceGroupName $ResourceGroupName -Name $LocalNetworkGatewayName
$VirtualGateway = Get-AzVirtualNetworkGateway -ResourceGroupName $ResourceGroupName -Name $VNGGatewayName
Set-AzVirtualNetworkGatewayDefaultSite -GatewayDefaultSite $LocalGateway -VirtualNetworkGateway $VirtualGateway
