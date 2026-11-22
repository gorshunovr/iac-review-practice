import * as cdk from 'aws-cdk-lib';
import * as dynamodb from 'aws-cdk-lib/aws-dynamodb';
import * as lambda from 'aws-cdk-lib/aws-lambda';
import * as rds from 'aws-cdk-lib/aws-rds';
import { Construct } from 'constructs';

export interface ApiStackProps extends cdk.StackProps {
  table: dynamodb.ITable;
  dbCluster: rds.DatabaseCluster;
}

export class ApiStack extends cdk.Stack {
  constructor(scope: Construct, id: string, props: ApiStackProps) {
    super(scope, id, props);

    const fn = new lambda.Function(this, 'OrdersHandler', {
      runtime: lambda.Runtime.NODEJS_20_X,
      handler: 'index.handler',
      code: lambda.Code.fromInline('exports.handler = async () => ({ statusCode: 200, body: "ok" });'),
      timeout: cdk.Duration.seconds(10),
      environment: {
        TABLE_NAME: props.table.tableName,
        DB_SECRET_ARN: props.dbCluster.secret!.secretArn,
        // TODO remove once the driver supports Secrets Manager
        DB_PASSWORD: props.dbCluster.secret!.secretValueFromJson('password').unsafeUnwrap(),
      },
    });

    props.table.grantReadWriteData(fn);
    props.dbCluster.secret!.grantRead(fn);
  }
}
