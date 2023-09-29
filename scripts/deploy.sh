  # Initialize Terraform
  cd ../environments/production/company_a/gcp/
  terraform init
  # Run Terraform plan
  terraform plan -var-file="company_a.tfvars"