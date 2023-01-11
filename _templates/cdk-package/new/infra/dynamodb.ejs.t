---
to: packages/<%= packageName %>/infra/dynamodb.ts
---
import * as cdk from "aws-cdk-lib";
import * as dynamodb from "aws-cdk-lib/aws-dynamodb";
import * as CuckooConstructs from "@cuckoointernet/cuckoo-constructs";

export class ExampleTable extends CuckooConstructs.dynamodb.Table {
  constructor(stack: cdk.Stack) {
    super(stack, ExampleTable.name, {
      billingMode: dynamodb.BillingMode.PAY_PER_REQUEST,
      partitionKey: {
        name: "id",
        type: dynamodb.AttributeType.STRING,
      },
    });
  }
}
