BUILD_DATE=$$(date -u +'%Y-%m-%d')
IMAGE_TAG=localhost/proprietary-collaboration-debian:$(BUILD_DATE)
COM_CONTAINERS_TOOLBOX_NAME=poprietary-collaboration-debian

.PHONY: build override-tz
build:
	podman build -t $(IMAGE_TAG) -f Containerfile --build-arg "BUILD_DATE=$(BUILD_DATE)"
	toolbox create $(COM_CONTAINERS_TOOLBOX_NAME) --image $(IMAGE_TAG)

override-tz:
	podman toolbox run --container $(COM_CONTAINERS_TOOLBOX_NAME) ln -snf "/usr/share/zoneinfo/${TZ}" /etc/localtime
	printf '%s' "$TZ" > /etc/timezone
    printf '%s\n' "localhost/debian-toolbox:${BUILD_DATE}" >/etc/com.github.empjustine.image
    printf '%s\n' "proprietary-collaboration-debian" >/etc/com.github.empjustine.toolbx-name


#nuke:
#	podman system reset
