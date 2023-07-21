FROM node:14-bullseye

# Update & Install dependences
RUN apt-get update && \
    apt-get install -y --no-install-recommends \ 
    sudo neovim curl git &&\ 
    rm -rf /var/lib/apt/lists/*

ARG USERNAME=node

RUN echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER $USERNAME

# Config terminal
COPY shell_scripts/posh-theme.sh /usr/bin/posh-theme

RUN chmod +x /usr/bin/posh-theme ;\
	posh-theme