FROM alpine:latest
RUN apk --no-cache add wget curl jq bash
RUN curl --silent "https://api.github.com/repos/etcd-io/etcd/releases/latest" | jq -r '.assets[] | select(.name | contains("linux-amd64")).browser_download_url' | xargs curl -L | tar -xvz && cp etcd*/etcd* /bin/ && rm -rf  etcd*
ADD asserts/ /opt/resource/
RUN chmod +x /opt/resource/*
