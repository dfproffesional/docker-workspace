# Select Image
FROM webdevops/apache:centos-7

# Install EPEL Repo
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm ;\
 	rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm ;\
 	rpm -Uvh https://rpms.remirepo.net/enterprise/remi-release-7.rpm

# Instal dependences
RUN yum -y update; \
    yum -y install  \
	sudo neovim unzip \
	lato-fonts ImageMagick  ImageMagick-devel \
	gcc make autoconf libc-dev pkg-config


# Config Installation
RUN yum-config-manager --enable remi-php74

# Config docker variables
ARG USERNAME=application
ARG DIR_BASE=webdevops_http_php/Dockerfiles

RUN useradd -m -p '!' $USERNAME ;\
	echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Install php dependences    
RUN yum -y install \
	php  php-cli php-fpm php-mysqlnd \
 	php-zip php-devel php-gd php-mcrypt \
	php-mbstring php-curl php-xml php-pear \
	php-bcmath php-json php-imagick \
	php-pear git

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# Config PHP Extension
RUN echo extension=imagick.so >> /etc/php.ini

# Config terminal
COPY shell_scripts/posh-theme.sh /usr/bin/posh-theme

RUN chmod +x /usr/bin/posh-theme ;\
	posh-theme

# Config Apache
COPY $DIR_BASE/vhost.conf /opt/docker/etc/httpd/vhost.conf

# Default page
RUN mkdir -p /app/default

COPY $DIR_BASE/index.php /app/default

RUN chown $USERNAME:$USERNAME -R /app