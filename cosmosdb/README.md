# To run the app locally you need to:

## 1. Run terraform infrastructure.



To execute the app locally, you only need to login in the Azure CLI and to run the powershell script

`az login`

`./deplot_local.ps1`

### Useful commands

- Login in azure CLI

`az login`

- To initialize terraform:

`terraform init`

 - To check the plan(see resources affected):

`terraform plan`

- To create the infrastructure:

`terraform apply`
- To destroy your infrastructure:

`terraform destroy`

