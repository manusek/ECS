# 🌐 Python app image deployment to ECS


This `README.md` file provides instructions for managing the project's infrastructure using Terraform and GitHub Actions, covering deployment, monitoring, dashboard access, and error handling.

It includes remote state management via **S3 backend** and **DynamoDB** for state locking.

---
```
## 📁 Repository Structure
.
├── 01_backend.tf                        
├── 02_providers.tf                   
├── 03_versions.tf                    
├── 04_variables.tf
├── 05_outputs.tf
├── 06_main.tf
│
├── modules/
│   ├── alb/
│   │   ├── 01_main.tf                
│   │   ├── 02_variables.tf
│   │   └── 04_outputs.tf
│   │
│   ├── auto-scaling/
│   │   ├── 01_main.tf                
│   │   └── 02_variables.tf
|   |
│   ├── ecr/
│   │   ├── 01_main.tf                
│   │   └── 02_variables.tf
|   |
│   ├── ecs/
│   │   ├── 01_main.tf              
│   │   ├── 02_variables.tf
|   |   ├── 03_locals.tf
│   │   └── 04_outputs.tf
|   |
│   ├── network/
│   │   ├── 01_main.tf              
│   │   ├── 02_variables.tf
|   |   ├── 03_locals.tf
│   │   └── 04_outputs.tf
|   |
│   ├── roles/
│   │   ├── 01_main.tf              
│   │   ├── 02_variables.tf
│   │   └── 04_outputs.tf
|   |
│   └── sg/
│       ├── 01_main.tf
│       ├── 02_variables.tf
|       ├── 03_locals.tf
│       └── 04_outputs.tf
│
└── app/
    ├──  app.py              
    ├──  requirements.txt                   
    └──  Dockerfile

```
---

## 🚀 Deployment Steps

1️⃣ Initialize the project: 

  terraform init


2️⃣ Validate configuration:

  terraform validate


3️⃣ Preview the deployment plan

  terraform plan


4️⃣ Deploy the infrastructure

  terraform apply


8️⃣ Destroy the infrastructure (cleanup)

  terraform destroy


