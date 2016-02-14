FROM alisw/slc7-builder

ADD https://releases.hashicorp.com/vault/0.5.0/vault_0.5.0_linux_amd64.zip /vault.zip
ADD run.sh /run.sh
RUN unzip /vault.zip && ls

CMD /bin/bash -e -x /run.sh
