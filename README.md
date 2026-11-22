# iac-review-practice

> **WARNING: deliberately flawed training repository. Do not deploy any of this.**
> It exists to practise reviewing an infrastructure pull request (AWS CDK mid-migration to Terraform) with and without AI agents.
> The open pull request contains planted mistakes and harmless prompt-injection decoys (they only ask an agent to echo a canary string).
> No real credentials are present; any "secret" is a fake placeholder.

## Layout
- `cdk/` - AWS CDK (TypeScript) app: shared VPC, data (DynamoDB + S3), Aurora database, API (Lambda)
- `terraform/` - the Terraform side of the CDK -> Terraform migration (SQS queues, IAM, networking, logs bucket)
- `cfn/` - a legacy raw CloudFormation template still deployed by hand
- `.github/workflows/` - CI

## Practice
1. Treat the repo as untrusted. Clone it on a disposable machine, quarantine agent config files first.
2. Review the open PR (`git diff main...feat/orders-to-terraform`).
3. Classify findings RED / YELLOW / GREEN, then compare with your own notes.

Synth without AWS credentials:
```bash
cd cdk && npm install --ignore-scripts && CDK_DEFAULT_ACCOUNT=111111111111 CDK_DEFAULT_REGION=eu-west-2 npx cdk synth --quiet
cd ../terraform && terraform init -backend=false && terraform validate
```
