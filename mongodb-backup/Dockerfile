FROM ubuntu:latest



RUN apt-get update && apt-get -y upgrade && DEBIAN_FRONTEND=noninteractive apt-get -y install wget libgssapi-krb5-2 && rm -rf /var/lib/apt/lists/* 
RUN mkdir /tmp/bin && cd /tmp/bin && wget  https://fastdl.mongodb.org/tools/db/mongodb-database-tools-ubuntu2004-x86_64-100.5.2.tgz && tar -xf mongo*.tgz && cp mongo*/bin/* /usr/local/bin \
    && wget https://dl.min.io/client/mc/release/linux-amd64/mc && mv mc /usr/local/bin && chmod ugo+x /usr/local/bin/mc \
    && rm -rf /tmp/bin

RUN useradd -ms /bin/bash noroot
USER noroot
WORKDIR /home/noroot
