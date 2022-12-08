#checks if there is a .setup file in the container
#if no .setup file: launch the mysql server, 
#waits until server start, create db, create .setup

cat .setup 2> /dev/null
if [ $? -ne 0 ]; then
	usr/bin/mysqld_safe --datadir=/var/lib/mysql &
	while ! mysqladmin ping -h "$MARIADB_HOST" --silent; do
    	sleep 1
	done
	eval "echo \"$(cat /tmp/create_db.sql)\"" | mariadb
	touch .setup
fi

#recomanded way to start mysql server
usr/bin/mysqld_safe --datadir=/var/lib/mysql