FROM mcr.microsoft.com/vscode/devcontainers/base:ubuntu
ARG PIP_OPTIONS="--break-system-packages"
RUN echo "deb [trusted=yes] https://netdevops.fury.site/apt/ /" |tee -a /etc/apt/sources.list.d/netdevops.list
RUN apt update && \
    apt install -y python3-pip containerlab && \
    python3 -m pip install $PIP_OPTIONS git+https://github.com/datum-cloud/netlab@galactic && \
    netlab install -y ubuntu ansible
USER vscode
