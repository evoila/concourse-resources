FROM ubuntu:latest

RUN apt-get update && apt-get -y upgrade && apt-get -y install python-pip  bsdtar ruby rubygems links wget curl bash zip unzip git jq gettext-base  && rm -rf /var/lib/apt/lists/* 
RUN cd /usr/bin && curl -L -s https://www.vaultproject.io/downloads.html | grep "https://.*amd64.zip" -o | xargs curl -L | bsdtar -xvf- && chmod ugo+x vault && curl --silent "https://api.github.com/repos/cloudfoundry/bosh-cli/releases/latest" | grep -o "https://.*download/.*linux-amd64" | xargs  wget  -O ./bosh && chmod ugo+x bosh
RUN  pip install yq
