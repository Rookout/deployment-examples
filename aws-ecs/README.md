# Install Rookout's controller & data-on-prem on AWS ECS cluster

Checkout the relevant terraform modules:
```
make clone_terraform_modules
```

Modify the following files :
- [dop_task_def.tpl](dop_task_def.tpl) : data-on-prem task definition settings
  * ROOKOUT_DOP_LOGGING_TOKEN env var required
- [controller_task_def.tpl](./controller_task_def.tpl) - controller task definition settings
  * ROOKOUT_TOKEN env var required

Deploy the changes at your AWS account by running
```
make patch_terraform init_terraform deploy_terraform
```

You should see the controller & data-on-prem DNS at the end of the deployment.



