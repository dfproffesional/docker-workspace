#!/bin/bash

# Download Oh-my-posh
curl -s https://ohmyposh.dev/install.sh | sudo bash -s

# Install Theme & Fonts
oh-my-posh font install FiraCode 
sudo cp -r /root/themes /home/$USERNAME/ ;\
sudo chown $USERNAME:$USERNAME -R /home/$USERNAME/themes ;\
echo 'eval "$(oh-my-posh init bash --config ~/themes/clean-detailed.omp.json)"' >> /home/$USERNAME/.bashrc
