import * as cdk from 'aws-cdk-lib';
import * as ec2 from 'aws-cdk-lib/aws-ec2';
import { Construct } from 'constructs';

export class SharedStack extends cdk.Stack {
  public readonly vpc: ec2.Vpc;

  constructor(scope: Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    this.vpc = new ec2.Vpc(this, 'Vpc', { availabilityZones: ['eu-west-2a', 'eu-west-2b'], natGateways: 1 });

    // Consumed by the legacy reporting stack (deployed from another repo) via Fn::ImportValue
    new cdk.CfnOutput(this, 'VpcIdExport', { value: this.vpc.vpcId, exportName: 'orders-vpc-id' });
  }
}
