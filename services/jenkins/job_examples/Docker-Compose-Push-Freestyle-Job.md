# Docker Compose Push Freestyle Job

A general outline of how to set up a Jenkins Freestyle job that utilizes Docker Compose to update containers after being triggered by a pushing to the `main` branch of a repository. The use case here is to have Jenkins build Docker images in a project stack if necessary, then recreate it.

## Required Plugins:

- [Generic Webhook Trigger Plugin](https://plugins.jenkins.io/generic-webhook-trigger/)
- [Timestamper](https://plugins.jenkins.io/timestamper/)

## General

- Check "Discard old builds" and leave all fields blank
- Check "GitHub project" and enter the url to the repository in the "Project url" field

## Source Code Management

- Select "Git"
  - Enter the url to the repository in the "Repository URL" field
  - Enter "\*/main" in the "Branch Specifier" field

## Build Triggers

- Generate a unique token for your job
  - This token will make sure your webhook only triggers the job with the same token in Jenkins
  - Just generate a random password or something - ensure there are no &'s in the token

### Create the Webhook (in GitHub)

- Navigate to the repository in GitHub
- Go to Settings > Webhooks
- Click "Add webhook" to begin configuration
  - Payload URL: <JENKINS_URL>/generic-webhook-trigger/invoke?token=<TOKEN>
  - Content type: application/json
  - Enable SSL verification
  - Select "Just the push event"
  - Check "Active"

### Configure the Build Trigger (in Jenkins)

- Check "Generic Webhook Trigger"
- Add "Post content parameters" - select "JSONPath" for both

| Variable | Expression |
| -------- | ---------- |
| branch   | $.ref      |

- Enter the generated token from above in the "Token" field
- Fill in the "Cause" field to describe the action that is triggering the job
- Check "Print contributed variables"
- Configure "Optional filter"
  - Expression: ^refs/heads/main$
  - Text: $branch

## Build Environment

- Check "Add timestamps to the Console Output"

## Build

- Add a build step of type "Execute shell" and paste the following

```bash
rm -f .env
cat <<EOT >> .env

# add any environment variable declarations here
VARIABLE=value

EOT

docker-compose pull
docker-compose --env-file .env up -d --force-recreate --build
docker image prune --force
```
