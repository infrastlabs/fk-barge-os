BARGE_VERSION  := 2.12.0
DOCKER_CHANNEL := stable
#18.09.3 19.03.15 17.12.1-ce
# v2.9.0-x: 18.03.1-ce
DOCKER_VERSION := 17.12.1-ce

ISO_NAME := barge-x.iso

EXTERNAL_DEPENDENCIES := bzImage rootfs.tar.xz isolinux.cfg docker.tgz docker.bash-completion

iso: $(ISO_NAME)

$(ISO_NAME): Dockerfile docker $(EXTERNAL_DEPENDENCIES)
	docker build -t barge-x .
	docker run --rm barge-x > $@

bzImage rootfs.tar.xz:
	# curl -L https://ghproxy.com/https://github.com/bargees/barge-os/releases/download/$(BARGE_VERSION)/$(@F) -o $@
	docker pull registry.cn-shenzhen.aliyuncs.com/infrastlabs/barge-build-output:latest
	docker  run -it --rm -v $(shell pwd):/mnt registry.cn-shenzhen.aliyuncs.com/infrastlabs/barge-build-output:latest sh -c "\cp -a /output/$(@F) /mnt/"

isolinux.cfg:
	curl -L https://ghproxy.com/https://raw.githubusercontent.com/bargees/barge-os/$(BARGE_VERSION)/configs/$(@F) -o $@

docker.tgz:
	curl -L https://download.docker.com/linux/static/$(DOCKER_CHANNEL)/x86_64/docker-$(DOCKER_VERSION).tgz -o $@

docker.bash-completion:
	curl -L https://ghproxy.com/https://raw.githubusercontent.com/docker/docker-ce/v$(DOCKER_VERSION)/components/cli/contrib/completion/bash/docker -o $@

clean:
	$(RM) $(EXTERNAL_DEPENDENCIES)

distclean: clean
	$(RM) $(ISO_NAME)

.PHONY: clean distclean
