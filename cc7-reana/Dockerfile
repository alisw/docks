FROM centos:centos7

# Install all required packages
RUN yum install -y http://linuxsoft.cern.ch/wlcg/centos7/x86_64/wlcg-repo-1.0.0-1.el7.noarch.rpm && \
    yum install -y HEP_OSlibs git environment-modules which                                      && \
    yum clean all                                                                                && \
    curl -o /tmp/get-pip.py https://bootstrap.pypa.io/get-pip.py                                 && \
    chmod +x /tmp/get-pip.py                                                                     && \
    /tmp/get-pip.py                                                                              && \
    rm -f /tmp/get-pip.py                                                                        && \
    pip install PyYAML requests                                                                  && \
    mkdir -p /opt/ali-bot                                                                        && \
    cd /opt/ali-bot                                                                              && \
    git clone https://github.com/alisw/ali-bot /opt/ali-bot

# CERN CA (for Python requests too)
RUN curl https://cafiles.cern.ch/cafiles/certificates/CERN%20Grid%20Certification%20Authority.crt > /etc/pki/ca-trust/source/anchors/CERN_Grid_CA.pem     && \
    curl https://cafiles.cern.ch/cafiles/certificates/CERN%20Root%20Certification%20Authority%202.crt > /etc/pki/ca-trust/source/anchors/CERN_Root_CA.pem && \
    update-ca-trust enable && update-ca-trust                                                                                                             && \
    ln -nfs /etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem /usr/lib/python2.7/site-packages/requests/cacert.pem

# Base publisher configuration, modulefile, entrypoint
COPY aliPublish.conf /opt/ali-bot/publish/aliPublish-reana.conf
COPY BASE.modulefile /cvmfs/alice.cern.ch/el5-x86_64/Modules/modulefiles/BASE/1.0
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# CVMFS-like directory structure
RUN chmod +x /usr/local/bin/entrypoint.sh                                                       && \
    mkdir -p /cvmfs/alice.cern.ch/bin                                                           && \
    cp /opt/ali-bot/cvmfs/alienv /cvmfs/alice.cern.ch/bin/alienv                                && \
    chmod +x /cvmfs/alice.cern.ch/bin/alienv                                                    && \
    mkdir -p /cvmfs/alice.cern.ch/etc/toolchain/modulefiles/el7-x86_64/Toolchain                && \
    ln -nfs /cvmfs/alice.cern.ch/el7-x86_64/Modules/modulefiles/GCC-Toolchain/v4.9.3-alice3-1      \
            /cvmfs/alice.cern.ch/etc/toolchain/modulefiles/el7-x86_64/Toolchain/GCC-v4.9.3      && \
    ln -nfs el5-x86_64                                                                             \
            /cvmfs/alice.cern.ch/x86_64-2.6-gnu-4.1.2

# Build parameter: override with --build-arg ALIPHYSICS_VERSION=...
ARG ALIPHYSICS_VERSION=vAN-20170521-1
ENV ALIPHYSICS_VERSION=${ALIPHYSICS_VERSION}

# Install everything (takes a while), and test -- fails if AliPhysics version is not found
RUN cd /opt/ali-bot/publish                                                                && \
    sed -i -e "s/@@ALIPHYSICS_VERSION@@/$ALIPHYSICS_VERSION/" aliPublish-reana.conf        && \
    ./aliPublish --debug --conf aliPublish-reana.conf sync-dir                             && \
    /cvmfs/alice.cern.ch/bin/alienv setenv AliPhysics/$ALIPHYSICS_VERSION -c which aliroot

# Container will be started with the correct environment loaded
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
CMD [ "/bin/bash" ]
