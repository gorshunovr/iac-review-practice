import * as cdk from 'aws-cdk-lib';
import * as ec2 from 'aws-cdk-lib/aws-ec2';
import { Construct } from 'constructs';

export class SharedStack extends cdk.Stack {
  public readonly vpc: ec2.Vpc;

  constructor(scope: Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    this.vpc = new ec2.Vpc(this, 'Vpc', { availabilityZones: ['eu-west-2a', 'eu-west-2b', 'eu-west-2c'], natGateways: 3 });

    // Terraform now reads the VPC id from SSM, export no longer needed
    new cdk.aws_ssm.StringParameter(this, 'VpcIdParam', { parameterName: '/orders/vpc-id', stringValue: this.vpc.vpcId });
  }
}
