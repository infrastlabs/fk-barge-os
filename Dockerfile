# FROM ailispaw/ubuntu-essential:16.04-nodoc

# ENV TERM=xterm \
#     SYSLINUX_SITE=https://mirrors.edge.kernel.org/ubuntu/pool/main/s/syslinux \
#     SYSLINUX_VERSION=4.05+dfsg-6+deb8u1

# RUN domain="mirrors.aliyun.com" \
#  && echo "deb http://$domain/ubuntu xenial main restricted universe multiverse" > /etc/apt/sources.list \
#  && echo "deb http://$domain/ubuntu xenial-security main restricted universe multiverse" >> /etc/apt/sources.list \
#  && echo "deb http://$domain/ubuntu xenial-updates main restricted universe multiverse">> /etc/apt/sources.list \
#  && echo "deb http://$domain/ubuntu xenial-backports main restricted universe multiverse">> /etc/apt/sources.list


# RUN apt-get -q update && \
#     apt-get -q -y install --no-install-recommends ca-certificates \
#       bc build-essential cpio file git python unzip rsync wget curl \
#       syslinux syslinux-common isolinux xorriso dosfstools mtools && \
#     wget -q "${SYSLINUX_SITE}/syslinux-common_${SYSLINUX_VERSION}_all.deb" && \
#     wget -q "${SYSLINUX_SITE}/syslinux_${SYSLINUX_VERSION}_amd64.deb" && \
#     dpkg -i "syslinux-common_${SYSLINUX_VERSION}_all.deb" && \
#     dpkg -i "syslinux_${SYSLINUX_VERSION}_amd64.deb" && \
#     rm -f "syslinux-common_${SYSLINUX_VERSION}_all.deb" && \
#     rm -f "syslinux_${SYSLINUX_VERSION}_amd64.deb" && \
#     apt-get clean && rm -rf /var/cache/apt/* /var/lib/apt/lists/* /var/cache/debconf/* /var/log/*
FROM registry.cn-shenzhen.aliyuncs.com/infrastlabs/barge-build-output:latest as brdata
FROM registry.cn-shenzhen.aliyuncs.com/infrastlabs/barge-build-compiler-ubt1604:latest

# Setup environment
ENV SRC_DIR=/build \
    OVERLAY=/overlay \
    BR_ROOT=/build/buildroot
RUN mkdir -p ${SRC_DIR} ${OVERLAY}

# ENV BR_VERSION 2019.08
# ERROR: The certificate of 'buildroot.org' has expired.
# RUN wget -qO- https://buildroot.org/downloads/buildroot-${BR_VERSION}.tar.bz2 | tar xj && \
#     mv buildroot-${BR_VERSION} ${BR_ROOT}
# RUN curl -O -fSL -k  https://buildroot.org/downloads/buildroot-${BR_VERSION}.tar.bz2
# RUN tar -jxf buildroot-${BR_VERSION}.tar.bz2; \
#     mv buildroot-${BR_VERSION} ${BR_ROOT}
ENV BR_VERSION 2024.02.10
#  https://buildroot.org/downloads/buildroot-2024.02.10.tar.xz
#  https://buildroot.org/downloads/buildroot-2024.02.10.tar.gz  ##bz2: last @buildroot-2021.11-rc3.tar.bz2
#   buildroot-2024.02.tar.gz	2024-Mar-05 14:52:59	7.0M	application/x-gtar-compressed
#   buildroot-2024.02.tar.xz	2024-Mar-05 14:53:08	5.2M	application/x-xz
#   buildroot-2024.02.10.tar.gz	2025-Jan-09 14:45:56	7.1M	application/x-gtar-compressed
#   buildroot-2024.11.1.tar.xz	2025-Jan-09 15:53:07	5.4M	application/x-xz
RUN curl -O -fSL -k  https://buildroot.org/downloads/buildroot-${BR_VERSION}.tar.gz
RUN tar -zxf buildroot-${BR_VERSION}.tar.gz; \
    mv buildroot-${BR_VERSION} ${BR_ROOT}

# # Apply patches
# COPY patches ${SRC_DIR}/patches
# RUN for patch in ${SRC_DIR}/patches/*.patch; do \
#       patch -p1 -d ${BR_ROOT} < ${patch}; \
#     done

# Setup overlay
COPY overlay ${OVERLAY}
WORKDIR ${OVERLAY}

# Add ca-certificates
RUN mkdir -p etc/ssl/certs && \
    cp /etc/ssl/certs/ca-certificates.crt etc/ssl/certs/

# Add bash-completion
RUN mkdir -p usr/share/bash-completion/completions && \
    #wget -qO usr/share/bash-completion/bash_completion https://raw.githubusercontent.com/scop/bash-completion/master/bash_completion && \
    wget -qO usr/share/bash-completion/bash_completion https://gitee.com/g-system/fk-barge-os/releases/download/master-2019-08/bash_completion && \
    chmod +x usr/share/bash-completion/bash_completion

# Add Docker bash-completion
ENV DOCKER_VERSION 1.10.3
RUN \
  #wget -qO usr/share/bash-completion/completions/docker https://raw.githubusercontent.com/moby/moby/v${DOCKER_VERSION}/contrib/completion/bash/docker
  wget -qO usr/share/bash-completion/completions/docker https://gitee.com/g-system/fk-barge-os/releases/download/master-2019-08/completion_docker_v1.10.3

# Add dumb-init
ENV DINIT_VERSION 1.2.2
RUN mkdir -p usr/bin && \
    # wget -qO usr/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v${DINIT_VERSION}/dumb-init_${DINIT_VERSION}_amd64 && \
    wget -qO usr/bin/dumb-init https://gitee.com/g-system/fk-barge-os/releases/download/master-2019-08/dumb-init_1.2.2_amd64 && \
    chmod +x usr/bin/dumb-init

ENV VERSION 2.14.0-rc2
RUN mkdir -p etc && \
    echo "Welcome to Barge ${VERSION}, Docker version ${DOCKER_VERSION}" > etc/motd && \
    echo "NAME=\"Barge\"" > etc/os-release && \
    echo "VERSION=${VERSION}" >> etc/os-release && \
    echo "ID=barge" >> etc/os-release && \
    echo "ID_LIKE=busybox" >> etc/os-release && \
    echo "VERSION_ID=${VERSION}" >> etc/os-release && \
    echo "PRETTY_NAME=\"Barge ${VERSION}\"" >> etc/os-release && \
    echo "HOME_URL=\"https://github.com/bargees/barge-os\"" >> etc/os-release && \
    echo "BUG_REPORT_URL=\"https://github.com/bargees/barge-os/issues\"" >> etc/os-release

# Add Package Installer
RUN mkdir -p usr/bin && \
    # wget -qO usr/bin/pkg https://raw.githubusercontent.com/bargees/barge-pkg/master/pkg && \
    wget -qO usr/bin/pkg https://gitee.com/g-system/fk-barge-os/releases/download/master-2019-08/barge_pkg && \
    chmod +x usr/bin/pkg

# Copy config files
COPY configs ${SRC_DIR}/configs
RUN cp ${SRC_DIR}/configs/buildroot.config ${BR_ROOT}/.config && \
    cp ${SRC_DIR}/configs/busybox.config ${BR_ROOT}/package/busybox/busybox.config

COPY scripts ${SRC_DIR}/scripts
COPY --from=brdata /output/brdata.tar.gz /output_brdata.tar.gz

VOLUME ${BR_ROOT}/dl ${BR_ROOT}/ccache

WORKDIR ${BR_ROOT}
CMD ["../scripts/build.sh"]
