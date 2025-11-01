# Terraform EKS E-Commerce Project (Template)
This repository contains a modular Terraform template to provision an AWS EKS-based
3-tier architecture (Presentation, Application, Data) for an 11-microservice e-commerce app.

## Structure
- `modules/` - Reusable Terraform modules (vpc, eks, ecr, rds, redis, s3, alb, opensearch, iam, cloudfront)
- `environments/` - env-specific variables and backend configs (dev/staging/prod)
- Root `main.tf`, `variables.tf`, `providers.tf`, `backend.tf`

## Quick start (dev)
1. Edit `environments/dev/terraform.tfvars` with desired values.
2. From `terraform/`:
   ```bash
   cd terraform
   terraform init -backend-config=environments/dev/backend.tfvars
   terraform plan -var-file=environments/dev/terraform.tfvars
   terraform apply -var-file=environments/dev/terraform.tfvars
   ```
3. After EKS is ready, configure kubeconfig:
   ```bash
   aws eks update-kubeconfig --name <cluster-name> --region ap-south-1
   ```

> This template is a starting point. Review and harden IAM policies, security groups,
> and parameter values before using in production.


## GitHub Actions CI/CD
 - Workflow: `.github/workflows/deploy.yml` (runs on push to `main`).
 - Secrets required: `AWS_ROLE_TO_ASSUME` (or use AWS keys), and proper AWS permissions.
 - Dockerfiles for each microservice should be placed under `services/<service-name>/Dockerfile`.


## Node.js Example Services
 - Example Node.js apps and Dockerfiles are available under `services/<service>/`.
 - They are minimal Express apps for quick testing and builds.

## Production Helm values
 - Each chart has a `values-production.yaml` with replica counts, resources, and HPA placeholders.

## GitHub Actions updates
 - Workflow now supports AWS access keys (`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`) or role assumption (`AWS_ROLE_TO_ASSUME`).
 - Docker images are tagged with the Git SHA (`${{ github.sha }}`) for reproducible deployments.

## 🚀 End-to-End Deployment Runbook (One-command checklist)

Prerequisites:
- AWS CLI configured with permissions for EKS, ECR, RDS, S3, CloudFront, IAM
- Docker installed (if building locally)
- kubectl and helm installed
- helmfile (optional) installed for bulk Helm operations

### 1) Provision infrastructure (Terraform)
```bash
cd terraform/environments/dev
terraform init -backend-config=backend.tfvars
terraform apply -auto-approve -var-file=terraform.tfvars
```

### 2) Configure kubeconfig
```bash
aws eks update-kubeconfig --region <region> --name <cluster-name>
```

### 3) Build & push Docker images (automated via GitHub Actions on push to main)
Manually:
```bash
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
REG=${ACCOUNT_ID}.dkr.ecr.<region>.amazonaws.com
for svc in auth-service product-service cart-service order-service payment-service inventory-service review-service shipping-service notification-service analytics-service api-gateway; do
  docker build -t $REG/$svc:latest -f services/$svc/Dockerfile services/$svc
  docker push $REG/$svc:latest
done
```

### 4) Deploy all Helm charts with helmfile
```bash
# from project root
helmfile -e dev apply
# or
helmfile apply
```

### 5) Verify
```bash
kubectl get ns
kubectl get pods -n ecommerce
kubectl get svc -n ecommerce
kubectl describe ingress -n ecommerce
```

### Notes
- Replace placeholders like `<region>`, `<cluster-name>`, and `<ACCOUNT_ID>` before running commands.
- Helm `values-production.yaml` files exist per-chart for production tuning.
- GitHub Actions workflow will run Terraform and Helm automatically on push to `main` if configured with appropriate secrets.
