FROM maven:3.6.1-jdk-12

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
	apt-utils xmlstarlet jq python python-yaml\
    && rm -rf /var/lib/apt/lists/*
RUN echo  "#!/bin/bash\nRES=\"/opt/resource\"\nexport RES\nexport PATH=\"$PATH:/opt/resource\"" >> ~/.bashrc
#RUN unlink  $JAVA_HOME/jre/lib/security/cacerts && \
    cp /etc/ssl/certs/java/cacerts $JAVA_HOME/jre/lib/security/cacerts
RUN mkdir -p /root/.m2
ADD asserts/ /opt/resource/
RUN chmod +x /opt/resource/*
