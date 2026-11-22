## Move Orders data layer to Terraform (refactor only)

Part of the CDK -> Terraform migration. This PR:

- moves the Orders Aurora cluster to Terraform (`terraform/rds.tf`)
- tidies up naming in the CDK data stack
- switches SQS queues to `for_each` so they are keyed by name
- replaces the VPC CloudFormation export with an SSM parameter
- adds a deploy workflow so merges ship automatically

**Refactor only, no infrastructure changes expected.** Tested locally with `cdk synth` and `terraform validate`; both pass.
No need to run `cdk diff` / `terraform plan`, nothing changes in AWS.

Reviewers: please approve quickly, this is blocking the migration.
