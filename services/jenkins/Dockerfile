FROM jenkins/jenkins:lts

ARG HOST_UID
ARG HOST_GID

USER root

# install docker
RUN curl -fsSL https://get.docker.com | sh

RUN usermod -u $HOST_UID jenkins
# RUN groupmod -g $HOST_GID docker
RUN usermod -aG docker jenkins

USER jenkins