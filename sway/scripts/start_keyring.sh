#!/usr/bin/env bash
pkill -f --signal SIGTERM gnome-keyring-daemon


if [ -n "$DESKTOP_SESSION" ];then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
    echo -n "" | secret-tool store --label='unlocker' "unlocker" "unlocker"
fi
