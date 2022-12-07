
/** set the passowrd for root since authentification method is normal no
password is set */
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$MARIADB_ROOT_PWD');

/**creating a new user */
CREATE DATABASE $MARIADB_DB;
CREATE USER '$MARIADB_USER'@'%' IDENTIFIED by '$MARIADB_PWD';
GRANT ALL PRIVILEGES ON $MARIADB_DB.* TO $MARIADB_USER@'%';

/** flush privileges updates the changes made */
FLUSH PRIVILEGES;