FROM ubuntu:15.04

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF                                           && \
    echo "deb http://repos.mesosphere.io/ubuntu vivid main" | tee /etc/apt/sources.list.d/mesosphere.list  && \
    apt-get update -y && apt-get install -y mesos=0.25.0-0.2.70.ubuntu1504 openjdk-8-jre unzip

ADD https://releases.hashicorp.com/vault/0.5.0/vault_0.5.0_linux_amd64.zip vault.zip

RUN unzip vault.zip && mv ./vault /usr/bin/vault
