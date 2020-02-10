# terraform-sample
Terraformの学習用リポジトリ。

## 参考
最初のステップはこのドキュメントを参考にした。
https://qiita.com/Chanmoro/items/55bf0da3aaf37dc26f73

## 実現したいこと
- VPC作成
  - VPC, subnet, gateway, peering
- EC2インスタンス作成
  - AZ選択、VPC選択、security groupの選択
  - autoscale group, loadbalancher, target group
- S3
- cloudfront
- route53
- RDB
- ElastCache

## 疑問
- 作成した後に、ドメインとかエンドポイントとか取れるのか？
- ファイルを分けて環境ごとに管理するとかどうするか？