FROM	alpine:3.14

RUN		apk update && apk upgrade --no-cache

RUN		apk add sudo

RUN		apk add --no-cache --quiet --update mariadb mysql-client

COPY	./conf/create_db.sql /tmp/create_db.sql

COPY	./tools/entrypoint.sh ./

COPY 	./conf/mariadb-server.cnf /etc/my.cnf.d/

RUN 	chmod +x ./entrypoint.sh

RUN		mysql_install_db --datadir=/var/lib/mysql \
			--auth-root-authentication-method=normal

RUN		chown -R mysql:mysql /var/lib/mysql

ENTRYPOINT [ "sh", "entrypoint.sh" ]
