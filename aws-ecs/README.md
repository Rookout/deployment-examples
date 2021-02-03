# Install Rookout's controller & data-on-prem on ECS cluster

Checkout the relevant terraform modules:
```
make clone_terraform_modules
```

Modify the following files if required
- main.tf 
- dop_task_def.tpl : data-on-prem task definition settings
- controller_task_def.tpl : controller task definition settings

Deploy the changes at your AWS account by running
```
make patch_terraform init_terraform deploy_terraform
```

You should see the Controller & data-on-prem DNS at the end of the deployment



