FROM ubuntu:latest

RUN apt-get update && apt-get -y upgrade && apt-get -y install python-pip  ruby rubygems links wget curl bash zip unzip git jq gettext-base  && rm -rf /var/lib/apt/lists/* 
RUN  pip install yq
