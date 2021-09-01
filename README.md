# ALICE Docker images

- *OS*-builder: the OS images used e.g. in CI, when building for the given OS
  (e.g. slc7 for CentOS 7)
- mesos-base: basic mesos installation.
- mesos-slave: a self contained Mesos Slave instance
- mesos-master: a self contained Mesos Master instance
- elasticsearch: a customized elasticsearch instance with HEAD and Marvel plugins
  installed.

## Building images with packer

Newer images have a `packer.json` file, which allows them to be built using
Hashicorp [packer](https://www.packer.io). This has the nice advantage that we
can customize and upload the images in one go. To build them:

```bash
brew install packer # > 0.10.0
cd <image-name>
packer build packer.json
```

If you don't want to upload the finished image to DockerHub (e.g. if you're just
testing changes to the image, or you don't have the rights to upload), remove
the `"docker-push"` entry from `"post-processors"` in the `packer.json` you're
using. (JSON doesn't allow trailing commas in arrays, so don't forget to remove
the comma as well!)

## Building with docker

Older images without a `packer.json` can be built with:

```bash
docker build -t alisw/<image-name> <image-name>
```
