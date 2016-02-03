ln -s /opt/alisw/el7 /opt/alisw/slc7_x86-64
export CMAKE_VERSION=none
export DEFAULTS_RELEASE_VERSION=none
export AUTOTOOLS_VERSION=none
WORK_DIR=/opt/alisw source /opt/alisw/*/mesos-workqueue/*/etc/profile.d/init.sh

mesos-workqueue-framework --volume /cvmfs:/cvmfs                          \
                          --volume /secrets/eos-proxy:/secrets/eos-proxy  \
                          --volume /build/workarea/wq:/tmp
