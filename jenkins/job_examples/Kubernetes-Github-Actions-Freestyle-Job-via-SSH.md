# Kubernetes Github Actions Freestyle Job via SSH

A general outline of how to set up a Jenkins Freestyle job that utilizes Kubernetes to update containers after being triggered by a Github Actions build completing successfully. The use case here is to have GitHub Actions build a Docker image and push it to a registry, which Jenkins then pulls to recreate the project stack with.

The assumption is the repository that is used in the Jenkins job has at least one GitHub Actions workflow associated with it that will run based on some defined trigger.

The deployment should likely have the image pull policy on any containers that have their image updates set to "Always". Initial deployments are manual. All subsequent deploys should trigger a rolling update to the deployment.

Another thing worth noting is I first attempted to get the kubectl context working with a remote k3s instance and was unsuccessful. Automating the process of SSHing into a master node and running the command seems to work well enough.

## Required Plugins:

* [Generic Webhook Trigger Plugin](https://plugins.jenkins.io/generic-webhook-trigger/)
* [Timestamper](https://plugins.jenkins.io/timestamper/)

### Prereqs to Job

1. Add SSH credentials for the remote host
  * Manage Jenkins > Manage Credentials > Add Credentials > Username with password OR SSH Username with private key
2. Configure the SSH Remote Host
  * Manage Jenkins > Configure System > SSH remote hosts > Add info for the remote host using the credentials set up in the previous step

## General

* Check "Discard old builds" and leave all fields blank
* Check "GitHub project" and enter the url to the repository in the "Project url" field

## Source Code Management

* Select "Git"
  * Enter the url to the repository in the "Repository URL" field
  * Enter "*/main" in the "Branch Specifier" field

## Build Triggers

* Generate a unique token for your job
  * This token will make sure your webhook only triggers the job with the same token in Jenkins
  * Just generate a random password or something - ensure there are no &'s in the token

### Create the Webhook (in GitHub)

* Navigate to the repository in GitHub
* Go to Settings > Webhooks
* Click "Add webhook" to begin configuration
  * Payload URL: <JENKINS_URL>/generic-webhook-trigger/invoke?token=<TOKEN>
  * Content type: application/json
  * Enable SSL verification
  * Select individual events - Check only "Check suites"
  * Check "Active"

### Configure the Build Trigger (in Jenkins)

* Check "Generic Webhook Trigger"
* Add "Post content parameters" - select "JSONPath" for both

| Variable   | Expression               |
| ---------- | ------------------------ |
| status     | $.check_suite.status     |
| conclusion | $.check_suite.conclusion |

* Enter the generated token from above in the "Token" field
* Fill in the "Cause" field to describe the action that is triggering the job
* Check "Print contributed variables"
* Configure "Optional filter"
  * Expression: ^completed success$
  * Text: $status $conclusion

## Build Environment

* Check "Add timestamps to the Console Output"

## Build
* Add a build step of type "Execute shell script on remote host using ssh", select your remote SSH host, and paste the following

``` bash
kubectl rollout restart deployment/<deployment_name>
```

* Check "Execute each line"
