FROM ubuntu:trusty
MAINTAINER Alan Kent

# Get Apache, mysql client, PHP etc
RUN apt-get update && apt-get install -y apache2 mysql mysql-client php5 php5-curl php5-mcrypt php5-gd php5-mysql curl git

# mcrypt.ini appears to be missing from apt-get install. Needed for PHP mcrypt library to be enabled.
ADD config/20-mcrypt.ini /etc/php5/cli/conf.d/20-mcrypt.ini
ADD config/20-mcrypt.ini /etc/php5/apache2/conf.d/20-mcrypt.ini

# Environment variables from /etc/apache2/apache2.conf
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2/apache2.pid

# Enable Apache rewrite module
#RUN a2enmod rewrite

# Add the Apache virtual host file
ADD config/apache_default_vhost /etc/apache2/sites-enabled/magento.conf
RUN rm -f /etc/apache2/sites-enabled/000-default.conf

# Download Magento CE
RUN cd /tmp && curl -O http://www.magentocommerce.com/downloads/assets/1.9.0.1/magento-1.9.0.1.tar.gz
RUN cd /tmp && curl -O http://www.magentocommerce.com/downloads/assets/1.9.0.0/magento-sample-data-1.9.0.0.tar.gz

# Install Magento CE
RUN cd /var/www && tar -zxvf /tmp/magento-1.9.0.1.tar.gz
RUN cd /var/www/magento && tar -zxvf /tmp/magento-sample-data-1.9.0.0.tar.gz && mysql -u root -p magento-db-instance-name < sample-data-filename.sql
RUN chown www-data:www-data -R /var/www/magento

# Expose the web server port
EXPOSE 80

# Start up the Apache server
#ADD scripts/runserver /usr/local/bin/runserver
#RUN chmod +x /usr/local/bin/runserver
#ENTRYPOINT ["bash", "-c"]
#CMD ["/usr/local/bin/runserver"]
CMD ["bash"]
