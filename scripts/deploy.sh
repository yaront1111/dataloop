  # Initialize Terraform
  cd ../environments/production/company_a/gcp/
  terraform init
  # Run Terraform plan
  terraform plan -var-file="../environments/production/company_a/gcp/company_a.tfvars"