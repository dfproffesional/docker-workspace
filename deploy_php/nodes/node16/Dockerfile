FROM node:16-bullseye

# Update & Install dependences
RUN apt-get update && \
    apt-get install -y --no-install-recommends \ 
    sudo neovim curl git &&\ 
    rm -rf /var/lib/apt/lists/*

ARG USERNAME=node

RUN echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER $USERNAME
RUN curl -s https://ohmyposh.dev/install.sh | sudo bash -s
RUN oh-my-posh font install FiraCode ;\
    sudo cp -r /root/themes ~/ ;\
    sudo chown $USERNAME:$USERNAME -R ~/themes ;\
    echo 'eval "$(oh-my-posh init bash --config ~/themes/clean-detailed.omp.json)"' >> ~/.bashrc
