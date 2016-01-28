FROM alisw/slc7-builder

ADD https://releases.hashicorp.com/vault/0.4.1/vault_0.4.1_linux_amd64.zip /vault.zip
ADD run.sh /run.sh
RUN unzip /vault.zip && ls

CMD /bin/sh -e -x /run.sh
