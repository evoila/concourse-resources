FROM ubuntu:xenial

RUN  apt update && apt upgrade -y && apt install -y curl wget vim sed build-essential coreutils git  \
     && curl https://golang.org/dl/ | grep -o  "https://.*linux-amd64.tar.gz" | head -n1 | xargs wget  \
     && tar -xvf go*  \
     && mv go /usr/local/  \
     && rm go*  \
     && echo '. ~/.profile' >> /etc/profile.d/home.sh \
     && echo 'export GOPATH=$HOME/go' >> ~/.profile  \
     && echo 'export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin' >> ~/.profile  \
     && . ~/.profile  \
     && mkdir -p ~/go/bin  \
     && curl https://glide.sh/get | sh  \
     && wget -qO - http://packages.confluent.io/deb/5.1/archive.key | apt-key add -  \
     && echo "deb [arch=amd64] http://packages.confluent.io/deb/5.1 stable main" >> /etc/apt/sources.list  \
     && apt update  \
     && apt install -y librdkafka-dev 

