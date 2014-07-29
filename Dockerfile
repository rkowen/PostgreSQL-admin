#
# Build a phppgadmin image to connect to the PostgreSQL server.
#

# change this to a recent image
FROM	ubuntu:14.04
MAINTAINER rk@owen.sj.ca.us

# Use phppgadmin as a web interface
USER	root
EXPOSE	80

RUN	apt-get -y -qq update
RUN	apt-get -y -qq upgrade

RUN	apt-get install -y -qq phppgadmin

ADD	config.inc.php	/etc/phppgadmin/
RUN	/bin/rm /etc/apache2/sites-enabled/000-default.conf
RUN	/bin/ln -s /etc/apache2/conf.d/phppgadmin /etc/apache2/conf-enabled/.
ADD	fqdn.conf /etc/apache2/conf-enabled/
ADD	www.conf /etc/apache2/sites-enabled/

ENV	APACHE_LOCK_DIR		/var/lock/apache2
ENV	APACHE_PID_FILE		/var/run/apache2.pid
ENV	APACHE_RUN_USER		www-data
ENV	APACHE_RUN_GROUP	www-data
ENV	APACHE_LOG_DIR		/var/log/apache2
ENTRYPOINT	["/usr/sbin/apache2"]
CMD	["-D", "FOREGROUND"]
