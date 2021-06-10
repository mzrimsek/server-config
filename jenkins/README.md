# Jenkins

A great tool for building pipelines. This setup differs from the others in that it has a local Dockerfile to build the image on the host rather than pulling from a registry. This is to facilitate not only allowing Jenkins to run Docker commands, but also to give it the permissions it needs to allow that to happen. 

Essentially to allow Jenkins to use Docker or Docker Compose commands in pipelines, the container needs those installed. Then the user that Jenkins runs under also needs to be made part of the `docker` group, then those ids need to be passed into the Dockerfile when building the image so the container uses the same user and group as the host machine.

[Reference](https://itnext.io/docker-inside-docker-for-jenkins-d906b7b5f527)

Steps to prep `jenkins` user (all commands run on host machine):

1. Create user: `sudo useradd jenkins`
2. Add user to docker group: `sudo usermod -aG docker jenkins`
3. Restart docker service: `sudo service docker restart`

* Data: Must have a directory to persist data, mounted as a volume to `/var/jenkins_home`
  * The `jenkins` user must have permissions to this volume - `sudo chown -R $(id -u jenkins)`

* Environment variables: A `.env` file is required with the necessary environment variables filled in for the `start_.jenkins` script to operate correctly.
  * Grab the host jenkins user id: `id -u jenkins`
  * Grab the host docker group id: `getent group | grep docker`