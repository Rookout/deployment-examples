clone_terraform_modules:
	git clone git@github.com:HENNGE/terraform-aws-ecs.git

patch_terraform:
	cp ./main.tf ./terraform-aws-ecs/examples/easy/fargate-alb
	cp ./dop_task_def.tpl ./terraform-aws-ecs/examples/easy/fargate-alb
	cp ./controller_task_def.tpl ./terraform-aws-ecs/examples/easy/fargate-alb

init_terraform:
	cd ./terraform-aws-ecs/examples/easy/fargate-alb; terraform init;

deploy_terraform:
	cd ./terraform-aws-ecs/examples/easy/fargate-alb; terraform apply

destroy_terraform:
	cd ./terraform-aws-ecs/examples/easy/fargate-alb; terraform destroy