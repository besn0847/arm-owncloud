FROM hypriot/rpi-alpine-scratch

RUN apk update && \
	apk add owncloud-sqlite nginx php-fpm php-curl supervisor && \
	mkdir /data /etc/nginx/sites-available /etc/nginx/sites-enabled && \
	mv /var/lib/owncloud/data /var/lib/owncloud/data.orig && \
	ln -s /data /var/lib/owncloud/data && \
	cp -rf /var/lib/owncloud/data.orig/* /data/	

ADD ./etc/ssl/ /etc/ssl/
ADD ./etc/nginx/nginx.conf /etc/nginx/nginx.conf
ADD ./etc/nginx/sites-available/ /etc/nginx/sites-available
ADD ./etc/php/ /etc/php/
ADD ./etc/supervisord.conf /etc/
ADD ./etc/supervisor.d/agent.ini /etc/supervisor.d/

RUN ln -s /etc/nginx/sites-available/owncloud /etc/nginx/sites-enabled/owncloud && \
	mkdir /var/www/owncloud/ && \
	ln -s /usr/share/webapps/owncloud /var/www/owncloud/www

EXPOSE 80 443

CMD /usr/bin/supervisord --nodaemon --configuration /etc/supervisord.conf  
