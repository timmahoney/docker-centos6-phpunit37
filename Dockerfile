FROM centos:centos6

MAINTAINER Timothy Mahoney <tim@opsarray.com>

RUN yum -y update ; yum clean all
RUN yum -y install epel-release tar wget unzip gcc mysql ; yum clean all

RUN wget http://rpms.famillecollet.com/enterprise/remi-release-6.rpm 
RUN rpm -Uvh remi-release-6*.rpm

RUN yum -y install php55 --enablerepo=remi,remi-php55
RUN yum -y install php-phpunit-PHPUnit php-devel php-mysqlnd php-mcrypt --enablerepo=remi-php55

COPY php.ini /etc/php.ini

RUN wget -q https://github.com/sebastianbergmann/phpunit/releases/download/3.7.32/phpunit.phar
RUN chmod +x phpunit.phar
RUN mv phpunit.phar /usr/local/bin/phpunit

RUN phpunit --version

# PECL Stuff
RUN pecl config-set php_ini /etc/php.ini
RUN echo -e "\n\n\n\n\n\n\n\n\n\n" | pecl install mongo-1.5.1
RUN echo "extension=mongo.so" > /etc/php.d/mongo.ini
RUN rm -rf /etc/php.d/xdebug.ini