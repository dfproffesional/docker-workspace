# Select Image
FROM webdevops/php-apache:8.1-alpine

# Config docker variables
ARG USERNAME=application
ARG DIR_BASE=webdevops_http_php/Dockerfiles

# Install deps
RUN apk update;\
	apk add --no-cache \
	sudo neovim

# Config sudo
RUN echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Config terminal
COPY shell_scripts/posh-theme.sh /usr/bin/posh-theme

RUN chmod +x /usr/bin/posh-theme ;\
	posh-theme

# Config Apache
COPY $DIR_BASE/vhost.conf /opt/docker/etc/httpd/vhost.conf

# Default page
RUN mkdir /app/default; chown $USERNAME:$USERNAME /app/default
COPY $DIR_BASE/index.php /app/default