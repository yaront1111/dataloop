  # Initialize Terraform
  cd ../environments/production/

  terraform init

  terraform validate
  # Run Terraform plan
  terraform plan -var-file="company_a.tfvars"