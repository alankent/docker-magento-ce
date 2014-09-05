# Magento CE 1.9 Demo

[Magento](http://magento.com/) is an open source ecommerce engine,
developed by eBay Inc powering 240,000+ online ecommerce sites.

This Dockerfile is a quick and dirty install of Magento CE 1.9.0.1
with sample data. THIS IS NOT RECOMMENDED PRODUCTION INSTALLATION
CONFIGURATION SETTINGS! For example, the MySQL database has no
password.

To run using a prebuild image use

    docker run -d -p 80:80 alankent/docker-magento-ce

Replace "80:80" with "8888:80" if you wish to run on port 8888 instead.

Otherwise build the supplied Dockerfile and run that. The build will
take up to 10 minutes to complete as it includes downloading the CE 
distribution and sample data from the Magento download site.

Connect to your VM using http://<yourhostname>/. You may need to wait for
up to a minute for the server to respond - when the container starts it
populates the database with sample data.  When you connect it will lead you
through an installation process. The following is the minimal settings to get
the demo up and going. AGAIN, THESE ARE NOT RECOMMENDED PRODUCTION SETTINGS!

On the first page, click the checkbox to accept the terms and conditions
and click the "Continue" button.

On the second page you can change the settings if you wish, or just click the
"Continue" button to accept the defaults.

On the third page, in the "Database Connection" pane for "User name" enter
"root". Leave the password blank. You should not need to change any other
settings on this page. Click the "Continue" button.

On the forth page you can enter your details, email address, and create an
adminsitrator account. If your service is going to be public you should
use a good username and password. Note that the email address does not
matter - the container has not been set up with email support. Example
inputs may be

* First Name: Magical
* Last Name: Magento
* Email: magento@example.com
* Username: magento
* Password: admin123
* Confirm Password: admin123
* Encryption Key: (leave blank)

The last page is a survey. If you look at the bottom of the page you will see
links to the frontend (store front) and backend (administration). Click on
"Go to Frontend" and experiment with the site. To go to the backend later,
on the URL use http://<yourhostname>/admin.

Enjoy!
