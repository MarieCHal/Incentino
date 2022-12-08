FROM	alpine:3.14

RUN		apk update && apk upgrade --no-cache

#install mariadb and mysql-client
RUN		apk add --no-cache --quiet --update mariadb mysql-client

#copy our .sql into our container
COPY	./conf/create_db.sql /tmp/create_db.sql

#copy our entrypoint into our container
COPY	./tools/entrypoint.sh ./

#copy our .conf into the conf directory of mariadb
COPY 	./conf/mariadb-server.cnf /etc/my.cnf.d/

RUN 	chmod +x ./entrypoint.sh

#initialize the MariaDB data dir. and creates the the system tables in mysql db
RUN		mysql_install_db --datadir=/var/lib/mysql \
			--auth-root-authentication-method=normal

#change ouwner and group of the database (it is creatd as root) for mysql
#to use it 
RUN		chown -R mysql:mysql /var/lib/mysql

ENTRYPOINT [ "sh", "entrypoint.sh" ]
