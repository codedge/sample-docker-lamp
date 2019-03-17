FROM httpd:2.4

RUN sed -i 's|#LoadModule rewrite_module|LoadModule rewrite_module|' /usr/local/apache2/conf/httpd.conf && \
    sed -i 's|#LoadModule ssl_module|LoadModule ssl_module|' /usr/local/apache2/conf/httpd.conf && \
    sed -i 's|#LoadModule socache_shmcb_module|LoadModule socache_shmcb_module|' /usr/local/apache2/conf/httpd.conf && \
    sed -i 's|#LoadModule proxy_module|LoadModule proxy_module|' /usr/local/apache2/conf/httpd.conf && \
    sed -i 's|#LoadModule proxy_fcgi_module|LoadModule proxy_fcgi_module|' /usr/local/apache2/conf/httpd.conf && \
    sed -i 's|#Include conf/extra/httpd-vhosts.conf|Include conf/extra/httpd-vhosts.conf|' /usr/local/apache2/conf/httpd.conf && \
    sed -i 's|#Include conf/extra/httpd-ssl.conf|Include conf/extra/httpd-ssl.conf|' /usr/local/apache2/conf/httpd.conf

RUN echo '' > /usr/local/apache2/conf/extra/httpd-vhosts.conf && \
    echo '' > /usr/local/apache2/conf/extra/httpd-ssl.conf

COPY docker/apache/ssl/vhost.crt /usr/local/apache2/conf/server.crt
COPY docker/apache/ssl/vhost.key /usr/local/apache2/conf/server.key

ENV APACHE_LOG_DIR=/usr/local/apache2/logs

RUN apachectl restart