FROM alisw/slc6-builder:latest

RUN curl -L http://cvmrepo.web.cern.ch/cvmrepo/yum/RPM-GPG-KEY-CernVM > /etc/pki/rpm-gpg/RPM-GPG-KEY-CernVM && \
    curl -L http://cvmrepo.web.cern.ch/cvmrepo/yum/cernvm.repo > /etc/yum.repos.d/cernvm.repo && \
    rpm --rebuilddb && yum install -y cvmfs

ENV PARROT_ALLOW_SWITCHING_CVMFS_REPOSITORIES=yes \
    PARROT_CVMFS_REPO=<default-repositories>\ alice-ocdb.cern.ch:url=http://cvmfs-stratum-one.cern.ch/cvmfs/alice-ocdb.cern.ch,pubkey=/etc/cvmfs/keys/cern.ch/cern-it1.cern.ch.pub \
    HTTP_PROXY=DIRECT;
ENTRYPOINT [ "parrot_run" ]
CMD [ "bash" ]
