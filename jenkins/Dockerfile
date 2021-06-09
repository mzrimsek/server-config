FROM jenkins/jenkins:lts

ARG HOST_UID
ARG HOST_GID

USER root
# install dependencies
RUN apt-get -y update && \
  apt-get -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
# install docker
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
  add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable" && \
  apt-get update && \
  apt-get -y install docker-ce docker-ce-cli containerd.io
# install docker compose
RUN curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
  chmod +x /usr/local/bin/docker-compose && \
  ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
# install kubectl
RUN sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg && \
  echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list && \
  sudo apt-get update && \
  sudo apt-get install -y kubectl

RUN usermod -u $HOST_UID jenkins
RUN groupmod -g $HOST_GID docker
RUN usermod -aG docker jenkins

USER jenkins