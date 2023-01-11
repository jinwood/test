---
inject: true
to: package.json
after: devDependencies
skip_if: \@aws-cdk/aws-appsync-alpha
---
    "@aws-cdk/aws-appsync-alpha": "2.40.0-alpha.0",