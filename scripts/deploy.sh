  # Initialize Terraform
  cd ../environments/production/company_a/gcp/

  terraform init -upgrade

  terraform validate
  # Run Terraform plan
  terraform plan -var-file="company_a.tfvars"
  terraform apply -var-file="company_a.tfvars"