
target="/etc/php7/php-fpm.d/www.conf"

grep -E "listen = 127.0.0.1" $target > /dev/null 2>&1
if [ $? -eq 0 ]; then
	sed -i "s|.*listen = 127.0.0.1.*|listen = 9000|g" $target
	echo "env[MARIADB_HOST] = \$MARIADB_HOST" >> $target
	echo "env[MARIADB_USER] = \$MARIADB_USER" >> $target
	echo "env[MARIADB_PWD] = \$MARIADB_PWD" >> $target
	echo "env[MARIADB_DB] = \$MARIADB_DB" >> $target
fi

# if no config.php 
if [ ! -f "wp-config.php" ]; then
	cp /config/wp-config ./wp-config.php

	sleep 5

	#website configuration
	wp-cli.phar core install --url="$WP_URL" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USER" \
    	--admin_password="$WP_ADMIN_PWD" --admin_email="$WP_ADMIN_EMAIL" --skip-email

	wp-cli.phar plugin update --all

	wp-cli.phar theme install twentysixteen --activate

	wp-cli.phar user create $WP_USER $WP_USER_EMAIL --role=editor --user_pass=$WP_USER_PWD

	wp-cli.phar post generate --count=2 --post_title="mchalard's post"
fi

php-fpm7 --nodaemonize