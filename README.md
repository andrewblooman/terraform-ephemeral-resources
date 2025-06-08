# terraform-ephemeral-resources

This project demonstrates how to use Terraform to manage ephemeral secrets in both **AWS Secrets Manager** and **HashiCorp Vault**. It provides examples for securely generating, storing, and retrieving secrets for use in cloud infrastructure.

## Features

- **AWS Secrets Manager**: Generate random passwords and store them as secrets for use in AWS resources (e.g., RDS).
- **HashiCorp Vault**: Store and retrieve secrets using Vault's KV v2 engine and use them in Vault-managed database connections.
- **Ephemeral Resources**: Use custom `ephemeral` blocks to manage temporary or one-time-use secrets.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- AWS credentials configured (for AWS resources)
- Running Vault server (for Vault resources)

## Usage

### 1. Clone the repository

```sh
git clone https://github.com/yourusername/terraform-ephemeral-resources.git
cd terraform-ephemeral-resources
```

### 2. Initialize Terraform

```sh
terraform init
```

### 3. Review and apply the configuration

```sh
terraform plan
terraform apply
```

## AWS Secrets Manager Example

Defined in [`aws_secrets_manager.tf`](aws_secrets_manager.tf):

- Generates a random password using an ephemeral resource.
- Stores the password in AWS Secrets Manager.
- Uses the secret in an example RDS instance.

**Key Resources:**
- `ephemeral "random_password" "db_password"`
- `aws_secretsmanager_secret` and `aws_secretsmanager_secret_version`
- `aws_db_instance` using the generated secret

## Vault Example

Defined in [`vault.tf`](vault.tf):

- Mounts a KV v2 secrets engine.
- Stores a root password as a secret.
- Retrieves the secret using an ephemeral resource.
- Uses the secret in a Vault database connection.

**Key Resources:**
- `vault_mount` and `vault_kv_secret_v2`
- `ephemeral "vault_kvv2_secret" "db_secret"`
- `vault_database_secret_backend_connection` using the secret

## Providers

Providers are configured in [`providers.tf`](providers.tf):

- AWS provider (region: `eu-west-1`)
- Vault provider

## Security

- `.gitignore` excludes sensitive files such as `.tfvars` and state files.
- Secrets are generated and managed securely using ephemeral resources.

## License

MIT License. See [`LICENSE`](LICENSE) for details.

---

**Note:**  
Replace placeholder values and customize the configuration as needed for your environment.