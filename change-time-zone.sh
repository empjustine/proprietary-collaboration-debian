#!/bin/sh

# https://wiki.debian.org/TimeZoneChanges

TZ=Etc/UTC
#TZ=America/Sao_Paulo

printf '%s' "${TZ}" | sudo tee /etc/timezone

sudo ln -sf "/usr/share/zoneinfo/${TZ}" /etc/localtime

diff -s /etc/localtime "/usr/share/zoneinfo/$(cat /etc/timezone)"

