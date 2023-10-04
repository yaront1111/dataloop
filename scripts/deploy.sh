  # Initialize Terraform
  cd ../environments/production/company_a/gcp/
  terraform init

  terraform validate
  # Run Terraform plan
  terraform plan -var-file="company_a.tfvars" -lock=false
  terraform apply -var-file="company_a.tfvars" -lock=false -parallelism=1