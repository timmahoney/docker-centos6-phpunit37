FROM centos:centos6

MAINTAINER Timothy Mahoney <tim@opsarray.com>

RUN yum -y update ; yum clean all
RUN yum -y install epel-release tar wget ; yum clean all

RUN wget http://rpms.famillecollet.com/enterprise/remi-release-6.rpm 
RUN rpm -Uvh remi-release-6*.rpm

RUN yum -y install php55 --enablerepo=remi,remi-php55

COPY php.ini /etc/php.ini
COPY php.ini /opt/remi/php55/root/etc/php.ini

RUN wget https://github.com/sebastianbergmann/phpunit/releases/download/3.7.32/phpunit.phar
RUN chmod +x phpunit.phar
RUN mv phpunit.phar /usr/local/bin/phpunit
RUN ln /usr/bin/php55 /usr/bin/php
RUN phpunit --version
