# about

we have isolated configuration of development environment terraform configuration for following resources,

* KMS
* IAM role
* Lambda Function
* Cloudwatch Rule

# usage

simply to modify individual configurations login to that specific folder (such as cloudwatch, iam, lambda) and run

  ```
  make init
  make plan
  make apply
  make destroy
  ```

if you want to apply or destroy everything from the root then simply use

  ```
  make apply
  make destroy
  ```  
