FROM centos:centos6

MAINTAINER Timothy Mahoney <tim@opsarray.com>

RUN yum -y update ; yum clean all
RUN yum -y install epel-release tar wget unzip gcc ; yum clean all

RUN wget http://rpms.famillecollet.com/enterprise/remi-release-6.rpm 
RUN rpm -Uvh remi-release-6*.rpm

RUN yum -y install php55 --enablerepo=remi,remi-php55
RUN yum -y install php-phpunit-PHPUnit php-devel --enablerepo=remi-php55

COPY php.ini /etc/php.ini

RUN wget https://github.com/sebastianbergmann/phpunit/releases/download/3.7.32/phpunit.phar
RUN chmod +x phpunit.phar
RUN mv phpunit.phar /usr/local/bin/phpunit

RUN phpunit --version

# PECL Stuff
pecl config-set php_ini /etc/php.ini
echo -e "\n\n\n\n\n\n\n\n\n\n" | pecl install mongo-1.5.1
echo "extension=mongo.so" > /etc/php.d/mongo.ini