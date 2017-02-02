DEVMODE=dev

mesos-base: $(wildcard mesos-base/*)
	packer build -var 'DOCKER_HUB_REPO=alisw$(DEVMODE)' mesos-base/packer.json

mesos-slave: $(wildcard mesos-slave/*) mesos-base
	packer build -var 'DOCKER_HUB_REPO=alisw$(DEVMODE)' mesos-slave/packer.json

mesos-master: $(wildcard mesos-master/*) mesos-base
	packer build -var 'DOCKER_HUB_REPO=alisw$(DEVMODE)' mesos-slave/packer.json

aurora-scheduler: $(wildcard aurora-scheduler/*) mesos-base
	packer build -var 'DOCKER_HUB_REPO=alisw$(DEVMODE)' aurora-scheduler/packer.json

aurora-executor: $(wildcard aurora-executor/*) mesos-base
	packer build -var 'DOCKER_HUB_REPO=alisw$(DEVMODE)' aurora-executor/packer.json

marathon: $(wildcard marathon/*) mesos-base
	packer build -var 'DOCKER_HUB_REPO=alisw$(DEVMODE)' marathon/packer.json

.PHONY: mesos-base mesos-slave mesos-master aurora-executor aurora-scheduler marathon
