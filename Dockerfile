FROM ubuntu:18.04

COPY apt/sources.list /etc/apt

ARG DEBIAN_FRONTEND=noninteractive
ARG USER_ID=1000
ARG GROUP_ID=1000

RUN set -ex \
	&& apt-get update && apt-get install -y \
		python3 \
		python3-distutils \
		wget \
		sudo

RUN set -ex \
	&& cd /tmp \
	&& wget -q https://bootstrap.pypa.io/get-pip.py -O get-pip.py \
	&& python3 get-pip.py \
	&& pip3 install bidict aiohttp ipdb ipython

EXPOSE 8080

COPY zmdoc_content_server /usr/local/bin
COPY entrypoint.sh /usr/local/bin

ENTRYPOINT ["/bin/bash", "/usr/local/bin/entrypoint.sh"]
