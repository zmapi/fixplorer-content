#!/bin/bash

set -e

# create a new user
id
mkdir -p /home/dev
echo "dev:x:$USER_ID:$GROUP_ID:Developer,,,:/home/dev:/bin/bash" >> /etc/passwd
echo "dev:x:$GROUP_ID:" >> /etc/group
echo "dev:wiod" | chpasswd

usermod -a -G sudo dev
echo "dev ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/dev

# chown -R dev:dev /home/dev

runusr="sudo -H -i -u dev"
runusr="$runusr env"

exec $runusr zmdoc_content_server --no-timestamps --debug
