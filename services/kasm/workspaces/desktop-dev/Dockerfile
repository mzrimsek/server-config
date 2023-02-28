FROM kasmweb/desktop:1.12.0-rolling
USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########


# VS Code
RUN set -ex && \
  ARCH=$(arch | sed 's/aarch64/arm64/g' | sed 's/x86_64/x64/g') && \
  wget -q https://update.code.visualstudio.com/latest/linux-deb-${ARCH}/stable -O vs_code.deb && \
  apt-get update && \
  apt-get install -y ./vs_code.deb && \
  mkdir -p /usr/share/icons/hicolor/apps && \
  wget -O /usr/share/icons/hicolor/apps/vscode.svg https://kasm-static-content.s3.amazonaws.com/icons/vscode.svg && \
  sed -i '/Icon=/c\Icon=/usr/share/icons/hicolor/apps/vscode.svg' /usr/share/applications/code.desktop && \
  sed -i 's#/usr/share/code/code#/usr/share/code/code --no-sandbox##' /usr/share/applications/code.desktop && \
  cp /usr/share/applications/code.desktop $HOME/Desktop && \
  chmod +x $HOME/Desktop/code.desktop && \
  chown 1000:1000 $HOME/Desktop/code.desktop && \
  rm vs_code.deb

# git
RUN apt update && \
  apt install -y git

# Node JS
RUN curl -sL https://deb.nodesource.com/setup_19.x | bash - && \
  apt-get install -y nodejs

# Go Lang
RUN apt update && \
  apt upgrade -y && \
  apt search golang-go && \
  apt search gccgo-go && \
  apt install -y golang-go

# Dotnet
RUN wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
  dpkg -i packages-microsoft-prod.deb && \
  rm packages-microsoft-prod.deb

RUN apt-get update && \
  apt-get install -y dotnet-sdk-6.0

# Python
RUN apt-get update && \
  apt-get install -y python3-setuptools \
  python3-venv \
  python3-virtualenv


######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000