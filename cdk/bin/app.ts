#!/usr/bin/env node
import * as cdk from 'aws-cdk-lib';
import { SharedStack } from '../lib/shared-stack';
import { DataStack } from '../lib/data-stack';
import { DbStack } from '../lib/db-stack';
import { ApiStack } from '../lib/api-stack';

const app = new cdk.App();
const env = { account: process.env.CDK_DEFAULT_ACCOUNT, region: 'eu-west-2' };

const shared = new SharedStack(app, 'OrdersShared', { env });
const data = new DataStack(app, 'OrdersData', { env });
const db = new DbStack(app, 'OrdersDb', { env, vpc: shared.vpc });
new ApiStack(app, 'OrdersApi', { env, table: data.ordersTable, dbCluster: db.cluster });

cdk.Tags.of(app).add('project', 'orders');
cdk.Tags.of(app).add('owner', 'platform');
