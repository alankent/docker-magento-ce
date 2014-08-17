FROM ubuntu:14.04
MAINTAINER Alan Kent

# Ensure UTF-8
RUN locale-gen en_US.UTF-8

# enable SSH service
ADD id_rsa.docker.pub /root/.ssh/
RUN cat /root/.ssh/id_rsa.docker.pub >> /root/.ssh/authorized_keys
RUN chmod 600 /root/.ssh/authorized_keys
EXPOSE 22

# Install 
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y --force-yes apache2 libapache2-mod-php5 php5-mysql php5-xdebug php5-curl php5-gd php5-mcrypt

# runit apache2
RUN mkdir /etc/service/apache2
ADD apache2.sh /etc/service/apache2/run
RUN chmod +x /etc/service/apache2/run

ADD setup.sh /etc/my_init.d/setup.sh
RUN chmod +x /etc/my_init.d/setup.sh

RUN rm /etc/apache2/sites-enabled/*
ADD magento.conf /etc/apache2/sites-enabled/
ADD magento-ssl.conf /etc/apache2/sites-enabled/
RUN ln -s /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/rewrite.load

# Clean up APT when done
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Magento
RUN mkdir /magento
ADD composer.json /magento
RUN cd /magetno && curl -sS https://getcomposer.org/installer | php
RUN cd /magento && php composer.phar update

VOLUME ["/magento", "/var/log/apache2"]

EXPOSE 80


