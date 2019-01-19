#!/bin/bash

set -e

args_fwd=""
interactive="-it"
skip_build=false
for opt in "$@"; do
	[[ $opt == "--no-interactive" ]] && interactive=""
	case $opt in
		--no-interactive)
			interactive=""
			;;
		--skip-build)
			skip_build=true
			;;
		*)
			args_fwd+=" $opt"
	esac
done

img_name="zmdoc_content"

[[ $skip_build != "true" ]] && docker build . -t $img_name

# RUN

docker run --rm $interactive \
	-p 80:8080 \
	-v $PWD/data:/home/dev/data \
	--env USER_ID=$(id -u) \
	--env GROUP_ID=$(id -g) \
	--hostname $img_name \
  $img_name $args_fwd
