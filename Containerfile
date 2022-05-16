# https://support.endlessos.org/en/dev/toolbox-debian
# https://piware.de/gitweb/?p=bin.git;a=blob;f=build-debian-toolbox
# in case of emergency: podman system reset

# see https://hub.docker.com/_/debian
# FROM docker.io/library/debian:11.3
FROM docker.io/library/debian:bullseye-20220509

ARG BUILD_DATE

# see https://github.com/opencontainers/image-spec/blob/main/annotations.md
# see https://github.com/containers/containertoolbx.org/blob/main/distros.md
LABEL com.github.containers.toolbox="true" \
      com.github.debarshiray.toolbox="true" \
      org.opencontainers.image.created="$BUILD_DATE" \
      org.opencontainers.image.version="11.3.0" \
      org.opencontainers.image.title="proprietary-collaboration-debian" \
      org.opencontainers.image.base.name="docker.io/library/debian:bullseye-20220509"

# https://wiki.debian.org/Locale
# head /etc/default/locale /etc/locale.gen

ENV LANG=C.UTF-8
ENV LANGUAGE=C.UTF-8

RUN apt-get update \
    && apt -y upgrade \
    && apt-get -y install libcap2-bin sudo libnss-myhostname
# && apt-get -y install fonts-noto

ENV TZ=Etc/UTC
RUN printf '%s' "${TZ}" | tee /etc/timezone
RUN ln -sf "/usr/share/zoneinfo/${TZ}" /etc/localtime

RUN printf '%s\n' '%sudo ALL=(ALL) NOPASSWD: ALL' >/etc/sudoers.d/com.github.containers.toolbox.sudo
RUN printf '\n%s\n' 'VARIANT_ID=container' >>/etc/os-release

# sudo mkdir -p /tmp/dummy-packages/ ; sudo cp ./dummy-packages/*.deb /tmp/dummy-packages/ ; sudo apt -y install /tmp/dummy-packages/*.deb ; sudo rm /tmp/dummy-packages/*.deb
# sudo mkdir -p /tmp/proprietary/ ; sudo cp ~/Downloads/proprietary/*.deb /tmp/proprietary/ ; sudo apt -y install /tmp/proprietary/*.deb ; sudo rm /tmp/proprietary/*.deb
