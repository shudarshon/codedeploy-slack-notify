# about

this repository contains lambda python script to get executed from codedeploy events and inform slack channel accordingly. slack channel and token (without https://) is stored as environment variables in the function and encrypted with kms. Lambda informs slack only when the deployment status is either SUCCESS or FAILURE or STOP.

# tools and services used

* codebuild
* lambda
* python
* kms
* cloudwatch
* slack

# pre-requirement

you need to declare three environment variables to make the lambda function to work.

* **kmsEncryptedHookUrl** is the encrypted url of slack channel token without (copy the url without https://)! This value is encrypted with KMS
* **slackChannel** is the slack channel where we want to send notification (i.e. #devops)
* **organization** is the organization name that will be shown in the message footer

# example

Following snippet is the JSON object used in notifying slack from Lambda function

```
    attachments_json = [{
      "color": "#1E90FF",
      "fields": [{
        "short": 0,
        "value": "myApplication",
        "title": "Application"
      }, {
        "short": 0,
        "value": "SUCCESS",
        "title": "State"
      }],
      "footer": u"\u00A9 Organization",        
      "title": "CodeDeploy Status Information"
    }]
```

![Alt text](images/success.png?raw=true)
![Alt text](images/stop.png?raw=true)
![Alt text](images/fail.png?raw=true)