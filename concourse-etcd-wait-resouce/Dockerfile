FROM bitnami/etcd:latest

ENV ALLOW_NONE_AUTHENTICATION=yes
RUN echo  "#!/bin/bash\nRES=\"/opt/resource\"\nexport RES\nexport PATH=\"$PATH:/opt/resource\"" >> ~/.bashrc
ADD asserts/ /opt/resource/
RUN chmod +x /opt/resource/*
