FROM alpine:latest
RUN apk --no-cache add wget curl jq bash coreutils
#RUN curl --silent "https://api.github.com/repos/etcd-io/etcd/releases/latest" | jq -r '.assets[] | select(.name | contains("linux-amd64")).browser_download_url' | xargs curl -L | tar -xvz && cp etcd*/etcd* /bin/ && rm -rf  etcd*
RUN curl -L  https://github.com/etcd-io/etcd/releases/download/v3.3.15/etcd-v3.3.15-linux-amd64.tar.gz | tar -xvz && cp etcd*/etcd* /bin/ && rm -rf  etcd*
ADD asserts/ /opt/resource/
RUN chmod +x /opt/resource/*
