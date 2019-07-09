FROM ubuntu:latest

RUN apt-get update && apt-get -y upgrade && apt-get -y install python-pip  bsdtar ruby rubygems links wget curl bash zip unzip git jq gettext-base  && rm -rf /var/lib/apt/lists/* 
RUN cd /usr/bin && curl https://releases.hashicorp.com/vault/ | grep -o "vault/\([0-9]\.\?\)\+/" | sort -r | head -n1 |  xargs -I{} bash -c 'curl https://releases.hashicorp.com/$1' -- {} | grep -o "/vault/.*/[a-zA-Z0-9_.]*linux_amd64.zip" | xargs -I{} bash -c 'curl -o - https://releases.hashicorp.com$1' -- {}  | bsdtar -xvf- && chmod ugo+x vault
RUN  pip install yq
