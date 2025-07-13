echo "Starting MySQL Container..."

/docker-entrypoint.sh mysqld &

until mysqladmin ping -h localhost --silent; do
  echo "Waiting for MySQL to be ready..."
  sleep 2
done

echo "Applying mysqlCore.sql..."

mysql -u root -p"$MYSQL_ROOT_PASSWORD" traffic_db < /docker-entrypoint-initdb.d/mysqlCore.sql

echo "Initialization complete."
