#
# Apache + PHP
#
# 2016-07-18
#   CentOS 6.7
#   Apache 2.2
#   PHP 5.3

FROM centos:6
MAINTAINER fnakatani

RUN mkdir /code
WORKDIR /code

# update yum
RUN yum update -y && \
    yum clean all

# httpd
RUN yum install -y httpd httpd-tools && \
    yum clean all

# php
RUN yum install  -y php php-devel gd php-gd&& \
    yum clean all

# modify /etc/php.ini
RUN sed -i -e "s/;date.timezone *=.*$/date.timezone = Asia\/Tokyo/" /etc/php.ini
# modify /etc/conf/httpd.conf
RUN sed -ri 's/DocumentRoot "\/var\/www\/html"/DocumentRoot "\/var\/www\/html\/public"/' /etc/httpd/conf/httpd.conf

RUN ln -sf /code/public /var/www/html/
EXPOSE 80

CMD ["/usr/sbin/httpd","-D","FOREGROUND"]
ADD . /code/
