- VPC
- 複数のpublic/private Subnetを作成
- NAT Gateway用のEIP
- Internet Gateway, NAT Gatewayを作成
- RouteTableをpublic/private用に作成
- Public SubnetにApplicationLBを配置
- 指定されたAMIで起動するLaunchConfigurations
- AutoScalingGroup作成
- TargetGroup作成