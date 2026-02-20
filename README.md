# Terraform Security Pipeline - QuantumTrade Engagement

![Security Pipeline](https://img.shields.io/badge/Security-Pipeline-green)
![Checkov](https://img.shields.io/badge/Checkov-Passing-brightgreen)
![tfsec](https://img.shields.io/badge/tfsec-Passing-brightgreen)
![OPA](https://img.shields.io/badge/OPA-Passing-brightgreen)

## Project Overview

This repository demonstrates enterprise-grade Infrastructure as Code security for **QuantumTrade**, a fintech startup processing $10M+ in daily cryptocurrency transactions. The project implements Policy as Code using multiple scanning tools to achieve SOC 2 compliance.

### Business Context
- **Client:** QuantumTrade (Cryptocurrency Trading Platform)
- **Challenge:** S3 data exposure incident, SOC 2 compliance deadline
- **Solution:** Automated IaC security scanning in CI/CD

## Security Tools Implemented

| Tool | Purpose | Checks |
|------|---------|--------|
| **Checkov** | CIS Benchmark scanning | 2,500+ policies |
| **tfsec** | AWS security best practices | AWS-specific rules |
| **OPA** | Custom business policies | Tagging, naming, architecture |

## Architecture

```
Developer PR --> GitHub Actions --> Security Scans --> Merge
                       |
                       ├── Checkov (CIS Benchmarks)
                       ├── tfsec (AWS Security)
                       ├── OPA (Custom Policies)
                       └── Terraform Validate
```

## Key Deliverables

1. **Secure Terraform Modules**
   - S3 with encryption, versioning, access logging
   - EC2 with IMDSv2, encrypted volumes, private subnets
   - VPC with flow logs and restricted security groups

2. **Custom OPA Policies**
   - Required tagging enforcement
   - Production instance type restrictions
   - S3 versioning requirements

3. **CI/CD Integration**
   - Automated scanning on every PR
   - SARIF reports in GitHub Security tab
   - Blocking deploys for CRITICAL/HIGH findings

4. **Compliance Documentation**
   - SOC 2 control mapping
   - Security assessment report template
   - Evidence collection procedures

## Getting Started

```bash
# Clone the repository
git clone https://github.com/YOUR_USERNAME/terraform-security-project.git

# Install scanning tools
pip install checkov
brew install tfsec opa

# Run local scans
checkov -d terraform/
tfsec terraform/
```

## Skills Demonstrated

- **Infrastructure as Code:** Terraform modules and state management
- **Security Scanning:** Checkov, tfsec, OPA policy evaluation
- **Policy as Code:** Custom Rego policies for business rules
- **CI/CD Security:** GitHub Actions with security gates
- **Compliance:** SOC 2 control mapping and evidence

## About This Project

Built as part of the **Cyber Agoge DevSecOps Bootcamp** - training the next generation of security engineers.

---
*This project demonstrates security scanning in a controlled environment. All "vulnerabilities" are intentional for educational purposes.*
EOF
