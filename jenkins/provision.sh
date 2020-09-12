rpm -Uvh http://repos.mesosphere.com/el/7/noarch/RPMS/mesosphere-el-repo-7-3.noarch.rpm
curl -o /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key

yum update -y

yum install -y cyrus-sasl java-1.8.0-headless which bash
yum install -y mesos-1.0.4 
yum install -y jenkins
yum install -y fontconfig dejavu-sans-fonts

yum versionlock add jenkins mesos

yum clean all -y
