#!/bin/bash

# Create the root directory
mkdir terraform-repo

# Create the README.md file
touch terraform-repo/README.md

# Create the global directory
mkdir terraform-repo/global

# Create the variables.tf and outputs.tf files in the global directory
touch terraform-repo/global/variables.tf
touch terraform-repo/global/outputs.tf

# Create the modules directory
mkdir terraform-repo/modules

# Create the aws and gcp subdirectories in the modules directory
mkdir terraform-repo/modules/aws
mkdir terraform-repo/modules/gcp

# Create the compute and database subdirectories in the aws and gcp subdirectories
mkdir terraform-repo/modules/aws/compute
mkdir terraform-repo/modules/aws/database
mkdir terraform-repo/modules/gcp/compute
mkdir terraform-repo/modules/gcp/database

# Create the main.tf files in the compute and database subdirectories of the aws and gcp subdirectories
touch terraform-repo/modules/aws/compute/main.tf
touch terraform-repo/modules/aws/database/main.tf
touch terraform-repo/modules/gcp/compute/main.tf
touch terraform-repo/modules/gcp/database/main.tf

# Create the backend-config directory
mkdir terraform-repo/backend-config

# Create the aws-backend.tf file in the backend-config directory
touch terraform-repo/backend-config/aws-backend.tf

# Create the environments directory
mkdir terraform-repo/environments

# Create the staging and production subdirectories in the environments directory
mkdir terraform-repo/environments/staging
mkdir terraform-repo/environments/production

# Create the variables.tf, outputs.tf, company_a, and company_b directories and files in the staging and production subdirectories
touch terraform-repo/environments/staging/variables.tf
touch terraform-repo/environments/staging/outputs.tf
mkdir terraform-repo/environments/staging/company_a
mkdir terraform-repo/environments/staging/company_b
touch terraform-repo/environments/staging/company_a/aws/main.tf
touch terraform-repo/environments/staging/company_a/gcp/main.tf
touch terraform-repo/environments/staging/company_b/main.tf

touch terraform-repo/environments/production/variables.tf
touch terraform-repo/environments/production/outputs.tf
mkdir terraform-repo/environments/production/company_a
mkdir terraform-repo/environments/production/company_b
touch terraform-repo/environments/production/company_a/aws/main.tf
touch terraform-repo/environments/production/company_a/gcp/main.tf
touch terraform-repo/environments/production/company_b/main.tf

# Create the scripts directory
mkdir terraform-repo/scripts

# Create the deploy.sh file in the scripts directory
touch terraform-repo/scripts/deploy.sh

# Create the docker-compose.yml file
touch terraform-repo/docker-compose.yml

echo "Terraform file structure created successfully!"
