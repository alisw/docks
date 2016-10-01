#!/bin/bash -ex
[[ $MESOS_WORKQUEUE_VERSION ]]
# While curl requires only the Grid CA, Python requets requires the whole chain:
# we need to download the Root CA as well.
curl https://cafiles.cern.ch/cafiles/certificates/CERN%20Grid%20Certification%20Authority.crt > /etc/pki/ca-trust/source/anchors/CERN_Grid_CA.pem
curl https://cafiles.cern.ch/cafiles/certificates/CERN%20Root%20Certification%20Authority%202.crt > /etc/pki/ca-trust/source/anchors/CERN_Root_CA.pem
update-ca-trust enable && update-ca-trust
cd /
rm -rf /alisw && rm -rf /tmp/publish
mkdir /tmp/publish && cd /tmp/publish
git clone https://github.com/alisw/ali-bot
cat > publish.conf <<EOF
---
base_url: https://ali-ci.cern.ch/TARS
architectures:
  slc7_x86-64:
    dir: el7-x86_64
    include:
      mesos-workqueue:
       - ^${MESOS_WORKQUEUE_VERSION}$
auto_include_deps: True
http_ssl_verify: True
conn_timeout_s: 6.05
conn_retries: 6
conn_dethrottle_s: 0.3
package_dir: /alisw/%(arch)s/%(package)s/%(version)s
modulefile: /alisw/%(arch)s/modulefiles/%(package)s/%(version)s
EOF
ali-bot/publish/aliPublish --debug --conf publish.conf sync-dir
cd /
rm -rf /tmp/publish
cat > /usr/bin/mesos-workqueue-framework <<EOF
#!/bin/bash -e
export MODULEPATH=/alisw/el7-x86_64/modulefiles:\$MODULEPATH
eval "\$(modulecmd bash load mesos-workqueue/$MESOS_WORKQUEUE_VERSION)"
exec mesos-workqueue-framework "\$@"
EOF
chmod +x /usr/bin/mesos-workqueue-framework
# Test
export MODULEPATH=/alisw/el7-x86_64/modulefiles:$MODULEPATH
eval "$(modulecmd bash load mesos-workqueue/$MESOS_WORKQUEUE_VERSION)"
[[ $(which mesos-workqueue-framework) == /alisw/* ]]
