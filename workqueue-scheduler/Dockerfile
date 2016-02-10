FROM alisw/slc7-builder

ADD https://cafiles.cern.ch/cafiles/certificates/CERN%20Grid%20Certification%20Authority.crt  /etc/pki/ca-trust/source/anchors/CERN_Grid_CA.pem
RUN update-ca-trust enable && update-ca-trust
ADD alisw-el7.repo /etc/yum.repos.d/alisw-el7.repo
RUN echo "diskspacecheck=0" >> /etc/yum.conf && yum install -y alisw-mesos-workqueue+0.0.2-45f7f853d2-1.x86_64 && yum clean all
ADD run.sh /run.sh

CMD /bin/sh -e -x /run.sh
