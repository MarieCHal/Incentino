FROM    alpine:3.14

RUN        apk update && apk upgrade --no-cache

#install php packages needed by wordpress (langage needed to make website)
RUN		apk add --no-cache --quiet --update php7 php-phar \
			php-json php-curl php-fpm php-mysqli php-iconv

#install wget (needed to install wordpress)
#install tar to extact wordpress from the tar file downloaded by wget
RUN     apk add wget tar --no-cache

#download .tar wordpress
RUN      wget -P /var/www/ https://wordpress.org/latest.tar.gz

#extract wordpress and delete .tar file
RUN 	cd /var/www && tar -xzf latest.tar.gz && rm latest.tar.gz

#set the working directory
WORKDIR /var/www/wordpress

#download the command-line interface needed by wordpress
RUN		wget -P /usr/bin https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

#give rights to exec wp-cli.phar (to use it in entrypoint)
RUN 	chmod +x /usr/bin/wp-cli.phar

#copy our wp-config into the config file of wordpress
COPY    conf/wp-config /config/wp-config

COPY    ./tools/entrypoint.sh /tmp/entrypoint.sh

RUN        chmod +x /tmp/entrypoint.sh

ENTRYPOINT ["sh", "/tmp/entrypoint.sh"]