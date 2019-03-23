init:
	make -C kms/ init
	make -C iam/ init
	make -C lambda/ init

apply-kms:
	make -C kms/ apply
	sleep 5

apply-iam:
	make -C iam/ apply
	sleep 5

apply-lambda:
	make -C lambda/ apply
	sleep 5

apply:
	make apply-kms
	make apply-iam
	make apply-lambda

destroy-lambda:
	make -C lambda/ destroy
	sleep 5

destroy-iam:
	make -C iam/ destroy
	sleep 5

destroy-kms:
	make -C kms/ destroy
	sleep 5

destroy:	
	make destroy-lambda
	make destroy-iam
	make destroy-kms
