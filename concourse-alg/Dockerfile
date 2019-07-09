FROM ubuntu:latest

RUN apt-get update && apt-get -y upgrade && apt-get -y install python-pip  bsdtar ruby rubygems links wget curl bash zip unzip git jq gettext-base  && rm -rf /var/lib/apt/lists/* 
RUN cd /usr/bin && curl -L -s https://www.vaultproject.io/downloads.html | grep "https://.*linux_amd64.zip" -o | xargs curl -L | bsdtar -xvf- && chmod ugo+x vault
RUN  pip install yq
