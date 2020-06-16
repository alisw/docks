rpmdb --rebuilddb
yum clean all
yum install -y deltarpm
yum install -y http://mirror.switch.ch/ftp/mirror/epel/epel-release-latest-7.noarch.rpm
yum update -y
yum groupinstall -y 'Development Tools'
yum install -y environment-modules                              \
               python-requests python-pip rubygems ruby-devel   \
               java-1.7.0-openjdk                               \
               perl-devel bzip2-devel perl-ExtUtils-Embed       \
               bison-devel flex-devel which                     \
               cmake texinfo freetype-devel libxml2-devel       \
               libXext-devel libXpm-devel libXft-devel          \
               mesa-libGLU-devel ncurses-devel                  \
               openssl-devel libXcursor-devel libXi-devel       \
               libXinerama-devel libXrandr-devel
yum clean -y all
pip install pyyaml
gem install --no-ri --no-rdoc fpm
curl -L https://releases.hashicorp.com/vault/0.5.0/vault_0.5.0_linux_amd64.zip -o vault.zip
unzip vault.zip && mv ./vault /usr/bin/vault && rm -f vault.zip
