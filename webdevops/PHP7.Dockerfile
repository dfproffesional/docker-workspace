# Select Image
FROM webdevops/apache:centos-7

# Install EPEL Repo
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm ;\
 	rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm ;\
 	rpm -Uvh https://rpms.remirepo.net/enterprise/remi-release-7.rpm

# Instal dependences
RUN yum -y update;\
    yum -y install \
	lato-fonts ImageMagick  ImageMagick-devel \
	gcc make autoconf libc-dev pkg-config ; \
    yum-config-manager --enable remi-php74

# Install php dependences    
RUN yum -y install \
	php  php-cli php-fpm php-mysqlnd \
 	php-zip php-devel php-gd php-mcrypt \
	php-mbstring php-curl php-xml php-pear \
	php-bcmath php-json \
	php-pear php-devel

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# Instan PHP Extensions
RUN	pecl install imagick

# Config PHP Extension
RUN	echo extension=imagick.so >> /etc/php.ini
