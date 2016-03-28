# Docker images description

- mesos-base: basic mesos installation.
- mesos-slave: a self contained Mesos Slave instance
- mesos-master: a self contained Mesos Master instance
- elasticsearch: a customized elasticsearch instance with HEAD and Marvel plugins
  installed.

# Building with docker

Usually you want to build images with:

    docker build -t alisw/<image-name> <image-name>

# Building images with packer

Some of the images now have a packer.json file which allows them to
be built using hashicorp [packer](www.packer.io). This has the nice
advantage that we can customize and upload the images in one go.
To build them:

    brew install packer # > 0.10.0
    packer build <image-name>/packer.json
